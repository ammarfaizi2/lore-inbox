Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWIUIEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWIUIEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWIUIEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:04:08 -0400
Received: from qb-out-0506.google.com ([72.14.204.234]:30650 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751032AbWIUIEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:04:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Yrld6USWhMr4Atl5UKHTyOwuRbvGKJZ5pn6XXqK2grnPIJX5fQpNr+6o/Ej+LRzh6YoDXH5goxOL+Gyubdvwyv/mnVI5QTQnAwCtRJYjFPHK0STAuA7L9ny7uCjzXPOlrlQ23Ln1f01ZAqpcVl7MrqY6YlbnThNbmkqO/AK1rCY=
Message-ID: <f4527be0609210104p3c6c4933ke77d8372f6dd3848@mail.gmail.com>
Date: Thu, 21 Sep 2006 09:04:05 +0100
From: "Andrew Lyon" <andrew.lyon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: JMicron 20360/20363 AHCI Controller much slower with 2.6.18
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Gigabyte GA_965P_DS3 with Core 2 Duo CPU, wd raptor connected
to onboard JMicron 20360/20363 AHCI Controller, with 2.6.18 the drive
is very slow:

beast ~ # uname -a
Linux beast 2.6.18 #1 SMP Wed Sep 20 15:04:24 BST 2006 i686 Intel(R) Core(TM)2 C
PU          6600  @ 2.40GHz GNU/Linux
beast ~ # hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  100 MB in  3.02 seconds =  33.10 MB/sec

beast ~ # dmesg | grep sda
SCSI device sda: 145223999 512-byte hdwr sectors (74355 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 145223999 512-byte hdwr sectors (74355 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: Attached scsi disk sda
EXT3 FS on sda2, internal journal
EXT3 FS on sda5, internal journal
EXT3 FS on sda6, internal journal
EXT3 FS on sda7, internal journal
EXT3 FS on sda8, internal journal
Adding 4000176k swap on /dev/sda3.  Priority:-1 extents:1 across:4000176k

beast ~ # dmesg | grep ata1
ata1: SATA max UDMA/133 cmd 0xF8CD4100 ctl 0x0 bmdma 0x0 irq 17
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 145223999 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133

with 2.6.17 the drive is more than twice as fast:

beast ~ # uname -a
Linux beast 2.6.17 #6 SMP Sat Sep 2 11:39:53 GMT 2006 i686 Intel(R)
Core(TM)2 CPU          6600  @ 2.40GHz GNU/Linux
beast ~ # hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  250 MB in  3.01 seconds =  82.95 MB/sec
beast ~ # dmesg | grep sda
SCSI device sda: 145223999 512-byte hdwr sectors (74355 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 145223999 512-byte hdwr sectors (74355 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: Attached scsi disk sda
EXT3 FS on sda2, internal journal
EXT3 FS on sda5, internal journal
EXT3 FS on sda6, internal journal
EXT3 FS on sda7, internal journal
EXT3 FS on sda8, internal journal
Adding 4000176k swap on /dev/sda3.  Priority:-1 extents:1 across:4000176k


beast ~ # dmesg | grep ata1
ata1: SATA max UDMA/133 cmd 0xF8CD8100 ctl 0x0 bmdma 0x0 irq 17
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:746b 83:7f61 84:4023 85:7468 86:3e41 87:4023 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 145223999 sectors: LBA48
ata1: dev 0 configured for UDMA/133

I have other drives connected to onboard piix sata, they perform the
same with 2.6.18 as with 2.6.17, only the jmicron controller is
slower..

I notice that there are messages about NCQ in 2.6.18 dmesg that were
not there with previous versions.

Andy
