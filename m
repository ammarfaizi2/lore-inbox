Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVASXOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVASXOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVASXOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:14:35 -0500
Received: from mid-2.inet.it ([213.92.5.19]:55514 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S261967AbVASXMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:12:31 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: bert hubert <ahu@ds9a.nl>
Subject: Re: 2.6.11-rc1-mm1 (and others): heavy disk I/O -> poor performance
Date: Thu, 20 Jan 2005 00:12:11 +0100
User-Agent: KMail/1.7.91
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200501182239.35992.cova@ferrara.linux.it> <20050119124223.GA14981@outpost.ds9a.nl>
In-Reply-To: <20050119124223.GA14981@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200501200012.11906.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 13:42, mercoledì 19 gennaio 2005, bert hubert ha scritto:
> On Tue, Jan 18, 2005 at 10:39:35PM +0100, Fabio Coatti wrote:
> > vmstat under load is the following, and config.gz attached. Of course I
> > can provide any other needed detail; many thanks for any hint.
>
> Looks mightily like DMA is not on, even though you compiled the PIIX driver
> in, which lists
>
> > 0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE
> > Controller
>
> Can you show the output of hdparm /dev/hda ? Can you show dmesg?

Sure, here is it:

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 60040544256, start = 0

I've cut down the ide relevant part of dmesg, please let me know if more 
details are needed
an 19 21:43:53 kefk Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jan 19 21:43:53 kefk ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Jan 19 21:43:53 kefk ICH5: IDE controller at PCI slot 0000:00:1f.1
Jan 19 21:43:53 kefk ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, 
low) -> IRQ 169
Jan 19 21:43:53 kefk ICH5: chipset revision 2
Jan 19 21:43:53 kefk ICH5: not 100% native mode: will probe irqs later
Jan 19 21:43:53 kefk ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, 
hdb:pio
Jan 19 21:43:53 kefk ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, 
hdd:pio
Jan 19 21:43:53 kefk Probing IDE interface ide0...
Jan 19 21:43:53 kefk hda: MAXTOR 6L060J3, ATA DISK drive
Jan 19 21:43:53 kefk ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 19 21:43:53 kefk Probing IDE interface ide1...
Jan 19 21:43:53 kefk hdc: TEAC DV-W58G, ATAPI CD/DVD-ROM drive
Jan 19 21:43:53 kefk ide1 at 0x170-0x177,0x376 on irq 15
Jan 19 21:43:53 kefk Probing IDE interface ide2...
Jan 19 21:43:53 kefk ide2: Wait for ready failed before probe !
Jan 19 21:43:53 kefk Probing IDE interface ide3...
Jan 19 21:43:53 kefk ide3: Wait for ready failed before probe !
Jan 19 21:43:53 kefk Probing IDE interface ide4...
Jan 19 21:43:53 kefk ide4: Wait for ready failed before probe !
Jan 19 21:43:53 kefk Probing IDE interface ide5...
Jan 19 21:43:53 kefk ide5: Wait for ready failed before probe !
Jan 19 21:43:53 kefk hda: max request size: 128KiB
Jan 19 21:43:53 kefk hda: 117266688 sectors (60040 MB) w/1819KiB Cache, 
CHS=65535/16/63, UDMA(100)
Jan 19 21:43:53 kefk hda: cache flushes supported
Jan 19 21:43:53 kefk hda: hda1 hda2 < hda5 hda6 hda7 > hda3 hda4
Jan 19 21:43:53 kefk PCI: 0000:03:06.0 has unsupported PM cap regs version (1)
Jan 19 21:43:53 kefk ACPI: PCI interrupt 0000:03:06.0[A] -> GSI 22 (level, 
low) -> IRQ 177
Jan 19 21:43:53 kefk PCI: 0000:03:06.0 has unsupported PM cap regs version (1)
Jan 19 21:43:53 kefk ahc_pci:3:6:0: Host Adapter Bios disabled.  Using default 
SCSI device parameters
Jan 19 21:43:53 kefk scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 
6.2.36
Jan 19 21:43:53 kefk <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
Jan 19 21:43:53 kefk aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
Jan 19 21:43:53 kefk
Jan 19 21:43:53 kefk Vendor: Nikon     Model: COOLSCANIII       Rev: 1.31
Jan 19 21:43:53 kefk Type:   Scanner                            ANSI SCSI 
revision: 02
Jan 19 21:43:53 kefk (scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
Jan 19 21:43:53 kefk Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.01
Jan 19 21:43:53 kefk Type:   CD-ROM                             ANSI SCSI 
revision: 02
Jan 19 21:43:53 kefk (scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
Jan 19 21:43:53 kefk Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0c
Jan 19 21:43:53 kefk Type:   CD-ROM                             ANSI SCSI 
revision: 02
Jan 19 21:43:53 kefk libata version 1.10 loaded.
Jan 19 21:43:53 kefk ata_piix version 1.03
Jan 19 21:43:53 kefk ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, 
low) -> IRQ 169
Jan 19 21:43:53 kefk PCI: Setting latency timer of device 0000:00:1f.2 to 64
Jan 19 21:43:53 kefk ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 
0xD000 irq 169
Jan 19 21:43:53 kefk ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 
0xD008 irq 169
Jan 19 21:43:53 kefk ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 
86:3e01 87:4003 88:207f
Jan 19 21:43:53 kefk ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
Jan 19 21:43:53 kefk ata1: dev 0 configured for UDMA/133
Jan 19 21:43:53 kefk scsi1 : ata_piix
Jan 19 21:43:53 kefk ata2: SATA port has no device.
Jan 19 21:43:53 kefk scsi2 : ata_piix
Jan 19 21:43:53 kefk Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
Jan 19 21:43:53 kefk Type:   Direct-Access                      ANSI SCSI 
revision: 05
Jan 19 21:43:53 kefk SCSI device sda: 320173056 512-byte hdwr sectors (163929 
MB)
Jan 19 21:43:53 kefk SCSI device sda: drive cache: write back
Jan 19 21:43:53 kefk SCSI device sda: 320173056 512-byte hdwr sectors (163929 
MB)
Jan 19 21:43:53 kefk SCSI device sda: drive cache: write back
Jan 19 21:43:53 kefk sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Jan 19 21:43:53 kefk Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Jan 19 21:43:53 kefk sr0: scsi-1 drive
Jan 19 21:43:53 kefk Uniform CD-ROM driver Revision: 3.20
Jan 19 21:43:53 kefk Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Jan 19 21:43:53 kefk sr1: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda 
tray
Jan 19 21:43:53 kefk Attached scsi CD-ROM sr1 at scsi0, channel 0, id 5, lun 0
Jan 19 21:43:53 kefk Attached scsi generic sg0 at scsi0, channel 0, id 2, lun 
0,  type 6
Jan 19 21:43:53 kefk Attached scsi generic sg1 at scsi0, channel 0, id 3, lun 
0,  type 5
Jan 19 21:43:53 kefk Attached scsi generic sg2 at scsi0, channel 0, id 5, lun 
0,  type 5
Jan 19 21:43:53 kefk Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 
0,  type 0



-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
