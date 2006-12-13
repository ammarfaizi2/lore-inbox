Return-Path: <linux-kernel-owner+w=401wt.eu-S964934AbWLMFCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWLMFCX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 00:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWLMFCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 00:02:23 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:41623 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964934AbWLMFCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 00:02:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LJpQh4pw52anz8jx9HjsbpzW3trr4uQVFBhCyBwtBzrbF3t4W9yqIozBUO2F5gDzioRYwWFCiXLxQl0KiKfIVBctwc1lI+Tnh5xwqc/RFgRRbmIom5xVvmdHjYLOAVX6hG5LuuZRPwmoGj41vo4RTGpfIQQK52qK5ptIrl6+Dko=
Message-ID: <f0e65c090612122102o327ac693u2f24a74a9ba973ef@mail.gmail.com>
Date: Wed, 13 Dec 2006 16:02:21 +1100
From: "David Shirley" <tephra@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SATA DMA problem (sata_uli)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chaps,

Basically I detected this problem because I added another drive to my
PCI SATA card, and now the system is running dog slow.

I tracked it down to one of the drives being forced into PIO4 mode
rather than UDMA mode; dmesg bits:

sata_nv 0000:00:0b.0: version 2.0
ACPI: PCI Interrupt Link [LSID] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LSID] -> GSI 11 (level,
low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE800 irq 11
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE808 irq 11
scsi0 : sata_nv
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3300831AS      3.06 PQ: 0 ANSI: 5
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      ST3300831AS      3.06 PQ: 0 ANSI: 5
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
sata_uli 0000:01:06.0: version 1.0
ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [LNK3] -> GSI 10 (level,
low) -> IRQ 10
ata3: SATA max UDMA/133 cmd 0x7000 ctl 0x7402 bmdma 0x8000 irq 10
ata4: SATA max UDMA/133 cmd 0x7800 ctl 0x7C02 bmdma 0x8008 irq 10
scsi2 : sata_uli
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : sata_uli
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
ata4.00: ata4: dev 0 multi count 16
ata4.00: simplex DMA is claimed by other device, disabling DMA
ata4.00: configured for PIO4
scsi 2:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: Direct-Access     ATA      ST3300831AS      3.06 PQ: 0 ANSI: 5
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg3 type 0

Why is ata4 reporting "simplex DMA is claimed by another device" and
how can I get it to work correctly?

Please let me know if you need more information.

Cheers
David
