Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293246AbSCAPjd>; Fri, 1 Mar 2002 10:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293270AbSCAPj0>; Fri, 1 Mar 2002 10:39:26 -0500
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:51599 "EHLO
	stud.fbi.fh-darmstadt.de") by vger.kernel.org with ESMTP
	id <S293246AbSCAPjJ>; Fri, 1 Mar 2002 10:39:09 -0500
Date: Fri, 1 Mar 2002 16:30:33 +0100 (CET)
From: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>
To: shura <shura@tibc.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <8707.020228@tibc.ru>
Message-ID: <Pine.LNX.4.30.0203011613480.11729-100000@stud.fbi.fh-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> I'm setting up a new machine with a pair of IDE drives connected to
> HPT 370 controller. I defined a RAID-1 array using the HPT370 bios
> setting utility.
> Description - hard:
> motherboard Abit ST6-RAID, HPT370, 2 identical hard disks as
> primary/secondary master on ide3/ide4
> - bios:
> Primary Master:   Mirror (Raid 1) for Array #0 UDMA 5 78150 BOOT
> Primary Slave:    No drive
> Secondary Master: Mirror (Raid 1) for Array #0 UDMA 5 78150 HIDDEEN
> Secondary Slave:  No drive
> - os:
> Linux RedHat 7.1 & kernel 2.4.17
> with compilation option
> CONFIG_BLK_DEV_ATARAID_HPT=y
> Lilo:
> ...
> root=/dev/hde10

The root should be /dev/ataraid/xxx for any ata raid but that is not the
real problem...

> During system booting i see following
> ...
> ataraid/d0: ataraid/d0p1 ataraid/d0p2 ataraid/d0p3 ataraid/d0p4 <>
> Highpoint HPT370 Softwareraid driver for linux version 0.01
> Drive 0 is 76319 Mb
> Drive 6 is 76319 Mb
> Raid array consists of 2 drivers
> ...
> Kernel panic: VFS: Unable to mount root fs on 21:0a
> ...

Ataraid seems to find four partitions d0p[1234]. But as far as I know
mirroring isn't supported by the in kernel open source drivers at all -
you may look at the closed source drivers at www.highpoint-tech.com, if
you really need the "hpt native" raid.
(http://people.redhat.com/arjanv/pdcraid/ataraidhowto.html)

> Booting with option root=/dev/atarad/d0p1 ro
> (or root=/dev/ataraid/d0p10 ro)
> and etc - no effect

If you just just use need to access the harddisks from linux it is
suggested to use linux software raid (there was a discussion at lkml - if
I remember right). On modern PCs it uses < 5% CPU and is faster, as it
operates high level in the kernel, not right before the hardware, as those
"big software part, small hardware part" raid controller from Promise and
Highpoint do.

HTH

Jan-Marek

