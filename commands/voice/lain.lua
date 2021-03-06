-- Licensed under the Open Software License version 3.0

return {
    name = "lain",
    description = "stream lain chan radio",
    hidden = false,
    command = function(message)
        local author = message.guild:getMember(message.author.id)
        local vc
        if not author.voiceChannel and not client.user.voiceChannel then
            local reply = message:reply("join a voice channel first retard")
            discordia.Clock():waitFor("", 5000)
            reply:delete()
            return
        elseif client.user.voiceChannel then
            vc = client.user.voiceChannel
        else
            vc = author.voiceChannel
            vc:join()
        end
        if not vc then return message:reply(err) end
        local stream
        if not args then -- if no args play everything playlist
            stream = "everything"
        elseif args == "cafe" or args == "cyberia" or args == "swing" then -- play playlist if it exists
            stream = args
        else -- if args are something else just play everything playlist
            stream = "everything"
        end
        if vc.connection then
            vc.connection:stopStream()
            message:reply({
                embed = {
                    author = {
                        name = "lain",
                        icon_url = "https://i.imgur.com/5DC7h3C.png"
                    },
                    title = stream,
                    color = botColor,
                    description = "requested by " .. author.mentionString,
                }
            })
            vc.connection:playFFmpeg("http://lainon.life:8000/" .. stream .. ".mp3")
        end
    end
}
