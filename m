Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVCUWs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVCUWs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVCUWq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:46:27 -0500
Received: from tiu.fh-brandenburg.de ([195.37.0.8]:18085 "EHLO
	tiu.fh-brandenburg.de") by vger.kernel.org with ESMTP
	id S262148AbVCUWoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:44:21 -0500
Date: Mon, 21 Mar 2005 23:44:10 +0100
From: Markus Dahms <dahms@fh-brandenburg.de>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Lockup using ALi SATA controller (sata_uli)
Message-ID: <20050321224410.GA27760@fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have a reproducable lockup of my system using an ALi SATA controller
and writing some 100 MB to the attached disk.

kernel: 2.6.11 SMP (w/ and w/o preemption tested)
system: 2 x Pentium III on Asus CUV266-D
controller: ALi M5283 based PCI card (1xPATA, 2xSATA)
disk: 160GB Hitachi

The Linux system is on another disk (PATA, onboard controller).

The same controller with the same disk in another system (AMD) show
the same errors (lockup, BadCRC as seen below), the disk with another
controller (SII) works.

Thanks to netconsole I could get the following "last words":

| ata2: command 0x35 timeout, stat 0xd0 host_stat 0x81
| ata2: status=0xd0 { Busy }
| SCSI error : <1 0 0 0> return code = 0x8000002
| sda: Current: sense key: Aborted Command
|     Additional sense: Scsi parity error
| end_request: I/O error, dev sda, sector 2087934
| Buffer I/O error on device sda5, logical block 260976
| lost page write due to I/O error on sda5
| ATA: abnormal status 0xD0 on port 0x9007
| ATA: abnormal status 0xD0 on port 0x9007
| ATA: abnormal status 0xD0 on port 0x9007

After a hard reset the following lines appear 4 to 10 times in the
boot messages and the filesystem recovery (XFS in my case) fails.
A second attempt to mount the filesystem succeeds.

| ata2: status=0x51 { DriveReady SeekComplete Error }
| ata2: error=0x84 { DriveStatusError BadCRC }

The relevant lines from the boot log:

| libata version 1.10 loaded.
| ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 17
| ata1: SATA max UDMA/133 cmd 0x9800 ctl 0x9402 bmdma 0x8400 irq 17
| ata2: SATA max UDMA/133 cmd 0x9000 ctl 0x8802 bmdma 0x8408 irq 17
| ata1: no device found (phy stat 00000000)
| scsi0 : sata_uli
| ata2: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e8 86:3c02 87:4023 88:003f
| ata2: dev 0 ATA, max UDMA/100, 321672960 sectors: lba48
| ata2: dev 0 configured for UDMA/100
| scsi1 : sata_uli
|   Vendor: ATA       Model: HDS722516VLSA80   Rev: V34O
|   Type:   Direct-Access                      ANSI SCSI revision: 05
| SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
| SCSI device sda: drive cache: write back
| SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
| SCSI device sda: drive cache: write back
|  sda: sda1 < sda5 >
| Attached scsi disk sda at scsi1, channel 0, id 0, lun 0

Do you have some hints?

Greetings,

	Markus

-- 
Do bl Sp ce is a v ry saf  me hod of driv  compr s ion
