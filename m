Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVK2EEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVK2EEg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 23:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVK2EEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 23:04:35 -0500
Received: from smtp-5.smtp.ucla.edu ([169.232.47.138]:64135 "EHLO
	smtp-5.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1750713AbVK2EEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 23:04:35 -0500
Message-ID: <438BD351.60902@ucla.edu>
Date: Mon, 28 Nov 2005 20:04:33 -0800
From: Ethan Chen <thanatoz@ucla.edu>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: thanatoz@ucla.edu
Subject: SIL_QUIRK_MOD15WRITE workaround problem on 2.6.14
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a dual Opteron 242 machine here with 2x Seagate ST3200822AS 
SATA drives attached to a Silicon Image SI3114 controller, and after 
upgrading to 2.6.14 from 2.6.13, it seems the SIL_QUIRK_MOD15WRITE 
workaround for the sata_sil driver isn't being applied anymore. This 
caused me trouble in the past before my drive was added to the 
blacklist, and this message that comes up when writing (~4GBfiles to 
test) files, right before the computer locks up, is the same as before:
kernel: ata1: command 0x35 timeout, stat 0xd8 host_stat 0x61
In the dmesg, the 'Applying Seagate errata fix' message doesn't appear 
anymore as well.
Finally, without the fix, write speeds are much higher as well, before 
it locks up.

dmesg snippet from 2.6.13.4
kernel: SCSI subsystem initialized
kernel: ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 17 (level, low) -> IRQ 16
kernel: ata1: SATA max UDMA/100 cmd 0xFFFFC20000004C80 ctl 
0xFFFFC20000004C8A bmdma 0xFFFFC20000004C00 irq 16
kernel: ata2: SATA max UDMA/100 cmd 0xFFFFC20000004CC0 ctl 
0xFFFFC20000004CCA bmdma 0xFFFFC20000004C08 irq 16
kernel: ata3: SATA max UDMA/100 cmd 0xFFFFC20000004E80 ctl 
0xFFFFC20000004E8A bmdma 0xFFFFC20000004E00 irq 16
kernel: ata4: SATA max UDMA/100 cmd 0xFFFFC20000004EC0 ctl 
0xFFFFC20000004ECA bmdma 0xFFFFC20000004E08 irq 16
kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
kernel: ata1: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
kernel: ata1(0): applying Seagate errata fix
kernel: ata1: dev 0 configured for UDMA/100
kernel: scsi0 : sata_sil
kernel: ata2: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
kernel: ata2(0): applying Seagate errata fix
kernel: ata2: dev 0 configured for UDMA/100
kernel: scsi1 : sata_sil
kernel: ata3: dev 0 ATA, max UDMA/133, 586114704 sectors: lba48
kernel: ata3: dev 0 configured for UDMA/100
kernel: scsi2 : sata_sil
kernel: ata4: no device found (phy stat 00000000)
kernel: scsi3 : sata_sil

dmesg snippet from 2.6.14.2
kernel: SCSI subsystem initialized
kernel: ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 17 (level, low) -> IRQ 16
kernel: ata1: SATA max UDMA/100 cmd 0xFFFFC20000004C80 ctl 
0xFFFFC20000004C8A bmdma 0xFFFFC20000004C00 irq 16
kernel: ata2: SATA max UDMA/100 cmd 0xFFFFC20000004CC0 ctl 
0xFFFFC20000004CCA bmdma 0xFFFFC20000004C08 irq 16
kernel: ata3: SATA max UDMA/100 cmd 0xFFFFC20000004E80 ctl 
0xFFFFC20000004E8A bmdma 0xFFFFC20000004E00 irq 16
kernel: ata4: SATA max UDMA/100 cmd 0xFFFFC20000004EC0 ctl 
0xFFFFC20000004ECA bmdma 0xFFFFC20000004E08 irq 16
kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
kernel: ata1: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
kernel: ata1: dev 0 configured for UDMA/100
kernel: scsi0 : sata_sil
kernel: ata2: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
kernel: ata2: dev 0 configured for UDMA/100
kernel: scsi1 : sata_sil
kernel: ata3: dev 0 ATA, max UDMA/133, 586114704 sectors: lba48
kernel: ata3: dev 0 configured for UDMA/100
kernel: scsi2 : sata_sil
kernel: ata4: no device found (phy stat 00000000)
kernel: scsi3 : sata_sil

Thanks,
Ethan Chen

