Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVHVTxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVHVTxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVHVTxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:53:16 -0400
Received: from mailtir.platform.com ([192.219.104.248]:60609 "EHLO
	mailtir.platform.com") by vger.kernel.org with ESMTP
	id S1750751AbVHVTxP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:53:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6.13-rc3][SATA] - SIL 3114 controller w/ firmware 5.0.39 - Hanging only in 64bit mode - Resolved in 2.6.13-rc6
Date: Mon, 22 Aug 2005 15:53:03 -0400
Message-ID: <9CD190F4AD92EC499A9397F49C8B0E4E01E8EDEC@catoexm04.noam.corp.platform.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.13-rc3][SATA] - SIL 3114 controller w/ firmware 5.0.39 - Hanging only in 64bit mode
Thread-Index: AcWJic8Vb8FqPRvRSVy+/aAK4fhX1QdyKxBg
From: "Shawn Starr" <sstarr@platform.com>
To: "Shawn Starr" <sstarr@platform.com>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <jgarzik@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It appears 2.6.13-rc6 has enough SATA/libata fixes that stop the DMA read/write locks (the .ordered_flush ops seems to do it). I did also flash the BIOS to the latest release as well (but older 2.6.13-rcX releases had problems still).

Thanks, 

Shawn.


-----Original Message-----
From: Shawn Starr 
Sent: Friday, July 15, 2005 18:09
To: 'linux-ide@vger.kernel.org'
Cc: 'linux-kernel@vger.kernel.org'; 'jgarzik@pobox.com'
Subject: [2.6.13-rc3][SATA] - SIL 3114 controller w/ firmware 5.0.39 -
Hanging only in 64bit mode



I just tried -rc3 today on the amd64 box which is a Asus K8N-E Deluxe motherboard. Is it possible the firmware for the controller is buggy? Anyone else reporting hangs?

I can reproduce the sata controller with various writes:

1) If I connect the box and allow a remote machine to PXE and TFTP boot from it, the machine hangs. This is consistent each time I try this but only if the box is in 64bit mode.

2) Certain times when doing disk writes it will just hang, there doesn't appear to be any messages from the sil driver logged to console. It still seems to be released to DMA problems.

I hope this info is helpful, 

thanks, 

Shawn.


lspci info:

00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev a1)
00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 Controller (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb AC'97 Audio Controller (rev a1)
00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller (v2.5) (rev a2)
00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2)
00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge (rev a2)
00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev a2)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta/Vanta LT] (rev 15)
02:07.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
02:08.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
02:0c.0 Unknown mass storage controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)

Relevent dmesg:

SCSI subsystem initialized
libata version 1.10 loaded.
sata_sil version 0.8
ata1: SATA max UDMA/100 cmd 0xFFFFFF0000004C80 ctl 0xFFFFFF0000004C8A bmdma 0xFFFFFF0000004C00 irq 11
ata2: SATA max UDMA/100 cmd 0xFFFFFF0000004CC0 ctl 0xFFFFFF0000004CCA bmdma 0xFFFFFF0000004C08 irq 11
ata3: SATA max UDMA/100 cmd 0xFFFFFF0000004E80 ctl 0xFFFFFF0000004E8A bmdma 0xFFFFFF0000004E00 irq 11
ata4: SATA max UDMA/100 cmd 0xFFFFFF0000004EC0 ctl 0xFFFFFF0000004ECA bmdma 0xFFFFFF0000004E08 irq 11
ata1: no device found (phy stat 00000000)
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
sata_nv version 0.6
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata5: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD000 irq 10
ata6: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD008 irq 10
ata5: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:007f
ata5: dev 0 ATA, max UDMA/133, 160086528 sectors:
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device removed
ata5: dev 0 configured for UDMA/133
scsi4 : sata_nv
ata6: no device found (phy stat 00000000)
scsi5 : sata_nv
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi4, channel 0, id 0, lun 0


Onboard IDE controller and devices information:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: GCR-8523B, ATAPI CD/DVD-ROM drive
hdb: LITE-ON DVD SOHD-16P9S, ATAPI CD/DVD-ROM drive
