Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWEIXuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWEIXuB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWEIXuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:50:01 -0400
Received: from owa.omneon.com ([12.36.122.13]:46606 "EHLO
	snv-exh1.omneon.local") by vger.kernel.org with ESMTP
	id S932280AbWEIXuA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:50:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8 cards
Date: Tue, 9 May 2006 16:49:57 -0700
Message-ID: <F0E8D0B1F8999D479196DA72521D954A87FBAB@snv-exh1.omneon.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8 cards
Thread-Index: AcZzw0cSPGlmOB+3QUm3NbAs7qMldw==
From: "Michael Robak" <mrobak@Omneon.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
  sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8
cards
Description:
  The systems hangs during the boot process for several minutes about 3
of 4 times.  If it does succeed in booting, IO through these cards work
fine.  


Configuration:

Fedora core 4 with 2.6.16.1 and 2.6.17-rc3 (both produce the same
results)
Motherboard: Supermicro PDSME
SATA Card: 8-port Supermicro AOC-SAT2-MV8 bios 1.0b (based on Marvell
Hercules-2 SATA Host Controller)
24 SATA drives plugged into 3 of these controllers

The last few lines of console output are:

INIT: version 2.85 booting
Input: AT Translated set 2 Keyboard as /class/input/input0
	Welcome to Fedora Core
	Press 'I' to enter interactive setup
Starting udev                               [  OK  ]
Initalizing Hardware .....

Other notes:

If all drives aree plugged directly into a SATA card, the system hangs
indefinately as fedora is trying to initalize hardware.

Plugging 4 of the drives directly into the motherboard makes the system
is able to boot.  The motherboard SATA controller use the ahci driver.
The system hangs for several minutes on "Initalizing Hardware ..."  In
this case, lsmod shows the sata_mv driver loaded however only 4 drives
show up in /dev.  Reloading the sata_mv module seems to have no effect.
Since the server boots in this case I'm able to get the dmesg output.

Snippet from dmesg:

sata_mv 0000:02:01.0: version 0.6
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 129
sata_mv 0000:02:01.0: 32 slots 8 ports SCSI mode IRQ via INTx
ata5: SATA max UDMA/133 cmd 0x0 ctl 0xF8922120 bmdma 0x0 irq 129
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xF8924120 bmdma 0x0 irq 129
ata7: SATA max UDMA/133 cmd 0x0 ctl 0xF8926120 bmdma 0x0 irq 129
ata8: SATA max UDMA/133 cmd 0x0 ctl 0xF8928120 bmdma 0x0 irq 129
ata9: SATA max UDMA/133 cmd 0x0 ctl 0xF8932120 bmdma 0x0 irq 129
ata10: SATA max UDMA/133 cmd 0x0 ctl 0xF8934120 bmdma 0x0 irq 129
ata11: SATA max UDMA/133 cmd 0x0 ctl 0xF8936120 bmdma 0x0 irq 129
ata12: SATA max UDMA/133 cmd 0x0 ctl 0xF8938120 bmdma 0x0 irq 129
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back SCSI device sda: 976773168
512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back SCSI device sdb: 976773168
512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back SCSI device sdc: 976773168
512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: unknown partition table
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back SCSI device sdd: 976773168
512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: unknown partition table
sd 3:0:0:0: Attached scsi disk sdd
ata5: dev 0 cfg 49:2f00 82:7469 83:7f61 84:4163 85:7469 86:3c41 87:4163
88:407f
ata5: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata5: qc timeout (cmd 0xef)
ata5: failed to set xfermode (err_mask=0x4)
scsi4 : sata_mv
ata6: dev 0 cfg 49:2f00 82:7469 83:7f61 84:4163 85:7469 86:3c41 87:4163
88:407f
ata6: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata6: qc timeout (cmd 0xef)
ata6: failed to set xfermode (err_mask=0x4)
scsi5 : sata_mv
ata7: dev 0 cfg 49:2f00 82:7469 83:7f61 84:4163 85:7469 86:3c41 87:4163
88:407f
ata7: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata7: qc timeout (cmd 0xef)
ata7: failed to set xfermode (err_mask=0x4)
scsi6 : sata_mv
ata8: dev 0 cfg 49:2f00 82:7469 83:7f61 84:4163 85:7469 86:3c41 87:4163
88:407f
ata8: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata8: qc timeout (cmd 0xef)
ata8: failed to set xfermode (err_mask=0x4)
scsi7 : sata_mv
ata9: dev 0 cfg 49:2f00 82:7469 83:7f61 84:4163 85:7469 86:3c41 87:4163
88:407f
ata9: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata9: qc timeout (cmd 0xef)
ata9: failed to set xfermode (err_mask=0x4)
scsi8 : sata_mv
ata10: dev 0 cfg 49:2f00 82:7469 83:7f61 84:4163 85:7469 86:3c41 87:4163
88:407f
ata10: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata10: qc timeout (cmd 0xef)
ata10: failed to set xfermode (err_mask=0x4)
scsi9 : sata_mv
ata11: dev 0 cfg 49:2f00 82:7469 83:7f61 84:4163 85:7469 86:3c41 87:4163
88:407f
ata11: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata11: qc timeout (cmd 0xef)
ata11: failed to set xfermode (err_mask=0x4) scsi10 : sata_mv
ata12: dev 0 cfg 49:2f00 82:7469 83:7f61 84:4163 85:7469 86:3c41 87:4163
88:407f
ata12: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata12: qc timeout (cmd 0xef)
ata12: failed to set xfermode (err_mask=0x4)
scsi11 : sata_mv


