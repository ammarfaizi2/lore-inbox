Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161286AbWGJAdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161286AbWGJAdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161284AbWGJAdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:33:24 -0400
Received: from smtp.ono.com ([62.42.230.12]:340 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S1161286AbWGJAdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:33:23 -0400
Date: Mon, 10 Jul 2006 02:33:11 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.18-rc1-mm1
Message-ID: <20060710023311.169251c4@werewolf.auna.net>
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
References: <20060709021106.9310d4d1.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.3.1cvs78 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 02:11:06 -0700, Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> 

Booted fine and running, after changing my fstab to match the libata SATA/PATA
ordering.

More questions on this:
I also built in the sata-promise driver. With both ata_piix and sata_promise
builtin, host detenction seems to go in PCI order but... promise detects
first the SATA drives. I'm trying to get a way to predict what switchng
from IDE to libata will do on my boxes, but...

current state:

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)
03:04.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTrak 378/SATA 378) (rev 02)

ata_piix 0000:00:1f.1: version 2.00ac5
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
sata_promise 0000:03:04.0: version 1.04
ata5: SATA max UDMA/133 cmd 0xF8804200 ctl 0xF8804238 bmdma 0x0 irq 17
ata6: SATA max UDMA/133 cmd 0xF8804280 ctl 0xF88042B8 bmdma 0x0 irq 17
ata7: PATA max UDMA/133 cmd 0xF8804300 ctl 0xF8804338 bmdma 0x0 irq 17

full dmesg:

libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac5
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
scsi0 : ata_piix
in ich_pata_cbl_detect
controller has 80c support
... and we defaulted to 40-pin
ata1.00: ATAPI, max UDMA/33
ata1.01: ATAPI, max MWDMA0, CDB intr
ata1.00: configured for UDMA/33
ata1.01: configured for PIO3
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi1 : ata_piix
in ich_pata_cbl_detect
controller has 80c support
... and we found an 80-pin cable
ata2.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16
ata2.01: ATAPI, max UDMA/33
ata2.00: configured for UDMA/100
ata2.01: configured for UDMA/33
  Vendor: ATA       Model: ST3120022A        Rev: 3.06
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1712  Rev: 1004
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
scsi2 : ata_piix
ata3: ENTER, pcs=0x13 base=0
ata3: LEAVE, pcs=0x13 present_mask=0x1
ata3.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : ata_piix
ata4: ENTER, pcs=0x13 base=2
ata4: LEAVE, pcs=0x11 present_mask=0x0
ata4: SATA port has no device.
ATA: abnormal status 0x7F on port 0xC807
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_promise 0000:03:04.0: version 1.04
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 23 (level, low) -> IRQ 17
sata_promise PATA port found
ata5: SATA max UDMA/133 cmd 0xF8804200 ctl 0xF8804238 bmdma 0x0 irq 17
ata6: SATA max UDMA/133 cmd 0xF8804280 ctl 0xF88042B8 bmdma 0x0 irq 17
ata7: PATA max UDMA/133 cmd 0xF8804300 ctl 0xF8804338 bmdma 0x0 irq 17
scsi4 : sata_promise
ata5: SATA link down (SStatus 0 SControl 300)
scsi5 : sata_promise
ata6: SATA link down (SStatus 0 SControl 0)
scsi6 : sata_promise
ATA: abnormal status 0x7F on port 0xF880431C
ata7: disabling port
sd 0:0:1:0: Attached scsi removable disk sda
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
sd 2:0:0:0: Attached scsi disk sdc
sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:0:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
sr 1:0:1:0: Attached scsi CD-ROM sr1
...

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam03 (gcc 4.1.1 20060518 (prerelease)) #3 SMP PREEMPT Mon
