Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbVISXIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbVISXIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 19:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbVISXIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 19:08:04 -0400
Received: from mxout1.netvision.net.il ([194.90.9.20]:12277 "EHLO
	mxout1.netvision.net.il") by vger.kernel.org with ESMTP
	id S932635AbVISXIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 19:08:02 -0400
Date: Tue, 20 Sep 2005 02:07:22 +0300
From: Maxim Kozover <maximkoz@netvision.net.il>
Subject: SATA drive recognized as hdc in 2.6.13.2
To: linux-kernel@vger.kernel.org
Reply-to: Maxim Kozover <maximkoz@netvision.net.il>
Message-id: <513537850.20050920020722@netvision.net.il>
MIME-version: 1.0
X-Mailer: The Bat! (v3.5.30) Professional
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Priority: 3 (Normal)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I have a Supermicro dual Xeon board and boot from Hitachi SATA drive
connected to an Intel (?) onboard controller.
Using 2.6.12.5 the SATA drive was recognized correctly as sda via ata_piix.
Now I tried 2.6.13.2 and it's recognized as hdc and works very slow.
It's really disappointing to see SATA drive as hdc in a new kernel.
Actually, I think the bug existed earlier and an another bug made it
non-exposed until now. I mean that skipping probe at 2.6.12.5 output.

By the way, hdx naming had some advantages as you're not limited to 16
partitions like in sdx (it's important if you have solaris slices
recognized by Linux and have 20 partitions).

Thanks,

Maxim.

2.6.13.2:
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdb: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
hdc: HDS724040KLSA80, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 1024KiB
hdc: 781422768 sectors (400088 MB) w/7919KiB Cache, CHS=48641/255/63
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 hdc11 hdc12 hdc13 hdc14 hdc15 >
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache


2.6.12.5:
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdb: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
............
Loading ata_piix.ko module
ata_piix: combined mode detected
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 169
ata: 0x1f0 IDE port busy
ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x14B8 irq 15
ata1: dev 0 ATA, max UDMA/133, 781422768 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
  Vendor: ATA       Model: HDS724040KLSA80   Rev: KFAO
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sda: drive cache: write back

