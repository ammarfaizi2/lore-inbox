Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbTITLCU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 07:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbTITLCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 07:02:19 -0400
Received: from cpe.atm2-0-53171.0xc2efe34e.bynxx8.customer.tele.dk ([194.239.227.78]:2176
	"EHLO klippegang.dk") by vger.kernel.org with ESMTP id S261811AbTITLCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 07:02:17 -0400
Subject: Re: Badness in as_completed_request in 2.6.0-test5-bk3
From: Rene Rask <rene@grain.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1064055732.5913.15.camel@animatrix.klippegang.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 20 Sep 2003 13:02:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not subscribed to the list so please cc me if you have questions.

>Try disabling TCQ, I don't think it is very stable for IDE drives.

I'm getting these messages with a 3ware 7500-12 card as well even though
it is a scsi card.
I'm using kernel 2.6-test5-bk6 and copying files files an nfs mount to
the local 3ware disks ( 6 200 GB disks in hardware RAID5).

Dmesg output:

Badness in as_completed_request at drivers/block/as-iosched.c:906
Call Trace:
 [<c020b460>] as_completed_request+0x190/0x1a0
 [<c020382f>] elv_completed_request+0x1f/0x30
 [<c0205c7c>] __blk_put_request+0x3c/0xc0
 [<c0206cc9>] end_that_request_last+0x59/0xf0
 [<f88519ed>] scsi_end_request+0xbd/0xf0 [scsi_mod]
 [<f8851d5c>] scsi_io_completion+0x18c/0x520 [scsi_mod]
 [<f882dbc7>] sd_rw_intr+0x87/0x300 [sd_mod]
 [<f884cbb4>] scsi_finish_command+0x84/0xe0 [scsi_mod]
 [<c010d508>] do_IRQ+0xc8/0x150
 [<f884c9af>] scsi_softirq+0xef/0x230 [scsi_mod]
 [<c010b73c>] common_interrupt+0x18/0x20
 [<c0125b93>] do_softirq+0xd3/0xe0
 [<f8a8cf27>] xprt_prepare_transmit+0x77/0xe0 [sunrpc]
 [<f8a8adca>] call_transmit+0x2a/0xb0 [sunrpc]
 [<f8a8ed27>] __rpc_execute+0x217/0x310 [sunrpc]
 [<c011fbd0>] autoremove_wake_function+0x0/0x50
 [<f8ab7ed2>] nfs_pagein_one+0xa2/0xf0 [nfs]
 [<f8ab7f6e>] nfs_pagein_list+0x4e/0x80 [nfs]
 [<f8ab8468>] nfs_readpages+0x98/0xa0 [nfs]
 [<f8ab8300>] readpage_async_filler+0x0/0xd0 [nfs]
 [<c01439a8>] read_pages+0x178/0x190
 [<c0141909>] __alloc_pages+0x99/0x330
 [<c02517b4>] kfree_skbmem+0x24/0x30
 [<c0143c80>] do_page_cache_readahead+0xf0/0x150
 [<c0143e25>] page_cache_readahead+0x145/0x180
 [<c013d88c>] do_generic_mapping_read+0xdc/0x500
 [<c013dcb0>] file_read_actor+0x0/0xf0
 [<c013df92>] __generic_file_aio_read+0x1f2/0x230
 [<c013dcb0>] file_read_actor+0x0/0xf0
 [<c013e02a>] generic_file_aio_read+0x5a/0x80
 [<f8ab0cc1>] nfs_file_read+0x91/0xe0 [nfs]
 [<c015d28b>] do_sync_read+0x8b/0xc0
 [<c01b5789>] inode_has_perm+0x69/0xa0
 [<c01b7b01>] selinux_file_permission+0x141/0x180
 [<c015d3a0>] vfs_read+0xe0/0x150
 [<c010b73c>] common_interrupt+0x18/0x20
 [<c015d662>] sys_read+0x42/0x70
 [<c010ad7d>] sysenter_past_esp+0x52/0x71
 
Badness in as_completed_request at drivers/block/as-iosched.c:906
Call Trace:
 [<c020b460>] as_completed_request+0x190/0x1a0
 [<c020382f>] elv_completed_request+0x1f/0x30
 [<c0205c7c>] __blk_put_request+0x3c/0xc0
 [<c0206cc9>] end_that_request_last+0x59/0xf0
 [<f88519ed>] scsi_end_request+0xbd/0xf0 [scsi_mod]
 [<f8851d5c>] scsi_io_completion+0x18c/0x520 [scsi_mod]
 [<f882dbc7>] sd_rw_intr+0x87/0x300 [sd_mod]
 [<f884f39a>] scsi_delete_timer+0x1a/0x70 [scsi_mod]
 [<f884cbb4>] scsi_finish_command+0x84/0xe0 [scsi_mod]
 [<f884c9af>] scsi_softirq+0xef/0x230 [scsi_mod]
 [<c0125b93>] do_softirq+0xd3/0xe0
 [<c010d547>] do_IRQ+0x107/0x150
 [<c0108930>] default_idle+0x0/0x40
 [<c010b73c>] common_interrupt+0x18/0x20
 [<c0108930>] default_idle+0x0/0x40
 [<c010895a>] default_idle+0x2a/0x40
 [<c01089e7>] cpu_idle+0x37/0x40
 [<c0105000>] rest_init+0x0/0x50
 [<c03848d7>] start_kernel+0x197/0x1d0
 [<c0384450>] unknown_bootoption+0x0/0x100

This is just the first 2 after a reboot. The logs are filled with these
now.

Cheers
Rene < rene AT grain dk >

