Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270082AbUJUENz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270082AbUJUENz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 00:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270358AbUJUEKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 00:10:24 -0400
Received: from mta13.adelphia.net ([68.168.78.44]:61838 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S270082AbUJUD5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:57:40 -0400
Message-ID: <4177339F.9010409@nodivisions.com>
Date: Wed, 20 Oct 2004 23:57:19 -0400
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oom killer on swapless music player
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run a linux box in my car as an mp3 player.  It just has a perl script 
that outputs to an LCD on the parallel port, and does a continuous loop 
accepting keyboard/remote control input, and forks to play songs via madplay 
or mpg321.  When the forked process finishes, it signals the parent script, 
which then starts the next song in the playlist.

The box has a 600MHz VIA CPU, 256MB of DDR RAM, and no swap space (the 
partitions are all mounted read-only since it's in a car).

This was running mostly fine on 2.4.25, but I recently upgraded to 2.6.8 to 
switch to udev and for a few other reasons.  Now after playing for about 2 
hours, the RAM is full, and the oom killer starts taking out the music 
script and/or madplay.  Under 2.4.25, I ran a small "freeram" C program 
whenever the memory usage was >70%, which just malloc()ed a bunch of memory 
and then exited, clearing the disk cache out of RAM.  But now, under 2.6.8, 
that doesn't work, because the buffer/cache is only 1 or 2 megs full; nearly 
all the 256MB of RAM shows up in the "used" column when I run the "free" 
program.  And after the oom killer has killed my music script, there's 
almost nothing else running -- I boot directly to my script, bypassing 
everything in /etc/init.d/ -- but the RAM is still full.

What has changed from 2.4 to 2.6 that makes this happen?  And... what 
exactly is it that's happening?  Does some program (my script, madplay, alsa 
drivers) have a severe memory leak that 2.4 somehow didn't care about?  Or 
did I configure something incorrectly in my 2.6 kernel?

Thanks,
Anthony DiSante
http://nodivisions.com/
