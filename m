Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUB1Ots (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 09:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUB1Ots
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 09:49:48 -0500
Received: from tench.street-vision.com ([212.18.235.100]:3542 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S261857AbUB1Oto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 09:49:44 -0500
Subject: Re: Serial ATA (SATA) status report
From: Justin Cormack <justin@street-vision.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org
In-Reply-To: <403D5B3D.6060804@pobox.com>
References: <403D5B3D.6060804@pobox.com>
Content-Type: text/plain
Message-Id: <1077979779.12949.1414.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 14:49:39 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-26 at 02:34, Jeff Garzik wrote:

> Silicon Image 3112/3114
> -----------------------
> Summary:  No TCQ.  Looks like a PATA controller, but with full SATA
> control including hotplug and PM.
> 
> libata driver status:  Alpha.
> 
> drivers/ide driver status:  Production, but see issue #4.
> 
> Issue #4:  Need to have the most recent fixes posted to lkml, for stable
> operation and full performance (where possible).

Having had problems with SiI 3112A under the standard IDE drivers
http://marc.theaimsgroup.com/?l=linux-kernel&m=107539618032329&w=2
I thought I would test my set of disks with some bad sectors that oops
or hang the standard driver. I also tested them under high load (which
also causes problems with the legacy drivers which can drop to PIO mode
or just hang).

libata (2.4.25-libata3) is much more stable, managing 22 hours without
problems, however has just hung with
ata3: DMA timeout, stat 0x1
as the last log message (nothing before), box completely unresponsive.
Will recompile with magic sysrq and with DPRINTK and VPRINTK defined. It
wasnt actually accessing a part of the disk with bad sectors at the
point, just under high load and accessing 3 disks. What is the best way
of debugging this?





SCSI subsystem driver Revision: 1.00
libata version 1.01 loaded.
sata_sil version 0.53
ata1: SATA max UDMA/133 cmd 0xF8816080 ctl 0xF881608A bmdma 0xF8816000
irq 26
ata2: SATA max UDMA/133 cmd 0xF88160C0 ctl 0xF88160CA bmdma 0xF8816008
irq 26
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c49 86:3a01 87:4003
88:207f
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors
ata1: dev 0 configured for UDMA/133
ata2: no device found (phy stat 00000000)
ata2: thread exiting
ata3: SATA max UDMA/133 cmd 0xF8818480 ctl 0xF881848A bmdma 0xF8818400
irq 27
ata4: SATA max UDMA/133 cmd 0xF88184C0 ctl 0xF88184CA bmdma 0xF8818408
irq 27
ata3: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003
88:203f
ata3: dev 0 ATA, max UDMA/100, 488397168 sectors (lba48)
ata3: dev 0 configured for UDMA/100
ata4: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003
88:203f
ata4: dev 0 ATA, max UDMA/100, 488397168 sectors (lba48)
ata4: dev 0 configured for UDMA/100
scsi0 : sata_sil
scsi1 : sata_sil
scsi2 : sata_sil
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: 1.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD2500JD-00F  Rev: 1.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD2500JD-00F  Rev: 1.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
Attached scsi disk sdc at scsi3, channel 0, id 0, lun 0
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
 sda: unknown partition table
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
 sdb: unknown partition table
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
 sdc: unknown partition table


