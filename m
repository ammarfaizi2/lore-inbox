Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUCDSwm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUCDSvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:51:09 -0500
Received: from joel.ist.utl.pt ([193.136.198.171]:16578 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S262075AbUCDSuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:50:11 -0500
Date: Thu, 4 Mar 2004 18:49:54 +0000 (WET)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-rc1-mm2: 3 dumps at __make_request, system freeze
Message-ID: <Pine.LNX.4.58.0403041834350.28568@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yesterday I got these 3 dumps (on dmesg) while compiling (on ext3 fs) the
kernel and some other userland utilities.  I was also running tvtime so
the system load was pretty high; some minutes after this, the system
freezed.  I tried to terminate all task (SysRq+E) without success. SysRq+P
several times, SysRq+S, SysRq+U and SysRq+B.  On reboot the system logs
were full of garbage, so nome more info...

You could find config at http://joel.ist.utl.pt/~rmps/config-2.6.4-rc1-mm2
and if you need more info about the system, just ask.

Regards,
	Rui Saraiva

-------------------------------------------------------------------------
Unable to handle kernel paging request at virtual address c794cf70
 printing eip:
c02783a5
*pde = 0001e063
*pte = 0794c000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c02783a5>]    Not tainted VLI
EFLAGS: 00010093
EIP is at __make_request+0x3a5/0x6a0
eax: c794cf60   ebx: c794cf60   ecx: 00000020   edx: 00000100
esi: cf6b8bf8   edi: 00000000   ebp: cf727c44   esp: cf727c00
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 6, threadinfo=cf726000 task=cf74b9d0)
Stack: cffc72c0 00000018 cffc72c0 cfea2fb8 cf727c40 c0156534 00000008 04b2be1e
       00000000 00000002 00000002 00000001 c794cf60 cfea7cf8 cf6b8bf8 00000002
       cfea7cf8 cf727c98 c0278796 cf727c70 c01fccaa c020b818 00000000 02859a60
Call Trace:
 [<c0156534>] kmem_cache_alloc+0x174/0x200
 [<c0278796>] generic_make_request+0xf6/0x170
 [<c01fccaa>] get_transaction+0xaa/0x100
 [<c020b818>] __jbd_kmalloc+0x18/0x20
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c0278868>] submit_bio+0x58/0xf0
 [<c017b913>] bio_alloc+0xc3/0x190
 [<c0179a41>] __block_write_full_page+0x171/0x360
 [<c017fcd0>] blkdev_get_block+0x0/0x50
 [<c017afb8>] block_write_full_page+0xd8/0x100
 [<c01f6cf7>] __ext3_journal_stop+0x27/0x50
 [<c017fcd0>] blkdev_get_block+0x0/0x50
 [<c01a7d92>] mpage_writepages+0x3f2/0x5a0
 [<c01a7d92>] mpage_writepages+0x3f2/0x5a0
 [<c017fdf0>] blkdev_writepage+0x0/0x10
 [<c0151ca1>] do_writepages+0x21/0x30
 [<c01a54cd>] __sync_single_inode+0x20d/0x5a0
 [<c012bc7a>] __do_softirq+0x7a/0x80
 [<c01a5c1a>] sync_sb_inodes+0x1aa/0x3d0
 [<c032029c>] common_interrupt+0x18/0x20
 [<c01a5fc7>] writeback_inodes+0x187/0x490
 [<c0151695>] get_dirty_limits+0x15/0xd0
 [<c0151afb>] wb_kupdate+0xcb/0x150
 [<c015251e>] __pdflush+0x25e/0x650
 [<c011fbf1>] __wake_up_common+0x31/0x60
 [<c015291e>] pdflush+0xe/0x10
 [<c0151a30>] wb_kupdate+0x0/0x150
 [<c014132e>] kthread+0x8e/0xa0
 [<c0152910>] pdflush+0x0/0x10
 [<c01412a0>] kthread+0x0/0xa0
 [<c0105289>] kernel_thread_helper+0x5/0xc

Code: 00 39 86 a8 01 00 00 74 2b 8b 86 90 00 00 00 03 86 8c 00 00 00 3b 86 30 01 00 00 0f 84 b8 00 00 00 8b 45 ec 0f b7 96 f0 01 00 00 <39> 50 10 0f
84 a5 00 00 00 8b 96 b4 01 00 00 81 3a 3c 4b 24 1d
 <6>note: pdflush[6] exited with preempt_count 1
drivers/block/ll_rw_blk.c:1163: spin_lock(drivers/ide/ide.c:c03ae688) already locked by drivers/block/ll_rw_blk.c/2035
Unable to handle kernel paging request at virtual address c8debf70
 printing eip:
c02783a5
*pde = 00023063
*pte = 08deb000
Oops: 0000 [#2]
PREEMPT DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c02783a5>]    Not tainted VLI
EFLAGS: 00010093
EIP is at __make_request+0x3a5/0x6a0
eax: c8debf60   ebx: c8debf60   ecx: 00000020   edx: 00000100
esi: cf6b8bf8   edi: 00000000   ebp: cf715c24   esp: cf715be0
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=cf714000 task=cf7439d0)
Stack: cffc72c0 00000018 cffc72c0 cfea2fe8 cf715c20 c0156534 c8debf60 0287147d
       00000000 00000008 00000008 00000001 c8debf60 c5436698 cf6b8bf8 00000008
       c5436698 cf715c78 c0278796 00000000 0285dac8 00000000 cf7439d0 c0122d50
Call Trace:
 [<c0156534>] kmem_cache_alloc+0x174/0x200
 [<c0278796>] generic_make_request+0xf6/0x170
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c0278868>] submit_bio+0x58/0xf0
 [<c0278868>] submit_bio+0x58/0xf0
 [<c017b913>] bio_alloc+0xc3/0x190
 [<c0179a41>] __block_write_full_page+0x171/0x360
 [<c017fcd0>] blkdev_get_block+0x0/0x50
 [<c017afb8>] block_write_full_page+0xd8/0x100
 [<c017fcd0>] blkdev_get_block+0x0/0x50
 [<c015ae77>] shrink_list+0x467/0xaa0
 [<c0159808>] __pagevec_release+0x18/0x30
 [<c015b6b0>] shrink_cache+0x200/0x6e0
 [<c015caf4>] balance_pgdat+0x194/0x1f0
 [<c015cc2c>] kswapd+0xdc/0xf0
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c031f812>] ret_from_fork+0x6/0x14
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c015cb50>] kswapd+0x0/0xf0
 [<c0105289>] kernel_thread_helper+0x5/0xc

Code: 00 39 86 a8 01 00 00 74 2b 8b 86 90 00 00 00 03 86 8c 00 00 00 3b 86 30 01 00 00 0f 84 b8 00 00 00 8b 45 ec 0f b7 96 f0 01 00 00 <39> 50 10 0f
84 a5 00 00 00 8b 96 b4 01 00 00 81 3a 3c 4b 24 1d
 <6>note: kswapd0[8] exited with preempt_count 1
drivers/block/ll_rw_blk.c:1163: spin_lock(drivers/ide/ide.c:c03ae688) already locked by drivers/block/ll_rw_blk.c/2035
Unable to handle kernel paging request at virtual address c0d96f70
 printing eip:
c02783a5
*pde = 00003063
*pte = 00d96000
Oops: 0000 [#3]
PREEMPT DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c02783a5>]    Not tainted VLI
EFLAGS: 00210093
EIP is at __make_request+0x3a5/0x6a0
eax: c0d96f60   ebx: c0d96f60   ecx: 00000020   edx: 00000100
esi: cf6b8bf8   edi: 00000000   ebp: c7fe9a34   esp: c7fe99f0
ds: 007b   es: 007b   ss: 0068
Process ldconfig (pid: 13998, threadinfo=c7fe8000 task=ca1c89d0)
Stack: cffc72c0 00000018 cffc72c0 cfea2df0 c7fe9a30 c0156534 c0d96f60 00642f5d
       00000000 00000008 00000008 00000001 c0d96f60 cfea7cf8 cf6b8bf8 00000008
       cfea7cf8 c7fe9a88 c0278796 00000000 0062f5a8 00000000 ca1c89d0 c0122d50
Call Trace:
 [<c0156534>] kmem_cache_alloc+0x174/0x200
 [<c0278796>] generic_make_request+0xf6/0x170
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c0278868>] submit_bio+0x58/0xf0
 [<c0278868>] submit_bio+0x58/0xf0
 [<c017b913>] bio_alloc+0xc3/0x190
 [<c0179a41>] __block_write_full_page+0x171/0x360
 [<c017fcd0>] blkdev_get_block+0x0/0x50
 [<c017afb8>] block_write_full_page+0xd8/0x100
 [<c017fcd0>] blkdev_get_block+0x0/0x50
 [<c015ae77>] shrink_list+0x467/0xaa0
 [<c0152b5f>] pdflush_operation+0x23f/0x310
 [<c015b6b0>] shrink_cache+0x200/0x6e0
 [<c015c76a>] shrink_zone+0x8a/0x90
 [<c015c7df>] shrink_caches+0x6f/0x80
 [<c015c895>] try_to_free_pages+0xa5/0x170
 [<c0150596>] __alloc_pages+0x1c6/0x340
 [<c0130d4c>] update_wall_time+0xc/0x40
 [<c01535e1>] do_page_cache_readahead+0x271/0x3e0
 [<c014c78e>] filemap_nopage+0x10e/0x300
 [<c01613f4>] do_no_page+0xe4/0x590
 [<c011c417>] pte_alloc_one+0x37/0x40
 [<c0162b6f>] __vma_link+0x2f/0xa0
 [<c0161b22>] handle_mm_fault+0x112/0x2e0
 [<c011ce3e>] do_page_fault+0x31e/0x53a
 [<c0110370>] old_mmap+0x140/0x160
 [<c011cb20>] do_page_fault+0x0/0x53a
 [<c032033b>] error_code+0x2f/0x38

Code: 00 39 86 a8 01 00 00 74 2b 8b 86 90 00 00 00 03 86 8c 00 00 00 3b 86 30 01 00 00 0f 84 b8 00 00 00 8b 45 ec 0f b7 96 f0 01 00 00 <39> 50 10 0f
84 a5 00 00 00 8b 96 b4 01 00 00 81 3a 3c 4b 24 1d
 <6>note: ldconfig[13998] exited with preempt_count 1
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c012230c>] __might_sleep+0xac/0xd0
 [<c012980f>] do_exit+0xaf/0x980
 [<c010855b>] die+0x24b/0x250
 [<c02783a5>] __make_request+0x3a5/0x6a0
 [<c011cb20>] do_page_fault+0x0/0x53a
 [<c011ccf5>] do_page_fault+0x1d5/0x53a
 [<c011e026>] kernel_map_pages+0x16/0x70
 [<c014e759>] mempool_free+0xd9/0x210
 [<c014e759>] mempool_free+0xd9/0x210
 [<c014e759>] mempool_free+0xd9/0x210
 [<c027eaeb>] as_put_request+0x6b/0xc0
 [<c011cb20>] do_page_fault+0x0/0x53a
 [<c032033b>] error_code+0x2f/0x38
 [<c02783a5>] __make_request+0x3a5/0x6a0
 [<c0156534>] kmem_cache_alloc+0x174/0x200
 [<c0278796>] generic_make_request+0xf6/0x170
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c0278868>] submit_bio+0x58/0xf0
 [<c0278868>] submit_bio+0x58/0xf0
 [<c017b913>] bio_alloc+0xc3/0x190
 [<c0179a41>] __block_write_full_page+0x171/0x360
 [<c017fcd0>] blkdev_get_block+0x0/0x50
 [<c017afb8>] block_write_full_page+0xd8/0x100
 [<c017fcd0>] blkdev_get_block+0x0/0x50
 [<c015ae77>] shrink_list+0x467/0xaa0
 [<c0152b5f>] pdflush_operation+0x23f/0x310
 [<c015b6b0>] shrink_cache+0x200/0x6e0
 [<c015c76a>] shrink_zone+0x8a/0x90
 [<c015c7df>] shrink_caches+0x6f/0x80
 [<c015c895>] try_to_free_pages+0xa5/0x170
 [<c0150596>] __alloc_pages+0x1c6/0x340
 [<c0130d4c>] update_wall_time+0xc/0x40
 [<c01535e1>] do_page_cache_readahead+0x271/0x3e0
 [<c014c78e>] filemap_nopage+0x10e/0x300
 [<c01613f4>] do_no_page+0xe4/0x590
 [<c011c417>] pte_alloc_one+0x37/0x40
 [<c0162b6f>] __vma_link+0x2f/0xa0
 [<c0161b22>] handle_mm_fault+0x112/0x2e0
 [<c011ce3e>] do_page_fault+0x31e/0x53a
 [<c0110370>] old_mmap+0x140/0x160
 [<c011cb20>] do_page_fault+0x0/0x53a
 [<c032033b>] error_code+0x2f/0x38

bad: scheduling while atomic!
Call Trace:
 [<c011fb51>] schedule+0x8d1/0x8e0
 [<c015eddc>] zap_pmd_range+0x3c/0x60
 [<c015ee38>] unmap_page_range+0x38/0x60
 [<c015f051>] unmap_vmas+0x1f1/0x310
 [<c0126c9c>] printk+0x27c/0x3f0
 [<c0164a66>] exit_mmap+0xb6/0x270
 [<c032033b>] error_code+0x2f/0x38
 [<c01231ce>] mmput+0xbe/0x140
 [<c0129934>] do_exit+0x1d4/0x980
 [<c010855b>] die+0x24b/0x250
 [<c02783a5>] __make_request+0x3a5/0x6a0
 [<c011cb20>] do_page_fault+0x0/0x53a
 [<c011ccf5>] do_page_fault+0x1d5/0x53a
 [<c011e026>] kernel_map_pages+0x16/0x70
 [<c014e759>] mempool_free+0xd9/0x210
 [<c014e759>] mempool_free+0xd9/0x210
 [<c014e759>] mempool_free+0xd9/0x210
 [<c027eaeb>] as_put_request+0x6b/0xc0
 [<c011cb20>] do_page_fault+0x0/0x53a
 [<c032033b>] error_code+0x2f/0x38
 [<c02783a5>] __make_request+0x3a5/0x6a0
 [<c0156534>] kmem_cache_alloc+0x174/0x200
 [<c0278796>] generic_make_request+0xf6/0x170
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c0122d50>] autoremove_wake_function+0x0/0x40
 [<c0278868>] submit_bio+0x58/0xf0
 [<c0278868>] submit_bio+0x58/0xf0
 [<c017b913>] bio_alloc+0xc3/0x190
 [<c0179a41>] __block_write_full_page+0x171/0x360
 [<c017fcd0>] blkdev_get_block+0x0/0x50
 [<c017afb8>] block_write_full_page+0xd8/0x100
 [<c017fcd0>] blkdev_get_block+0x0/0x50
 [<c015ae77>] shrink_list+0x467/0xaa0
 [<c0152b5f>] pdflush_operation+0x23f/0x310
 [<c015b6b0>] shrink_cache+0x200/0x6e0
 [<c015c76a>] shrink_zone+0x8a/0x90
 [<c015c7df>] shrink_caches+0x6f/0x80
 [<c015c895>] try_to_free_pages+0xa5/0x170
 [<c0150596>] __alloc_pages+0x1c6/0x340
 [<c0130d4c>] update_wall_time+0xc/0x40
 [<c01535e1>] do_page_cache_readahead+0x271/0x3e0
 [<c014c78e>] filemap_nopage+0x10e/0x300
 [<c01613f4>] do_no_page+0xe4/0x590
 [<c011c417>] pte_alloc_one+0x37/0x40
 [<c0162b6f>] __vma_link+0x2f/0xa0
 [<c0161b22>] handle_mm_fault+0x112/0x2e0
 [<c011ce3e>] do_page_fault+0x31e/0x53a
 [<c0110370>] old_mmap+0x140/0x160
 [<c011cb20>] do_page_fault+0x0/0x53a
 [<c032033b>] error_code+0x2f/0x38

drivers/block/ll_rw_blk.c:1163: spin_lock(drivers/ide/ide.c:c03ae688) already locked by drivers/block/ll_rw_blk.c/2035
