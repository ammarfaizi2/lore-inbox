Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267655AbTAXNyT>; Fri, 24 Jan 2003 08:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267658AbTAXNyT>; Fri, 24 Jan 2003 08:54:19 -0500
Received: from BSN-77-15-28.dsl.siol.net ([193.77.15.28]:15339 "EHLO
	klada.dyndns.org") by vger.kernel.org with ESMTP id <S267655AbTAXNyR>;
	Fri, 24 Jan 2003 08:54:17 -0500
Subject: PCI Pin A routed to interrupt line 0xff ???
From: Simon Posnjak <simon@activetools.si>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Jan 2003 15:03:29 +0100
Message-Id: <1043417009.3603.19.camel@klada.dyndns.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While looking for the cause of my problem (correctly set UDMA133 disk on
UDMA 133 controller working at 1-2M/sec) I found this

#lspci -x
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master
IDE (rev 06)
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e4 00 00 00 00 00 00 00 00 00 00 06 11 71 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00	<---!!!

If I get this correctly it wants to have 0xff interrupt line. If this is
correct how can this be possible and can I do anything about it. [And
could this be the reason for my bad transmissions times.]

I have:
-QDI Kudoz 7x board with VIA KT400 chipset (vt8235)
-2.4.18 kernel (stock RedHat 8) also tried 2.4.21pre3 and 2.4.21pre3-ac4

And I also tried upgrading the BIOS and the problem didn't go away.

At boot time I get:
-------------------
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD800JB-00CRA1, ATA DISK drive
hdc: SAMSUNG CD-R/RW SW-216B BS05 20010727, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-ROM SC-152L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63, UDMA(100)

Testing with hdparm:
--------------------
# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.54 seconds =236.61 MB/sec
 Timing buffered disk reads:  64 MB in  1.39 seconds = 45.89 MB/sec

Real life situations:
---------------------
Making of an Iso image on zero load: 5:00 min
Coping 700 MB file around the disk:  4-6 min

	Regards Simon

