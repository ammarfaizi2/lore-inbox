Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSE0M6h>; Mon, 27 May 2002 08:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSE0M6g>; Mon, 27 May 2002 08:58:36 -0400
Received: from spook.vger.org ([213.204.128.210]:41388 "HELO
	kenny.worldonline.se") by vger.kernel.org with SMTP
	id <S316601AbSE0M6f>; Mon, 27 May 2002 08:58:35 -0400
Date: Mon, 27 May 2002 15:35:44 +0200 (CEST)
From: me@vger.org
To: linux-kernel@vger.kernel.org
Subject: /dev/hd[ijkl] only using udma (not udma 100)
Message-ID: <Pine.LNX.4.21.0205271513080.7794-100000@kenny.worldonline.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ive got a machine running debian test dist and 2.4.18. The machine has two
promise ata100 tx2 controller cards. My question is why does the devices
hde to hdh use udma100 but devices hdi to hdl only use udma. Note on this
is that the devices hdi to hdl did i have to make myself (dont know if
there is some other configure possibility). All drives are the same model.

--- dmesg ---
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override
with idebus=xx
PDC20268: IDE controller on PCI bus 00 dev 58
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit DISABLED Primary PCI Mode
Secondary PCI Mode.
PDC20268: FORCING BURST BIT 0x50 -> 0x51 INACTIVE
    ide2: BM-DMA at 0x2050-0x2057, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x2058-0x205f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller on PCI bus 00 dev 68
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit DISABLED Primary PCI Mode
Secondary PCI Mode.
PDC20268: FORCING BURST BIT 0x50 -> 0x51 INACTIVE
    ide4: BM-DMA at 0x2080-0x2087, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x2088-0x208f, BIOS settings: hdk:pio, hdl:pio
PIIX4: IDE controller on PCI bus 00 dev 91
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2040-0x2047, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x2048-0x204f, BIOS settings: hdc:DMA, hdd:pio
hda: *****************, ATA DISK drive
hdc: ***********************, ATAPI CD/DVD-ROM drive
hde: ****************, ATA DISK drive
hdf: ****************, ATA DISK drive
hdh: ****************, ATA DISK drive
hdi: ****************, ATA DISK drive
hdj: ****************, ATA DISK drive
hdk: ****************, ATA DISK drive
hdl: ****************, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x2070-0x2077,0x2066 on irq 18
ide3 at 0x2068-0x206f,0x2062 on irq 18
ide4 at 0x2098-0x209f,0x207e on irq 17
ide5 at 0x2090-0x2097,0x207a on irq 17
hda: ******** sectors (***** MB) w/512KiB Cache, CHS=****/***/**, UDMA(33)
hde: ********* sectors (****** MB) w/****KiB Cache, CHS=******/**/**,
UDMA(100)
hdf: ********* sectors (****** MB) w/****KiB Cache, CHS=******/**/**,
UDMA(100)
hdh: ********* sectors (****** MB) w/****KiB Cache, CHS=******/**/**,
UDMA(100)
hdi: ********* sectors (****** MB) w/****KiB Cache, CHS=******/**/**,
(U)DMA
hdj: ********* sectors (****** MB) w/****KiB Cache, CHS=******/**/**,
(U)DMA
hdk: ********* sectors (****** MB) w/****KiB Cache, CHS=******/**/**,
(U)DMA
hdl: ********* sectors (****** MB) w/****KiB Cache, CHS=******/**/**,
(U)DMA
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
--- dmesg ---

--- hdparm test ---
# hdparm -t -T /dev/hd[efhijkl]

/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.93 seconds =137.63 MB/sec
 Timing buffered disk reads:  64 MB in  1.82 seconds = 35.16 MB/sec

/dev/hdf:
 Timing buffer-cache reads:   128 MB in  0.94 seconds =136.17 MB/sec
 Timing buffered disk reads:  64 MB in  1.40 seconds = 45.71 MB/sec

/dev/hdh:
 Timing buffer-cache reads:   128 MB in  0.95 seconds =134.74 MB/sec
 Timing buffered disk reads:  64 MB in  1.82 seconds = 35.16 MB/sec

/dev/hdi:
 Timing buffer-cache reads:   128 MB in  0.94 seconds =136.17 MB/sec
 Timing buffered disk reads:  64 MB in  4.16 seconds = 15.38 MB/sec

/dev/hdj:
 Timing buffer-cache reads:   128 MB in  0.94 seconds =136.17 MB/sec
 Timing buffered disk reads:  64 MB in  4.17 seconds = 15.35 MB/sec

/dev/hdk:
 Timing buffer-cache reads:   128 MB in  0.93 seconds =137.63 MB/sec
 Timing buffered disk reads:  64 MB in  4.16 seconds = 15.38 MB/sec

/dev/hdl:
 Timing buffer-cache reads:   128 MB in  0.94 seconds =136.17 MB/sec
 Timing buffered disk reads:  64 MB in  4.17 seconds = 15.35 MB/sec
--- hdparm test ---

As you see the speed on the other devices is less then half.

Please include me in the response mails because im not on the list (not
from this account anyway).

Thanks to anyone that can help me! =) If you need more info, just drop me
a mail.



