Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWGFVy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWGFVy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWGFVy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:54:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13228 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750872AbWGFVy0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:54:26 -0400
Date: Thu, 6 Jul 2006 14:57:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. =?ISO-8859-1?Q?Magall=F3n" ?= <jamagallon@ono.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.17-mm6
Message-Id: <20060706145752.64ceddd0.akpm@osdl.org>
In-Reply-To: <20060706234425.678cbc2f@werewolf.auna.net>
References: <20060703030355.420c7155.akpm@osdl.org>
	<20060705234347.47ef2600@werewolf.auna.net>
	<20060705155602.6e0b4dce.akpm@osdl.org>
	<20060706015706.37acb9af@werewolf.auna.net>
	<20060705170228.9e595851.akpm@osdl.org>
	<20060706163646.735f419f@werewolf.auna.net>
	<20060706164802.6085d203@werewolf.auna.net>
	<20060706234425.678cbc2f@werewolf.auna.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallón" <jamagallon@ono.com> wrote:
>
> On Thu, 6 Jul 2006 16:48:02 +0200, "J.A. Magallón" <jamagallon@ono.com> wrote:
> 
> > On Thu, 6 Jul 2006 16:36:46 +0200, "J.A. Magallón" <jamagallon@ono.com> wrote:
> > 
> > > On Wed, 5 Jul 2006 17:02:28 -0700, Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > 
> > > This a shot till I can try to get a full dmesg.
> > > 
> > > http://belly.cps.unizar.es/~magallon/tmp/shot.jpg
> > > 
> > > Anyways, what I wanted to point above was that previous kernels talk
> > > about 'sda1(8,1)', and newer use 'dev(8,19)'.
> > > Perhaps somebedy did a strcpy( ... , "dev" ), instead of strcpy( ... , dev ) ?
> > > 
> > 
> > Hey !!. I disabled md and usb to get more useful messages in my screen, and
> > now I have realized that libata is managing my IDE drive !! And I did not
> > boot with any 'libata.atapi_enable'....
> > 
> > In -mm1,
> > sda -> 200Gb sata
> > hda -> HL-DT-ST DVDRAM GSA-4120B
> > hdb -> (zip drive)
> > hdc -> 120Gb ide
> > hdd -> DVD-ROM
> > 
> > In -mm6,
> > 
> > sda -> (zip drive) ?
> > sdb -> 120Gb
> > sdc -> 200Gb
> > 
> 
> Well, booting onto sdc1 let me get to single user mode at least so I got
> a full dmesg. Relevant parts for -mm1 and -mm6 are below (if you want it
> full I can provide). Basically it looks like libata 2.0 by default handles
> PATA drives. This can break a lot of systems. In my opinion, PATA hosts
> should be detected _after_ real sata hosts in the same chipset (now it
> looks like its done _before_). What is handled by IDE will break anyways,
> but this way at least real SATA will stay at the same /dev/sdX devices.
> 
> -mm1:
> ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> ICH5: IDE controller at PCI slot 0000:00:1f.1
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> 
> -mm6:
> 
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> 

Ah-hah, thanks.  I think this is a relatively-FAQ, but I forget the answer.
Alan's the man.



> dmesg-mm1:
> 
> libata version 1.30 loaded.
> ata_piix 0000:00:1f.2: version 1.10tj1ac3
> ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> scsi0 : ata_piix
> ata1: ENTER, pcs=0x13 base=0
> ata1: LEAVE, pcs=0x13 present_mask=0x1
> ata1.00: cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
> ata1.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48 
> ata1.00: configured for UDMA/133
> scsi1 : ata_piix
> ata2: ENTER, pcs=0x13 base=2
> ata2: LEAVE, pcs=0x11 present_mask=0x0
> ata2: SATA port has no device.
>   Vendor: ATA       Model: ST3200822AS       Rev: 3.01
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3
> sd 0:0:0:0: Attached scsi disk sda
> ...
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH5: IDE controller at PCI slot 0000:00:1f.1
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
> ICH5: chipset revision 2
> ICH5: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: HL-DT-ST DVDRAM GSA-4120B, ATAPI CD/DVD-ROM drive
> hdb: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> ide-floppy driver 0.99.newide
> hdb: No disk in drive
> hdb: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
> hdb: No disk in drive
> hda: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> hdc: ST3120022A, ATA DISK drive
> hdd: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hdd: ATAPI 48X DVD-ROM drive, 128kB Cache, UDMA(33)
> hdc: max request size: 512KiB
> hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
> hdc: cache flushes supported
>  hdc: hdc1
> EXT3 FS on sda1, internal journal
> Adding 2112536k swap on /dev/sda3.  Priority:-1 extents:1 across:2112536k
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda2, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
> EXT3 FS on hdc1, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> 
> dmesg-mm6:
> 
> libata version 2.00 loaded.
> ata_piix 0000:00:1f.1: version 2.00tj1ac5
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> scsi0 : ata_piix
> ata1.00: configured for PIO3
> ata1.01: configured for PIO3
>   Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111
>   Type:   CD-ROM                             ANSI SCSI revision: 05
>   Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> scsi1 : ata_piix
> ata2.00: configured for UDMA/33
> ata2.01: configured for UDMA/33
>   Vendor: ATA       Model: ST3120022A        Rev: 3.06
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: TOSHIBA   Model: DVD-ROM SD-M1712  Rev: 1004
>   Type:   CD-ROM                             ANSI SCSI revision: 05
> ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> scsi2 : ata_piix
> ata3: ENTER, pcs=0x13 base=0
> ata3: LEAVE, pcs=0x13 present_mask=0x1
> ata3.00: configured for UDMA/133
> scsi3 : ata_piix
> ata4: ENTER, pcs=0x13 base=2
> ata4: LEAVE, pcs=0x11 present_mask=0x0
> ata4: SATA port has no device.
> ATA: abnormal status 0x7F on port 0xC807
>   Vendor: ATA       Model: ST3200822AS       Rev: 3.01
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> sd 0:0:1:0: Attached scsi removable disk sda
> SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
> SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
>  sdb: sdb1
> sd 1:0:0:0: Attached scsi disk sdb
> SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
> sdc: Write Protect is off
> sdc: Mode Sense: 00 3a 00 00
> SCSI device sdc: drive cache: write back
> SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
> sdc: Write Protect is off
> sdc: Mode Sense: 00 3a 00 00
> SCSI device sdc: drive cache: write back
>  sdc: sdc1 sdc2 sdc3
> sd 2:0:0:0: Attached scsi disk sdc
> ...
> sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> sr 0:0:0:0: Attached scsi CD-ROM sr0
> sr1: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
> sr 1:0:1:0: Attached scsi CD-ROM sr1
> ...
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ide-floppy driver 0.99.newide
> EXT3 FS on sdc1, internal journal
> 
> --
> J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
>                                          \         It's better when it's free
> Mandriva Linux release 2007.0 (Cooker) for i586
> Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
