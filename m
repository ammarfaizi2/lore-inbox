Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbUL3AYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbUL3AYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbUL3AYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:24:40 -0500
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:51087 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261453AbUL3AXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:23:40 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Message-Id: <200412300019.iBU0JYgr022375@wildsau.enemy.org>
Subject: disabling IRQs cause nobody cares (incl. oops)
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Dec 2004 01:19:34 +0100 (MET)
CC: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good evening,

anyone knows what's the cause of this:

Dec 30 01:13:45 burn kernel: irq 19: nobody cared!
Dec 30 01:13:45 burn kernel:  [<c01318a3>] __report_bad_irq+0x33/0x98
Dec 30 01:13:45 burn kernel:  [<c0131980>] note_interrupt+0x50/0x78 
Dec 30 01:13:45 burn kernel:  [<c0131469>] __do_IRQ+0x10d/0x144
Dec 30 01:13:45 burn kernel:  [<c0104cab>] do_IRQ+0x1b/0x28
Dec 30 01:13:45 burn kernel:  [<c01036a2>] common_interrupt+0x1a/0x20
Dec 30 01:13:45 burn kernel:  [<c02d007b>] packet_recvmsg+0xef/0x140
Dec 30 01:13:45 burn kernel:  [<c0101049>] default_idle+0x29/0x38
Dec 30 01:13:45 burn kernel:  [<c01010d9>] cpu_idle+0x39/0x58
Dec 30 01:13:45 burn kernel:  [<c01002be>] rest_init+0x1e/0x20
Dec 30 01:13:45 burn kernel:  [<c03b4994>] start_kernel+0x14c/0x154
Dec 30 01:13:45 burn kernel: handlers:
Dec 30 01:13:45 burn kernel: [<c025eeb4>] (ide_intr+0x0/0x134)
Dec 30 01:13:45 burn kernel: [<c025eeb4>] (ide_intr+0x0/0x134)
Dec 30 01:13:45 burn kernel: Disabling IRQ #19
Dec 30 01:13:51 burn kernel: irq 17: nobody cared!
Dec 30 01:13:51 burn kernel:  [<c01318a3>] __report_bad_irq+0x33/0x98
Dec 30 01:13:51 burn kernel:  [<c0131980>] note_interrupt+0x50/0x78
Dec 30 01:13:51 burn kernel:  [<c0131469>] __do_IRQ+0x10d/0x144
Dec 30 01:13:51 burn kernel:  [<c0104cab>] do_IRQ+0x1b/0x28
Dec 30 01:13:51 burn kernel:  [<c01036a2>] common_interrupt+0x1a/0x20
Dec 30 01:13:51 burn kernel:  [<c02d007b>] packet_recvmsg+0xef/0x140
Dec 30 01:13:51 burn kernel:  [<c0101049>] default_idle+0x29/0x38
Dec 30 01:13:51 burn kernel:  [<c01010d9>] cpu_idle+0x39/0x58
Dec 30 01:13:51 burn kernel:  [<c01002be>] rest_init+0x1e/0x20
Dec 30 01:13:51 burn kernel:  [<c03b4994>] start_kernel+0x14c/0x154
Dec 30 01:13:51 burn kernel: handlers:
Dec 30 01:13:51 burn kernel: [<c025eeb4>] (ide_intr+0x0/0x134)
Dec 30 01:13:51 burn kernel: [<c025eeb4>] (ide_intr+0x0/0x134)
Dec 30 01:13:51 burn kernel: Disabling IRQ #17



or even this:



Dec 30 01:16:24 burn kernel: Disabling IRQ #19
Dec 30 01:16:24 burn kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Dec 30 01:16:24 burn kernel:  printing eip:
Dec 30 01:16:24 burn kernel: c014fdb3
Dec 30 01:16:24 burn kernel: *pde = 00000000
Dec 30 01:16:24 burn kernel: Oops: 0002 [#1]
Dec 30 01:16:24 burn kernel: PREEMPT SMP
Dec 30 01:16:24 burn kernel: Modules linked in:
Dec 30 01:16:24 burn kernel: CPU:    1
Dec 30 01:16:24 burn kernel: EIP:    0060:[<c014fdb3>]    Not tainted VLI
Dec 30 01:16:24 burn kernel: EFLAGS: 00010292   (2.6.10)
Dec 30 01:16:24 burn kernel: EIP is at create_empty_buffers+0x1f/0x88
Dec 30 01:16:24 burn kernel: eax: 00000000   ebx: c1321e20   ecx: 00000010   edx: 00000000
Dec 30 01:16:24 burn kernel: esi: 00000000   edi: 00000000   ebp: c1321e20   esp: e2acdcd0
Dec 30 01:16:24 burn kernel: ds: 007b   es: 007b   ss: 0068
Dec 30 01:16:24 burn kernel: Process rip-cd (pid: 396, threadinfo=e2acc000 task=c1a16020)
Dec 30 01:16:24 burn kernel: Stack: c1321e38 00010000 e2acdd7c c0150649 c1321e20 00010000 00000000 c1321e38
Dec 30 01:16:25 burn kernel:        c1321e20 e2acdd7c 00000000 c192d180 00000046 00000001 c01df315 00000001
Dec 30 01:16:25 burn kernel:        00000020 00010000 e93ee440 c01df593 dc93aa94 dc93aaa0 00000000 dc93a9ec
Dec 30 01:16:25 burn kernel: Call Trace:
Dec 30 01:16:25 burn kernel:  [<c0150649>] block_read_full_page+0x61/0x2dc
Dec 30 01:16:25 burn kernel:  [<c01df315>] radix_tree_node_alloc+0x15/0x60
Dec 30 01:16:25 burn kernel:  [<c01df593>] radix_tree_insert+0x6f/0xf0
Dec 30 01:16:25 burn kernel:  [<c013240e>] add_to_page_cache+0x3e/0xb8
Dec 30 01:16:25 burn kernel:  [<c0132469>] add_to_page_cache+0x99/0xb8
Dec 30 01:16:25 burn kernel:  [<c01540af>] blkdev_readpage+0xf/0x14
Dec 30 01:16:25 burn kernel:  [<c0153f5c>] blkdev_get_block+0x0/0x54
Dec 30 01:16:25 burn kernel:  [<c0138e4e>] read_pages+0xba/0x13c
Dec 30 01:16:25 burn kernel:  [<c013679b>] __alloc_pages+0x2ff/0x30c
Dec 30 01:16:25 burn kernel:  [<c0139218>] do_page_cache_readahead+0x16c/0x194
Dec 30 01:16:25 burn kernel:  [<c0139386>] page_cache_readahead+0x146/0x1c8
Dec 30 01:16:25 burn kernel:  [<c0132aa6>] do_generic_mapping_read+0xe6/0x464
Dec 30 01:16:25 burn kernel:  [<c01330c8>] __generic_file_aio_read+0x1d0/0x1f4
Dec 30 01:16:25 burn kernel:  [<c0132e24>] file_read_actor+0x0/0xd4
Dec 30 01:16:25 burn kernel:  [<c01331ed>] generic_file_read+0xad/0xc8
Dec 30 01:16:25 burn kernel:  [<c014e5f0>] file_move+0x38/0x3c
Dec 30 01:16:25 burn kernel:  [<c014cdaa>] dentry_open+0x12a/0x208
Dec 30 01:16:25 burn kernel:  [<c014cc76>] filp_open+0x52/0x5c
Dec 30 01:16:25 burn kernel:  [<c012b81c>] autoremove_wake_function+0x0/0x40
Dec 30 01:16:25 burn kernel:  [<c01540ec>] block_llseek+0x0/0xc8
Dec 30 01:16:25 burn kernel:  [<c014d75c>] vfs_read+0x9c/0xcc
Dec 30 01:16:25 burn kernel:  [<c014d97c>] sys_read+0x40/0x6c
Dec 30 01:16:25 burn kernel:  [<c0102d33>] syscall_call+0x7/0xb
Dec 30 01:16:25 burn kernel: Code: 08 8b 44 24 10 5b 5e 5f 5d 59 c3 90 57 56 53 8b 5c 24 10 8b 44 24 14 8b 7c 24 18 6a 01 50 53 e8 c8 f6 ff ff 89 c6 89 f2 83 c4 0c <09> 3a 89 d0 8b 52 04 85 d2 75 f5 89 70 04 8b 43 10 83 c0 44 e8
Dec 30 01:16:25 burn kernel:  <3>irq 19: nobody cared!
Dec 30 01:16:25 burn kernel:  [<c01318a3>] __report_bad_irq+0x33/0x98
Dec 30 01:16:25 burn kernel:  [<c0131980>] note_interrupt+0x50/0x78
Dec 30 01:16:25 burn kernel:  [<c0131469>] __do_IRQ+0x10d/0x144
Dec 30 01:16:25 burn kernel:  [<c0104cab>] do_IRQ+0x1b/0x28
Dec 30 01:16:25 burn kernel:  [<c01036a2>] common_interrupt+0x1a/0x20
Dec 30 01:16:25 burn kernel:  [<c02e007b>] interruptible_sleep_on_timeout+0x2b/0x90
Dec 30 01:16:25 burn kernel:  [<c025007b>] e1000_tbi_adjust_stats+0x197/0x1d4
Dec 30 01:16:25 burn kernel:  [<c013259e>] end_page_writeback+0xe/0x50
Dec 30 01:16:25 burn kernel:  [<c016c1f4>] mpage_end_io_write+0x4c/0x64
Dec 30 01:16:25 burn kernel:  [<c01529a1>] bio_endio+0x51/0x58
Dec 30 01:16:25 burn kernel:  [<c0240b41>] __end_that_request_first+0xf1/0x1dc
Dec 30 01:16:25 burn kernel:  [<c0240c5c>] end_that_request_chunk+0x14/0x18
Dec 30 01:16:25 burn kernel:  [<c0270b44>] scsi_end_request+0x24/0xb4
Dec 30 01:16:25 burn kernel:  [<c0270f30>] scsi_io_completion+0x1d4/0x40c
Dec 30 01:16:25 burn kernel:  [<c0278386>] sd_rw_intr+0x20e/0x218
Dec 30 01:16:25 burn kernel:  [<c026d39c>] scsi_finish_command+0x88/0x90
Dec 30 01:16:25 burn kernel:  [<c026d2cd>] scsi_softirq+0xc9/0xe0
Dec 30 01:16:25 burn kernel:  [<c011e25a>] __do_softirq+0x6a/0xd4
Dec 30 01:16:25 burn kernel:  [<c011e2ec>] do_softirq+0x28/0x30
Dec 30 01:16:25 burn kernel:  [<c01312f5>] irq_exit+0x2d/0x38
Dec 30 01:16:25 burn kernel:  [<c0110f32>] smp_apic_timer_interrupt+0xce/0xd4
Dec 30 01:16:25 burn kernel:  [<c0103730>] apic_timer_interrupt+0x1c/0x24
Dec 30 01:16:25 burn kernel:  [<c011007b>] machine_real_restart+0x7b/0xac
Dec 30 01:16:25 burn kernel:  [<c02e0c3d>] _spin_unlock_irq+0x9/0x20
Dec 30 01:16:25 burn kernel:  [<c0115559>] finish_task_switch+0x35/0x78
Dec 30 01:16:25 burn kernel:  [<c02dfe5e>] schedule+0xa4e/0xaa0
Dec 30 01:16:25 burn kernel:  [<c02e034c>] schedule_timeout+0x8c/0xb4
Dec 30 01:16:25 burn kernel:  [<c02e0354>] schedule_timeout+0x94/0xb4
Dec 30 01:16:25 burn kernel:  [<c0121cd4>] process_timeout+0x0/0xc
Dec 30 01:16:25 burn kernel:  [<c015e189>] do_select+0x295/0x2d8
Dec 30 01:16:25 burn kernel:  [<c015ddb4>] __pollwait+0x0/0x9c
Dec 30 01:16:25 burn kernel:  [<c015e52a>] sys_select+0x336/0x494
Dec 30 01:16:25 burn kernel:  [<c0102d33>] syscall_call+0x7/0xb
Dec 30 01:16:25 burn kernel: handlers:
Dec 30 01:16:25 burn kernel: [<c025eeb4>] (ide_intr+0x0/0x134)
Dec 30 01:16:25 burn kernel: [<c025eeb4>] (ide_intr+0x0/0x134)


kernel is 2.6.10.

anyone interested in tracking this down?

it goes on for several minutes, filling the logfile with thousands
of lines like that.

/herp

