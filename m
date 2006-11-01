Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946744AbWKAJ6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946744AbWKAJ6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946747AbWKAJ6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:58:14 -0500
Received: from 80-218-222-94.dclient.hispeed.ch ([80.218.222.94]:21465 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S1946744AbWKAJ6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:58:14 -0500
Message-ID: <45486FAA.3070209@steudten.org>
Date: Wed, 01 Nov 2006 10:58:02 +0100
From: "alpha @ steudten Engineering" <alpha@steudten.com>
Organization: Steudten Engineering
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: INFO: possible circular locking dependency detected  2.6.18-1.2798
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Check: bc5ad08d3824f7c7972eaa539235374c on steudten.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FC5 kernel 2.6.18-1.2798

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.18-1.2798self #1
-------------------------------------------------------
kswapd0/201 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c03306d1>] mutex_lock+0x1c/0x1f

but task is already holding lock:
 (iprune_mutex){--..}, at: [<c03306d1>] mutex_lock+0x1c/0x1f

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (iprune_mutex){--..}:
       [<c012f533>] __lock_acquire+0x82c/0x904
       [<c012fb73>] lock_acquire+0x4b/0x6c
       [<c0330542>] __mutex_lock_slowpath+0xb3/0x226
       [<c03306d1>] mutex_lock+0x1c/0x1f
       [<c01794ce>] invalidate_inodes+0x20/0xcd
       [<c016826b>] generic_shutdown_super+0x45/0xf7
       [<c016833d>] kill_block_super+0x20/0x32
       [<c01683fd>] deactivate_super+0x5d/0x6f
       [<c017b60e>] mntput_no_expire+0x42/0x71
       [<c016de9e>] path_release_on_umount+0x15/0x18
       [<c017c74f>] sys_umount+0x1e7/0x21b
       [<c017c790>] sys_oldumount+0xd/0xf
       [<c0102fff>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #2 (&type->s_lock_key#9){--..}:
       [<c012f533>] __lock_acquire+0x82c/0x904
       [<c012fb73>] lock_acquire+0x4b/0x6c
       [<c0330542>] __mutex_lock_slowpath+0xb3/0x226
       [<c03306d1>] mutex_lock+0x1c/0x1f
       [<c01a505a>] ext3_orphan_add+0x32/0x1d0
       [<c01a2aa8>] ext3_setattr+0x152/0x1e1
       [<c017a0b7>] notify_change+0x137/0x2cc
       [<c0161058>] do_truncate+0x53/0x6c
       [<c016f646>] may_open+0x1b6/0x204
       [<c0171770>] open_namei+0x286/0x638
       [<c0160de5>] do_filp_open+0x1f/0x35
       [<c0160e3b>] do_sys_open+0x40/0xb5
       [<c0160edc>] sys_open+0x16/0x18
       [<c0102fff>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #1 (&inode->i_alloc_sem){--..}:
       [<c012f533>] __lock_acquire+0x82c/0x904
       [<c012fb73>] lock_acquire+0x4b/0x6c
       [<c012c9c1>] down_write+0x28/0x42
       [<c017a06f>] notify_change+0xef/0x2cc
       [<c0161058>] do_truncate+0x53/0x6c
       [<c016f646>] may_open+0x1b6/0x204
       [<c0171770>] open_namei+0x286/0x638
       [<c0160de5>] do_filp_open+0x1f/0x35
       [<c0160e3b>] do_sys_open+0x40/0xb5
       [<c0160edc>] sys_open+0x16/0x18
       [<c0102fff>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #0 (&inode->i_mutex){--..}:
       [<c012f467>] __lock_acquire+0x760/0x904
       [<c012fb73>] lock_acquire+0x4b/0x6c
       [<c0330542>] __mutex_lock_slowpath+0xb3/0x226
       [<c03306d1>] mutex_lock+0x1c/0x1f
       [<f922c244>] ntfs_put_inode+0x3d/0x75 [ntfs]
       [<c0178a89>] iput+0x33/0x6a
       [<f922c081>] ntfs_clear_big_inode+0x99/0xb2 [ntfs]
       [<c0178f84>] clear_inode+0xce/0x11f
       [<c0179277>] dispose_list+0x4c/0xd1
       [<c0179486>] shrink_icache_memory+0x18a/0x1b2
       [<c014dd8c>] shrink_slab+0xd0/0x14a
       [<c014e148>] kswapd+0x2a2/0x379
       [<c012a04b>] kthread+0xb0/0xdd
       [<c0103d77>] kernel_thread_helper+0x7/0x10
       [<ffffffff>] 0xffffffff

other info that might help us debug this:

2 locks held by kswapd0/201:
 #0:  (shrinker_rwsem){----}, at: [<c014dce1>] shrink_slab+0x25/0x14a
 #1:  (iprune_mutex){--..}, at: [<c03306d1>] mutex_lock+0x1c/0x1f

stack backtrace:
 [<c0103e7b>] show_trace_log_lvl+0x12/0x25
 [<c0103f5e>] show_trace+0xd/0x10
 [<c01047aa>] dump_stack+0x19/0x1b
 [<c012ecfc>] print_circular_bug_tail+0x59/0x64
 [<c012f467>] __lock_acquire+0x760/0x904
 [<c012fb73>] lock_acquire+0x4b/0x6c
 [<c0330542>] __mutex_lock_slowpath+0xb3/0x226
 [<c03306d1>] mutex_lock+0x1c/0x1f
 [<f922c244>] ntfs_put_inode+0x3d/0x75 [ntfs]
 [<c0178a89>] iput+0x33/0x6a
 [<f922c081>] ntfs_clear_big_inode+0x99/0xb2 [ntfs]
 [<c0178f84>] clear_inode+0xce/0x11f
 [<c0179277>] dispose_list+0x4c/0xd1
 [<c0179486>] shrink_icache_memory+0x18a/0x1b2
 [<c014dd8c>] shrink_slab+0xd0/0x14a
 [<c014e148>] kswapd+0x2a2/0x379
 [<c012a04b>] kthread+0xb0/0xdd
 [<c0103d77>] kernel_thread_helper+0x7/0x10
 =======================

