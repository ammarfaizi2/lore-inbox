Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284653AbRLIXhU>; Sun, 9 Dec 2001 18:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284656AbRLIXhA>; Sun, 9 Dec 2001 18:37:00 -0500
Received: from femail42.sdc1.sfba.home.com ([24.254.60.36]:8590 "EHLO
	femail42.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S284653AbRLIXgy>; Sun, 9 Dec 2001 18:36:54 -0500
Date: Sun, 9 Dec 2001 18:36:52 -0500
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: block devs and high latency
Message-ID: <20011209183652.A18469@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while doing some experimentation, i've discovered an annoying problem. when
writing to one or two scsi drives, there seems to be some weird side
effects. the effect is the same, whether i run cat /dev/zero > /dev/sdc1 or
dd bs=131027 if=/dev/zero of=/dev/sdc1. buffer size doesn't make a
difference, bs can also be set to 5 megs. if you hit ctrl-c to kill one or
two of the dd or cat procs, you can't switch consoles for a good 20-30
seconds (my estimation). i was running screen and i couldn't switch screens,
either, so, at some level, all keyboard input was being delayed. the machine
has normal ping times during this.

also, if you run sync while the other procs are running, it won't return
until they're done. it also is unkillable during this, in state D. is this a
race? ie, as sync flushes dirty buffers, they're added just as fast. i
always thought sync was atomic and meant "flush every io issued before this
call, but not after".

this is using 2.4.17-pre6 on an alpha pws500 with a half gig of ram, and a
sym53c895 (using the new driver).

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
