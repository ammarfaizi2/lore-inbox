Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265875AbUFRXOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUFRXOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUFRXOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:14:03 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:39121 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265974AbUFRXMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:12:30 -0400
Date: Fri, 18 Jun 2004 19:06:37 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SATA 3112 errors on 2.6.7
In-Reply-To: <200406190018.03500.rjwysocki@sisk.pl>
Message-ID: <Pine.GSO.4.33.0406181831180.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, R. J. Wysocki wrote:
>Are your drives out of Seagate, maybe?  If not, what make are they?

(As I said in a previous email...) 4 x Seagate ST3160023AS's RAID0'd
together in a BIOS "raid" mode compatable manner.

kernel: ata3: DMA timeout, stat 0x1
kernel: ATA: abnormal status 0xD8 on port 0xFFFFFF000004FE87

As I understand it, the "0x1" indicates ATA_DMA_ACTIVE, and "0xD8" is
ATA_BUSY | ATA_DRQ + two more bits (ata.h doesn't make it clear which
are command bits vs. status bits.)

FWIW...

Linux version 2.6.7-SMP+BK@1.1400 (root@spork.troz.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #15 SMP BK[20040618194307] Fri Jun 18 15:56:38 EDT 2004

Kernel command line: ro console=ttyS0,115200 console=tty0 debug numa=off md=d0,0,2,0,/dev/sda,/dev/sdb,/dev/sdc,/dev/sdd root=/dev/hdd1

ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_sil
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata3: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_sil
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata4: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_sil
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3160023AS       Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
...
 md_d0: p1 p2 p3

I am currently "zero"ing md/d0p2 in a loop. (code is @
	http://sweetums.bluetronic.net/~jfbeam/zero.c
) With the buffer size set to 49 stripes, it'll eventually fail.  At 64,
it fails quickly.  If O_DIRECT is enabled, it never fails.

--Ricky


