Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTDFHYZ (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 03:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbTDFHYZ (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 03:24:25 -0400
Received: from relief.getitback.org ([208.49.116.17]:56711 "EHLO
	diesel.grid4.com") by vger.kernel.org with ESMTP id S262868AbTDFHYX (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 03:24:23 -0400
Date: Sun, 6 Apr 2003 03:35:53 -0400
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: XFS, Slab corruption, oops
Message-ID: <20030406073553.GV13861@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi;

	During an intensive compile (xfree86) in xfs mount on lvm
lv. Ive got all the kernel debuging on, so these symbols should
be right.  (from dmesg) Let me know if I can suply more; this
wasnt easy to trigger, Ive built huge parts of this system several
times already over days without this problem. (glibc, gcc,
binutils, etc) System has passed memtest86 and endless kernel
compiles recently...

Paul
set@pobox.com

Slab corruption: start=c1755b28, expend=c1755d4f, problemat=c1755b40
Data: ************************28 5B 75 C1 EC 2B 38 C5 60 DF 42 C0 00 00 00 00 *******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************A5 
Next: 84 6C 32 C3 B0 84 D2 C4 D8 56 75 C1 80 50 29 C5 34 7D 76 C2 00 8C FE C6 50 5D 75 C1 64 C0 3B C7 
slab error in check_poison_obj(): cache `xfs_inode': object was modified after freeing
Call Trace:
 [<c013a342>] __slab_error+0x1e/0x20
 [<c013a5cc>] check_poison_obj+0x178/0x180
 [<c013bdca>] kmem_cache_alloc+0x8e/0x124
 [<c0247bcf>] kmem_zone_zalloc+0x53/0x130
 [<c0247bcf>] kmem_zone_zalloc+0x53/0x130
 [<c021c630>] xfs_iread+0x1c/0x188
 [<c0245c74>] linvfs_alloc_inode+0x28/0x38
 [<c021a34e>] xfs_iget_core+0x17e/0x598
 [<c021a7ca>] xfs_iget+0x62/0x118
 [<c02342a3>] xfs_dir_lookup_int+0x5f/0xc8
 [<c0237f8a>] xfs_lookup+0x3e/0x64
 [<c024314a>] linvfs_lookup+0x42/0x78
 [<c016323c>] real_lookup+0x194/0x20c
 [<c016399e>] do_lookup+0x4a/0x8c
 [<c0164337>] link_path_walk+0x957/0xbe8
 [<c0164896>] path_lookup+0x13e/0x148
 [<c01649c3>] __user_walk+0x2f/0x48
 [<c015eb32>] vfs_stat+0x1a/0x40
 [<c015f047>] sys_stat64+0x13/0x28
 [<c010b667>] syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address 6b6b6bbb
 printing eip:
c024721d
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c024721d>]    Not tainted
EFLAGS: 00010282
EIP is at vn_rele+0x111/0x22c
eax: 6b6b6b6b   ebx: c11ce000   ecx: c5382c28   edx: c1755b40
esi: c5382c08   edi: c5382bec   ebp: c11cfe14   esp: c11cfe00
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 6, threadinfo=c11ce000 task=c11cd980)
Stack: c1755b40 00000000 c5382bec c11cfe7c c0427974 c11cfe24 c024600a c5382bec 
       c5382c20 c11cfe34 c01714f9 c5382c20 c5382c20 c11cfe50 c0171572 c5382c20 
       c66092b4 c0427974 c11ce000 00000015 c11cfe84 c0171d99 c11cfe7c 00000019 
Call Trace:
 [<c024600a>] linvfs_clear_inode+0x12/0x20
 [<c01714f9>] clear_inode+0x65/0x8c
 [<c0171572>] dispose_list+0x52/0x188
 [<c0171d99>] prune_icache+0x3b1/0x3f0
 [<c0171dee>] shrink_icache_memory+0x16/0x20
 [<c013e8f8>] shrink_slab+0xec/0x130
 [<c013fe3e>] balance_pgdat+0xce/0x130
 [<c013ff89>] kswapd+0xe9/0xf0
 [<c013fea0>] kswapd+0x0/0xf0
 [<c0119320>] autoremove_wake_function+0x0/0x3c
 [<c0119320>] autoremove_wake_function+0x0/0x3c
 [<c0108e15>] kernel_thread_helper+0x5/0xc

Code: 8b 40 50 ff d0 83 c4 08 ff 43 14 81 7e 00 3c 4b 24 1d 74 15 
 
	
