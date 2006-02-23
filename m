Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWBWRRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWBWRRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWBWRRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:17:47 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:8870 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1751443AbWBWRRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:17:46 -0500
Date: Thu, 23 Feb 2006 18:18:17 +0100
From: Luca <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
Message-ID: <20060223171817.GA7927@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> ha scritto:
> Various fixes and cleanups, some new functionality notably Promise
> 20246/2026x support which although basic should get it going with disk.
> Not 100% sure about ATAPI on PDC2026x yet.
> 
> http://zeniv.linux.org.uk/~alan/IDE

Hi Alan,
I just tested the patch on my desktop (VIA VT8233A) and on my notebook
(SiS 5513): it boots correctly and performance (hdparm -T) looks good.
With atapi_enable all optical drives are recognized; I didn't try
burning (I'm out of disks...), but I'll do the test if it's useful.

This is the desktop:

lspci:
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8233A ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

dmesg:
libata version 1.20 loaded.
pata_via 0000:00:11.1: version 0.1.4
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 11
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xD400 irq 14
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
ata1: dev 1 cfg 49:0f00 82:346b 83:4001 84:4000 85:3469 86:0001 87:4000 88:101f
ata1: dev 1 ATA-4, max UDMA/66, 20044080 sectors: LBA
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
via_do_set_mode: Mode=69 ast broken=Y udma=133 mul=4
ata1: dev 0 configured for UDMA/100
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
via_do_set_mode: Mode=68 ast broken=Y udma=133 mul=4
ata1: dev 1 configured for UDMA/66
scsi0 : pata_via
  Vendor: ATA       Model: Maxtor 6Y120L0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: QUANTUM FIREBALL  Rev: A03.
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xD408 irq 15
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
ata2: dev 0 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata2: dev 0 ATAPI, max UDMA/33
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
ata2: dev 1 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata2: dev 1 ATAPI, max UDMA/33
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
via_do_set_mode: Mode=66 ast broken=Y udma=133 mul=4
ata2: dev 0 configured for UDMA/33
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
via_do_set_mode: Mode=66 ast broken=Y udma=133 mul=4
ata2: dev 1 configured for UDMA/33
scsi1 : pata_via
  Vendor: _NEC      Model: DVD_RW ND-1300A   Rev: 1.0A
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: WAITEC    Model: ALADAR/1          Rev: B1.5
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 > sda3
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 20044080 512-byte hdwr sectors (10263 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 20044080 512-byte hdwr sectors (10263 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 0:0:1:0: Attached scsi disk sdb
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 16x/40x writer cd/rw xa/form2 cdda tray
sr 1:0:1:0: Attached scsi CD-ROM sr1
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
sr 1:0:0:0: Attached scsi generic sg2 type 5
sr 1:0:1:0: Attached scsi generic sg3 type 5

And this is the notebook:

lspci:
0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media IO] (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 1658
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b800 [size=16]
	Capabilities: [58] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

dmesg:

libata version 1.20 loaded.
pata_sis 0000:00:02.5: version 0.1
ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xB800 irq 14
ata1: dev 0 cfg 49:0f00 82:746b 83:49a8 84:4003 85:f469 86:0808 87:4003 88:203f
ata1: dev 0 ATA-5, max UDMA/100, 78140160 sectors: LBA
ata1: dev 0 configured for UDMA/100
scsi0 : pata_sis
  Vendor: ATA       Model: IC25N040ATCS04-0  Rev: CA4O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xB808 irq 15
ata2: dev 0 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : pata_sis
  Vendor: MATSHITA  Model: UJDA740 DVD/CDRW  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5


Luca
-- 
Home: http://kronoz.cjb.net
K.R.O.N.O.S
Kinetic Replicant Optimized for Nocturnal Observation and Sabotage
