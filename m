Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbUCCDJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbUCCDJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:09:52 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:33983 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262327AbUCCDJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:09:48 -0500
Message-ID: <40454C6F.5020901@matchmail.com>
Date: Tue, 02 Mar 2004 19:09:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: bad: scheduling while atomic in nfs with 2.6.3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.6.3-zonebal-lofft-slabfaz

That's with the nfsd loff_t patch and two VM patches from -mm.

More info available upon request.

Mike

loop: loaded (max 8 devices)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
Debug: sleeping function called from invalid context at 
include/linux/rwsem.h:66
in_atomic():1, irqs_disabled():0
Call Trace:
  [<c012258d>] __might_sleep+0x9d/0xe0
  [<c01651d8>] deactivate_super+0x58/0x100
  [<f89e9fba>] svc_export_put+0x7a/0x80 [nfsd]
  [<f898167c>] cache_clean+0x18c/0x2e0 [sunrpc]
  [<f89817d9>] do_cache_clean+0x9/0x50 [sunrpc]
  [<c0136128>] worker_thread+0x1b8/0x260
  [<f89817d0>] do_cache_clean+0x0/0x50 [sunrpc]
  [<c0120750>] default_wake_function+0x0/0x20
  [<c0109e16>] ret_from_fork+0x6/0x20
  [<c0120750>] default_wake_function+0x0/0x20
  [<c0135f70>] worker_thread+0x0/0x260
  [<c0107d95>] kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
Call Trace:
  [<c01206eb>] schedule+0x6fb/0x710
  [<c014a06c>] __pagevec_release+0x1c/0x30
  [<c014a7d4>] truncate_inode_pages+0xc4/0x2a0
  [<c010cb7b>] do_IRQ+0x16b/0x1a0
  [<c0179d00>] dispose_list+0xc0/0xd0
  [<c0179e82>] invalidate_inodes+0xb2/0xf0
  [<c016549b>] generic_shutdown_super+0x9b/0x200
  [<c0166454>] kill_block_super+0x14/0x30
  [<c01651f7>] deactivate_super+0x77/0x100
  [<f89e9fba>] svc_export_put+0x7a/0x80 [nfsd]
  [<f898167c>] cache_clean+0x18c/0x2e0 [sunrpc]
  [<f89817d9>] do_cache_clean+0x9/0x50 [sunrpc]
  [<c0136128>] worker_thread+0x1b8/0x260
  [<f89817d0>] do_cache_clean+0x0/0x50 [sunrpc]
  [<c0120750>] default_wake_function+0x0/0x20
  [<c0109e16>] ret_from_fork+0x6/0x20
  [<c0120750>] default_wake_function+0x0/0x20
  [<c0135f70>] worker_thread+0x0/0x260
  [<c0107d95>] kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
Call Trace:
  [<c01206eb>] schedule+0x6fb/0x710
  [<c0163fae>] free_buffer_head+0x3e/0x70
  [<c013fe48>] __remove_from_page_cache+0x18/0x80
  [<c014a06c>] __pagevec_release+0x1c/0x30
  [<c014aa3f>] invalidate_mapping_pages+0x8f/0xf0
  [<c0119a95>] smp_apic_timer_interrupt+0xe5/0x160
  [<c0161c9d>] invalidate_bh_lru+0x2d/0x60
  [<c014aab0>] invalidate_inode_pages+0x10/0x20
  [<c016690f>] kill_bdev+0xf/0x30
  [<c0167c9c>] blkdev_put+0x1fc/0x220
  [<c0166466>] kill_block_super+0x26/0x30
  [<c01651f7>] deactivate_super+0x77/0x100
  [<f89e9fba>] svc_export_put+0x7a/0x80 [nfsd]
  [<f898167c>] cache_clean+0x18c/0x2e0 [sunrpc]
  [<f89817d9>] do_cache_clean+0x9/0x50 [sunrpc]
  [<c0136128>] worker_thread+0x1b8/0x260
  [<f89817d0>] do_cache_clean+0x0/0x50 [sunrpc]
  [<c0120750>] default_wake_function+0x0/0x20
  [<c0109e16>] ret_from_fork+0x6/0x20
  [<c0120750>] default_wake_function+0x0/0x20
  [<c0135f70>] worker_thread+0x0/0x260
  [<c0107d95>] kernel_thread_helper+0x5/0x10

