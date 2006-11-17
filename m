Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755702AbWKQPbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702AbWKQPbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755713AbWKQPbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:31:07 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:114 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1755702AbWKQPbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:31:05 -0500
Date: Fri, 17 Nov 2006 16:30:03 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Alasdair G Kergon <agk@redhat.com>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: 2.6.19-rc6 -- dm: possible recursive locking detected
Message-ID: <20061117153003.GB7131@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sent this a few days ago, but got no response. Probably because I addressed
this to the wrong persons. So, next try.

With current git tree as of today I get this:

=============================================
[ INFO: possible recursive locking detected ]
2.6.19-rc6-g1b9bb3c1 #28
---------------------------------------------
kpartx/945 is trying to acquire lock:
 (&md->io_lock){----}, at: [<00000000001f8faa>] dm_request+0x42/0x24c

but task is already holding lock:
 (&md->io_lock){----}, at: [<00000000001f8faa>] dm_request+0x42/0x24c

other info that might help us debug this:
1 lock held by kpartx/945:
 #0:  (&md->io_lock){----}, at: [<00000000001f8faa>] dm_request+0x42/0x24c

stack backtrace:
0000000000000000 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 00000000003a4d68 00000000003a4d68 0000000000016272 
       040000000d983280 00000000006d93e8 0000000000000000 0000000000477620 
       0000000000000000 000000000000000d 000000000d983380 000000000d9833f8 
       0000000000372450 0000000000016272 000000000d983380 000000000d9833d0 
Call Trace:
([<00000000000161d8>] show_trace+0xc0/0xdc)
 [<0000000000016294>] show_stack+0xa0/0xd0
 [<00000000000162f2>] dump_stack+0x2e/0x3c
 [<0000000000063244>] __lock_acquire+0xa80/0xeac
 [<0000000000063c10>] lock_acquire+0x90/0xc0
 [<000000000005d540>] down_read+0x54/0x9c
 [<00000000001f8faa>] dm_request+0x42/0x24c
 [<000000000017e528>] generic_make_request+0x174/0x1fc
 [<00000000001f88ee>] __map_bio+0x7e/0xec
 [<00000000001f8f44>] __split_bio+0x510/0x534
 [<00000000001f915c>] dm_request+0x1f4/0x24c
 [<000000000017e528>] generic_make_request+0x174/0x1fc
 [<000000000017e672>] submit_bio+0xc2/0x18c
 [<00000000000d7a00>] submit_bh+0x13c/0x1d8
 [<00000000000da95c>] block_read_full_page+0x3f0/0x470
 [<00000000000dd2e0>] blkdev_readpage+0x30/0x40
 [<0000000000084638>] __do_page_cache_readahead+0x190/0x300
 [<0000000000084976>] blockable_page_cache_readahead+0x7a/0x104
 [<0000000000084db4>] page_cache_readahead+0x29c/0x328
 [<000000000007c14c>] do_generic_mapping_read+0x428/0x51c
 [<000000000007e8fc>] generic_file_aio_read+0x160/0x244
 [<00000000000a9cac>] do_sync_read+0xd8/0x130
 [<00000000000a9dac>] vfs_read+0xa8/0x188
 [<00000000000aa19a>] sys_read+0x56/0x88
 [<0000000000020d40>] sysc_noemu+0x10/0x16
