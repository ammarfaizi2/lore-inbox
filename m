Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWIDXwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWIDXwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWIDXwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:52:16 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:54561 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965058AbWIDXwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:52:14 -0400
Subject: Very slow CD audio rip with DVD DUAL 4XMax
From: Alex Bennee <kernel-hacker@bennee.com>
Reply-To: kernel-hacker@bennee.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 00:52:36 +0100
Message-Id: <1157413956.7632.9.camel@malory>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was trying to rip some of my collection this evening when I noticed
grip was running at something like 0.3x speed. Investigating the kernel
log I was seeing a whole load of:

ATAPI device hdc:
  Error: Not ready -- (Sense key=0x02)
  Incompatible medium installed -- (asc=0x30, ascq=0x00)
  The failed "Read Subchannel" packet command was:
  "42 02 40 01 00 00 00 00 10 00 00 00 00 00 00 00 "

Messages, followed by the ide subsystem timing out:

hdc: DMA timeout retry
hdc: timeout waiting for DMA
hdc: status timeout: status=0xff { Busy }
ide: failed opcode was: unknown
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: DMA timeout retry
hdc: timeout waiting for DMA
hdc: status timeout: status=0xff { Busy }
ide: failed opcode was: unknown
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: DMA timeout retry
hdc: timeout waiting for DMA
hdc: status timeout: status=0xff { Busy }
ide: failed opcode was: unknown
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: DMA timeout retry
hdc: timeout waiting for DMA
hdc: status timeout: status=0xff { Busy }
ide: failed opcode was: unknown
hdc: drive not ready for command
hdc: ATAPI reset complete
Losing some ticks... checking if CPU frequency changed.

The drive is a 40x MSI DVD/RW drive so it should be running a lot faster
than that. Any idea how I can figure out what is going on? I've attached
the relevant dmesg dumps:


ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: ATAPI DVD DUAL 4XMax, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 2.00 loaded.
sata_nv 0000:00:0a.0: version 2.0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
GSI 18 sharing vector 0xC1 and IRQ 18
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 21 (level,
high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 193
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 193
scsi0 : sata_nv
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 398297088 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda

malory downloaded # uname -a
Linux malory 2.6.18-rc4-ajb #25 Sat Aug 12 14:04:51 BST 2006 x86_64 AMD
Athlon(tm) 64 Processor 3400+ GNU/Linux

What else would be useful to figure out whats going on?

--
Alex, homepage: http://www.bennee.com/~alex/
Mal (naked, alone in the desert): "Yep... that went well."

