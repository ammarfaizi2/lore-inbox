Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267714AbSLGEUT>; Fri, 6 Dec 2002 23:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbSLGEUT>; Fri, 6 Dec 2002 23:20:19 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:39695 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S267714AbSLGEUR>; Fri, 6 Dec 2002 23:20:17 -0500
Subject: Re: 2.4.18 beats 2.5.50 in hard drive access????
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Ashley <dash@xdr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1039227036.25004.0.camel@irongate.swansea.linux.org.uk>
References: <200212062300.gB6N0jg10757@xdr.com>
	 <1039227036.25004.0.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1039235352.3232.22.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 06 Dec 2002 23:29:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 21:10, Alan Cox wrote:
> On Fri, 2002-12-06 at 23:00, David Ashley wrote:
> > hda is an IDE cdrom drive, but here it is:
> 
> Ok that would explain why DMA is off on it. The disk puzzles me - for an
> OSB4 the code should be selecting MWDMA2
> 


This may or may not be related.  I am still trying to dig through the
ide code to see what changed, but 2.4.x will enable DMA on my disks. 
2.5.x turns it off explicitly.  As far as I have been able to figure in
my digging (just a half hour or so, so far), my drives aren't black
listed.

Anyway, when I did my initial tests I had scsi cd stuff, not ide (now I
am dropping scsi, so I have an ide cdrw).  Here is the dmesg output from
2.4.x

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try
using pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD136AA, ATA DISK drive
hdb: ATAPI CD-RW 40/12/48X, ATAPI CD/DVD-ROM drive
hdc: WDC WD153BA, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 26564832 sectors (13601 MB) w/2048KiB Cache, CHS=1653/255/63,
(U)DMA
hdc: 30043440 sectors (15382 MB) w/2048KiB Cache, CHS=29805/16/63,
UDMA(66)
ide-floppy driver 0.99.newide
Partition check:
hda: hda1 hda2 < hda5 >
hdc: [PTBL] [1870/255/63] hdc1 hdc2 hdc3


and 2.5.47 (From system logs):

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
Nov 19 17:14:50 aurora kernel: VP_IDE: IDE controller at PCI slot
00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try
using pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD136AA, ATA DISK drive
hdb: ATAPI CD-RW 40/12/48X, ATAPI CD/DVD-ROM drive
hda: DMA disabled
hdb: DMA disabled

What is this?
Nov 19 19:09:06 aurora kernel: Speakup v-1.00 CVS: Tue Jun 11 14:22:53
EDT 2002
: initialized
Some kind of speech stuff or the kernel?

Anyway, 2.5.x does seem a little slower to me than 2.4.x on disk access
as well.  This DMA disabled worries me.

Trever Adams

--
"Magazines all too frequently lead to books and should be regarded by
the prudent as the heavy petting of literature." -- Fran Lebowitz

