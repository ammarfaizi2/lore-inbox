Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbUJYQEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbUJYQEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbUJYQBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:01:14 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:19073 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S261968AbUJYPvx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:51:53 -0400
Date: Mon, 25 Oct 2004 10:52:36 -0500
From: John Lash <jlash@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: sata_sil problems on 2.6.9
Message-ID: <20041025105236.1aff8801@homer.sarvega.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs102 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having a problem with a pci sata card using the SiI 3112 controller: Here's
what lspci shows.

00:09.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 SATARaid
Controller (rev 01) 

This is an athlon 760mpx (asus motherboard) system. I've tried plugging the card
into both 32 and 64bit slots and get the same behaviour.

On the most recent boot I got the following error:
(note, this is 2.6.9 with Jeff's patches: 2.6.9-libata1-dev1.patch.bz2 and
2.6.9-libata1.patch.bz2)

libata version 1.02 loaded.
sata_sil version 0.54
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 21 (level, low) -> IRQ 21
ata1: SATA max UDMA/100 cmd 0xF8836080 ctl 0xF883608A bmdma 0xF8836000 irq 21
ata2: SATA max UDMA/100 cmd 0xF88360C0 ctl 0xF88360CA bmdma 0xF8836008 irq 21
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata1: dev 0 ATA, max UDMA/133, 156301488 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
  Vendor: ATA       Model: Sô380013AS        Rev: 3þ18
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0:<3>ata1: command 0x25 timeout, stat 0x50
host_stat 0x1 unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

It's intermittent. Sometimes I see it on boot. Sometimes I see it when I try to
fdisk the drive. Once I got all the way into making a filesystem on the disk
before it started choking on me. Always with the same "command 0x25" error.

I've tried sata_sil with 2.6.9 vanilla and with the two patches I mentioned
above.

I also tried 2.6.8.1 using the siimage driver and got quite a few stacks in
dmesg along with stuff on the console about disabling int 17.

fwiw, I did a quick reboot, back on a vanilla 2.6.9 kernel. the boot was clean.
I ran "fdisk -l /dev/sda" and it worked once. The second time, I again got the
"ata1: command 0x25 timeout, stat 0x50 host_stat 0x1" error.

any ideas.

--john
