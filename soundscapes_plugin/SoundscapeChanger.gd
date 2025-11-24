@tool
extends Node2D
#Add as many SoundscapeChanger nodes as you like! 
#Ensure your sound effects are sent to the SFX bus!

#This is the scape you want the scene to use by default
@export var defaultScape: Resource
#This the scape the scene is currently playing, which is set to the default at the beginning
@onready var currentScape: Resource = defaultScape
#An array of all the scapes in the scapes folder
var scapesList: Array = get_scapes()

#This is the scape you want this SoundscapeChanger to change to
@export var nextScape : Resource

func get_scapes():
	#Ensure path is the folder containing your scapes
	var path = "res://SoundscapeContent/Scapes/"
	var files = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		while true:
			var file = dir.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				files.append(file)
	return files

func _change_soundscape(): #Call this function from another script to change scapes
	if nextScape != currentScape:
		currentScape = nextScape
		AudioServer.set_bus_layout(currentScape)
