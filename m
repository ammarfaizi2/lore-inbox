Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbTGTSOe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 14:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267647AbTGTSOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 14:14:34 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:40154 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S267638AbTGTSOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 14:14:32 -0400
Message-ID: <3F1ADED4.8020809@cox.net>
Date: Sun, 20 Jul 2003 11:26:28 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Hard-to-catch oops with 2.6.0-test1, is this enough?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had an oops occurring randomly, and not frequently (every 5-6 
days) for weeks now, using 2.5.7? kernels and now today with 
2.6.0-test1. I've got the system set up with a serial console, and 
another system capturing the output (when I set it up), but have never 
managed to catch the oops message.

This morning, however, the oops occurred and I was able to use 
Alt-SysRq-P and capture that output, which is below. Is this adequate 
for tracking down the cause of this problem? If not, I'm going to have 
to set up something that can run 24/7 to catch the real oops message.

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

