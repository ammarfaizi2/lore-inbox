Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTH2RhB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbTH2RhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:37:01 -0400
Received: from meetpoint.leesburg-geeks.org ([66.63.28.250]:44548 "EHLO
	meetpoint.home") by vger.kernel.org with ESMTP id S261695AbTH2Rg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:36:56 -0400
Date: Fri, 29 Aug 2003 13:36:59 -0400 (EDT)
From: Ken Ryan <newsryan@leesburg-geeks.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Single P4, make IDE PCI cards == trouble??
Message-ID: <Pine.LNX.4.21.0308291304001.806-100000@meetpoint.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nick Urbanik wrote:

> Is there _anyone_ who is using a number of ATA133 IDE disks (>=6), each
> on its own IDE channel, on a number of PCI IDE cards, and doing so
> successfully and reliably?

Not a P4-based, but AMD...

[I'm not near the machine at the moment]

Abit KG7-RAID mobo
                  - Don't remember the BIOS rev; it's 2 revs behind
                    the latest Abit BIOS.
Athlon XP 1900
1GB RAM
Onboard VIA IDE => Primary channel empty, secondary has IDE DVD-ROM
                   (Panasonic, ATA66)
Onboard HPT372 => Two Maxtor 80GB
                  - one disk per channel
                  - four partitions, all software RAID-1 + LVM on 4th
                       (controller is in plain IDE mode)
                       (part. 1 is boot/root, 2 is spare boot/root,
                          3 is /tmp, 4th is LVM for home dirs and apps)
                  - ATA100
2 x Promise TX2 ('69 chip) => Four Maxtor 80GB
                  - one disk per channel
                  - software RAID-5 + LVM (data areas)
                  - ATA133
Adaptec DuoConnect => One disk on internal firewire
                  - Internal IDE removable carrier hacked up to make it
                    Firewire hot-swap (this is how I solved my affordable
                    backup problem)
                  - Sometimes an external firewire disk
Adaptec SCSI (inexpensive aic7xxx, don't remember the model)
               => Yamhaha CD-RW (16x/4x/40x IIRC)
GeForce 4 440MX
SoundBlaster AudioPCI
100 Ethernet (don't remember which card, a cheap one)

This machine was very long in the making - I bought the parts nearly a
year ago (except for the firewire stuff) but it took the 2.4.21 kernel
before everything could be made to come up cleanly (under 2.4.18 it pretty
much worked but I maxed out the lilo 'append' line getting the disks
recognized properly - now it's just 'ide=reverse').  It's not in
"production" use yet (it's waiting for a UPS) but I've beat on it by
copying around large trees of data, large files (>4GB) and whatever else I
could think of (copying to another machine via NFS and samba,
firewire<->IDE copies, etc).  I saw no instance of data corruption.

It's using the large Antec case (with the two 3-disk trays) but I had to
put in a larger power supply because I was getting lockups (I went to 500W
which should have some margin).  I also have tons of fans - the PSU has
two, the back of the case has two, and each drive tray has one.  The air
coming out the back is still noticeably warm when it's working
hard. :-)  The NVidia card is also kept away fromAGP4x; I turned it back a
while ago when I was having lockup problems.  It may be OK at 4x now with
the updated kernel and bigger PSU but I see no reason to bother.

Since it isn't doing its proper role yet, I'd be happy to run any other
tests anyone might suggest (though my time is limited, one of the reasons
it's still not in service).


                Ken Ryan


p.s. Please CC me any responses - I do regularly read the list archives on
ussg.iu.edu but I don't have a good way to reply to messages there.

