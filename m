Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbSL3Xt6>; Mon, 30 Dec 2002 18:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267111AbSL3Xt6>; Mon, 30 Dec 2002 18:49:58 -0500
Received: from dsl-67-48-44-237.telocity.com ([67.48.44.237]:25412 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S267079AbSL3XsN>;
	Mon, 30 Dec 2002 18:48:13 -0500
Date: Mon, 30 Dec 2002 19:15:18 -0500
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.53-mm2: scheduling while atomic! + kernel BUG at mm/slab.c:1671!
Message-ID: <20021231001518.GA28259@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.5.53-mm2 I got the following in dmesg.  I have no idea how to
reproduce them since I wasn't here when they occured..

bad: scheduling while atomic!
Call Trace:
 [<c01143c1>] do_schedule+0x3d/0x2c8
 [<c011530b>] __cond_resched+0x17/0x1c
 [<c012f138>] shrink_list+0x38/0x4bc
 [<c011d88f>] run_timer_softirq+0x12b/0x134
 [<c0119b6c>] it_real_fn+0x0/0x48
 [<c011a4ea>] do_softirq+0x5a/0xac
 [<c010a880>] do_IRQ+0xfc/0x118
 [<c01092f4>] common_interrupt+0x18/0x20
 [<c012f767>] shrink_cache+0x1ab/0x2d8
 [<c012fddc>] shrink_zone+0x6c/0x74
 [<c012fe4e>] shrink_caches+0x6a/0x94
 [<c012fef7>] try_to_free_pages+0x7f/0xbc
 [<c012a58c>] __alloc_pages+0x1b4/0x260
 [<c012a660>] __get_free_pages+0x28/0x64
 [<c012ca76>] cache_grow+0xb6/0x20c
 [<c012cc5f>] __cache_alloc_refill+0x93/0x220
 [<c012ce26>] cache_alloc_refill+0x3a/0x58
 [<c012d1ad>] kmem_cache_alloc+0x45/0xc8
 [<c0136770>] pte_chain_alloc+0x38/0x68
 [<c01311ea>] copy_page_range+0x2be/0x3f0
 [<c0115fdb>] copy_mm+0x283/0x348
 [<c0116a9f>] copy_process+0x61b/0xb24
 [<c0117026>] do_fork+0x7e/0x134
 [<c0242214>] sys_socketcall+0x150/0x1f4
 [<c0107478>] sys_fork+0x18/0x2c
 [<c01089af>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c01143c1>] do_schedule+0x3d/0x2c8
 [<c011530b>] __cond_resched+0x17/0x1c
 [<c012f138>] shrink_list+0x38/0x4bc
 [<c010a880>] do_IRQ+0xfc/0x118
 [<c01092f4>] common_interrupt+0x18/0x20
 [<c012e566>] __pagevec_release+0x1a/0x28
 [<c012f767>] shrink_cache+0x1ab/0x2d8
 [<c012fddc>] shrink_zone+0x6c/0x74
 [<c012fe4e>] shrink_caches+0x6a/0x94
 [<c012fef7>] try_to_free_pages+0x7f/0xbc
 [<c012a58c>] __alloc_pages+0x1b4/0x260
 [<c012a660>] __get_free_pages+0x28/0x64
 [<c012ca76>] cache_grow+0xb6/0x20c
 [<c012cc5f>] __cache_alloc_refill+0x93/0x220
 [<c012ce26>] cache_alloc_refill+0x3a/0x58
 [<c012d1ad>] kmem_cache_alloc+0x45/0xc8
 [<c0136770>] pte_chain_alloc+0x38/0x68
 [<c01311ea>] copy_page_range+0x2be/0x3f0
 [<c0115fdb>] copy_mm+0x283/0x348
 [<c0116a9f>] copy_process+0x61b/0xb24
 [<c0117026>] do_fork+0x7e/0x134
 [<c0107478>] sys_fork+0x18/0x2c
 [<c01089af>] syscall_call+0x7/0xb

------------[ cut here ]------------
kernel BUG at mm/slab.c:1671!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c012d2eb>]    Not tainted
EFLAGS: 00010a02
EIP is at kmalloc+0xbb/0x114
eax: c3ff9518   ebx: cffff440   ecx: 00000000   edx: cfff3bc3
esi: cfff3b40   edi: cfff3b40   ebp: c360f1f4   esp: c6367e70
ds: 007b   es: 007b   ss: 0068
Process find (pid: 1563, threadinfo=c6366000 task=c3e326e0)
Stack: c1546364 cc3a28f4 cc3a295c c01517ec 00000070 000001d0 00000000 cc3a28f4 
       cc3a295c c360f1f4 00000066 c01492fc c360f1f4 c6367f14 00000000 c6367f54 
       cfff7324 c6367f14 c01495a0 c360f1f4 c6367f14 00000004 c6367f0c 00000000 
Call Trace:
 [<c01517ec>] d_alloc+0x48/0x194
 [<c01492fc>] real_lookup+0x38/0xc0
 [<c01495a0>] do_lookup+0x48/0x88
 [<c0149ae9>] link_path_walk+0x509/0x77c
 [<c012d1c7>] kmem_cache_alloc+0x5f/0xc8
 [<c014a007>] path_lookup+0x10b/0x110
 [<c014a128>] __user_walk+0x28/0x40
 [<c0145f92>] vfs_lstat+0x16/0x44
 [<c014649f>] sys_lstat64+0x13/0x30
 [<c0110001>] mtrr_write+0x119/0x2ec
 [<c01089af>] syscall_call+0x7/0xb

Code: 0f 0b 87 06 a0 df 28 c0 b8 a5 c2 0f 17 89 f2 03 53 30 87 42 
 <3>bad: scheduling while atomic!
Call Trace:
 [<c01143c1>] do_schedule+0x3d/0x2c8
 [<c011dac0>] schedule_timeout+0x80/0xa0
 [<c01de4d8>] blk_run_queues+0x88/0xb8
 [<c011da34>] process_timeout+0x0/0xc
 [<c0115355>] io_schedule_timeout+0x11/0x1c
 [<c01decfe>] blk_congestion_wait+0x8a/0xa0
 [<c0115aa4>] autoremove_wake_function+0x0/0x38
 [<c0115aa4>] autoremove_wake_function+0x0/0x38
 [<c012feb7>] try_to_free_pages+0x3f/0xbc
 [<c012a58c>] __alloc_pages+0x1b4/0x260
 [<c012a660>] __get_free_pages+0x28/0x64
 [<c012ca76>] cache_grow+0xb6/0x20c
 [<c012cc5f>] __cache_alloc_refill+0x93/0x220
 [<c012ce26>] cache_alloc_refill+0x3a/0x58
 [<c012d1ad>] kmem_cache_alloc+0x45/0xc8
 [<c0136770>] pte_chain_alloc+0x38/0x68
 [<c01311ea>] copy_page_range+0x2be/0x3f0
 [<c0115fdb>] copy_mm+0x283/0x348
 [<c0116a9f>] copy_process+0x61b/0xb24
 [<c0117026>] do_fork+0x7e/0x134
 [<c0107478>] sys_fork+0x18/0x2c
 [<c01089af>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c01143c1>] do_schedule+0x3d/0x2c8
 [<c0152dcf>] shrink_icache_memory+0x17/0x20
 [<c011530b>] __cond_resched+0x17/0x1c
 [<c012f07d>] shrink_slab+0x115/0x15c
 [<c012fec9>] try_to_free_pages+0x51/0xbc
 [<c012a58c>] __alloc_pages+0x1b4/0x260
 [<c012a660>] __get_free_pages+0x28/0x64
 [<c012ca76>] cache_grow+0xb6/0x20c
 [<c012cc5f>] __cache_alloc_refill+0x93/0x220
 [<c012ce26>] cache_alloc_refill+0x3a/0x58
 [<c012d1ad>] kmem_cache_alloc+0x45/0xc8
 [<c0136770>] pte_chain_alloc+0x38/0x68
 [<c01311ea>] copy_page_range+0x2be/0x3f0
 [<c0115fdb>] copy_mm+0x283/0x348
 [<c0116a9f>] copy_process+0x61b/0xb24
 [<c0117026>] do_fork+0x7e/0x134
 [<c0107478>] sys_fork+0x18/0x2c
 [<c01089af>] syscall_call+0x7/0xb

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
