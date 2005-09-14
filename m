Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVINTsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVINTsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVINTsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:48:54 -0400
Received: from juno.lps.ele.puc-rio.br ([139.82.40.34]:12966 "EHLO
	juno.lps.ele.puc-rio.br") by vger.kernel.org with ESMTP
	id S932392AbVINTsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:48:54 -0400
Message-ID: <60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br>
Date: Wed, 14 Sep 2005 16:48:57 -0300 (BRT)
Subject: Re: libata sata_sil broken on 2.6.13.1
From: izvekov@lps.ele.puc-rio.br
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-6.FC2
X-Mailer: SquirrelMail/1.4.3a-6.FC2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to get a serial cable. Now follows the dmesg, from where libata
starts until it dies.

ata1: SATA max UDMA/100 cmd 0xF881E080 ctl 0xF881E08A bmdma 0xF881E000 irq 11
ata2: SATA max UDMA/100 cmd 0xF881E0C0 ctl 0xF881E0CA bmdma 0xF881E008 irq 11
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata1(0): applying Seagate errata fix
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
irq 11: nobody cared (try booting with the "irqpoll" option)
 [<c01421fa>] __report_bad_irq+0x2a/0x90
 [<c01419c9>] handle_IRQ_event+0x39/0x70
 [<c0142320>] note_interrupt+0xa0/0x100
 [<c0141b28>] __do_IRQ+0x128/0x140
 [<c010506e>] do_IRQ+0x3e/0x60
 =======================
 [<c01034b2>] common_interrupt+0x1a/0x20
 [<c0122950>] __do_softirq+0x30/0x90
 [<c0105181>] do_softirq+0x41/0x50
 =======================
 [<c0122a65>] irq_exit+0x35/0x40
 [<c0105075>] do_IRQ+0x45/0x60
 [<c01034b2>] common_interrupt+0x1a/0x20
 [<c010f544>] delay_tsc+0x14/0x20
 [<c039fa6f>] ata_pio_complete+0x15f/0x220
 [<c03a02c0>] ata_pio_task+0x50/0x80
 [<c012e2a0>] worker_thread+0x200/0x2f0
 [<c03a0270>] ata_pio_task+0x0/0x80
 [<c0119960>] default_wake_function+0x0/0x20
 [<c0119960>] default_wake_function+0x0/0x20
 [<c012e0a0>] worker_thread+0x0/0x2f0
 [<c0132948>] kthread+0xa8/0xe0
 [<c01328a0>] kthread+0x0/0xe0
 [<c0101395>] kernel_thread_helper+0x5/0x10
handlers:
[<c03a0cc0>] (ata_interrupt+0x0/0x120)
Disabling IRQ #11
ata2: dev 0 ATA, max UDMA/100, 39102336 sectors:
ata2(0): applying bridge limits


So that means the irq triggered, but there where no handlers? Also, this
seems a non-critical fault, why whould the machine lock?

Here is lspci -vvx of the sata controller in kernel 2.6.12.6

0000:01:0b.0 RAID bus controller: Silicon Image, Inc. SiI 3112
[SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. SiI 3112 SATARaid Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9c00 [size=8]
	Region 1: I/O ports at a000 [size=4]
	Region 2: I/O ports at a400 [size=8]
	Region 3: I/O ports at a800 [size=4]
	Region 4: I/O ports at ac00 [size=16]
	Region 5: Memory at df001000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 95 10 12 31 07 00 b0 02 02 00 04 01 08 20 00 00
10: 01 9c 00 00 01 a0 00 00 01 a4 00 00 01 a8 00 00
20: 01 ac 00 00 00 10 00 df 00 00 00 00 95 10 12 61
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00

and here is the same thing, but for kernel 2.6.13.1
0000:01:0b.0 RAID bus controller: Silicon Image, Inc. SiI 3112
[SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. SiI 3112 SATARaid Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9c00 [size=8]
	Region 1: I/O ports at a000 [size=4]
	Region 2: I/O ports at a400 [size=8]
	Region 3: I/O ports at a800 [size=4]
	Region 4: I/O ports at ac00 [size=16]
	Region 5: Memory at df001000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at de000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 95 10 12 31 07 00 b0 02 02 00 04 01 08 20 00 00
10: 01 9c 00 00 01 a0 00 00 01 a4 00 00 01 a8 00 00
20: 01 ac 00 00 00 10 00 df 00 00 00 00 95 10 12 61
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00

The only difference i can see is the presence of the line
Expansion ROM at de000000 [disabled] [size=512K]
in the latter.

Now, the dmesg output for 2.6.13.1, with the pata hd disconnected,
but the bridge connected and powered:

libata version 1.12 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNK3] -> GSI 11 (level, low)
-> IRQ 11
ata1: SATA max UDMA/100 cmd 0xF881E080 ctl 0xF881E08A bmdma 0xF881E000 irq 11
ata2: SATA max UDMA/100 cmd 0xF881E0C0 ctl 0xF881E0CA bmdma 0xF881E008 irq 11
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003
88:207f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata1(0): applying Seagate errata fix
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2 is slow to respond, please be patient
ata2 failed to respond (30 secs)
scsi1 : sata_sil
  Vendor: ATA       Model: ST3120026AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

Nothing seems wrong here (except for Vendor "ATA" instead of Seagate,
but that doesnt matter anyway)
