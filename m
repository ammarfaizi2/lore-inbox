Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTDVT6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTDVT6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:58:24 -0400
Received: from ip-64-7-1-79.dsl.lax.megapath.net ([64.7.1.79]:10694 "EHLO
	ip-64-7-1-79.dsl.lax.megapath.net") by vger.kernel.org with ESMTP
	id S263488AbTDVT6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:58:19 -0400
Date: Tue, 22 Apr 2003 13:10:23 -0700 (PDT)
From: <lk@trolloc.com>
X-X-Sender: <bpape@ip-64-7-1-79.dsl.lax.megapath.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: HPT374 - 2.4.21-rc1 - closer, but still broken
Message-ID: <Pine.LNX.4.33.0304221309150.17017-100000@ip-64-7-1-79.dsl.lax.megapath.net>
X-keyboard: Happy Hacking Keyboard Lite
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Setup: 8 Maxtor drives on 2 Highpoint 1540 controllers, Supermicro
X5DPE-G2 motherboard.
Kernel 2.4.21-rc1

In 2.4.21-pre*, the last 2 drives would result in the following errors:
Apr 10 11:07:30 nfs2 kernel: hds: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Apr 10 11:07:30 nfs2 kernel: hds: drive not ready for command


In 2.4.21-rc1, the error is now:
Apr 22 02:34:16 nfs2 kernel: HPT374: port 0x4828 already claimed by ide4
Apr 22 02:34:16 nfs2 kernel: HPT374: port 0x4820 already claimed by ide5

and drives /dev/hds and /dev/hdq aren't enumerated.

Highpoint BIOSes are enabled, although disabling them makes no difference.


lspci -v doesn't seem to reflect this message.


--------------------------
Apr 22 02:34:16 nfs2 kernel: HPT374: IDE controller at PCI slot 05:01.0
Apr 22 02:34:16 nfs2 kernel: HPT374: chipset revision 7
Apr 22 02:34:16 nfs2 kernel: HPT374: not 100%% native mode: will probe irqs later
Apr 22 02:34:16 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 22 02:34:16 nfs2 kernel:     ide2: BM-DMA at 0x4000-0x4007, BIOS settings: hde:DMA, hdf:pio
Apr 22 02:34:16 nfs2 kernel:     ide3: BM-DMA at 0x4008-0x400f, BIOS settings: hdg:DMA, hdh:pio
Apr 22 02:34:16 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 22 02:34:16 nfs2 kernel:     ide4: BM-DMA at 0x4400-0x4407, BIOS settings: hdi:DMA, hdj:pio
Apr 22 02:34:16 nfs2 kernel:     ide5: BM-DMA at 0x4408-0x440f, BIOS settings: hdk:DMA, hdl:pio
Apr 22 02:34:16 nfs2 kernel: HPT374: IDE controller at PCI slot 06:01.0
Apr 22 02:34:16 nfs2 kernel: HPT374: chipset revision 7
Apr 22 02:34:16 nfs2 kernel: HPT374: not 100%% native mode: will probe irqs later
Apr 22 02:34:16 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 22 02:34:16 nfs2 kernel:     ide6: BM-DMA at 0x5000-0x5007, BIOS settings: hdm:DMA, hdn:pio
Apr 22 02:34:16 nfs2 kernel:     ide7: BM-DMA at 0x5008-0x500f, BIOS settings: hdo:DMA, hdp:pio
Apr 22 02:34:16 nfs2 kernel: PCI: Unable to reserve I/O region #5:100@4400 for device 05:01.1
Apr 22 02:34:16 nfs2 kernel: HPT37X: using 33MHz PCI clock
Apr 22 02:34:16 nfs2 kernel: HPT374: port 0x4828 already claimed by ide4
Apr 22 02:34:16 nfs2 kernel: HPT374: port 0x4820 already claimed by ide5
Apr 22 02:34:16 nfs2 kernel: HPT374: neither IDE port enabled (BIOS)
Apr 22 02:34:16 nfs2 kernel: hda: Maxtor 6Y120L0, ATA DISK drive
Apr 22 02:34:16 nfs2 kernel: blk: queue c036f8a0, I/O limit 4095Mb (mask 0xffffffff)
Apr 22 02:34:16 nfs2 kernel: hde: Maxtor 6Y200P0, ATA DISK drive
Apr 22 02:34:16 nfs2 kernel: blk: queue c0370180, I/O limit 4095Mb (mask 0xffffffff)
Apr 22 02:34:16 nfs2 kernel: hdg: Maxtor 6Y200P0, ATA DISK drive
Apr 22 02:34:16 nfs2 kernel: blk: queue c03705f0, I/O limit 4095Mb (mask 0xffffffff)
Apr 22 02:34:16 nfs2 kernel: hdi: Maxtor 6Y200P0, ATA DISK drive
Apr 22 02:34:16 nfs2 kernel: blk: queue c0370a60, I/O limit 4095Mb (mask 0xffffffff)
Apr 22 02:34:16 nfs2 kernel: hdk: Maxtor 6Y200P0, ATA DISK drive
Apr 22 02:34:16 nfs2 kernel: blk: queue c0370ed0, I/O limit 4095Mb (mask 0xffffffff)
Apr 22 02:34:16 nfs2 kernel: hdm: Maxtor 6Y200P0, ATA DISK drive
Apr 22 02:34:16 nfs2 kernel: blk: queue c0371340, I/O limit 4095Mb (mask 0xffffffff)
Apr 22 02:34:16 nfs2 kernel: hdo: Maxtor 6Y200P0, ATA DISK drive
Apr 22 02:34:16 nfs2 kernel: blk: queue c03717b0, I/O limit 4095Mb (mask 0xffffffff)
Apr 22 02:34:16 nfs2 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr 22 02:34:16 nfs2 kernel: ide2 at 0x4810-0x4817,0x4806 on irq 96
Apr 22 02:34:16 nfs2 kernel: ide3 at 0x4808-0x480f,0x4802 on irq 96
Apr 22 02:34:16 nfs2 kernel: ide4 at 0x4828-0x482f,0x481e on irq 96
Apr 22 02:34:16 nfs2 kernel: ide5 at 0x4820-0x4827,0x481a on irq 96
Apr 22 02:34:16 nfs2 kernel: ide6 at 0x5810-0x5817,0x5806 on irq 72
Apr 22 02:34:16 nfs2 kernel: ide7 at 0x5808-0x580f,0x5802 on irq 72
Apr 22 02:34:16 nfs2 kernel: hda: attached ide-disk driver.
Apr 22 02:34:16 nfs2 kernel: hda: host protected area => 1
Apr 22 02:34:16 nfs2 kernel: hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
Apr 22 02:34:16 nfs2 kernel: hde: attached ide-disk driver.
Apr 22 02:34:16 nfs2 kernel: hde: host protected area => 1
Apr 22 02:34:16 nfs2 kernel: hde: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 22 02:34:16 nfs2 kernel: hdg: attached ide-disk driver.
Apr 22 02:34:16 nfs2 kernel: hdg: host protected area => 1
Apr 22 02:34:16 nfs2 kernel: hdg: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 22 02:34:16 nfs2 kernel: hdi: attached ide-disk driver.
Apr 22 02:34:16 nfs2 kernel: hdi: host protected area => 1
Apr 22 02:34:16 nfs2 kernel: hdi: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 22 02:34:16 nfs2 kernel: hdk: attached ide-disk driver.
Apr 22 02:34:16 nfs2 kernel: hdk: host protected area => 1
Apr 22 02:34:16 nfs2 kernel: hdk: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 22 02:34:16 nfs2 kernel: hdm: attached ide-disk driver.
Apr 22 02:34:16 nfs2 kernel: hdm: host protected area => 1
Apr 22 02:34:16 nfs2 kernel: hdm: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 22 02:34:16 nfs2 kernel: hdo: attached ide-disk driver.
Apr 22 02:34:16 nfs2 kernel: hdo: host protected area => 1
Apr 22 02:34:16 nfs2 kernel: hdo: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Apr 22 02:34:16 nfs2 kernel: ide-floppy driver 0.99.newide
Apr 22 02:34:16 nfs2 kernel: Partition check:
Apr 22 02:34:16 nfs2 kernel:  hda: hda1 hda2 hda4 < hda5 hda6 hda7 >
Apr 22 02:34:16 nfs2 kernel:  hde: hde1
Apr 22 02:34:16 nfs2 kernel:  hdg: hdg1
Apr 22 02:34:16 nfs2 kernel:  hdi: hdi1
Apr 22 02:34:16 nfs2 kernel:  hdk: hdk1
Apr 22 02:34:16 nfs2 kernel:  hdm: hdm1
Apr 22 02:34:16 nfs2 kernel:  hdo: hdo1







# lspci -v

05:01.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 96
	I/O ports at 4810 [size=8]
	I/O ports at 4804 [size=4]
	I/O ports at 4808 [size=8]
	I/O ports at 4800 [size=4]
	I/O ports at 4000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2

05:01.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 96
	I/O ports at 4828 [size=8]
	I/O ports at 481c [size=4]
	I/O ports at 4820 [size=8]
	I/O ports at 4818 [size=4]
	I/O ports at 4400 [size=256]
	Capabilities: [60] Power Management version 2

06:01.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 72
	I/O ports at 5810 [size=8]
	I/O ports at 5804 [size=4]
	I/O ports at 5808 [size=8]
	I/O ports at 5800 [size=4]
	I/O ports at 5000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2

06:01.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 72
	I/O ports at 5828 [size=8]
	I/O ports at 581c [size=4]
	I/O ports at 5820 [size=8]
	I/O ports at 5818 [size=4]
	I/O ports at 5400 [size=256]
	Capabilities: [60] Power Management version 2


