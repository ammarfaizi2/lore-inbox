Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272956AbTG3PS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272928AbTG3PRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:17:20 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:11684 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S272932AbTG3PQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:16:11 -0400
Date: Wed, 30 Jul 2003 08:15:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1014] New: Infrequent but persistent oops in either XFS or block layer
Message-ID: <21770000.1059578154@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1014

           Summary: Infrequent but persistent oops in either XFS or block
                    layer
    Kernel Version: 2.6.0-test1
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: kpfleming@cox.net


Distribution: modified RH7.2
Hardware Environment: MSI KT266-based board, Athlon 1GHz, 512M RAM, 3ware 7000-2
RAID controller, various NICs
Software Environment: kernel 2.6.0-test1, LVM2 using device mapper, XFS
Problem Description: Infrequent oops using XFS, but appears to be in block layer

Steps to reproduce: Cannot reliably reproduce. Have not been able to directly
capture oops trace, but below is Alt-SysRq-P output from this morning's episode.

SysRq : Show Regs


Pid: 7, comm:              pdflush

EIP: 0060:[<c0119ea7>] CPU: 0
EIP is at panic+0xe7/0x100
EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c138c000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: c010a1c0 EBP: c5049880 DS: 007b ES: 007b
CR0: 8005003b CR2: 41360000 CR3: 0ade1000 CR4: 000002d0
Call Trace:
 [<c0109eb7>] die+0xb7/0xd0
 [<c010a289>] do_invalid_op+0xc9/0xd0
 [<c02027f9>] bio_end_io_pagebuf+0xb9/0x130
 [<c01172ca>] default_wake_function+0x2a/0x30
 [<c0117301>] __wake_up_common+0x31/0x60
 [<c01172ca>] default_wake_function+0x2a/0x30
 [<c0117301>] __wake_up_common+0x31/0x60
 [<c0109855>] error_code+0x2d/0x38
 [<c02027f9>] bio_end_io_pagebuf+0xb9/0x130
 [<c0149e73>] bio_endio+0x53/0x80
 [<c030874f>] clone_endio+0x6f/0xb0
 [<c0149e73>] bio_endio+0x53/0x80
 [<c026af35>] __end_that_request_first+0x205/0x230
 [<c02a527b>] scsi_end_request+0x3b/0xb0
 [<c02a565b>] scsi_io_completion+0x1bb/0x480
 [<c02cea42>] sd_rw_intr+0x52/0x1c0
 [<c02a1a88>] scsi_finish_command+0x78/0xc0
 [<c02a199e>] scsi_softirq+0xae/0xe0
 [<c011d399>] do_softirq+0x99/0xa0
 [<c010b2d2>] do_IRQ+0xc2/0xe0
 [<c01097b8>] common_interrupt+0x18/0x20
 [<c013404f>] mark_page_accessed+0x1f/0x30
 [<c0201c95>] _pagebuf_lookup_pages+0x365/0x3b0
 [<c0201fc9>] pagebuf_get+0xb9/0x140
 [<c01f513d>] xfs_trans_read_buf+0x17d/0x390
 [<c01a2a67>] xfs_alloc_read_agfl+0x87/0xa0
 [<c01a4bac>] xfs_alloc_fix_freelist+0x2dc/0x470
 [<c01a4eb8>] xfs_alloc_log_agf+0x58/0x60
 [<c01a2aea>] xfs_alloc_ag_vextent+0x6a/0x120
 [<c01a5400>] xfs_alloc_vextent+0x1f0/0x390
 [<c01b4180>] xfs_bmap_alloc+0x860/0x1350
 [<c01bee1f>] xfs_bmbt_get_state+0x2f/0x40
 [<c01b805e>] xfs_bmapi+0x56e/0x1400
 [<c01bee1f>] xfs_bmbt_get_state+0x2f/0x40
 [<c01b6428>] xfs_bmap_do_search_extents+0xb8/0x3d0
 [<c01e4eed>] xfs_log_reserve+0xbd/0xd0
 [<c0208878>] xfs_iomap_write_allocate+0x2a8/0x4c0
 [<c02707a5>] as_set_request+0x25/0x70
 [<c0207bc2>] xfs_iomap+0x3b2/0x4c0
 [<c0308d70>] dm_request+0x70/0xb0
 [<c02148c3>] rb_erase+0x63/0x100
 [<c020380e>] map_blocks+0x5e/0xd0
 [<c0204635>] page_state_convert+0x3f5/0x540
 [<c0267f66>] elv_next_request+0x16/0x100
 [<c026982e>] generic_unplug_device+0x4e/0x50
 [<c0269956>] blk_run_queues+0x66/0x80
 [<c01e0e5e>] xfs_iflush+0x1de/0x4d0
 [<c0204d48>] linvfs_writepage+0x58/0x110
 [<c0161f7e>] mpage_writepages+0x1ce/0x290
 [<c01097da>] apic_timer_interrupt+0x1a/0x20
 [<c0204cf0>] linvfs_writepage+0x0/0x110
 [<c0131326>] do_writepages+0x36/0x40
 [<c0160949>] __sync_single_inode+0xa9/0x1f0
 [<c0160ccc>] sync_sb_inodes+0x18c/0x230
 [<c0160da3>] writeback_inodes+0x33/0x50
 [<c013116c>] wb_kupdate+0x9c/0x120
 [<c013166e>] __pdflush+0xae/0x160
 [<c0131720>] pdflush+0x0/0x20
 [<c013172f>] pdflush+0xf/0x20
 [<c01310d0>] wb_kupdate+0x0/0x120
 [<c0106fb0>] kernel_thread_helper+0x0/0x10
 [<c0106fb5>] kernel_thread_helper+0x5/0x10

SysRq : Show Regs


Pid: 28831, comm:              pdflush
EIP: 0060:[<c0119ea7>] CPU: 0
EIP is at panic+0xe7/0x100
EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: cc96a000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: c010a1c0 EBP: c3961380 DS: 007b ES: 007b
CR0: 8005003b CR2: 401a47ac CR3: 0aca8000 CR4: 000002d0
Call Trace:
 [<c0109eb7>] die+0xb7/0xd0
 [<c010a289>] do_invalid_op+0xc9/0xd0
 [<c02027f9>] bio_end_io_pagebuf+0xb9/0x130
 [<c01172ca>] default_wake_function+0x2a/0x30
 [<c0117301>] __wake_up_common+0x31/0x60
 [<c012f193>] mempool_free+0x33/0x70
 [<c0109855>] error_code+0x2d/0x38
 [<c02027f9>] bio_end_io_pagebuf+0xb9/0x130
 [<c0149e73>] bio_endio+0x53/0x80
 [<c030874f>] clone_endio+0x6f/0xb0
 [<c0149e73>] bio_endio+0x53/0x80
 [<c026af35>] __end_that_request_first+0x205/0x230
 [<c02a527b>] scsi_end_request+0x3b/0xb0
 [<c02a565b>] scsi_io_completion+0x1bb/0x480
 [<c02cea42>] sd_rw_intr+0x52/0x1c0
 [<c02a1a88>] scsi_finish_command+0x78/0xc0
 [<c02a199e>] scsi_softirq+0xae/0xe0
 [<c011d399>] do_softirq+0x99/0xa0
 [<c010b2d2>] do_IRQ+0xc2/0xe0
 [<c01097b8>] common_interrupt+0x18/0x20
 [<c012c870>] find_lock_page+0x80/0x90
 [<c012c8a1>] find_or_create_page+0x21/0xb0
 [<c0201c39>] _pagebuf_lookup_pages+0x309/0x3b0
 [<c0201fc9>] pagebuf_get+0xb9/0x140
 [<c01f513d>] xfs_trans_read_buf+0x17d/0x390
 [<c01a509b>] xfs_alloc_read_agf+0x7b/0x1f0
 [<c01a4cab>] xfs_alloc_fix_freelist+0x3db/0x470
 [<c01f558b>] xfs_trans_log_buf+0x6b/0xb0
 [<c035a802>] fn_hash_lookup+0xb2/0xe0
 [<c0359c74>] __fib_res_prefsrc+0x24/0x30
 [<c0358b3a>] fib_validate_source+0x1fa/0x220
 [<c01a5400>] xfs_alloc_vextent+0x1f0/0x390
 [<c01b4180>] xfs_bmap_alloc+0x860/0x1350
 [<c01bee1f>] xfs_bmbt_get_state+0x2f/0x40
 [<c01b805e>] xfs_bmapi+0x56e/0x1400
 [<c03128c3>] __kfree_skb+0x83/0x100
 [<c01e4eed>] xfs_log_reserve+0xbd/0xd0
 [<c0208878>] xfs_iomap_write_allocate+0x2a8/0x4c0
 [<c02707a5>] as_set_request+0x25/0x70
 [<c01dc7e7>] xfs_iunlock+0x37/0x80
 [<c0207bc2>] xfs_iomap+0x3b2/0x4c0
 [<c0308d70>] dm_request+0x70/0xb0
 [<c02148c3>] rb_erase+0x63/0x100
 [<c020380e>] map_blocks+0x5e/0xd0
 [<c0204635>] page_state_convert+0x3f5/0x540
 [<c0267f66>] elv_next_request+0x16/0x100
 [<c026982e>] generic_unplug_device+0x4e/0x50
 [<c0269956>] blk_run_queues+0x66/0x80
 [<c01e0e5e>] xfs_iflush+0x1de/0x4d0
 [<c0204d48>] linvfs_writepage+0x58/0x110
 [<c0161f7e>] mpage_writepages+0x1ce/0x290
 [<c0204cf0>] linvfs_writepage+0x0/0x110
 [<c0131326>] do_writepages+0x36/0x40
 [<c0160949>] __sync_single_inode+0xa9/0x1f0
 [<c0160ccc>] sync_sb_inodes+0x18c/0x230
 [<c0160da3>] writeback_inodes+0x33/0x50
 [<c013116c>] wb_kupdate+0x9c/0x120
 [<c013166e>] __pdflush+0xae/0x160
 [<c0131720>] pdflush+0x0/0x20
 [<c013172f>] pdflush+0xf/0x20
 [<c01310d0>] wb_kupdate+0x0/0x120
 [<c0106fb0>] kernel_thread_helper+0x0/0x10
 [<c0106fb5>] kernel_thread_helper+0x5/0x10


