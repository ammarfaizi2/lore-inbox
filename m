Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272603AbTHKHYm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 03:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272604AbTHKHYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 03:24:42 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:43534 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S272603AbTHKHYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 03:24:37 -0400
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test3] file system corruption (related to atime update?) 
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Mon, 11 Aug 2003 09:24:35 +0200
Message-ID: <877k5k1wss.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file system corruption I observed late in the 2.5.x series is
still not gone.  File system modes are suddenly wrong, and a fsck run
removes the files. 8-/ This happens with ext2 (and previously with
ext3).

The strange thing is that these files are only read, not written to,
so it probably has to do with atime updates.

Hardware is a Siemens Primergy H450, with the following SCSI
controller (2.4.x output, as I had to downgrade again).  The machine
runs a software RAID 5 across all six disks.

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue c3f87c18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: FUJITSU   Model: MAN3367MC         Rev: 5207
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue c3f87a18, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: FUJITSU   Model: MAP3367NC         Rev: 5205
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue c3f87218, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: FUJITSU   Model: MAP3367NC         Rev: 5205
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7aaf818, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:4): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: SDR       Model: GEM318            Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
blk: queue f7aaaa18, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:2:0: Tagged Queuing enabled.  Depth 253
scsi0:A:4:0: Tagged Queuing enabled.  Depth 253
  Vendor: FUJITSU   Model: MAN3367MC         Rev: 5207
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7aa4818, I/O limit 4095Mb (mask 0xffffffff)
(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: FUJITSU   Model: MAP3367NC         Rev: 5205
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7a9ee18, I/O limit 4095Mb (mask 0xffffffff)
(scsi1:A:2): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: FUJITSU   Model: MAP3367NC         Rev: 5205
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7a9e418, I/O limit 4095Mb (mask 0xffffffff)
(scsi1:A:4): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: SDR       Model: GEM318            Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
blk: queue f7a94618, I/O limit 4095Mb (mask 0xffffffff)
scsi1:A:0:0: Tagged Queuing enabled.  Depth 253
scsi1:A:2:0: Tagged Queuing enabled.  Depth 253
scsi1:A:4:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 4, lun 0
Attached scsi disk sdd at scsi1, channel 0, id 0, lun 0
Attached scsi disk sde at scsi1, channel 0, id 2, lun 0
Attached scsi disk sdf at scsi1, channel 0, id 4, lun 0
SCSI device sda: 71771688 512-byte hdwr sectors (36747 MB)
