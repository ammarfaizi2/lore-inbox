Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSHKCVM>; Sat, 10 Aug 2002 22:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSHKCVM>; Sat, 10 Aug 2002 22:21:12 -0400
Received: from zooty.lancs.ac.uk ([148.88.16.231]:49625 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S317422AbSHKCVL>; Sat, 10 Aug 2002 22:21:11 -0400
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: steveb@unix.lancs.ac.uk
Date: Sun, 11 Aug 2002 03:24:57 +0100
Subject: Re: 2.4.19 IDE Partition Check issue (again)
To: linux-kernel@vger.kernel.org
Message-Id: <E17diPZ-0004bU-00@wing1.lancs.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is an old issue, but I'm still seeing this problem between
ALI15x3 and Maxtor drives when DMA is enabled...

If I run 2.4.19 DMA is not autodetected. I get lousy performance. I can enable DMA (with hdparm) on all but my Maxtor drive, but if I manually enable DMA on the Maxtor drive disk access freezes (to both drives on the channel).

If I run 2.4.19-ac4 DMA is turned on automatically and the system hangs at the partition check.

on 2.4.19 I see this in dmesg:
...
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 20
PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using pci=biosirq.
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340016A, ATA DISK drive
hdb: Maxtor 4G120J6, ATA DISK drive
hdc: RICOH DVD/CDRW MP9120, ATAPI CD/DVD-ROM drive
hdd: IBM-DPTA-372050, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63
hdb: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63
hdd: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=39770/16/63, UDMA(66)
ide-floppy driver 0.99.newide
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
 /dev/ide/host0/bus0/target1/lun0: p1
 /dev/ide/host0/bus1/target1/lun0: [PTBL] [2495/255/63] p1

2.4.19-ac4 (correctly) probes hda and hdb as being UDMA(100), but it looks like hdb chokes on the DMA...

Steve Bennett
