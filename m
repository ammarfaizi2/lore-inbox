Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289244AbSAGQIU>; Mon, 7 Jan 2002 11:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289247AbSAGQIL>; Mon, 7 Jan 2002 11:08:11 -0500
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:9403 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289244AbSAGQID>; Mon, 7 Jan 2002 11:08:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Steve Snyder <swsnyder@home.com>
Reply-To: swsnyder@home.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ES1869 audio plays too fast
Date: Mon, 7 Jan 2002 11:08:00 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020107160802.RESG20568.femail28.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my laptop (a Compaq Presario 1260), which has integrated ES1869 audio, 
any sounds that are not played via KDE's artsd daemon are played at many 
times their correct speeds.  Sounds played through artsd are OK.

Examples of non-artsd applications would be RealAudio and mplayer.  In 
these applications (at least) human voices sound like chipmonks.  Music 
sounds like, well, very fast music.

This is on a RedHat v7.2 system with all RH-released updates applied, and 
with kernel v2.4.17.  Below is what I hope is pertinent info.

Can anyone advise me on how to fix this problem?  Thanks.

------------------------------------------

This is the audio-related output that I get at boot time:

Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
SB 3.01 detected OK (220)
ESS chip ES1869 detected
<ESS ES1869 AudioDrive (rev 11) (3.01)> at 0x220 irq 5 dma 1
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x330-0x337 0x378-0x37f 
0x388-0x38f 0x3f8-0x3ff 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.


My audio-related kernel config looks like this:

CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_SB=m
CONFIG_SOUND_YM3812=m


And then we have the modules loaded:

# lsmod
Module                  Size  Used by
sb                      1744   0
sb_lib                 33456   0  [sb]
uart401                 6192   0  [sb_lib]
sound                  55136   0  [sb_lib uart401]
soundcore               3472   4  [sb_lib sound]


This is the relevant portion of my /etc/modules.conf:

alias sound-slot-0 sb
alias synth0 opl3
options sound dmabuf=1
options opl3 io=0x388
options sb io=0x220 irq=5 dma=1 mpu_io=0x330
alias sound-slot-1 off                  # secondary sound card
alias sound-service-1-0 off             # secondary sound card
