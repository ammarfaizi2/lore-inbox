Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263406AbTKAFcW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 00:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263716AbTKAFcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 00:32:22 -0500
Received: from pa-steclge-cmts2a-19.stcgpa.adelphia.net ([68.168.167.19]:39659
	"EHLO potassium.stop.dyndns.org") by vger.kernel.org with ESMTP
	id S263406AbTKAFcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 00:32:20 -0500
Message-ID: <3FA34523.30902@nodivisions.com>
Date: Sat, 01 Nov 2003 00:31:15 -0500
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Audio skips when RAM is ~full
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a memory-related question regarding a Slackware system I'm running 
(kernel 2.4.22, compiled for i386, on a VIA Eden 600MHz processor, with 
256MB RAM).

First, the background info:

This system is primarily an mp3 player.  It boots directly to /bin/bash 
bypassing everything under /etc/rc.d, and just runs a small script that does 
modprobing and a few other miscellaneous things, then starts the main 
control script (which is Perl).

I have about 250 CDs encoded as mp3s on the 40gig drive, laid out in 
directories as /music/band/album/songs.mp3.  I also have a text file which 
contains one line for the full path to each album (so ~250 lines total). 
This file is used by my play-random-album function, which plays a random 
album each time I press the tick key.  When I do that, the songs from the 
randomly-chosen album become the current playlist, and the first song starts 
playing.

Now, the problem/question:

Each time I press the tick key, a new directory is read from the disk (and a 
song is played, and the directory contents are enqueued).  This causes the 
free memory (as reported by free) to drop by 1%, each time I press tick.  I 
often press it 5 or 10 or 20 times in a row until I find something I feel 
like listening to, and the free memory will drop by almost exactly 5 or 10 
or 20 percent by the time I settle on an album.  If the free memory was 
already very low (for example, when I do this after having already listened 
to an album or two), then it will often get down to 2% or 3% at this point, 
and stay there until I reboot.

This system has one of those awful on-board "ac'97" sound chips, which 
(AIUI) uses the system CPU to do much of the audio work instead of using 
dedicated audio chips for it.  When the free memory is less than about 10%, 
each song will "skip" when it first starts playing.  (It sounds like 1/2 or 
1 or 2 seconds of audio was deleted from the song; you don't hear silence, 
you hear the music at seconds 1, 2, and then 4, or just 2, 3, 4, ... 
skipping the very start, etc.  But it's always some portion of the first ~5 
seconds getting skipped.)

When the system is first booted, the free mem is around 90%, and this 
skipping doesn't happen.  As time goes on, the free mem drops, and skipping 
starts happening somewhere along the line; by the time it's down to ~10% 
free, every song skips when it starts.

The disk is a modern one using DMA.  And I even set up a ramdisk to try 
playing the songs from there (copying the "next" track into ramdisk while 
the current track is playing), but it still skips at the beginning of each 
track when the free mem is low enough.

My understanding/analysis/proposed solution:

The kernel is buffering the contents of each directory (album) that it reads 
(and also, mpg321 copies each mp3 file into RAM before playing it?).  I 
understand that the idea is to stuff as much into RAM as possible to reduce 
pagefile usage, and that the kernel will reclaim memory utilized by buffers 
if/when it needs to.  But apparently that isn't happening fast enough to 
allow a realtime process like music-playing to work skip-free on this system 
with this soundcard.  I think that if I could regularly forcibly dump the 
buffered stuff out of the RAM (dropping the used-RAM percentage down to, 
say, 10%, like at boot time) then this would make the skipping stop.

So... do I have a correct understanding of the problem, and a correct 
analysis of the kernel/mem issues that are related to it?  Is it possible to 
clear some of the RAM; if so, would that help?

Thanks,
Anthony

PS - you can see the system at:
http://nodivisions.com/tech/systems/musicbox/
