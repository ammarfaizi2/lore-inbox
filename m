Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbUKDVmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUKDVmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbUKDVmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:42:53 -0500
Received: from ns1.vbchosting.be ([62.213.193.67]:42193 "HELO vbc.be")
	by vger.kernel.org with SMTP id S262427AbUKDVmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:42:47 -0500
Message-ID: <2169.81.83.13.5.1099605723.squirrel@www.vbchosting.be>
Date: Thu, 4 Nov 2004 23:02:03 +0100 (CET)
Subject: HPT372 (on Lanparty pro875) on 2.6.8/9 not working
From: p1234@p1.be
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few lanparty pro875 mb's.
They have the highpoint 372 hardware raid controller on board (bios
says HPT370/372 v2.345).
Each time two IDE harddisk connected (one as master on each channel),
configured as mirror.
I have one running on Linux RedHat 9 with the driver downloaded
from the highpoint website.  Works splendid, shows up as /dev/sda.
Recently I installed Fedore Core 2 (2.6.5-1.358 stock kernel).
Works splendid (shows up as /dev/hde).
Extract from the relevant boot sequence messages
kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
kernel: ICH5: chipset revision 2
kernel: ICH5: not 100%% native mode: will probe irqs later
kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
kernel: hda: CD-956E/AKV, ATAPI CD/DVD-ROM drive
kernel: Using cfq io scheduler
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: F\201Ã^D^F: IDE controller at PCI slot 0000:03:01.0
kernel: F\201Ã^D^F: chipset revision 6
kernel: HPT37X: using 33MHz PCI clock
kernel: F\201Ã^D^F: 100%% native mode on irq 185
kernel:     ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:DMA, hdf:pio
kernel: hde: Maxtor 6Y120P0, ATA DISK drive
kernel: ide2 at 0x9000-0x9007,0x9402 on irq 185
kernel: hde: max request size: 128KiB
kernel: hde: 240121728 sectors (122942 MB) w/7936KiB Cache,
CHS=65535/16/63, UDMA(100)
kernel:  hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 >

Bit weird identifier though.
For various reasons, I wanted to upgrade to 2.6.8, got the source and
compiled.  No go anymore.
Consistently, the two harddisks show up instead of the "virtual" mirror
disk, with all problems that follow (duplicate labels etc).
I checked the changes in drivers/ide/pci/hpt366.c.  Directly taking
the version from 2.6.5 is not possible as the "layout" of the ide
structures seem to have changed quite a bit.  I tried to "undo" the changes
manually in the 2.6.8 hpt366.c.  No go, still two disks show up.  So, I
fear some more (drastic) changes have been made in the general/generic
ide handling between 2.6.5 and 2.6.8, but for the life of me, I can't
find any, but then again, I am far from a kernel expert.
Also tried 2.6.9, same thing.
As these disks are my boot disks, testing is difficult and I have
no means of "grabbing" the boot log.
I looked at the log, mostly it is the same, only now it finds a HPT372N,
instead of the funny string above.
Also, standard it says "Using anticipatory io scheduler".  I booted with
the option elevator=cfq, and indeed it said "Using cfq io scheduler", but
the net result was the same, two disks, no hardware raid recognised.

THis is as far as I can get, help would be very much appreciated.

Regards,

--Pj.
Peter.
