Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261314AbREOThp>; Tue, 15 May 2001 15:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbREOThf>; Tue, 15 May 2001 15:37:35 -0400
Received: from geos.coastside.net ([207.213.212.4]:8872 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261314AbREOThZ>; Tue, 15 May 2001 15:37:25 -0400
Mime-Version: 1.0
Message-Id: <p05100316b7272cdfd50c@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>
Date: Tue, 15 May 2001 12:36:32 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:15 AM -0700 2001-05-15, Linus Torvalds wrote:
>The part I absolutely detest is when the information becomes more than
>just "information", and is used to enforce a world-view. Anybody who uses
>physical location for naming devices (ie you have to know where the hell
>the thing is in order to look it up), is so far out to lunch that it's not
>even funny. And the sad fact is that this is pretty much how ALL unixes
>have historically done things ("Oh, you want to see the disk? Sure. It's
>on scsi bus 1, channel 2, ID 3, lun 0, so you just open /dev/s1c3l0 and
>you're done! Easy as pie!").
>
>Keep it informational. And NEVER EVER make it part of the design.

What about:

1 (network domain). I have two network interfaces that I connect to 
two different network segments, eth0 & eth1; they're ifconfig'd to 
the appropriate IP and MAC addresses. I really do need to know 
physically which (physical) hole to plug my eth0 cable into. 
(Extension: same situation, but it's a firewall and I've got 12 ports 
to connect.) (Extension #2: if I add a NIC to the system and reboot, 
I'd really prefer that the NICs already in use didn't get renumbered.)

2 (disk domain). I have multiple spindles on multiple SCSI adapters. 
I want to allocate them to more than one RAID0/1/5 set, with the 
usual considerations of putting mirrors on different adapters, 
spreading my RAID5 drives optimally, ditto stripes. I need (eg) SCSI 
paths to config all this, and I further need real physical locations 
to identify failed drives that need to be hot-replaced. The mirror 
members will move around as drives are replaced and hot spares come 
into play.

Seems like more that merely informational.

(A side observation: PCI or SCSI bus/device/lun/etc paths are not 
physical locations; you also need external hardware-specific 
knowledge to be able to talk about real physical locations in a way 
that does the system operator any good.)
-- 
/Jonathan Lundell.
