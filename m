Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTKQRQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 12:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTKQRQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 12:16:52 -0500
Received: from host243-83.pool81115.interbusiness.it ([81.115.83.243]:42118
	"EHLO mazinga.penteres.it") by vger.kernel.org with ESMTP
	id S263593AbTKQRQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 12:16:49 -0500
Message-ID: <3FB90275.4090804@timenet.it>
Date: Mon, 17 Nov 2003 18:16:37 +0100
From: Luca Cecchi <guybrush@timenet.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: ide tcq kernel 2.6.test9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all,

I had compiled kernel 2.6.test9 on a debian 3.0 linux box, with 2 IBM 
disk configured in raid0, with tcq enable but after not a lot time the 
machine crash with this error

Nov 17 17:28:39 bacco kernel: ide_dmaq_intr: stat=40, not expected
Nov 17 17:28:39 bacco last message repeated 3 times

Nov 17 17:28:39 bacco kernel: hdg: bad DMA status (dma_stat=30)
Nov 17 17:28:39 bacco kernel: hdg: rw_queued: status=0x51 { DriveReady 
SeekComplete Error }
Nov 17 17:28:39 bacco kernel: hdg: rw_queued: error=0x04 { 
DriveStatusError }
Nov 17 17:28:39 bacco kernel: hdg: invalidating tag queue (2 commands)
Nov 17 17:28:39 bacco kernel: ------------[ cut here ]------------
Nov 17 17:28:39 bacco kernel: kernel BUG at drivers/ide/ide-iops.c:1062!
Nov 17 17:28:39 bacco kernel: invalid operand: 0000 [#1]
Nov 17 17:28:39 bacco kernel: CPU:    1
Nov 17 17:28:39 bacco kernel: EIP:    
0060:[ide_execute_command+56/180]    Not tainted
Nov 17 17:28:39 bacco kernel: EFLAGS: 00010086
Nov 17 17:28:39 bacco kernel: EIP is at ide_execute_command+0x38/0xb4
Nov 17 17:28:39 bacco kernel: eax: 00000000   ebx: ce2e4000   ecx: 
c0451778   edx: cfc85d80
Nov 17 17:28:39 bacco kernel: esi: 00000286   edi: c046f2e0   ebp: 
c046f234   esp: ce2e5a78
Nov 17 17:28:39 bacco kernel: ds: 007b   es: 007b   ss: 0068
Nov 17 17:28:39 bacco kernel: Process smbd (pid: 356, 
threadinfo=ce2e4000 task=ce5066b0)
Nov 17 17:28:39 bacco kernel: Stack: c046f234 c046f2e0 c046f2e0 00000004 
0000dc02 c0241ddc c046f2e0 00000000
Nov 17 17:28:39 bacco kernel:        c0241de4 00002710 00000000 00000000 
0000d802 c046f2e0 00000000 cfc85e68
Nov 17 17:28:39 bacco kernel:        c046f234 00004fdc c02420a8 c046f2e0 
00000000 00000000 c0241de4 00000000
Nov 17 17:28:39 bacco kernel: Call Trace:
Nov 17 17:28:39 bacco kernel:  [ide_cmd+108/116] ide_cmd+0x6c/0x74
Nov 17 17:28:39 bacco kernel:  [drive_cmd_intr+0/228] 
drive_cmd_intr+0x0/0xe4
Nov 17 17:28:39 bacco kernel:  [execute_drive_cmd+408/476] 
execute_drive_cmd+0x198/0x1dc
Nov 17 17:28:39 bacco kernel:  [drive_cmd_intr+0/228] 
drive_cmd_intr+0x0/0xe4
Nov 17 17:28:39 bacco kernel:  [start_request+389/524] 
start_request+0x185/0x20c
Nov 17 17:28:39 bacco kernel:  [ide_do_request+874/980] 
ide_do_request+0x36a/0x3d4
Nov 17 17:28:39 bacco kernel:  [ide_do_request+880/980] 
ide_do_request+0x370/0x3d4
Nov 17 17:28:39 bacco kernel:  [do_ide_request+18/24] 
do_ide_request+0x12/0x18
Nov 17 17:28:39 bacco kernel:  [__make_request+1264/1332] 
__make_request+0x4f0/0x534
Nov 17 17:28:39 bacco kernel:  [generic_make_request+302/324] 
generic_make_request+0x12e/0x144
Nov 17 17:28:39 bacco kernel:  [autoremove_wake_function+0/64] 
autoremove_wake_function+0x0/0x40
Nov 17 17:28:39 bacco kernel:  [bio_alloc+284/416] bio_alloc+0x11c/0x1a0
Nov 17 17:28:39 bacco kernel:  [submit_bio+126/140] submit_bio+0x7e/0x8c
Nov 17 17:28:39 bacco kernel:  [submit_bh+267/276] submit_bh+0x10b/0x114
Nov 17 17:28:39 bacco kernel:  [block_read_full_page+616/636] 
block_read_full_page+0x268/0x27c
Nov 17 17:28:39 bacco kernel:  [mpage_bio_submit+34/40] 
mpage_bio_submit+0x22/0x28
Nov 17 17:28:39 bacco kernel:  [do_mpage_readpage+856/884] 
do_mpage_readpage+0x358/0x374
Nov 17 17:28:39 bacco kernel:  [ext3_get_block+0/104] 
ext3_get_block+0x0/0x68
Nov 17 17:28:39 bacco kernel:  [add_to_page_cache+87/272] 
add_to_page_cache+0x57/0x110
Nov 17 17:28:39 bacco kernel:  [mpage_readpages+145/304] 
mpage_readpages+0x91/0x130
Nov 17 17:28:39 bacco kernel:  [ext3_get_block+0/104] 
ext3_get_block+0x0/0x68
Nov 17 17:28:39 bacco kernel:  [ext3_readpages+25/32] 
ext3_readpages+0x19/0x20
Nov 17 17:28:39 bacco kernel:  [ext3_get_block+0/104] 
ext3_get_block+0x0/0x68
Nov 17 17:28:39 bacco kernel:  [read_pages+53/300] read_pages+0x35/0x12c
Nov 17 17:28:39 bacco kernel:  [__alloc_pages+159/728] 
__alloc_pages+0x9f/0x2d8
Nov 17 17:28:39 bacco kernel:  [do_page_cache_readahead+424/464] 
do_page_cache_readahead+0x1a8/0x1d0
Nov 17 17:28:39 bacco kernel:  [page_cache_readahead+241/292] 
page_cache_readahead+0xf1/0x124
Nov 17 17:28:39 bacco kernel:  [do_generic_mapping_read+183/832] 
do_generic_mapping_read+0xb7/0x340
Nov 17 17:28:39 bacco kernel:  [__generic_file_aio_read+501/540] 
__generic_file_aio_read+0x1f5/0x21c
Nov 17 17:28:39 bacco kernel:  [file_read_actor+0/208] 
file_read_actor+0x0/0xd0
Nov 17 17:28:39 bacco kernel:  [generic_file_aio_read+73/84] 
generic_file_aio_read+0x49/0x54
Nov 17 17:28:39 bacco kernel:  [do_sync_read+129/176] do_sync_read+0x81/0xb0
Nov 17 17:28:39 bacco kernel:  [free_pages+54/56] free_pages+0x36/0x38
Nov 17 17:28:39 bacco kernel:  [poll_freewait+62/72] poll_freewait+0x3e/0x48
Nov 17 17:28:39 bacco kernel:  [select_bits_free+10/16] 
select_bits_free+0xa/0x10
Nov 17 17:28:39 bacco kernel:  [sys_select+1121/1136] sys_select+0x461/0x470
Nov 17 17:28:39 bacco kernel:  [vfs_read+156/204] vfs_read+0x9c/0xcc
Nov 17 17:28:39 bacco kernel:  [sys_read+49/76] sys_read+0x31/0x4c
Nov 17 17:28:39 bacco kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 17:28:39 bacco kernel:
Nov 17 17:28:39 bacco kernel: Code: 0f 0b 26 04 1a c2 34 c0 8b 44 24 20 
89 02 8b 44 24 28 89 82
Nov 17 17:28:39 bacco kernel:  <6>note: smbd[356] exited with 
preempt_count 1

This is the entire trace

Anyone know why?

