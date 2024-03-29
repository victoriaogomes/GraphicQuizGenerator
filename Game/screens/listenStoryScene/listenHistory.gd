extends Node2D

var next_scene = preload("res://screens/gameScene/game.tscn")
var next_scene2 = preload("res://screens/gameScene2/game2.tscn")
var previous_scene = load("res://screens/chooseStoryScene/storyChoose.tscn")

var musicOff = preload("res://sprites/images/soundOff.png")
var musicOn = preload("res://sprites/images/soundOn.png")



func _ready():
	$Bluebackground.set_frame_color(Color(global_config.game_color["r"], global_config.game_color["g"], global_config.game_color["b"]))
	if(global_config.music == true):
		$musicButton.set_texture(musicOn)
	else:
		$musicButton.set_texture(musicOff)
	global_config.level = 0
	$title.set_text(global_config.stories["Story_" + str(global_config.storychosen)]["Story_title"])
	global_config.best_fit_check(70, $title)
	$book.set_texture(global_config.stories["Story_" + str(global_config.storychosen)]["Story_cover"])
	get_tree().set_auto_accept_quit(false)
	get_tree().set_quit_on_go_back(false)
	$AnimationPlayer.play("transition3", -1, 1.0, false)
	yield($AnimationPlayer, "animation_finished")


func _on_iniciarJogo_pressed():
	if($history.listened_once == 1):
		if(global_config.music==true):
			if(global_config.background_sound.is_playing() == false):
				global_config.music_on()
		if(global_config.img[global_config.storychosen-1] == false):
			#warning-ignore:return_value_discarded
			get_tree().change_scene_to(next_scene2)
		else:
			#warning-ignore:return_value_discarded
			get_tree().change_scene_to(next_scene)
	else:
		$Popup.popup()
		$Popup/ok.set_block_signals(false)
		$history._on_pause_pressed()


func _on_voltar_pressed():
	$history.stop()
	get_node("/root/Node2D/AnimationPlayer").play_backwards("transition3", -1)
	yield(get_node("/root/Node2D/AnimationPlayer"), "animation_finished")
	#warning-ignore:return_value_discarded
	get_tree().change_scene_to(previous_scene)


func _on_ok_pressed():
	$Popup.set_visible(false)
	$Popup/ok.set_block_signals(true)
	$history._on_play_pressed()


func _on_musicButton_pressed():
	if(global_config.music == true):
		global_config.music_off()
		$musicButton.set_texture(musicOff)
	else:
		global_config.music_on()
		$musicButton.set_texture(musicOn)