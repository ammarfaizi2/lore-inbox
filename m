Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVKONRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVKONRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVKONRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:17:17 -0500
Received: from vsmtp2alice.tin.it ([212.216.176.142]:22207 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S932488AbVKONRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:17:17 -0500
From: ldonesty <jorge78_REMOVE_ME_@inwind.it>
Subject: Re: Intel Sata controller and DVD-RW
Date: Tue, 15 Nov 2005 14:17:45 +0100
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2005.11.15.13.17.43.825234@inwind.it>
References: <58PeB-6G6-47@gated-at.bofh.it> <58Qaf-80f-93@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Mon, 14 Nov 2005 18:20:27 +0100, Mark Lord ha scritto:

> libata.atapi_enabled=1  in /boot/grub/menu.lst,
> 
> or this line in /etc/modprobe.conf:
> 
> options libata atapi_enabled=1
First of all, thanks a lot Mark for this suggestion!
In my config modprobe.conf doesn't exist (I try to set it in
modules.conf without any real improvement) and the grub modification (is
it in the "kernel" line, right?) doesn't help. 
But, searching in the tree files for atapi_enabled occurrence, I found
that variable in the drivers/scsi/libata-core.c:81 and after set it to 1,
I try to compile.
This seems to solve my problem because now I can use DVD-RW (device scd0):

*******************
libata version 1.12 loaded.
ata_piix 0000:00:1f.2: version 1.04
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
ata1: dev 0 cfg 49:2b00 82:346b 83:5b29 84:6003 85:3469 86:9a09 87:6003 88:203f
ata1: dev 0 ATA-6, max UDMA/100, 156301488 sectors: LBA
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: FUJITSU MHV2080A  Rev: 0000
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: Attached scsi disk sda
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
ata2: dev 0 cfg 49:0f00 82:4218 83:5000 84:4000 85:4218 86:1000 87:4000 88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
  Vendor: TSSTcorp  Model: DVD+-RW TS-L532B  Rev: DE03
  Type:   CD-ROM                             ANSI SCSI revision: 05
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
ReiserFS: sda7: found reiserfs format "3.6" with standard journal
ReiserFS: sda7: using ordered data mode
ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda7: checking transaction log (sda7)
ReiserFS: sda7: Using r5 hash to sort names
*******************

Anyway, how can i set the variable in menu.lst instead of changing
libata-core.c?

Thanks.

-- 
Il reggiseno e' uno strumento democratico perche' separa la destra dalla
sinistra, solleva le masse e attira i popoli.

www.debianizzati.org | Founder Member
Mario "Ldonesty" Di Nitto --- [Linux Registered User #334335]

