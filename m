Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbWJSMDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWJSMDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWJSMDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:03:14 -0400
Received: from mail.tweerlei.de ([85.183.132.91]:53259 "EHLO mail.tweerlei.de")
	by vger.kernel.org with ESMTP id S1751517AbWJSMDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:03:13 -0400
Message-ID: <4537697C.7080500@tweerlei.de>
Date: Thu, 19 Oct 2006 14:03:08 +0200
From: Robert Wruck <wruck@tweerlei.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.19-rc2] SATA boot problems
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having problems booting from a SATA disk with 2.6.19-rc2.
Grub loads fine, but when the kernel boots, it *sometimes* ends up with
VFS: Cannot open root device "sda5" or unknown-block(0,0)

The strange thing is that this happens only in 2/3 of the boot attempts.
If I reset the machine, the next attempt is likely to succeed.
I first noted this when switching from 2.6.17 (2.6.17.11, IIRC) to
2.6.18 and it persists in 2.6.19-rc2 (Windows does not encounter similar
problems on the same machine).

I attached a diff of a successful and an unsuccessful netconsole log
below. It seems that the drive is sometimes simply not detected...
I'm not using an initrd and changing the kernel command line from
root=/dev/sda5 to root=0x0805 did not help.

The controller is:
00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA
Controller (rev 03)

Any ideas? Please CC me, as I'm not subscribed.
Robert


 ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 19
 ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 19
 scsi0 : ata_piix
+ata1.00: ATA-7, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 0/32)
+ata1.00: ata1: dev 0 multi count 16
+ata1.00: configured for UDMA/133
 scsi1 : ata_piix
 ATA: abnormal status 0x7F on port 0xE407
+  Vendor: ATA       Model: Maxtor 6V160E0    Rev: VA11
+  Type:   Direct-Access                      ANSI SCSI revision: 05
+SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
+sda: Write Protect is off
+SCSI device sda: drive cache: write back
+SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
+sda: Write Protect is off
+SCSI device sda: drive cache: write back
+ sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 >
+sd 0:0:0:0: Attached scsi disk sda
+sd 0:0:0:0: Attached scsi generic sg0 type 0
 ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 20
 ehci_hcd 0000:00:1d.7: EHCI Host Controller
 ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1

