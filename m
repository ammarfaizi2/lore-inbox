Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSLBNcd>; Mon, 2 Dec 2002 08:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSLBNcc>; Mon, 2 Dec 2002 08:32:32 -0500
Received: from mail.wincom.net ([209.216.129.3]:41483 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S263279AbSLBNcb>;
	Mon, 2 Dec 2002 08:32:31 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: linux-kernel@vger.kernel.org
Date: Mon, 02 Dec 102 08:36:58 -0500
Subject: ATAPI DMA timeouts showing up in logs
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3deb629a.69c1.0@wincom.net>
X-User-Info: 24.57.83.120
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Rcpt-To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I've got the proper IDE driver in place (2.4.20rc4) and the master drive
on the primary interface is running at a full ATA133, these have started showing
up in the logs - 2 or 3 a day:

hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status timeout: status=0xd0 { Busy }
hdc: drive not ready for command
hdc: ATAPI reset complete

Here's the dmesg output about this drive:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6E030L0, ATA DISK drive
hdc: 56X CD-ROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c034b164, I/O limit 4095Mb (mask 0xffffffff)
hda: 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=3738/255/63, UDMA(133)

hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12

And /sbin/hdparm -I /dev/hdc

/dev/hdc:

ATAPI CD-ROM, with removable media
        Model Number:       56X CD-ROM
        Serial Number:      MT1102A Firmware
        Firmware Revision:  VER 1.5F
Standards:
        Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
        Supported: CD-ROM ATAPI-2
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(cannot be disabled)
        DMA: *mdma0 mdma1 mdma2 *udma0 udma1 udma2 (?)
             Cycle time: min=120ns recommended=150ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=227ns  IORDY flow control=120ns

And /sbin/hdparm -i /dev/hdc

/dev/hdc:

 Model=56X CD-ROM, FwRev=VER 1.5F, SerialNo=MT1102A Firmware
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:150}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no

And finally, 

/sbin/hdparm -v /dev/hdc

/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  1 (on)
 readahead    =  8 (on)
 HDIO_GETGEO failed: Invalid argument

This last one is the only indication that something might be amiss - the two
instances of "invalid argument" Other than that, the drive appears to work just
fine.

What am I looking at?

DG

