Return-Path: <linux-kernel-owner+w=401wt.eu-S1750837AbXAVIC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbXAVIC6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 03:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbXAVIC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 03:02:58 -0500
Received: from server077.de-nserver.de ([62.27.12.245]:53409 "EHLO
	server077.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbXAVIC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 03:02:57 -0500
Message-ID: <45B46FA0.2060901@profihost.com>
Date: Mon, 22 Jan 2007 09:02:40 +0100
From: Stefan Priebe - FH <studium@profihost.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SATA ahci Bug in 2.6.19.x
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 84.134.23.182
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've an Asus A8V Mainboard which works wonderful with a 2.6.18.X kernel. 
But i cannot use the SATA Controller with a 2.6.19.x Kernel.

dmesg output from 2.6.18.3 where it works perfectly:
libata version 2.00 loaded.
ahci 0000:00:0f.0: version 2.0
GSI 19 sharing vector 0xD9 and IRQ 19
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI
21 (level, low) -> IRQ 217
ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4
ports 3 Gbps 0xf impl IDE mode
ahci 0000:00:0f.0: flags: 64bit ncq pm led
clo pmp pio slum part
ata1: SATA max UDMA/133 cmd
0xFFFFC20000004D00 ctl 0x0 bmdma 0x0 irq 225
ata2: SATA max UDMA/133 cmd
0xFFFFC20000004D80 ctl 0x0 bmdma 0x0 irq 225
ata3: SATA max UDMA/133 cmd
0xFFFFC20000004E00 ctl 0x0 bmdma 0x0 irq 225
ata4: SATA max UDMA/133 cmd
0xFFFFC20000004E80 ctl 0x0 bmdma 0x0 irq 225
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
ata1.00: ATA-7, max UDMA7, 312581808
sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
ata2.00: ATA-7, max UDMA7, 312581808
sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
   Vendor: ATA       Model: SAMSUNG HD160JJ
  Rev: ZM10
   Type:   Direct-Access
  ANSI SCSI revision: 05
   Vendor: ATA       Model: SAMSUNG HD160JJ
  Rev: ZM10
   Type:   Direct-Access
  ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr
sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr
sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 312581808 512-byte hdwr
sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr
sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
  sdb: sdb1 < sdb5 sdb6 sdb7 >
sd 1:0:0:0: Attached scsi disk sdb


Output with 2.6.19.2 (logged via netconsole cause the system can't boot):

"ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 21 (level, low) -> IRQ 21"
"ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl IDE 
mode"
"ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio slum part "
"ata1: SATA max UDMA/133 cmd 0xFFFFC20000004D00 ctl 0x0 bmdma 0x0 irq 1277"
"ata2: SATA max UDMA/133 cmd 0xFFFFC20000004D80 ctl 0x0 bmdma 0x0 irq 1277"
"ata3: SATA max UDMA/133 cmd 0xFFFFC20000004E00 ctl 0x0 bmdma 0x0 irq 1277"
"ata4: SATA max UDMA/133 cmd 0xFFFFC20000004E80 ctl 0x0 bmdma 0x0 irq 1277"
"scsi0 : ahci"
"ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)"
"ata1.00: qc timeout (cmd 0xec)"
"ata1.00: failed to IDENTIFY (I/O error, err_mask=0x104)"
"ata1: port is slow to respond, please be patient (Status 0x80)"
"ata1: port failed to respond (30 secs, Status 0x80)"
"ata1: COMRESET failed (device not ready)"
"ata1: hardreset failed, retrying in 5 secs"
"ata1: port is slow to respond, please be patient (Status 0x80)"
"ata1: port failed to respond (30 secs, Status 0x80)"
"ata1: COMRESET failed (device not ready)"
"ata1: hardreset failed, retrying in 5 secs"
"ata1: port is slow to respond, please be patient (Status 0x80)"
"ata1: port failed to respond (30 secs, Status 0x80)"
"ata1: COMRESET failed (device not ready)"
"ata1: reset failed, giving up"
"scsi1 : ahci"
"ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)"
"ata2.00: qc timeout (cmd 0xec)"
"ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)"
"ata2: port is slow to respond, please be patient (Status 0x80)"
"ata2: port failed to respond (30 secs, Status 0x80)"
"ata2: COMRESET failed (device not ready)"
"ata2: hardreset failed, retrying in 5 secs"
"ata2: port is slow to respond, please be patient (Status 0x80)"
"ata2: port failed to respond (30 secs, Status 0x80)"
"ata2: COMRESET failed (device not ready)"
"ata2: hardreset failed, retrying in 5 secs"
"ata2: port is slow to respond, please be patient (Status 0x80)"
"ata2: port failed to respond (30 secs, Status 0x80)"
"ata2: COMRESET failed (device not ready)"
"ata2: reset failed, giving up"
"scsi2 : ahci"
"ata3: SATA link down (SStatus 0 SControl 300)"
"scsi3 : ahci"
"ata4: SATA link down (SStatus 0 SControl 300)"


Stefan
