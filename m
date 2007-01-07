Return-Path: <linux-kernel-owner+w=401wt.eu-S932536AbXAGNXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbXAGNXs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 08:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbXAGNXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 08:23:47 -0500
Received: from ns1.heckrath.net ([213.239.192.68]:33286 "EHLO
	mail.heckrath.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536AbXAGNXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 08:23:46 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 08:23:45 EST
Date: Sun, 7 Jan 2007 15:17:26 +0100
From: Sebastian =?ISO-8859-15?Q?K=E4rgel?= <mailing@wodkahexe.de>
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.6.29.1
 (slab_get_obj,free_block,journal_write_metadata_buffer)
Message-Id: <20070107151726.0c462938.mailing@wodkahexe.de>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while running "shred /dev/hda3" this night I got the following oops. The
keyboard is no longer working, but the machine is up and running.
If you need any other information, please let me know, as I will reboot
this machine in ~24hours.

BUG: unable to handle kernel paging request at virtual address 1b1ca570
 printing eip:
c014c3b1
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c014c3b1>]    Not tainted VLI
EFLAGS: 00010807   (2.6.19.1 #1)
EIP is at slab_get_obj+0x14/0x1f
eax: 55555544   ebx: 00000017   ecx: 55555555   edx: c5c75000
esi: c5c75000   edi: c18ddc60   ebp: c18d7e00   esp: e54bfc58
ds: 007b   es: 007b   ss: 0068
Process shred (pid: 3393, ti=e54be000 task=f77fda70 task.ti=e54be000)
Stack: c014c62b c18dfba0 c5c75000 00000000 00000024 00000246 00000050 c18dfba0 
       00000001 c014c8c3 c18dfba0 00000050 f77cb8f4 00000400 00000400 c016dd60 
       c18dfba0 00000050 f77cb8f4 c016b66c 00000050 c1309d60 00000800 c1309d60 
Call Trace:
 [<c014c62b>] cache_alloc_refill+0xc8/0x17d
 [<c014c8c3>] kmem_cache_alloc+0x55/0x61
 [<c016dd60>] alloc_buffer_head+0x18/0x2f
 [<c016b66c>] alloc_page_buffers+0x26/0xa9
 [<c016be86>] create_empty_buffers+0x25/0x7c
 [<c016c2ca>] __block_prepare_write+0x95/0x445
 [<c01386c8>] __alloc_pages+0x72/0x2f0
 [<c016ce5a>] block_prepare_write+0x31/0x3e
 [<c016f289>] blkdev_get_block+0x0/0x3e
 [<c01362d8>] generic_file_buffered_write+0x231/0x61e
 [<c016f289>] blkdev_get_block+0x0/0x3e
 [<c01036f3>] apic_timer_interrupt+0x1f/0x24
 [<c011b2d8>] current_fs_time+0x47/0x52
 [<c016070f>] file_update_time+0x37/0x9f
 [<c0136bbd>] __generic_file_aio_write_nolock+0x4f8/0x526
 [<c02f47d9>] ide_dma_exec_cmd+0x30/0x34
 [<c02f480f>] ide_dma_start+0x32/0x40
 [<c02f6354>] __ide_do_rw_disk+0x3ba/0x49e
 [<c0232407>] as_move_to_dispatch+0xff/0x124
 [<c0136c43>] generic_file_aio_write_nolock+0x58/0xb1
 [<c014efe9>] do_sync_write+0xdd/0x11a
 [<c0127fb2>] autoremove_wake_function+0x0/0x4b
 [<c0133a64>] handle_edge_irq+0xcd/0xee
 [<c010513c>] do_IRQ+0x70/0x83
 [<c0133a64>] handle_edge_irq+0xcd/0xee
 [<c014f0c6>] vfs_write+0xa0/0x16b
 [<c014f24d>] sys_write+0x4b/0x71
 [<c0102d47>] syscall_call+0x7/0xb
 =======================
Code: 15 0f 0b 3e 0a d1 5e 44 c0 c3 a8 01 74 08 0f 0b 40 0a d1 5e 44 c0 c3 8b 54 24 08 8b 44 24 04 8b 4a 14 8b 40 10 ff 42 10 0f af c1 <8b> 4c 8a 1c 03 42 0c 89 4a 14 c3 8b 54 24 08 8b 4c 24 04 8b 44 
EIP: [<c014c3b1>] slab_get_obj+0x14/0x1f SS:ESP 0068:e54bfc58
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():0, irqs_disabled():1
 [<c01151aa>] __might_sleep+0xa8/0xaa
 [<c012a8f3>] down_read+0x1b/0x2f
 [<c0119180>] exit_mm+0x2e/0xba
 [<c01198c9>] do_exit+0x18e/0x351
 [<c0117da1>] printk+0x16/0x19
 [<c0103f97>] die+0x1b5/0x1bd
 [<c0112de2>] do_page_fault+0x4b4/0x5a5
 [<c041e063>] __sched_text_start+0x4b3/0x519
 [<c011292e>] do_page_fault+0x0/0x5a5
 [<c041f531>] error_code+0x39/0x40
 [<c014c3b1>] slab_get_obj+0x14/0x1f
 [<c014c62b>] cache_alloc_refill+0xc8/0x17d
 [<c014c8c3>] kmem_cache_alloc+0x55/0x61
 [<c016dd60>] alloc_buffer_head+0x18/0x2f
 [<c016b66c>] alloc_page_buffers+0x26/0xa9
 [<c016be86>] create_empty_buffers+0x25/0x7c
 [<c016c2ca>] __block_prepare_write+0x95/0x445
 [<c01386c8>] __alloc_pages+0x72/0x2f0
 [<c016ce5a>] block_prepare_write+0x31/0x3e
 [<c016f289>] blkdev_get_block+0x0/0x3e
 [<c01362d8>] generic_file_buffered_write+0x231/0x61e
 [<c016f289>] blkdev_get_block+0x0/0x3e
 [<c01036f3>] apic_timer_interrupt+0x1f/0x24
 [<c011b2d8>] current_fs_time+0x47/0x52
 [<c016070f>] file_update_time+0x37/0x9f
 [<c0136bbd>] __generic_file_aio_write_nolock+0x4f8/0x526
 [<c02f47d9>] ide_dma_exec_cmd+0x30/0x34
 [<c02f480f>] ide_dma_start+0x32/0x40
 [<c02f6354>] __ide_do_rw_disk+0x3ba/0x49e
 [<c0232407>] as_move_to_dispatch+0xff/0x124
 [<c0136c43>] generic_file_aio_write_nolock+0x58/0xb1
 [<c014efe9>] do_sync_write+0xdd/0x11a
 [<c0127fb2>] autoremove_wake_function+0x0/0x4b
 [<c0133a64>] handle_edge_irq+0xcd/0xee
 [<c010513c>] do_IRQ+0x70/0x83
 [<c0133a64>] handle_edge_irq+0xcd/0xee
 [<c014f0c6>] vfs_write+0xa0/0x16b
 [<c014f24d>] sys_write+0x4b/0x71
 [<c0102d47>] syscall_call+0x7/0xb
 =======================
BUG: unable to handle kernel paging request at virtual address 55555555
 printing eip:
c014c71a
*pde = 00000000
Oops: 0000 [#2]
Modules linked in:
CPU:    0
EIP:    0060:[<c014c71a>]    Not tainted VLI
EFLAGS: 00010002   (2.6.19.1 #1)
EIP is at free_block+0x3a/0xd6
eax: 55555555   ebx: c5c75000   ecx: 91c752a8   edx: 55555555
esi: c18ddc60   edi: 00000016   ebp: c18dfba0   esp: c195fd50
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 173, ti=c195e000 task=c1994030 task.ti=c195e000)
Stack: c18dfba0 c5c75000 c5c757bc 00000000 0000003c 00000246 dd618518 c18debc0 
       c014c840 c18dfba0 c18d7e10 0000003c 00000000 c18d7e00 00000246 dd618518 
       c195fe64 c014ca9b c18dfba0 c18d7e00 dd618c00 00000001 c18cda20 c016dd9e 
Call Trace:
 [<c014c840>] cache_flusharray+0x8a/0xb8
 [<c014ca9b>] kmem_cache_free+0x5c/0x6d
 [<c016dd9e>] free_buffer_head+0x27/0x34
 [<c016dc61>] try_to_free_buffers+0x70/0x82
 [<c013bdfd>] shrink_page_list+0x271/0x346
 [<c013bffc>] shrink_inactive_list+0x8d/0x1c3
 [<c013b8e3>] shrink_slab+0x18c/0x19a
 [<c013c518>] shrink_zone+0xc5/0xe6
 [<c013c95b>] balance_pgdat+0x1db/0x302
 [<c013cb72>] kswapd+0xf0/0xf2
 [<c0127fb2>] autoremove_wake_function+0x0/0x4b
 [<c0127fb2>] autoremove_wake_function+0x0/0x4b
 [<c013ca82>] kswapd+0x0/0xf2
 [<c0127ca2>] kthread+0x8d/0xb2
 [<c0127c15>] kthread+0x0/0xb2
 [<c010381f>] kernel_thread_helper+0x7/0x10
 =======================
Code: 24 2c 0f 8d b7 00 00 00 8b 44 24 28 8b 0c b8 8d 91 00 00 00 40 c1 ea 0c c1 e2 05 03 15 40 8b 58 c0 8b 02 f6 c4 40 74 03 8b 52 0c <8b> 02 a8 80 75 08 0f 0b 5f 02 d1 5e 44 c0 8b 5a 1c 8b 44 24 30 
EIP: [<c014c71a>] free_block+0x3a/0xd6 SS:ESP 0068:c195fd50
 <1>BUG: unable to handle kernel paging request at virtual address 55555555
 printing eip:
c014c71a
*pde = 00000000
Oops: 0000 [#3]
Modules linked in:
CPU:    0
EIP:    0060:[<c014c71a>]    Not tainted VLI
EFLAGS: 00010002   (2.6.19.1 #1)
EIP is at free_block+0x3a/0xd6
eax: 55555555   ebx: c5c75000   ecx: 91c752a8   edx: 55555555
esi: c18ddc60   edi: 00000016   ebp: c18dfba0   esp: c1907ecc
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 4, ti=c1906000 task=c18f8a90 task.ti=c1906000)
Stack: c18dfba0 c5c75000 c5c757bc 00000000 c18d7e10 00000018 c18d7e00 00000000 
       c014ce4a c18dfba0 c18d7e10 00000018 00000000 c18ddc60 c18dfba0 c18d4420 
       c014cec7 c18dfba0 c18ddc60 c18d7e00 00000000 00000000 00000000 00000282 
Call Trace:
 [<c014ce4a>] drain_array+0x82/0xa7
 [<c014cec7>] cache_reap+0x58/0xf2
 [<c0124fc3>] run_workqueue+0x79/0xa8
 [<c014ce6f>] cache_reap+0x0/0xf2
 [<c012512a>] worker_thread+0x138/0x168
 [<c0114386>] default_wake_function+0x0/0x12
 [<c0114386>] default_wake_function+0x0/0x12
 [<c0124ff2>] worker_thread+0x0/0x168
 [<c0127ca2>] kthread+0x8d/0xb2
 [<c0127c15>] kthread+0x0/0xb2
 [<c010381f>] kernel_thread_helper+0x7/0x10
 =======================
Code: 24 2c 0f 8d b7 00 00 00 8b 44 24 28 8b 0c b8 8d 91 00 00 00 40 c1 ea 0c c1 e2 05 03 15 40 8b 58 c0 8b 02 f6 c4 40 74 03 8b 52 0c <8b> 02 a8 80 75 08 0f 0b 5f 02 d1 5e 44 c0 8b 5a 1c 8b 44 24 30 
EIP: [<c014c71a>] free_block+0x3a/0xd6 SS:ESP 0068:c1907ecc
 <1>BUG: unable to handle kernel paging request at virtual address 55555555
 printing eip:
c014c71a
*pde = 00000000
Oops: 0000 [#4]
Modules linked in:
CPU:    0
EIP:    0060:[<c014c71a>]    Not tainted VLI
EFLAGS: 00010002   (2.6.19.1 #1)
EIP is at free_block+0x3a/0xd6
eax: 55555555   ebx: c5c75000   ecx: 91c752a8   edx: 55555555
esi: c18ddc60   edi: 00000016   ebp: c18dfba0   esp: e54bf9a0
ds: 007b   es: 007b   ss: 0068
Process shred (pid: 3393, ti=e54be000 task=f77fda70 task.ti=e54be000)
Stack: c18dfba0 c5c75000 c5c757bc 00000000 0000003c 00000246 c0ce5b64 c18debc0 
       c014c840 c18dfba0 c18d7e10 0000003c 00000000 c18d7e00 00000246 c0ce5b64 
       00000001 c014ca9b c18dfba0 c18d7e00 c0ce5684 00000001 00000001 c016dd9e 
Call Trace:
 [<c014c840>] cache_flusharray+0x8a/0xb8
 [<c014ca9b>] kmem_cache_free+0x5c/0x6d
 [<c016dd9e>] free_buffer_head+0x27/0x34
 [<c016dc61>] try_to_free_buffers+0x70/0x82
 [<c013afa8>] invalidate_complete_page+0x28/0x44
 [<c013b320>] invalidate_mapping_pages+0x62/0xbf
 [<c013b39c>] invalidate_inode_pages+0x1f/0x23
 [<c016f15b>] kill_bdev+0x18/0x3e
 [<c016ad37>] sync_blockdev+0x1c/0x1e
 [<c016fe8c>] __blkdev_put+0x35/0x101
 [<c016ff6e>] blkdev_put+0x16/0x19
 [<c014ff2f>] __fput+0xd6/0x18d
 [<c014e7cc>] filp_close+0x5e/0x66
 [<c0118f86>] close_files+0x53/0x63
 [<c0118fbe>] put_files_struct+0x17/0x44
 [<c01198ea>] do_exit+0x1af/0x351
 [<c0117da1>] printk+0x16/0x19
 [<c0103f97>] die+0x1b5/0x1bd
 [<c0112de2>] do_page_fault+0x4b4/0x5a5
 [<c041e063>] __sched_text_start+0x4b3/0x519
 [<c011292e>] do_page_fault+0x0/0x5a5
 [<c041f531>] error_code+0x39/0x40
 [<c014c3b1>] slab_get_obj+0x14/0x1f
 [<c014c62b>] cache_alloc_refill+0xc8/0x17d
 [<c014c8c3>] kmem_cache_alloc+0x55/0x61
 [<c016dd60>] alloc_buffer_head+0x18/0x2f
 [<c016b66c>] alloc_page_buffers+0x26/0xa9
 [<c016be86>] create_empty_buffers+0x25/0x7c
 [<c016c2ca>] __block_prepare_write+0x95/0x445
 [<c01386c8>] __alloc_pages+0x72/0x2f0
 [<c016ce5a>] block_prepare_write+0x31/0x3e
 [<c016f289>] blkdev_get_block+0x0/0x3e
 [<c01362d8>] generic_file_buffered_write+0x231/0x61e
 [<c016f289>] blkdev_get_block+0x0/0x3e
 [<c01036f3>] apic_timer_interrupt+0x1f/0x24
 [<c011b2d8>] current_fs_time+0x47/0x52
 [<c016070f>] file_update_time+0x37/0x9f
 [<c0136bbd>] __generic_file_aio_write_nolock+0x4f8/0x526
 [<c02f47d9>] ide_dma_exec_cmd+0x30/0x34
 [<c02f480f>] ide_dma_start+0x32/0x40
 [<c02f6354>] __ide_do_rw_disk+0x3ba/0x49e
 [<c0232407>] as_move_to_dispatch+0xff/0x124
 [<c0136c43>] generic_file_aio_write_nolock+0x58/0xb1
 [<c014efe9>] do_sync_write+0xdd/0x11a
 [<c0127fb2>] autoremove_wake_function+0x0/0x4b
 [<c0133a64>] handle_edge_irq+0xcd/0xee
 [<c010513c>] do_IRQ+0x70/0x83
 [<c0133a64>] handle_edge_irq+0xcd/0xee
 [<c014f0c6>] vfs_write+0xa0/0x16b
 [<c014f24d>] sys_write+0x4b/0x71
 [<c0102d47>] syscall_call+0x7/0xb
 =======================
Code: 24 2c 0f 8d b7 00 00 00 8b 44 24 28 8b 0c b8 8d 91 00 00 00 40 c1 ea 0c c1 e2 05 03 15 40 8b 58 c0 8b 02 f6 c4 40 74 03 8b 52 0c <8b> 02 a8 80 75 08 0f 0b 5f 02 d1 5e 44 c0 8b 5a 1c 8b 44 24 30 
EIP: [<c014c71a>] free_block+0x3a/0xd6 SS:ESP 0068:e54bf9a0
 <1>Fixing recursive fault but reboot is needed!
BUG: unable to handle kernel paging request at virtual address 91c752a8
 printing eip:
c0199d52
*pde = 00000000
Oops: 0002 [#5]
Modules linked in:
CPU:    0
EIP:    0060:[<c0199d52>]    Not tainted VLI
EFLAGS: 00010246   (2.6.19.1 #1)
EIP is at journal_write_metadata_buffer+0x1f5/0x2c5
eax: 91c752a8   ebx: e948d3a0   ecx: c1ba3000   edx: c0002e00
esi: c1037460   edi: 00000000   ebp: c1ba3000   esp: c1b9be90
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 894, ti=c1b9a000 task=f7c03030 task.ti=c1b9a000)
Stack: c1ba3000 00000003 ccceb310 f7c35600 f701d170 f783bbcc 91c752a8 00000000 
       00000000 00000000 e948d3a0 f701d170 f701d414 f7c35600 c019758e e948d3a0 
       f701d414 c1b9befc 00007c3a f77052c0 00000001 00000ff4 eea7200c 00000000 
Call Trace:
 [<c019758e>] journal_commit_transaction+0x4fe/0xba8
 [<c01998b1>] kjournald+0xa0/0x1d5
 [<c0127fb2>] autoremove_wake_function+0x0/0x4b
 [<c0127fb2>] autoremove_wake_function+0x0/0x4b
 [<c0199811>] kjournald+0x0/0x1d5
 [<c0127ca2>] kthread+0x8d/0xb2
 [<c0127c15>] kthread+0x0/0xb2
 [<c010381f>] kernel_thread_helper+0x7/0x10
 =======================
Code: c7 44 24 04 03 00 00 00 89 34 24 e8 15 9a f7 ff c7 04 38 00 00 00 00 c7 44 24 04 03 00 00 00 89 04 24 e8 7a 9a f7 ff 8b 44 24 18 <c7> 00 00 00 00 00 89 04 24 c7 44 24 08 00 00 00 00 c7 44 24 04 
EIP: [<c0199d52>] journal_write_metadata_buffer+0x1f5/0x2c5 SS:ESP 0068:c1b9be90
 

