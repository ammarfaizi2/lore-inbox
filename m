Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSHMMOk>; Tue, 13 Aug 2002 08:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSHMMOk>; Tue, 13 Aug 2002 08:14:40 -0400
Received: from [64.105.35.243] ([64.105.35.243]:23168 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315257AbSHMMOi>; Tue, 13 Aug 2002 08:14:38 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 13 Aug 2002 05:18:21 -0700
Message-Id: <200208131218.FAA01126@adam.yggdrasil.com>
To: aia21@cantab.net
Subject: Re: [BUG] 2.5.31 doesn't boot - looks IDE related
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2002-08-13 8:38:02, Anton Altaparmakov wrote:
>2.5.31 dies with the last messages being:
>[snip]
>ATA/ATAPI device driver v7.0.0
>ATA: PCI bus speed 33.3MHz
>ATA: VIA Technologies, Inc. Bus Master IDE, PCI slot 00:07.1
>ATA: chipset rev.: 6
>ATA: non-legacy mode: IRQ probe delayed
>VP_IDE: VIA vt82c686b (rev 40) ATA UDMA100 controller on PCI 00:07.1
>    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
>hda: IC35L040AVER07-0, DISK drive
>hdc: LITE-ON LTR-12102B, ATAPI CD/DVD-ROM drive 
>hdd: Maxtor 90288D2, DISK drive 
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>ide1 at 0x170-0x177,0x376 on irq 15
><it is dead>

	I am running 2.5.31 on two computers that have a Via vt82c686b
chipset (in addition to some other computers).  I am running them with
IDE as module and with CONFIG_PREEMPT (with Skip Ford's fix), and I
also booted one without CONFIG_PREEMPT.  On one machine, I have booted
the kernel about ten times.  These are multiprocessor kernels running on
uniprocessor machines.

ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: PCI device 1106:0571, PCI slot 00:04.1
ATA: chipset rev.: 16
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c596b (rev 23) ATA UDMA66 controller on PCI 00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 98196H8, DISK drive
hdc: Pioneer CD-ROM ATAPI Model DVD-A01X 010, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 160086528 sectors w/2048KiB Cache, CHS=158816/16/63, UDMA(66)

ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: PCI device 1106:0571, PCI slot 00:07.1
ATA: chipset rev.: 6
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c596b (rev 12) ATA UDMA66 controller on PCI 00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 92720U8, DISK drive
hdc: LTN262, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 53177040 sectors w/2048KiB Cache, CHS=52755/16/63, UDMA(66)


	While you're waiting for someone who knows what they're doing
to respond, you might to try booting 2.5.31 with the CDROM and second
hard disk unplugged to narrow down what is triggering the hang.  If
it still hangs, you might try dd'ing the vmlinux to a floppy, and
unplugging the first hard disk to see if the kernel gets past IDE
detect with no drives attached and, if so, with only the second
cable attached (the one with the Maxtor and the CD-ROM drive).

	By the way, you might want to post the make and model of that
"IC35L040AVER07-0" primary hard disk.  Perhaps someone else who has
tried 2.5.31 with that hard disk will be able to tell you how they
fared.

	By the way, I see that you forwarded those BUG_ON patches
in ntfs to Linus and that they're in 2.5.31.  Thanks for doing that
so quickly.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
