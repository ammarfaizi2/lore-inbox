Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbSLFTWj>; Fri, 6 Dec 2002 14:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265677AbSLFTWj>; Fri, 6 Dec 2002 14:22:39 -0500
Received: from [209.48.37.1] ([209.48.37.1]:53377 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S265670AbSLFTWg>;
	Fri, 6 Dec 2002 14:22:36 -0500
Date: Fri, 6 Dec 2002 11:29:57 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200212061929.gB6JTvq10286@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 beats 2.5.50 in hard drive access????
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same hard drive (Western Digital 7200 rpm 80 gig ATA100 drive).

Test program does scattered reads across disk surface, each read is 96256
bytes, and it uses threads. Each thread opens the device, does a read, then
closes the device. The program spawns 250 threads. The reads are each from a
different random place on the disk. Each time the program is run the random
number generator is seeded from the time of day clock, so the random
locations are always unique.

2.4.18 gets 7.26 megs/second read capacity.
2.5.50 gets 1.92 megs/second read capacity with TCQ off.
2.5.50 gets 1.97 megs/second read capacity with TCQ on, set to 32.

Part of my dmesg is this:
Kernel command line: rw root=/dev/rd/0 rdbase= ide0=ata66 ide1=ata66 idebus=66 
ide_setup: ide0=ata66
ide_setup: ide1=ata66
ide_setup: idebus=66
...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
SvrWks OSB4: IDE controller at PCI slot 00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1880-0x1887, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0x1888-0x188f, BIOS settings: hdc:pio, hdd:DMA
hda: LTN486S, ATAPI CD/DVD-ROM drive
hdb: WDC WD800BB-00CAA1, ATA DISK drive
hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hda: set_drive_speed_status: error=0x04
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD800BB-00CAA1, ATA DISK drive
hdd: WDC WD800BB-00CAA1, ATA DISK drive
hdc: DMA disabled
hdc: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
hdb: host protected area => 1
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=10337/240/63, (U)DMA
 /dev/ide/host0/bus0/target1/lun0: unknown partition table
hdc: host protected area => 1
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63
 /dev/ide/host0/bus1/target0/lun0: unknown partition table
hdd: host protected area => 1
hdd: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, (U)DMA
 /dev/ide/host0/bus1/target1/lun0: unknown partition table
hda: ATAPI 48X CD-ROM drive, 120kB Cache


All three drives (hdb,hdc,hdd) are identical.
I put in the idebus=66 because there was a kernel warning about that
earlier but it made no difference. Nor did the ide?=ata66. I've
tried forcing the BIOS to use udma2 instead of autodetecting, since there
was some issue on a google search about that in a similiar problem. No
difference.

Possibly I tried this experiment with 2.5.40 (or 2.5.16) and got better
results, but I'm not certain, and it would have been on completely different
hardware.

On the SeekComplete Error messages I tried turning the IDEDISK_MULTI_MODE
on, but it didn't make any difference (it is on in this case).

Any help appreciated.
-Dave
