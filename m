Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWJALXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWJALXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWJALXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:23:42 -0400
Received: from natblert.rzone.de ([81.169.145.181]:17910 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S1751426AbWJALXl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:23:41 -0400
Date: Sun, 1 Oct 2006 13:23:34 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, axboe@kernel.dk
Subject: DVD drive lost DVD capabilities in current git tree
Message-ID: <20061001112333.GA15311@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Current git tree does not detect the DVD drive in the G5 anymore:

-Linux version 2.6.18-g5-g5ffd1a6a (olaf@g5) (gcc version 4.1.0 (SUSE Linux)) #61 SMP Sat Sep 30 19:16:58 CEST 2006
+Linux version 2.6.18-g5-g82965add (olaf@g5) (gcc version 4.1.0 (SUSE Linux)) #62 SMP Sun Oct 1 11:41:42 CEST 2006

 Probing IDE interface ide0...
 hda: HL-DT-ST DVD-RW GWA-4165B, ATAPI CD/DVD-ROM drive
 hda: Enabling Ultra DMA 4
 ide0 at 0xd00008008730e000-0xd00008008730e007,0xd00008008730e160 on irq 38
-hda: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
+hda: ATAPI CD-ROM drive, 0kB Cache, UDMA(66)
 Uniform CD-ROM driver Revision: 3.20
 libata version 2.00 loaded.
 sata_svw 0001:03:0c.0: version 2.0


4aff5e2333c9a1609662f2091f55c3f6fffdad36 is first bad commit
diff-tree 4aff5e2333c9a1609662f2091f55c3f6fffdad36 (from 77ed74da26f50fa28471571ee7a2251b77526d84)
Author: Jens Axboe <axboe@suse.de>
Date:   Thu Aug 10 08:44:47 2006 +0200

    [PATCH] Split struct request ->flags into two parts
    
    Right now ->flags is a bit of a mess: some are request types, and
    others are just modifiers. Clean this up by splitting it into
    ->cmd_type and ->cmd_flags. This allows introduction of generic
    Linux block message types, useful for sending generic Linux commands
    to block devices.
    
    Signed-off-by: Jens Axboe <axboe@suse.de>

:040000 040000 ff931af25471578be78885d8e27e9e0df829b49d f5edcbd2a9424828cfb4f1579d672c95bba7a4a0 M      block
:040000 040000 5e4d7235fa7d0a48cb3b23399905dc3d472d738e 05a44d13e66ce6e6bdc6e9d697675c32799c70e3 M      drivers
:040000 040000 887303b2f4077cc43bd23e42d0b104cab05655b1 50c82dbe8394b6b8e5bd169c182e0b4cc3d71963 M      include


BISECT_LOG
git-bisect start
# bad: [82965addad66fce61a92c5f03104ea90b0b87124] Merge master.kernel.org:/pub/scm/linux/kernel/git/davej/agpgart
git-bisect bad 82965addad66fce61a92c5f03104ea90b0b87124
# good: [5ffd1a6aaacc25be8cd0770a51ec6d46add3a276] Merge master.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb
git-bisect good 5ffd1a6aaacc25be8cd0770a51ec6d46add3a276
# bad: [c7bce3097c0f9bbed76ee6fd03742f2624031a45] serial: Fix up offenders peering at baud bits directly
git-bisect bad c7bce3097c0f9bbed76ee6fd03742f2624031a45
# bad: [50be345560f1ffdcb15cc0e146416b80529a2ef2] fix creating zero sized bio mempools in low memory system
git-bisect bad 50be345560f1ffdcb15cc0e146416b80529a2ef2
# bad: [981a79730d586335ef8f942c83bdf2b1de6d4e3d] cfq-iosched: kill the empty_list
git-bisect bad 981a79730d586335ef8f942c83bdf2b1de6d4e3d
# bad: [8a8e674cb1dafc818ffea93d97e4c1c1f01fdbb6] as-iosched: kill arq
git-bisect bad 8a8e674cb1dafc818ffea93d97e4c1c1f01fdbb6
# bad: [1fbfdfcddff4df188b24d9d05271a76a85064583] elevator: introduce a way to reuse rq for internal FIFO handling
git-bisect bad 1fbfdfcddff4df188b24d9d05271a76a85064583
# bad: [2e662b65f05d550b6799ed6bfa9963b82279e6b7] elevator: abstract out the rbtree sort handling
git-bisect bad 2e662b65f05d550b6799ed6bfa9963b82279e6b7
# bad: [9817064b68fef7e4580c6df1ea597e106b9ff88b] elevator: move the backmerging logic into the elevator core
git-bisect bad 9817064b68fef7e4580c6df1ea597e106b9ff88b
# bad: [4aff5e2333c9a1609662f2091f55c3f6fffdad36] Split struct request ->flags into two parts
git-bisect bad 4aff5e2333c9a1609662f2091f55c3f6fffdad36
# good: [77ed74da26f50fa28471571ee7a2251b77526d84] i2c: Prevent deadlock on i2c client registration
git-bisect good 77ed74da26f50fa28471571ee7a2251b77526d84
