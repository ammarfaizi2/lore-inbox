Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTDYHuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 03:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTDYHuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 03:50:16 -0400
Received: from inconnu.isu.edu ([134.50.8.55]:65499 "EHLO inconnu.isu.edu")
	by vger.kernel.org with ESMTP id S263426AbTDYHuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 03:50:15 -0400
Date: Fri, 25 Apr 2003 02:02:24 -0600 (MDT)
From: I Am Falling I Am Fading <skuld@anime.net>
X-X-Sender: skuld@inconnu.isu.edu
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Highpoint 374 first port device early blocks nonfunctional
Message-ID: <Pine.LNX.4.44.0304250135020.10384-100000@inconnu.isu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(This is my first bug report on the Linux kernel ever, so please bear with 
me, it will also be a bit sparse on information as I am not following the 
bug report template exactly due to laziness on my part. I am sending this 
to the LKML because I can't find a particular maintainer for the hpt3xx 
driver)

[1.] Highpoint 374 first port device early blocks nonfunctional

[2.] I have a Epox EP-K9A3+ motherboard with integrated HPT374 controller. 
Due to issues with the HPT BIOS a bootloader started from the southbridge 
IDE controller cannot see the hpt374-attached devices, therefore I am 
placing all of my drives on the HPT controller. I am not using them in any 
RAID configuration for purposes of just getting the system working 
properly to begin with. Basically I am just using it as another IDE 
controller.

Using LILO (as GRUB does not function properly with this controller) I can 
boot into Linux successfully provided that I do not utilize the first 
port.

While experimenting with the controller I discovered that under Linux, 
using the native hpt7xx drivers as of kernel 2.4.21-pre5, I could not 
successfully mount the first partition on whichever drive was attached to 
port 1 of the controller. (in this case /dev/hde). It reports that the 
partition is "not a block device". Partitions AFTER this do work properly, 
therefore I can mount /dev/hde3, for instance, but not /dev/hde1. 

Moving the drive to a different port (e.g. making it /dev/hdg, /dev/hdi, 
etc.) fixes the problem, and I can access the first partition properly, 
therefore it is not a problem with the drive, but rather with the driver 
(as Win2k can address the first partition on the first port without any 
problems).

This leads me to believe that there is either a problem addressing the 
early blocks of the device on the first port, or a problem with how the 
driver handles its partitioning internally.

[4.] (from memory) 2.4.21-pre5, compiled with 2.95.3, but also observed in 
2.4.21-pre4.

[5.] There was no Oops:

[6.] 

# Take a drive that is properly partitioned and formatted on another 
# port/controller with your filesystem of choice, and place it on 
# port 1 of the onboard HPT374 controller, in the case of my 
# EP-8K9A3+ it is the bottom port of the four.

mount /dev/hde1 /mnt/myfavoritemountpoint

[7.] This is where I'm getting lazy. As the machine is in pieces at the
moment I can't generate the necessary output here. I wish I could give
more info on this. :-( I can only hope that someone with more clue than I
has similar hardware and can try to replecate the problem. I will briefly 
describe the system though.

Epox EP-8K9A3+ mb (KT400-based)
Athlon XP 1800+ Palomino core running at stock rates
2 X Crucial PC2700 512MB  
ATI Radeon 7500 AIW
3Com 3c905-series NIC (driver not loaded, using onboard NIC right now)
RealMagic Hollywood Plus (no driver loaded)

The error seems to occur regardless of which modules are loaded and what 
state the system is in.

I'm sorry I'm not giving better info. :-( In any case I hope someone can 
make use of this information. If anyone is interested in taking up the 
problem, please write me directly as I do not subscribe to the LKML 
(though I do read through the archives from time to time). Thanks!

-----
James Sellman -- ISU CoE-CS/ISLUG Linux Lab Admin   |"Lum, did you just see
----------------------------------------------------| a hentai rabbit flying
skuld@inconnu.isu.edu      |   // A4000/604e/60 128M| through the air?"
skuld@anime.net            | \X/  A500/20 3M        |   - Miyake Shinobu

