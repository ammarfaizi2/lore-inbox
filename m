Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319844AbSINCyi>; Fri, 13 Sep 2002 22:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319845AbSINCyi>; Fri, 13 Sep 2002 22:54:38 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:30691 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S319844AbSINCyg>; Fri, 13 Sep 2002 22:54:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Jens Axboe <axboe@suse.de>, Andre Hedrick <andre@linux-ide.org>
Subject: Re: 34-bk current ide problems - unexpected interrupt
Date: Fri, 13 Sep 2002 22:58:21 -0400
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200209120838.44092.tomlins@cam.org> <20020913060647.GH1847@suse.de> <200209132142.23964.tomlins@cam.org>
In-Reply-To: <200209132142.23964.tomlins@cam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209132258.21297.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 13, 2002 09:42 pm, Ed Tomlinson wrote:
> Hi,
>
> To check if the problem I am seeing is with the port to 2.5 I tried
> 2.4.20-pre5-ac4 and 2.4.20-pre5-ac6.  Both booted correctly.
>
> Now to try 2.5.34+bk without Andrew's mm patch.  If that fails what
> debugging info would help solve the unexpected interrupt problem?

to summerize

2.4.20-pre5-ac4	works
2.4.20-pre5-ac5	works
2.5.34-mm1		works	(without Jens ide port of pre5-ac4)
2.5.34-mm2		fails with unexpected interrupt loop
2.5.34-bk current	fails with unexpected interrupt loop

Removing the printk from ide.c does _not_ cure the problem.   The ide
setting between 2.4 and 2.5 were as identical as I can make them.

A failing 2.5 boot gives:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
hdd: HP COLORADO 20GB, ATAPI TAPE drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
PDC20267: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 12 for device 00:09.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xeb000000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:pio
hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide2 at 0xac00-0xac07,0xb002 on irq 12
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
ide_intr: unexpected interrupt!
....

A working 2.4-pre5-ac4 boot gives:
Sep 13 21:17:50 oscar kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep 13 21:17:50 oscar kernel: ide: Assuming 33MHz system bus speed for PIO modes
Sep 13 21:17:50 oscar kernel: VP_IDE: IDE controller at PCI slot 00:07.1
Sep 13 21:17:50 oscar kernel: VP_IDE: chipset revision 6
Sep 13 21:17:50 oscar kernel: VP_IDE: not 100%% native mode: will probe irqs later
Sep 13 21:17:50 oscar kernel: VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
Sep 13 21:17:50 oscar kernel:     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
Sep 13 21:17:50 oscar kernel:     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
Sep 13 21:17:50 oscar kernel: PDC20267: IDE controller at PCI slot 00:09.0
Sep 13 21:17:50 oscar kernel: PCI: Found IRQ 12 for device 00:09.0
Sep 13 21:17:50 oscar kernel: PDC20267: chipset revision 2
Sep 13 21:17:50 oscar kernel: PDC20267: not 100%% native mode: will probe irqs later
Sep 13 21:17:50 oscar kernel: PDC20267: ROM enabled at 0xeb000000
Sep 13 21:17:50 oscar kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
Sep 13 21:17:50 oscar kernel:     ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
Sep 13 21:17:50 oscar kernel:     ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:pio
Sep 13 21:17:50 oscar kernel: hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
Sep 13 21:17:50 oscar kernel: hda: DMA disabled
Sep 13 21:17:50 oscar kernel: blk: queue c02a83c0, I/O limit 4095Mb (mask 0xffffffff)
Sep 13 21:17:50 oscar kernel: hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
Sep 13 21:17:50 oscar kernel: hdd: HP COLORADO 20GB, ATAPI TAPE drive
Sep 13 21:17:50 oscar kernel: hdc: DMA disabled
Sep 13 21:17:50 oscar kernel: hdd: DMA disabled
Sep 13 21:17:50 oscar kernel: hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
Sep 13 21:17:50 oscar kernel: blk: queue c02a8ca8, I/O limit 4095Mb (mask 0xffffffff)
Sep 13 21:17:50 oscar kernel: hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive

Notice that 2.4 orders the boot differently.  Wonder if this is significant?

What additional info would help?

Ed Tomlinson




