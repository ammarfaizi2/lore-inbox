Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUH0QMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUH0QMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUH0QMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:12:16 -0400
Received: from gl177a.glassen.ac ([82.182.223.101]:34311 "HELO findus.dhs.org")
	by vger.kernel.org with SMTP id S266427AbUH0QMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:12:03 -0400
Message-ID: <412F5D50.7000807@findus.dhs.org>
Date: Fri, 27 Aug 2004 18:12:00 +0200
From: =?ISO-8859-1?Q?Petter_Sundl=F6f?= <petter.sundlof@findus.dhs.org>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040825)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jgarzik@pobox.com
Subject: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.8.1. DMA works fine on /dev/hda (PATA, CD burner).

When I try to enable it for my SATA drive (which is performing horribly 
bad -- 80-90% CPU load on an AMD64 3200+ during copy of large files) I 
get this error:

# hdparm -d 1 /dev/sda

/dev/sda:
  setting using_dma to 1 (on)
  HDIO_SET_DMA failed: Invalid argument

Tried different commands:

# hdparm -X66 -d1 /dev/sda

/dev/sda:
  setting using_dma to 1 (on)
  HDIO_SET_DMA failed: Invalid argument
  setting xfermode to 66 (UltraDMA mode2)
  HDIO_DRIVE_CMD(setxfermode) failed: Invalid argument

hdparm -d /dev/sda gives absolutely no information.

The chipset is VIA82Cxx (ASUS K8VSE Deluxe motherboard). Disk is Maxtor 
6Y200M0.

Seen in /proc/scsi/scsi like this:

Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 6Y200M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05

I also have the Promise controller, which I can use use a regular SATA 
controller (not RAID as is default). Should I attach it to it instead 
(I'd rather not if it can be avoided).

dmesg info:

libata version 1.02 loaded.
sata_via version 0.20
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xD000 irq 20
ata2: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xD008 irq 20
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
   Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
  /dev/scsi/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 p12 
p13 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
