Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275647AbTHOBv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 21:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275648AbTHOBv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 21:51:29 -0400
Received: from f05s15.cac.psu.edu ([128.118.141.58]:51163 "EHLO
	f05n15.cac.psu.edu") by vger.kernel.org with ESMTP id S275647AbTHOBv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 21:51:27 -0400
Date: Thu, 14 Aug 2003 21:51:25 -0400
From: Matt Rickard <mjr318@psu.edu>
To: linux-kernel@vger.kernel.org
Subject: JFS kernel bug in 2.6.0-test3
Message-Id: <20030814215125.13affe12.mjr318@psu.edu>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.6.0-r3 with all filesystems using JFS.  After a recent
power outage and attempted fsck, I got the following on reboot:

kernel BUG at fs/jfs/jfs_dmap.c:385!
invalid operand: 0000 [#1]
CPU:	0
EIP:	0060:[<c02484eb>]	Not tainted
EFLAGS:	00010282
EIP is at dbFree+0xab/0x280
eax: 0000004b	ebx: 0000002f	ecx: c04471b4	edx: 00000286
esi: 00642e74	edi: 00000000	ebp: cfdffd2c	esp: cfdffcdc
ds: 007b   es: 007b   ss: 0068
Process jfsCommit (pid: 17, threadinfo=cfdfe000 task=c137ece0)
Stack: c03f967d c03f9860 00000181 c040ae20 00000001 00000000 00000000 000590bd
       00000000 cf5c78cc cf984000 cf5c7a84 00000001 cf35d000 cfda6770 6f726376
       0000002f 00000000 cf3d7aa4 0000002f cfdffd6c c025ae42 cf3d7aa4 6f726376
Call Trace:
 [<c025ae42>] txFreeMap+0xb2/0x340
 [<c011cb4f>] schedule+0x21f/0x530
 [<c017e5f6>] __mark_inode_dirty+0x126/0x130
 [<c0243436>] xtTruncate+0xcb6/0x1020
 [<c013faee>] mempool_free+0x5e/0xc0
 [<c013f990>] mempool_alloc+0x80/0x180
 [<c013cb4a>] find_get_page+0x3a/0x80
 [<c015fa8b>] nobh_commit_write+0x8b/0x90
 [<c0239850>] jfs_delete_inode+0x0/0x40
 [<c023b08b>] freeZeroLink+0xab/0x1d0
 [<c02554d3>] release_metapage+0x243/0x320
 [<c0239850>] jfs_delete_inode+0x0/0x40
 [<c0239888>] jfs_delete_inode+0x38/0x40
 [<c0177788>] generic_delete_inode+0x78/0x140
 [<c0177a63>] iput+0x63/0x90
 [<c025ab12>] txUpdateMap+0x1c2/0x290
 [<c025b3c6>] txLazyCommit+0x26/0x110
 [<c025b58b>] jfs_lazycommit+0xdb/0x230
 [<c011ceb0>] default_wake_function+0x0/0x30
 [<c0109696>] ret_from_fork+0x6/0x14
 [<c011ceb0>] default_wake_function+0x0/0x30
 [<c025b4b0>] jfs_lazycommit+0x0/0x230
 [<c0107479>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 81 01 60 98 3f c0 c7 45 e8 00 00 00 00 85 ff 0f 8e a2
 
