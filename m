Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267821AbTBEGVa>; Wed, 5 Feb 2003 01:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267822AbTBEGV3>; Wed, 5 Feb 2003 01:21:29 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:31879 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267821AbTBEGV1>; Wed, 5 Feb 2003 01:21:27 -0500
Date: Wed, 5 Feb 2003 07:30:58 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.21pre4-ac2 IDE status on PDC20268
Message-ID: <20030205063058.GA27959@louise.pinerecords.com>
References: <200302041702.h14H2O112078@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302041702.h14H2O112078@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gave 2.4.21-pre4-ac2 a spin.

IDE seems to be shaping up, the only problem I ran into with
it is about the darn PDC20268 -- again.  It seems to work nicely
but misdetects the max transfer rate of the only drive on the
secondary channel and then won't allow me to set UDMA > 2 on it
(I get no error msg but there's no change).

The ideX=ata66 switch doesn't seem to do anything any more.
(On 2.4.{19,20} if I omit "ide2=ata66 ide3=ata66", I get
the UDMA <= 2 restriction on *both* channels of the PDC.)

hdparm -Iv of the affected drive (from 2.4.20):
/dev/hdg:
 multcount    =  0 (off)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1869/255/63, sectors = 30033360, start = 0

ATA device, with non-removable media
	Model Number:       IBM-DJNA-351520                         
	Serial Number:      G80GLT4F735
	Firmware Revision:  J56OA30K
Standards:
	Used: ATA/ATAPI-4 T13 1153D revision 17 
	Supported: 4 3 2 1 & some of 5
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:   30033360
	device size with M = 1024*1024:       14664 MBytes
	device size with M = 1000*1000:       15377 MBytes (15 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Buffer size: 430.0kB	bytes avail on r/w long: 34	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
		Release interrupt
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
		Address Offset Reserved Area Boot
	   *	READ/WRITE DMA QUEUED
	   *	DOWNLOAD MICROCODE cmd
Security: 
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
	26min for SECURITY ERASE UNIT. 

Compare:

Linux version 2.4.21-pre4-ac2 (kala@ns) (gcc version 2.95.3 20010315 (release)) #1 Wed Feb 5 06:50:14 CET 2003
...
Kernel command line: auto BOOT_IMAGE=l rw root=900
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 00:04.1
PCI: Enabling device 00:04.1 (0000 -> 0001)
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
PIIX3: neither IDE port enabled (BIOS)
PDC20268: IDE controller at PCI slot 00:06.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xf8b0-0xf8b7, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xf8b8-0xf8bf, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD205BA, ATA DISK drive
blk: queue c02abf60, I/O limit 4095Mb (mask 0xffffffff)
hdg: IBM-DJNA-351520, ATA DISK drive
blk: queue c02ac3d0, I/O limit 4095Mb (mask 0xffffffff)
ide2 at 0xf898-0xf89f,0xf8aa on irq 9
ide3 at 0xf8a0-0xf8a7,0xf8ae on irq 9
hde: host protected area => 1
hde: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=39770/16/63, UDMA(66)
hdg: host protected area => 1
hdg: 30033360 sectors (15377 MB) w/430KiB Cache, CHS=29795/16/63, UDMA(33)

                                                                       ^^
vs.

Linux version 2.4.21-pre4-2420ide-1 (kala@ns) (gcc version 2.95.3 20010315 (release)) #1 Wed Jan 29 11:27:16 CET 2003
...
Kernel command line: auto BOOT_IMAGE=l rw root=900 ide2=ata66 ide3=ata66
ide_setup: ide2=ata66
ide_setup: ide3=ata66
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 21
PCI: Enabling device 00:04.1 (0000 -> 0001)
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
PIIX3: neither IDE port enabled (BIOS)
PDC20268: IDE controller on PCI bus 00 dev 30
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20268: ATA-66/100 forced bit set (WARNING)!!
    ide2: BM-DMA at 0xf8b0-0xf8b7, BIOS settings: hde:pio, hdf:pio
PDC20268: ATA-66/100 forced bit set (WARNING)!!
    ide3: BM-DMA at 0xf8b8-0xf8bf, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD205BA, ATA DISK drive
hdg: IBM-DJNA-351520, ATA DISK drive
ide2 at 0xf898-0xf89f,0xf8aa on irq 9
ide3 at 0xf8a0-0xf8a7,0xf8ae on irq 9
blk: queue c029d38c, I/O limit 4095Mb (mask 0xffffffff)
hde: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=39770/16/63, UDMA(66)
blk: queue c029d6f0, I/O limit 4095Mb (mask 0xffffffff)
hdg: 30033360 sectors (15377 MB) w/430KiB Cache, CHS=29795/16/63, UDMA(66)

T.
