Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWHXRfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWHXRfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWHXRfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:35:15 -0400
Received: from mail.first.fraunhofer.de ([194.95.169.2]:18913 "EHLO
	mail.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030420AbWHXRfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:35:12 -0400
Subject: translated ATA stat/err 0x51/0c to ... PDC20376 (FastTrak 376)
	related cold freezes
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 19:34:26 +0200
Message-Id: <1156440866.29118.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I just upgraded to using 2 sata disks (both seagate drives
ST3400832AS and ST3750640AS) on this asus a7v8x on-board promise fastrak
376 (PDC20376) controller. However, as soon as I do a lot of io (cp some
G of files) I get swamped in 

ata1: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x0c { DriveStatusError }
ata2: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x0c { DriveStatusError }
...

messages. For that it is enough to do it on a single drive or copy from
drive to drive. This is on kernel 2.6.17.4, but I remember (when I was
still using a single drive) this very same output to happen on 2.6.15.

Can anyone translate these dubious error messages to me ?

Here are more details about the system:

- the sata_promise driver version 1.04 is used

- relevant dmesg output:
libata version 1.20 loaded.
sata_promise 0000:00:08.0: version 1.04
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 17 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0xF8822200 ctl 0xF8822238 bmdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xF8822280 ctl 0xF88222B8 bmdma 0x0 irq 17
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:007f
ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:007f
ata2: dev 0 ATA-7, max UDMA/133, 1465149168 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_promise
  Vendor: ATA       Model: ST3400832AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3750640AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 1465149168 512-byte hdwr sectors (750156 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 1465149168 512-byte hdwr sectors (750156 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb


# cat /proc/interrupts
           CPU0
  0:    1513605    IO-APIC-edge  timer
  1:        469    IO-APIC-edge  i8042
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:      85189    IO-APIC-edge  ide0
 15:      14736    IO-APIC-edge  ide1
 16:      88324   IO-APIC-level  ide2
 17:     234771   IO-APIC-level  libata
 18:     277667   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4
 19:      14909   IO-APIC-level  fcpci, eth0
 20:          0   IO-APIC-level  saa7146 (0)
 21:          0   IO-APIC-level  VIA8233
NMI:    1516297
LOC:    1515188
ERR:          0
MIS:          0

# lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
0000:00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
0000:00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (FastTrak 376) (rev 02)
0000:00:09.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
0000:00:0a.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
0000:00:0b.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
0000:00:0c.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
0000:00:0f.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 04)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01)
0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] (Secondary) (rev 01)

Any ideas/need more info -> let me know.

Thanks in advance,
Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
