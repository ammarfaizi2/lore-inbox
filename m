Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWJPOFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWJPOFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWJPOFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:05:37 -0400
Received: from 84-72-7-39.dclient.hispeed.ch ([84.72.7.39]:19685 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S1750813AbWJPOFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:05:36 -0400
Message-ID: <453391A4.5090100@steudten.org>
Date: Mon, 16 Oct 2006 16:05:24 +0200
From: "alpha @ steudten Engineering" <alpha@steudten.com>
Organization: Steudten Engineering
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: INFO: possible circular locking dependency detected
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Check: b1520e823e8afe50f81b46855458ab4b on steudten.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.18-1.2189self #1
-------------------------------------------------------
kswapd0/186 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c0326e32>] mutex_lock+0x21/0x24

but task is already holding lock:
 (iprune_mutex){--..}, at: [<c0326e32>] mutex_lock+0x21/0x24

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (iprune_mutex){--..}:
       [<c012fe17>] lock_acquire+0x4b/0x6c
       [<c0326cc4>] __mutex_lock_slowpath+0xb3/0x200
       [<c0326e32>] mutex_lock+0x21/0x24
       [<c017638a>] shrink_icache_memory+0x36/0x1b2
       [<c014cf50>] shrink_slab+0xd0/0x123
       [<c014d70e>] try_to_free_pages+0x114/0x1ba
       [<c0149b78>] __alloc_pages+0x18b/0x279
       [<c0146b10>] generic_file_buffered_write+0x167/0x546
       [<c014722f>] __generic_file_aio_write_nolock+0x340/0x38a
       [<c01472d5>] generic_file_aio_write+0x5c/0xaf
       [<f9c9e1cf>] nfs_file_write+0x7b/0x97 [nfs]
       [<c015f976>] do_sync_write+0xaf/0xe4
       [<c0160229>] vfs_write+0xab/0x157
       [<c0160760>] sys_write+0x3b/0x60
       [<c0102df3>] syscall_call+0x7/0xb

-> #0 (&inode->i_mutex){--..}:
       [<c012fe17>] lock_acquire+0x4b/0x6c
       [<c0326cc4>] __mutex_lock_slowpath+0xb3/0x200
       [<c0326e32>] mutex_lock+0x21/0x24
       [<f921706d>] ntfs_put_inode+0x3d/0x75 [ntfs]
       [<c0175acd>] iput+0x33/0x6a
       [<f9216eaa>] ntfs_clear_big_inode+0x99/0xb2 [ntfs]
       [<c0175fdc>] clear_inode+0xd8/0x129
       [<c01762cf>] dispose_list+0x4c/0xd1
       [<c01764de>] shrink_icache_memory+0x18a/0x1b2
       [<c014cf50>] shrink_slab+0xd0/0x123
       [<c014d2a3>] kswapd+0x260/0x336
       [<c012a4b7>] kthread+0xb0/0xdd
       [<c0101005>] kernel_thread_helper+0x5/0xb

other info that might help us debug this:
2 locks held by kswapd0/186:
 #0:  (shrinker_rwsem){----}, at: [<c014cea5>] shrink_slab+0x25/0x123
 #1:  (iprune_mutex){--..}, at: [<c0326e32>] mutex_lock+0x21/0x24

stack backtrace:
 [<c0103fe1>] show_trace+0xd/0x10
 [<c010447d>] dump_stack+0x19/0x1b
 [<c012ef1e>] print_circular_bug_tail+0x59/0x64
 [<c012f70b>] __lock_acquire+0x7e2/0x986
 [<c012fe17>] lock_acquire+0x4b/0x6c
 [<c0326cc4>] __mutex_lock_slowpath+0xb3/0x200
 [<c0326e32>] mutex_lock+0x21/0x24
 [<f921706d>] ntfs_put_inode+0x3d/0x75 [ntfs]
 [<c0175acd>] iput+0x33/0x6a
 [<f9216eaa>] ntfs_clear_big_inode+0x99/0xb2 [ntfs]
 [<c0175fdc>] clear_inode+0xd8/0x129
 [<c01762cf>] dispose_list+0x4c/0xd1
 [<c01764de>] shrink_icache_memory+0x18a/0x1b2
 [<c014cf50>] shrink_slab+0xd0/0x123
 [<c014d2a3>] kswapd+0x260/0x336
 [<c012a4b7>] kthread+0xb0/0xdd
 [<c0101005>] kernel_thread_helper+0x5/0xb

