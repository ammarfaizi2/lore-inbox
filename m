Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264897AbUGBSgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbUGBSgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbUGBSgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:36:47 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:51082 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264886AbUGBSgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:36:42 -0400
Date: Fri, 2 Jul 2004 19:35:14 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       <cova@ferrara.linux.it>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: question about SATA and IDE DVD/CD drives.
In-Reply-To: <Pine.LNX.4.44.0407021805580.2190-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.44.0407021929070.3033-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

After I gave up fiddling with "ideX=???" options, an alternative
possibility just occurred to me, looking at this dmesg output from libata:

ata_piix version 1.02
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
  Vendor: ATA       Model: ST3120026AS       Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
ata2: dev 0 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000 87:0000 88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

wouldn't it be nice if I could specify somehow to skip the "ata2" instance
and leave the 0x170/0x376 resource to be allocated by IDE, which would be
compiled as a module? Or, once probed and allocated (but not in use) I
could tell the driver to "release" a particular instance and free all
resources? I think this is not possible with the current infrastructure
and, seeing you want to get rid of this conflict altogether, it is
unlikely you would be interested in adding such support, right?

Kind regards
Tigran

