Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTE0Ix7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 04:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbTE0Ix6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 04:53:58 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:63901 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S262850AbTE0Ix4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:53:56 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: ALSA problems: sound lockup, modules, 2.5.70
Date: Tue, 27 May 2003 03:11:10 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305270311.10530.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote about this in a previous mail, but this is a repost as a separate 
subject.

1) All sound applications on my system break on 2.5.70 and work fine on 
2.4.21-rc4 with alsa 0.9.2. The problem is a lockup where the sound keeps 
looping. The kernel log does not report anything, but: 

	- aplay locks up when beginning to play a wav. file
	- xmms locks up on attempted stop or skipping back or forward (mp3)
	- mplayer locks up on pause (mp3)
	- xine locks up on start (mp3)

Soundcard uses snd-via82xx driver (ALC650)

2) Module issues.
Perhaps this is not a bug, but I cannot get the sound modules to autload.
I use module-init-tools 0.9.12, devfs, and I have set up moprobe.devfs and 
modprobe.conf. I have kmod compiled in the kernel. The redhat initscripts are 
not turning off autoloading - other things autoload fine. 

Modprobe.devfs says:
alias /dev/snd snd-card-0
alias /dev/snd/*  /dev/snd
alias /dev/sound/* /dev/sound
alias /dev/sound sound-slot-0
alias /dev/audio sound-slot-0
alias /dev/mixer sound-slot-0
alias /dev/dsp sound-slot-0
alias /dev/dspW sound-slot-0
alias /dev/midi sound-slot-0

Modprobe.conf says:
alias sound-slot-0 snd-via82xx
alias snd-card-0 snd-via82xx
install snd-via82xx /sbin/modprobe --ignore-install snd-via82xx && { alsactl 
-f /etc/asound.state restore; }
remove snd-via82xx /sbin/modprobe -r --ignore-remove snd-via82xx && { alsactl 
-f /etc/asound.state store; }

Devfsd.conf says:
REGISTER sound/.* PERMISSIONS root.audio 660
REGISTER snd/.* PERMISSIONS root.audio 660

And the modules won't load until I manually modprobe snd-via82xx.

Also...on modprobe --remove snd-via82xx:
[root@cobra etc]# modprobe --remove snd-via82xx
alsactl: save_state:1050: No soundcards found...
FATAL: Error running remove command for snd_via82xx
[root@cobra etc]#

Thank you for your help.



                                                                                                         

