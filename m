Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbTDJXPn (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264237AbTDJXPn (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:15:43 -0400
Received: from ip-64-7-1-79.dsl.lax.megapath.net ([64.7.1.79]:28924 "EHLO
	ip-64-7-1-79.dsl.lax.megapath.net") by vger.kernel.org with ESMTP
	id S264236AbTDJXPW (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 19:15:22 -0400
Date: Thu, 10 Apr 2003 15:27:00 -0700 (PDT)
From: <lk@trolloc.com>
X-X-Sender: <bpape@ip-64-7-1-79.dsl.lax.megapath.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre7 hpt374 wierdness
Message-ID: <Pine.LNX.4.33.0304101509410.5231-100000@ip-64-7-1-79.dsl.lax.megapath.net>
X-keyboard: Happy Hacking Keyboard Lite
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two Highpoint RocketRAID 1540 controllers (with HPT374 chips and
Marvell bridges) in a SuperMicro X5DPE-G2 motherboard, running
2.4.21-pre7, running 8 Maxtor 6Y200P0 200GB drives with SATA cables and
Highpoint Rockethead SATA-PATA adapters.

The Highpoint BIOS correctly sees all 8 drives, in ATA/133 mode.

When the kernel boots and loads the hpt366 driver, I'm seeing one of two 
scenarios:

If the cards are inserted into the PCI slots 4, 5, or 6 the kernel only
sees the first 6 drives (ide2 .. ide7; interfaces 1 and 2 on the first
card, and interface 3 on the second card).  The two drives on the 4th
interface are not seen.

If I run the cards in the PCI slots 1, 2, or 3, the kernel sees all 8 
devices (ide2 .. ide9), but it thinks the cable type is ATA-33 for the two 
drives on the 4th interface, and I get IDE errors:
Apr 10 08:30:33 nfs2 kernel: hds: drive not ready for command
Apr 10 08:30:33 nfs2 kernel: hds: status error: status=0x58 { DriveReady SeekComplete DataRequest }


Below are the dmesg excerpts from the cards in slots 1-2 (look for SLOT12)
as well as from the cards in slots 4-5 (look for SLOT45)

Thanks!



Here's /proc/ide/htp366:
                             HighPoint HPT366/368/370/372/374

Controller: 0
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------
Enabled:        yes                             yes
Cable:          ATA-66                          ATA-66

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------
DMA capable:    yes              no             yes               no 
Mode:           UDMA             off            UDMA              off 

Controller: 1
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------
Enabled:        yes                             yes
Cable:          ATA-66                          ATA-66

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------
DMA capable:    yes              no             yes               no 
Mode:           UDMA             off            UDMA              off 

Controller: 2
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------
Enabled:        yes                             yes
Cable:          ATA-66                          ATA-66

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------
DMA capable:    yes              no             yes               no 
Mode:           UDMA             off            UDMA              off 

Controller: 3
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------
Enabled:        yes                             yes
Cable:          ATA-33                          ATA-33

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------
DMA capable:    yes              no             yes               no 
Mode:           UDMA             off            UDMA              off 



----------------------------------------------------------------------
SLOT12 
This is dmesg output when the cards are in PCI slots 1 and 2


Apr 10 08:30:33 nfs2 kernel: HPT374: IDE controller at PCI slot 05:02.0
Apr 10 08:30:33 nfs2 kernel: HPT374: chipset revision 7
Apr 10 08:30:33 nfs2 kernel: HPT374: not 100%% native mode: will probe irqs later
Apr 10 08:30:33 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 10 08:30:33 nfs2 kernel:     ide2: BM-DMA at 0x4000-0x4007, BIOS settings: hde:DMA, hdf:pio
Apr 10 08:30:33 nfs2 kernel:     ide3: BM-DMA at 0x4008-0x400f, BIOS settings: hdg:DMA, hdh:pio
Apr 10 08:30:33 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 10 08:30:33 nfs2 kernel:     ide4: BM-DMA at 0x4400-0x4407, BIOS settings: hdi:DMA, hdj:pio
Apr 10 08:30:33 nfs2 kernel:     ide5: BM-DMA at 0x4408-0x440f, BIOS settings: hdk:DMA, hdl:pio
Apr 10 08:30:33 nfs2 kernel: HPT374: IDE controller at PCI slot 05:03.0
Apr 10 08:30:33 nfs2 kernel: HPT374: chipset revision 7
Apr 10 08:30:33 nfs2 kernel: HPT374: not 100%% native mode: will probe irqs later
Apr 10 08:30:33 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 10 08:30:33 nfs2 kernel:     ide6: BM-DMA at 0x4800-0x4807, BIOS settings: hdm:DMA, hdn:pio
Apr 10 08:30:33 nfs2 kernel:     ide7: BM-DMA at 0x4808-0x480f, BIOS settings: hdo:DMA, hdp:pio
Apr 10 08:30:33 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 10 08:30:33 nfs2 kernel:     ide8: BM-DMA at 0x4c00-0x4c07, BIOS settings: hdq:DMA, hdr:pio
Apr 10 08:30:33 nfs2 kernel:     ide9: BM-DMA at 0x4c08-0x4c0f, BIOS settings: hds:DMA, hdt:pio
Apr 10 08:30:33 nfs2 kernel: hda: Maxtor 6Y120L0, ATA DISK drive
Apr 10 08:30:33 nfs2 kernel: blk: queue c036f8a0, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:30:33 nfs2 kernel: hde: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:30:33 nfs2 kernel: blk: queue c0370180, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:30:33 nfs2 kernel: hdg: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:30:33 nfs2 kernel: blk: queue c03705f0, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:30:33 nfs2 kernel: hdi: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:30:33 nfs2 kernel: blk: queue c0370a60, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:30:33 nfs2 kernel: hdk: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:30:33 nfs2 kernel: blk: queue c0370ed0, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:30:33 nfs2 kernel: hdm: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:30:33 nfs2 kernel: blk: queue c0371340, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:30:33 nfs2 kernel: hdo: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:30:33 nfs2 random: Initializing random number generator:  succeeded
Apr 10 08:30:33 nfs2 kernel: blk: queue c03717b0, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:30:33 nfs2 kernel: hdq: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:30:33 nfs2 kernel: blk: queue c0371c20, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:30:33 nfs2 kernel: hds: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:30:33 nfs2 kernel: blk: queue c0372090, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:30:33 nfs2 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr 10 08:30:33 nfs2 kernel: ide2 at 0x5010-0x5017,0x5006 on irq 100
Apr 10 08:30:33 nfs2 kernel: ide3 at 0x5008-0x500f,0x5002 on irq 100
Apr 10 08:30:33 nfs2 kernel: ide4 at 0x5028-0x502f,0x501e on irq 100
Apr 10 08:30:33 nfs2 kernel: ide5 at 0x5020-0x5027,0x501a on irq 100
Apr 10 08:30:33 nfs2 kernel: ide6 at 0x5040-0x5047,0x5036 on irq 104
Apr 10 08:30:33 nfs2 kernel: ide7 at 0x5038-0x503f,0x5032 on irq 104
Apr 10 08:30:33 nfs2 kernel: ide8 at 0x5058-0x505f,0x504e on irq 104
Apr 10 08:30:33 nfs2 kernel: ide9 at 0x5050-0x5057,0x504a on irq 104
Apr 10 08:30:33 nfs2 kernel: hda: attached ide-disk driver.
Apr 10 08:30:33 nfs2 kernel: hda: host protected area => 1
Apr 10 08:30:33 nfs2 kernel: hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
Apr 10 08:30:33 nfs2 kernel: hde: attached ide-disk driver.
Apr 10 08:30:33 nfs2 kernel: hde: host protected area => 1
Apr 10 08:30:33 nfs2 kernel: hde: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:30:33 nfs2 kernel: hdg: attached ide-disk driver.
Apr 10 08:30:33 nfs2 kernel: hdg: host protected area => 1
Apr 10 08:30:33 nfs2 kernel: hdg: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:30:33 nfs2 kernel: hdi: attached ide-disk driver.
Apr 10 08:30:33 nfs2 kernel: hdi: host protected area => 1
Apr 10 08:30:33 nfs2 kernel: hdi: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:30:33 nfs2 kernel: hdk: attached ide-disk driver.
Apr 10 08:30:33 nfs2 kernel: hdk: host protected area => 1
Apr 10 08:30:33 nfs2 kernel: hdk: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:30:33 nfs2 kernel: hdm: attached ide-disk driver.
Apr 10 08:30:33 nfs2 kernel: hdm: host protected area => 1
Apr 10 08:30:33 nfs2 kernel: hdm: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:30:33 nfs2 kernel: hdo: attached ide-disk driver.
Apr 10 08:30:33 nfs2 kernel: hdo: host protected area => 1
Apr 10 08:30:33 nfs2 kernel: hdo: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:30:33 nfs2 kernel: hdq: attached ide-disk driver.
Apr 10 08:30:33 nfs2 kernel: hdq: host protected area => 1
Apr 10 08:30:33 nfs2 kernel: hdq: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(33)
Apr 10 08:30:33 nfs2 kernel: hds: attached ide-disk driver.
Apr 10 08:30:33 nfs2 kernel: hds: host protected area => 1
Apr 10 08:30:33 nfs2 kernel: hds: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(33)
Apr 10 08:30:33 nfs2 kernel: ide-floppy driver 0.99.newide
Apr 10 08:30:33 nfs2 kernel: Partition check:
Apr 10 08:30:33 nfs2 kernel:  hda: hda1 hda2 hda4 < hda5 hda6 hda7 >
Apr 10 08:30:33 nfs2 kernel:  hde: hde1
Apr 10 08:30:33 nfs2 kernel:  hdg: hdg1
Apr 10 08:30:33 nfs2 kernel:  hdi: hdi1
Apr 10 08:30:33 nfs2 kernel:  hdk: hdk1
Apr 10 08:30:33 nfs2 kernel:  hdm: hdm1
Apr 10 08:30:33 nfs2 kernel:  hdo: hdo1
Apr 10 08:30:33 nfs2 kernel:  hdq: hdq1
Apr 10 08:30:33 nfs2 kernel:  hds: hds1
Apr 10 08:30:33 nfs2 kernel: ide-floppy driver 0.99.newide





----------------------------------------------------------------------
SLOT45 
This is dmesg output when the cards are in PCI slots 4 and 5


Apr 10 08:12:47 nfs2 kernel: HPT374: IDE controller at PCI slot 03:01.0
Apr 10 08:12:47 nfs2 kernel: HPT374: chipset revision 7
Apr 10 08:12:47 nfs2 kernel: HPT374: not 100%% native mode: will probe irqs later
Apr 10 08:12:47 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 10 08:12:47 nfs2 kernel:     ide2: BM-DMA at 0x3000-0x3007, BIOS settings: hde:DMA, hdf:pio
Apr 10 08:12:47 nfs2 kernel:     ide3: BM-DMA at 0x3008-0x300f, BIOS settings: hdg:DMA, hdh:pio
Apr 10 08:12:47 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 10 08:12:47 nfs2 kernel:     ide4: BM-DMA at 0x3400-0x3407, BIOS settings: hdi:DMA, hdj:pio
Apr 10 08:12:47 nfs2 kernel:     ide5: BM-DMA at 0x3408-0x340f, BIOS settings: hdk:DMA, hdl:pio
Apr 10 08:12:47 nfs2 kernel: HPT374: pci-config space interrupt fixed.
Apr 10 08:12:47 nfs2 kernel: HPT374: IDE controller at PCI slot 06:01.0
Apr 10 08:12:47 nfs2 kernel: HPT374: chipset revision 7
Apr 10 08:12:47 nfs2 kernel: HPT374: not 100%% native mode: will probe irqs later
Apr 10 08:12:47 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 10 08:12:47 nfs2 kernel:     ide6: BM-DMA at 0x4000-0x4007, BIOS settings: hdm:DMA, hdn:pio
Apr 10 08:12:47 nfs2 kernel:     ide7: BM-DMA at 0x4008-0x400f, BIOS settings: hdo:DMA, hdp:pio
Apr 10 08:12:47 nfs2 kernel: PCI: Unable to reserve I/O region #5:100@3400 for device 03:01.1
Apr 10 08:12:47 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 10 08:12:47 nfs2 kernel: HPT374: port 0x38a8 already claimed by ide4
Apr 10 08:12:47 nfs2 kernel: HPT374: port 0x38a0 already claimed by ide5
Apr 10 08:12:47 nfs2 kernel: HPT374: neither IDE port enabled (BIOS)
Apr 10 08:12:47 nfs2 kernel: hda: Maxtor 6Y120L0, ATA DISK drive
Apr 10 08:12:47 nfs2 kernel: blk: queue c036f8a0, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:12:47 nfs2 kernel: hde: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:12:47 nfs2 kernel: blk: queue c0370180, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:12:47 nfs2 kernel: hdg: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:12:47 nfs2 kernel: blk: queue c03705f0, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:12:47 nfs2 kernel: hdi: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:12:47 nfs2 kernel: blk: queue c0370a60, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:12:47 nfs2 kernel: hdk: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:12:47 nfs2 kernel: blk: queue c0370ed0, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:12:47 nfs2 kernel: hdm: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:12:47 nfs2 kernel: blk: queue c0371340, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:12:47 nfs2 kernel: hdo: Maxtor 6Y200P0, ATA DISK drive
Apr 10 08:12:47 nfs2 kernel: blk: queue c03717b0, I/O limit 4095Mb (mask 0xffffffff)
Apr 10 08:12:47 nfs2 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr 10 08:12:47 nfs2 kernel: ide2 at 0x3890-0x3897,0x3886 on irq 24
Apr 10 08:12:47 nfs2 kernel: ide3 at 0x3888-0x388f,0x3882 on irq 24
Apr 10 08:12:47 nfs2 kernel: ide4 at 0x38a8-0x38af,0x389e on irq 24
Apr 10 08:12:47 nfs2 kernel: ide5 at 0x38a0-0x38a7,0x389a on irq 24
Apr 10 08:12:47 nfs2 random: Initializing random number generator:  succeeded
Apr 10 08:12:47 nfs2 kernel: ide6 at 0x4810-0x4817,0x4806 on irq 72
Apr 10 08:12:47 nfs2 kernel: ide7 at 0x4808-0x480f,0x4802 on irq 72
Apr 10 08:12:47 nfs2 kernel: hda: attached ide-disk driver.
Apr 10 08:12:47 nfs2 kernel: hda: host protected area => 1
Apr 10 08:12:47 nfs2 kernel: hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
Apr 10 08:12:47 nfs2 kernel: hde: attached ide-disk driver.
Apr 10 08:12:47 nfs2 kernel: hde: host protected area => 1
Apr 10 08:12:47 nfs2 kernel: hde: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:12:47 nfs2 kernel: hdg: attached ide-disk driver.
Apr 10 08:12:47 nfs2 kernel: hdg: host protected area => 1
Apr 10 08:12:47 nfs2 kernel: hdg: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:12:47 nfs2 kernel: hdi: attached ide-disk driver.
Apr 10 08:12:47 nfs2 kernel: hdi: host protected area => 1
Apr 10 08:12:47 nfs2 kernel: hdi: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:12:47 nfs2 kernel: hdk: attached ide-disk driver.
Apr 10 08:12:47 nfs2 kernel: hdk: host protected area => 1
Apr 10 08:12:47 nfs2 kernel: hdk: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:12:47 nfs2 kernel: hdm: attached ide-disk driver.
Apr 10 08:12:47 nfs2 kernel: hdm: host protected area => 1
Apr 10 08:12:47 nfs2 kernel: hdm: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:12:47 nfs2 kernel: hdo: attached ide-disk driver.
Apr 10 08:12:47 nfs2 kernel: hdo: host protected area => 1
Apr 10 08:12:47 nfs2 kernel: hdo: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 10 08:12:47 nfs2 kernel: ide-floppy driver 0.99.newide
Apr 10 08:12:47 nfs2 kernel: Partition check:
Apr 10 08:12:47 nfs2 kernel:  hda: hda1 hda2 hda4 < hda5 hda6 hda7 >
Apr 10 08:12:47 nfs2 kernel:  hde: hde1
Apr 10 08:12:47 nfs2 kernel:  hdg: hdg1
Apr 10 08:12:47 nfs2 kernel:  hdi: hdi1
Apr 10 08:12:47 nfs2 kernel:  hdk: hdk1
Apr 10 08:12:47 nfs2 kernel:  hdm: hdm1
Apr 10 08:12:47 nfs2 kernel:  hdo: hdo1
Apr 10 08:12:47 nfs2 kernel: ide-floppy driver 0.99.newide
...
Apr 10 08:30:33 nfs2 kernel: hds: status error: status=0x58 { DriveReady SeekCom
plete DataRequest }
Apr 10 08:30:33 nfs2 kernel: 
Apr 10 08:30:33 nfs2 kernel: hds: drive not ready for command
Apr 10 08:30:33 nfs2 kernel: hdq: status error: status=0x58 { DriveReady SeekCom
plete DataRequest }
Apr 10 08:30:33 nfs2 kernel: 
Apr 10 08:30:33 nfs2 kernel: hdq: drive not ready for command
Apr 10 08:30:33 nfs2 kernel: hds: status error: status=0x58 { DriveReady SeekCom
plete DataRequest }
Apr 10 08:30:33 nfs2 kernel: 
Apr 10 08:30:33 nfs2 kernel: hds: drive not ready for command 
Apr 10 08:30:33 nfs2 kernel: hds: status error: status=0x58 { DriveReady SeekCom
plete DataRequest }
Apr 10 08:30:33 nfs2 kernel: 
Apr 10 08:30:33 nfs2 kernel: hds: drive not ready for command
Apr 10 08:30:33 nfs2 kernel: hds: status error: status=0x58 { DriveReady SeekCom
plete DataRequest }


