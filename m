Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSJ2L7H>; Tue, 29 Oct 2002 06:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSJ2L7H>; Tue, 29 Oct 2002 06:59:07 -0500
Received: from math.ut.ee ([193.40.5.125]:53731 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S261854AbSJ2L7F>;
	Tue, 29 Oct 2002 06:59:05 -0500
Date: Tue, 29 Oct 2002 14:05:13 +0200 (EET)
From: Meelis Roos <mroos@math.ut.ee>
To: linux-kernel@vger.kernel.org
cc: Holger Lobitz <holger@lubitz.org>
Subject: PIIX4 IDE w/ MWDMA disk still broken in 2.4.20-rc1(bk)
Message-ID: <Pine.GSO.4.44.0210291356170.15168-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the EXTRAVERSION is -rc1 already in BK, I did try 2.4.20-current
again - just to see that mwdma disk with piix4 is still broken as in
2.4.19. I will continue using 2.4.18 but here are the details again.

I have 3 hard disks an 1 cdrom. 2 quantums in udma mode on first
channel, toshiba cdrom and 2.5G mwdma seagate on second channel:

PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL ST1.6A, ATA DISK drive
hdb: QUANTUM FIREBALL ST1.6A, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-6002B, ATAPI CD/DVD-ROM drive
hdd: ST32531A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02cdfa4, I/O limit 4095Mb (mask 0xffffffff)
hda: 3153024 sectors (1614 MB) w/81KiB Cache, CHS=782/64/63, UDMA(33)
blk: queue c02ce0f0, I/O limit 4095Mb (mask 0xffffffff)
hdb: 3153024 sectors (1614 MB) w/81KiB Cache, CHS=782/64/63, UDMA(33)
blk: queue c02ce454, I/O limit 4095Mb (mask 0xffffffff)
hdd: 4996476 sectors (2558 MB), CHS=4956/16/63, DMA

hdd is the problematic one. When I put any heavy disk load on it, the
computer just hangs in 2.4.19 and later. It is OK in 2.4.18 and below.
The drive is using mwdma2 mode (hdparm -i from 2.4.18):

 Model=ST32531A, FwRev=0.62, SerialNo=VE047143
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=4956/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=16
 CurCHS=4956/16/63, CurSects=4996476, LBA=yes, LBAsects=4996476
 IORDY=on/off, tPIO={min:383,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio3 pio4
 DMA modes: mdma0 mdma1 *mdma2
 AdvancedPM=no

PIIX chipset support and tuning is on, as it has been for a long time
since BIOS programs very slow non-udma dma modes.

-- 
Meelis Roos             e-mail: mroos@ut.ee
                        www:    http://www.cs.ut.ee/~mroos/

