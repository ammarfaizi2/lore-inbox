Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbTBPCtD>; Sat, 15 Feb 2003 21:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTBPCtD>; Sat, 15 Feb 2003 21:49:03 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46778 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265806AbTBPCs7>; Sat, 15 Feb 2003 21:48:59 -0500
Date: Sat, 15 Feb 2003 18:58:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 365] New: Raid-0 causes kernel BUG at
 drivers/block/ll_rw_blk.c:1996
Message-ID: <5630000.1045364322@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=365

           Summary: Raid-0 causes kernel BUG at
                    drivers/block/ll_rw_blk.c:1996
    Kernel Version: 2.5.61
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: harisri@bigpond.com


Distribution: RH 8.0
Hardware Environment: Athlon, AMD 761 (AMD North Bridge, VIA South bridge),
IDE Hard drives
Software Environment: Gnu C 3.2, Linux C Library 2.2.93,
raidtools-1.00.2-3.3 Problem Description: 2.5.61 oops while trying to
activate raid-0 volumes. Please refer the thread
http://marc.theaimsgroup.com/?l=linux-kernel&m=103830814911111&w=2 for more
information from Neil Brown, Jens Axboe and Andrew Morton.

Steps to reproduce: Try to enable raid-0 volumes under 2.5.49 to 2.5.61

Sample oops:
------------[ cut here ]------------
kernel BUG at drivers/block/ll_rw_blk.c:1996!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c02255d7>]    Not tainted
EFLAGS: 00010246
EIP is at submit_bio+0x67/0x80
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: df515804
esi: df515804   edi: 00001e74   ebp: c14d72e0   esp: df325d28
ds: 007b   es: 007b   ss: 0068
Process rpmq (pid: 161, threadinfo=df324000 task=df5a5440)
Stack: df9f9e04 df515804 c0188b1e 00000000 df515804 00001000 c0188de2
00000000         df515804 00001000 00000000 c0142d2f 00000001 dfd29d74
00000004 00004388         00000004 0000000a df17a0d4 00000010 df0e85fc
df17a194 c14d72e0 00010901  Call Trace:
 [<c0188b1e>] mpage_bio_submit+0x2e/0x40
 [<c0188de2>] do_mpage_readpage+0x182/0x320
 [<c0142d2f>] cache_alloc_debugcheck_after+0xaf/0xd0
 [<c01c63df>] radix_tree_node_alloc+0x1f/0x60
 [<c01c65d3>] radix_tree_insert+0x93/0xd0
 [<c0189117>] mpage_readpage+0x37/0x60
 [<c01a3430>] ext3_get_block+0x0/0xa0
 [<c0139d89>] do_generic_mapping_read+0x1c9/0x3f0
 [<c01a3430>] ext3_get_block+0x0/0xa0
 [<c0139ff0>] file_read_actor+0x0/0xe0
 [<c013a299>] __generic_file_aio_read+0x1c9/0x200
 [<c0139ff0>] file_read_actor+0x0/0xe0
 [<c013a32a>] generic_file_aio_read+0x5a/0x80
 [<c015c9fc>] do_sync_read+0x8c/0xc0
 [<c011801c>] do_page_fault+0x23c/0x457
 [<c014e7a8>] do_brk+0x148/0x220
 [<c015caec>] vfs_read+0xbc/0x130
 [<c015ce68>] sys_pread64+0x58/0x80
 [<c010a3af>] syscall_call+0x7/0xb

Code: 0f 0b cc 07 6e 7f 37 c0 eb aa 90 8d b4 26 00 00 00 00 8d bc 

 ------------[ cut here ]------------
kernel BUG at drivers/block/ll_rw_blk.c:1996!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c02255d7>]    Not tainted
EFLAGS: 00010246
EIP is at submit_bio+0x67/0x80
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: df517a04
esi: df517a04   edi: 0000003c   ebp: c14c40f0   esp: debc1bd8
ds: 007b   es: 007b   ss: 0068
Process squid (pid: 395, threadinfo=debc0000 task=df5a40c0)
Stack: dffbef0c df517a04 c0188b1e 00000000 df517a04 00001000 c0188de2
00000000         df517a04 00001000 00000000 c0141c26 00000001 dfd29d74
00000004 00000131         00000004 0000000a de96b554 00000010 00000020
00000001 c14c40f0 00034fc2  Call Trace:
 [<c0188b1e>] mpage_bio_submit+0x2e/0x40
 [<c0188de2>] do_mpage_readpage+0x182/0x320
 [<c0141c26>] kmem_cache_alloc+0x56/0x80
 [<c01c65ff>] radix_tree_insert+0xbf/0xd0
 [<c01890ab>] mpage_readpages+0x12b/0x160
 [<c01a3430>] ext3_get_block+0x0/0xa0
 [<c013fd81>] read_pages+0x111/0x120
 [<c01a3430>] ext3_get_block+0x0/0xa0
 [<c0142c07>] cache_free_debugcheck+0x157/0x1d0
 [<c013d563>] __alloc_pages+0x93/0x2c0
 [<c01401c8>] __do_page_cache_readahead+0xd8/0x150
 [<c013fdd3>] do_page_cache_readahead+0x43/0x50
 [<c013fe54>] page_cache_readahead+0x74/0x190
 [<c0139c6d>] do_generic_mapping_read+0xad/0x3f0
 [<c0139ff0>] file_read_actor+0x0/0xe0
 [<c013a299>] __generic_file_aio_read+0x1c9/0x200
 [<c0139ff0>] file_read_actor+0x0/0xe0
 [<c013a32a>] generic_file_aio_read+0x5a/0x80
 [<c015c9fc>] do_sync_read+0x8c/0xc0
 [<c014d03b>] vma_merge+0x1cb/0x520
 [<c014d956>] do_mmap_pgoff+0x5c6/0x6f0
 [<c015caec>] vfs_read+0xbc/0x130
 [<c015cd8e>] sys_read+0x3e/0x60
 [<c010a3af>] syscall_call+0x7/0xb

Code: 0f 0b cc 07 6e 7f 37 c0 eb aa 90 8d b4 26 00 00 00 00 8d bc 

------------[ cut here ]------------
kernel BUG at drivers/block/ll_rw_blk.c:1996!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c02255d7>]    Not tainted
EFLAGS: 00010246
EIP is at submit_bio+0x67/0x80
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: df517504
esi: df517504   edi: 00000058   ebp: c14ac090   esp: de295bd8
ds: 007b   es: 007b   ss: 0068
Process squid (pid: 501, threadinfo=de294000 task=de6ba800)
Stack: dffafd44 df517504 c0188b1e 00000000 df517504 00001000 c0188de2
00000000         df517504 00001000 00000000 de295c08 00000001 dfd29d74
00000004 00000131         00000004 0000000a de96b554 00000010 def492e4
df4a0f34 c14ac090 00035042  Call Trace:
 [<c0188b1e>] mpage_bio_submit+0x2e/0x40
 [<c0188de2>] do_mpage_readpage+0x182/0x320
 [<c01b09db>] journal_dirty_metadata+0x25b/0x340
 [<c015e92f>] wake_up_buffer+0xf/0x40
 [<c015e993>] unlock_buffer+0x33/0x60
 [<c01890ab>] mpage_readpages+0x12b/0x160
 [<c01a3430>] ext3_get_block+0x0/0xa0
 [<c01a5c96>] ext3_do_update_inode+0x196/0x420
 [<c013fd81>] read_pages+0x111/0x120
 [<c01a3430>] ext3_get_block+0x0/0xa0
 [<c0142c07>] cache_free_debugcheck+0x157/0x1d0
 [<c013d563>] __alloc_pages+0x93/0x2c0
 [<c01401c8>] __do_page_cache_readahead+0xd8/0x150
 [<c013fdd3>] do_page_cache_readahead+0x43/0x50
 [<c013ff29>] page_cache_readahead+0x149/0x190
 [<c0139c6d>] do_generic_mapping_read+0xad/0x3f0
 [<c0139ff0>] file_read_actor+0x0/0xe0
 [<c013a299>] __generic_file_aio_read+0x1c9/0x200
 [<c0139ff0>] file_read_actor+0x0/0xe0
 [<c013a32a>] generic_file_aio_read+0x5a/0x80
 [<c015c9fc>] do_sync_read+0x8c/0xc0
 [<c011801c>] do_page_fault+0x23c/0x457
 [<c014e7a8>] do_brk+0x148/0x220
 [<c015caec>] vfs_read+0xbc/0x130
 [<c015cd8e>] sys_read+0x3e/0x60
 [<c010a3af>] syscall_call+0x7/0xb

Code: 0f 0b cc 07 6e 7f 37 c0 eb aa 90 8d b4 26 00 00 00 00 8d bc 

------------[ cut here ]------------
kernel BUG at drivers/block/ll_rw_blk.c:1996!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c02255d7>]    Not tainted
EFLAGS: 00010246
EIP is at submit_bio+0x67/0x80
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: df515e84
esi: df515e84   edi: 00000008   ebp: c1465280   esp: dc82dbd8
ds: 007b   es: 007b   ss: 0068
Process gnome-session (pid: 515, threadinfo=dc82c000 task=de6b8e00)
Stack: dffbef7c df515e84 c0188b1e 00000000 df515e84 00001000 c0188de2
00000000         df515e84 00001000 00000000 c0141c26 00000001 dfd29ec4
00000004 00000009         00000004 0000000a dc23e554 00000010 00000020
00000001 c1465280 00002b81  Call Trace:
 [<c0188b1e>] mpage_bio_submit+0x2e/0x40
 [<c0188de2>] do_mpage_readpage+0x182/0x320
 [<c0141c26>] kmem_cache_alloc+0x56/0x80
 [<c01c65ff>] radix_tree_insert+0xbf/0xd0
 [<c01890ab>] mpage_readpages+0x12b/0x160
 [<c01a3430>] ext3_get_block+0x0/0xa0
 [<c0244866>] ide_wait_stat+0xf6/0x120
 [<c02404d9>] start_request+0xf9/0x1b0
 [<c013fd81>] read_pages+0x111/0x120
 [<c01a3430>] ext3_get_block+0x0/0xa0
 [<c013d563>] __alloc_pages+0x93/0x2c0
 [<c01401c8>] __do_page_cache_readahead+0xd8/0x150
 [<c013fdd3>] do_page_cache_readahead+0x43/0x50
 [<c013fe54>] page_cache_readahead+0x74/0x190
 [<c0139c6d>] do_generic_mapping_read+0xad/0x3f0
 [<c0161008>] __bread+0x38/0x40
 [<c0139ff0>] file_read_actor+0x0/0xe0
 [<c013a299>] __generic_file_aio_read+0x1c9/0x200
 [<c0139ff0>] file_read_actor+0x0/0xe0
 [<c013a32a>] generic_file_aio_read+0x5a/0x80
 [<c015c9fc>] do_sync_read+0x8c/0xc0
 [<c014cbea>] __vma_link+0x3a/0xa0
 [<c014cd04>] vma_link+0xb4/0x1a0
 [<c014d7ac>] do_mmap_pgoff+0x41c/0x6f0
 [<c015caec>] vfs_read+0xbc/0x130
 [<c015cd8e>] sys_read+0x3e/0x60
 [<c010a3af>] syscall_call+0x7/0xb

Code: 0f 0b cc 07 6e 7f 37 c0 eb aa 90 8d b4 26 00 00 00 00 8d bc 

Thanks.


