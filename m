Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSK0TBM>; Wed, 27 Nov 2002 14:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbSK0TBM>; Wed, 27 Nov 2002 14:01:12 -0500
Received: from boxer.fnal.gov ([131.225.80.86]:63141 "EHLO boxer.fnal.gov")
	by vger.kernel.org with ESMTP id <S264677AbSK0TBK>;
	Wed, 27 Nov 2002 14:01:10 -0500
Date: Wed, 27 Nov 2002 13:08:29 -0600 (CST)
From: Steven Timm <timm@fnal.gov>
To: <linux-kernel@vger.kernel.org>
Subject: Tyan 2466, 2468 BIOS setting
Message-ID: <Pine.LNX.4.31.0211271302250.5024-100000@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In a number of boards with Phoenix BIOS including
the Tyan S2466 and S2468, there is a setting in the BIOS
for "Large Disk Access Mode", the available settings are
"DOS" and "Other".  Tyan docs suggest selecting "other".

These boards use the AMD 760MPX chipset. (dmesg output is below).
My question...is anyone aware of (1) does the kernel look
at this BIOS option at all, and if so (2) could having
it set to DOS instead of Other lead to any
data corruption?

Steve Timm



Kernel 2.4.9-31smp detects it as:

PCI_IDE: unknown IDE controller on PCI bus 00 device 39, VID=1022,
DID=7441
PCI_IDE: chipset revision 4
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: ST340016A, ATA DISK drive
hdb: ST380021A, ATA DISK drive
hdc: CD-ROM 56X/AKH, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63

from lspci

00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441
(rev 04)

-----------------------------------------

Kernel 2.4.18-18smp detects it as:

AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD400BB-00DEA0, ATA DISK drive
hdb: WDC WD800BB-00CAA1, ATA DISK drive
hdc: SR243T, ATAPI CD/DVD-ROM drive
hdd: WDC WD1200BB-00CAA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03f9ce4, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03f9ce4, I/O limit 4095Mb (mask 0xffffffff)
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
UDMA(100)
blk: queue c03f9e2c, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03f9e2c, I/O limit 4095Mb (mask 0xffffffff)
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63,
UDMA(100)
blk: queue c03fa188, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03fa188, I/O limit 4095Mb (mask 0xffffffff)



------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

