Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751667AbWD1LMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWD1LMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWD1LMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:12:15 -0400
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:26186 "EHLO
	ecstlaurent8.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S1750764AbWD1LMO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:12:14 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: sata_via + Plextor 716SA + ATAPI error
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Date: Fri, 28 Apr 2006 07:12:13 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7011B261C@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sata_via + Plextor 716SA + ATAPI error
Thread-Index: AcZqqg2U+r+WXe5sRamZig7Ij5nG2gACnEIA
From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
To: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Apr 2006 11:12:13.0472 (UTC) FILETIME=[99DD6A00:01C66AB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a A8V Deluxe Motherboard with a SATA hard drive (channel 1) on
which my OS (FC5 x86_64) stands.  I also have a SATA Plextor DVD RW DL
716SA on channel 2.

When libata starts it either timeout on ata2, BLIST_INQUIRY_36 the
device (and before 2.6.16 would systematically kernel panic but now does
a slow to respond a finally does a timeout after 30secs.) and finally
often also detect the drive properly to then hang on udev for 2-3
minutes to finally do a kernel panic when arriving on HAL startup.

I've made about 40 cold reboots and I can get any of thoses 3 errors at
any time.... Although timeout and BLIST_INQUIRY_36 + timeout are the
most often ones.

I know my Plextor DVD drive works fine since I've also installed an XP
an XP
64 on the first 2 partitions of my drive and it does burn CD's and DVD's
properly.

I've opened up a bug at http://bugzilla.kernel.org/show_bug.cgi?id=5533
on november 2005 and also at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=176072 but I did
not got a lot of attention.... So I tought this mailing list might help?

For now the only quick fix I've found is to simply unplug the device
unless I really really need to use it... and if so I switch to XP.

Here is a part of my dmesg:
libata version 1.20 loaded.
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 0 sata_via 0000:00:0f.0:
routed to hard irq line 0
ata1: SATA max UDMA/133 cmd 0xD000 ctl 0xC802 bmdma 0xB800 irq 16
ata2: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB808 irq 16
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663
88:407f
ata1: dev 0 ATA-7, max UDMA/133, 490234752 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
88:001f
ata2: dev 0 ATAPI, max UDMA/66
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/66
scsi1 : sata_via
  Vendor: ATA       Model: Maxtor 6B250S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back SCSI device sda: 490234752
512-byte hdwr sectors (251000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12
sda13 > sd 0:0:0:0: Attached scsi disk sda
ata2: command 0xa0 timeout, stat 0xd0 host_stat 0x1
ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00 scsi
scan: 96 byte inquiry failed.  Consider BLIST_INQUIRY_36 for this device
ata2 is slow to respond, please be patient
ata2 failed to respond (30 secs)
Losing some ticks... checking if CPU frequency changed.
ata2: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00

Helps greatly appreciated!

- vin

