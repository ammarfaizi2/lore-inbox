Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbTBCWcC>; Mon, 3 Feb 2003 17:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbTBCWcB>; Mon, 3 Feb 2003 17:32:01 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:51973 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S266965AbTBCWbd>;
	Mon, 3 Feb 2003 17:31:33 -0500
Message-ID: <3E3EEF6E.6080107@scssoft.com>
Date: Mon, 03 Feb 2003 23:38:38 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VIA vt8235 headache
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since after the hw update to VIA KT400 board (MSI KT4 Ultra) I am having
a problem where I can't access any devices hanging on the secondary IDE1
channel (hdd & cdrom) The hardware does work ok on the 'other' OS
though...

This is going on on 2.4.20, 2.4.21-pre4, 2.4.21-pre4-ac1
and 2.4.21-pre4 + the patch Andre is having on kernel.org:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: Hardcoded IRQ 14 for device 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340016A, ATA DISK drive
hdb: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
blk: queue c02cce00, I/O limit 4095Mb (mask 0xffffffff)
hdc: QUANTUM FIREBALL CX13.0A, ATA DISK drive
hdd: 50X CD-ROM, ATAPI CD/DVD-ROM drive
blk: queue c02cd270, I/O limit 4095Mb (mask 0xffffffff)
hdd: set_drive_speed_status: status=0x00 { }
ide1: Drive 1 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc: host protected area => 1
hdc: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=25228/16/63
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
 hdc:<3>hdc: lost interrupt
hdc: dma_timer_expiry: dma status == 0x60
hdc: DMA interrupt recovery
hdc: lost interrupt
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x00 { }
hdc: dma_timer_expiry: dma status == 0x60
hdc: DMA interrupt recovery
hdc: lost interrupt
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x00 { }
hdc: recal_intr: status=0xd0 { Busy }

hdc: DMA disabled
hdd: DMA disabled
ide1: reset: master: error (0x00?)
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
 [PTBL] [1582/255/63] hdc1

The timeouts takes ages... but it will eventually boot. I can't however 
access
anything on IDE1, this will result to another timeout round with no success
at the end.

If I physically remove the /dev/hdc (Quantum Fireball disc), I am 
getting just
this from the cdrom:

hdd: 50X CD-ROM, ATAPI CD/DVD-ROM drive
hdd: DMA disabled
hdd: set_drive_speed_status: status=0x7f { DriveReady DeviceFault 
SeekComplete DataRequest CorrectedError Index Error }
hdd: set_drive_speed_status: error=0x7f
ide1: Drive 1 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdd: ATAPI 40X CD-ROM drive, 128kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
hdd: irq timeout: status=0xd0 { Busy }
hdd: irq timeout: error=0x00
hdd: DMA disabled
hdd: ATAPI reset timed-out, status=0xd1
ide1: reset: master: error (0x7f?)

I'd be pleased if someone could enlighten me a little bit...

Thanks,
Petr



