Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270824AbTHQUDT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270847AbTHQUDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:03:19 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:25071 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S270824AbTHQUDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:03:10 -0400
Date: Sun, 17 Aug 2003 22:03:06 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: IDE DMA related lockup in 2.6.0-test3
Message-ID: <20030817200306.GA3904@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I'll stop reporting them after this one. As usual, after an IDE DMA
timeout the log was flodded with call traces and the system became
increasingly unresponsive. It died completely (sysrq safe) about two
minutes after the incident. Some minor filesystem corruption ensued.

I guess that's the kernel saying "Get a new disk or else...". The real
problem of course is hard disk quality (or lack thereof), but with the
typical hardware sold these days a somewhat more robust error handling
would seem beneficial.

ALi Chipset, IBM hard disk.

Roger

Aug 17 21:17:39 k3 kernel: hda: dma_timer_expiry: dma status == 0x61
Aug 17 21:17:49 k3 kernel: hda: DMA timeout error
Aug 17 21:17:49 k3 kernel: hda: dma timeout error: status=0xd0 { Busy }
Aug 17 21:17:49 k3 kernel: 
Aug 17 21:17:49 k3 kernel: hda: DMA disabled
Aug 17 21:17:49 k3 kernel: hdb: DMA disabled
Aug 17 21:17:49 k3 kernel: ide0: reset: success
Aug 17 21:17:49 k3 kernel: Call Trace:
Aug 17 21:17:49 k3 kernel:  [<c0105000>] rest_init+0x0/0x30
Aug 17 21:17:49 k3 kernel:  [<c011cce0>] schedule+0x500/0x510
Aug 17 21:17:49 k3 kernel:  [<c0107000>] default_idle+0x0/0x40
Aug 17 21:17:49 k3 kernel:  [<c0105000>] rest_init+0x0/0x30
Aug 17 21:17:49 k3 kernel:  [<c0107000>] default_idle+0x0/0x40
Aug 17 21:17:49 k3 kernel:  [<c0105000>] rest_init+0x0/0x30
Aug 17 21:17:49 k3 kernel:  [<c01070b8>] cpu_idle+0x38/0x40
Aug 17 21:17:49 k3 kernel:  [<c03766ed>] start_kernel+0x13d/0x140
Aug 17 21:17:49 k3 kernel:  [<c0376480>] unknown_bootoption+0x0/0x100
Aug 17 21:17:49 k3 kernel: 
Aug 17 21:17:52 k3 kernel: Call Trace:
Aug 17 21:17:52 k3 kernel:  [<c011f09c>] __might_sleep+0x5c/0x60
Aug 17 21:17:52 k3 kernel:  [<c01521c4>] kmem_cache_alloc+0x184/0x190
Aug 17 21:17:52 k3 kernel:  [<c011f9c9>] dup_task_struct+0x29/0xe0
Aug 17 21:17:52 k3 kernel:  [<c011f9ee>] dup_task_struct+0x4e/0xe0
Aug 17 21:17:52 k3 kernel:  [<c0120e9f>] copy_process+0x6f/0xeb0
Aug 17 21:17:52 k3 kernel:  [<c015d787>] handle_mm_fault+0x207/0x2e0
Aug 17 21:17:52 k3 kernel:  [<c011a83d>] do_page_fault+0x15d/0x4aa
Aug 17 21:17:52 k3 kernel:  [<c0121d2d>] do_fork+0x4d/0x1e0
Aug 17 21:17:52 k3 kernel:  [<c01324df>] sigprocmask+0xef/0x280
Aug 17 21:17:52 k3 kernel:  [<c013005d>] sigqueue_free+0x9d/0x190
Aug 17 21:17:52 k3 kernel:  [<c013277e>] sys_rt_sigprocmask+0x10e/0x310
Aug 17 21:17:52 k3 kernel:  [<c0107a78>] sys_fork+0x38/0x40
Aug 17 21:17:52 k3 kernel:  [<c0109f6f>] syscall_call+0x7/0xb
Aug 17 21:17:52 k3 kernel: 
Aug 17 21:17:52 k3 kernel: Call Trace:
Aug 17 21:17:52 k3 kernel:  [<c011cce0>] schedule+0x500/0x510
Aug 17 21:17:52 k3 kernel:  [<c0107a78>] sys_fork+0x38/0x40
Aug 17 21:17:52 k3 kernel:  [<c0109f96>] work_resched+0x5/0x16
Aug 17 21:17:52 k3 kernel: 
Aug 17 21:17:52 k3 kernel:  printing eip:
Aug 17 21:17:52 k3 kernel: 08074225
Aug 17 21:17:52 k3 kernel: Oops: 0007 [#1]
Aug 17 21:17:52 k3 kernel: CPU:    0
Aug 17 21:17:52 k3 kernel: EIP:    0073:[<08074225>]    Not tainted
Aug 17 21:17:52 k3 kernel: EFLAGS: 00010246
Aug 17 21:17:52 k3 kernel: EIP is at 0x8074225
Aug 17 21:17:52 k3 kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
Aug 17 21:17:52 k3 kernel: esi: bfffd870   edi: 00000000   ebp: bfffd988   esp: bfffd860
Aug 17 21:17:52 k3 kernel: ds: 007b   es: 007b   ss: 007b
Aug 17 21:17:52 k3 kernel: Process sh (pid: 25531, threadinfo=ceeb8000 task=d1301080)
Aug 17 21:17:52 k3 kernel:  <6>note: sh[25531] exited with preempt_count 1
Aug 17 21:17:52 k3 kernel: Call Trace:
Aug 17 21:17:52 k3 kernel:  [<c011cce0>] schedule+0x500/0x510
Aug 17 21:17:52 k3 kernel:  [<c015abe1>] unmap_page_range+0x41/0x70
Aug 17 21:17:52 k3 kernel:  [<c015adf0>] unmap_vmas+0x1e0/0x340
Aug 17 21:17:52 k3 kernel:  [<c0160599>] exit_mmap+0xc9/0x2a0
Aug 17 21:17:52 k3 kernel:  [<c011fd94>] mmput+0xa4/0x130
Aug 17 21:17:52 k3 kernel:  [<c0125d05>] do_exit+0x265/0x810
Aug 17 21:17:52 k3 kernel:  [<c010a89c>] die+0x1fc/0x200
Aug 17 21:17:52 k3 kernel:  [<c011a9a4>] do_page_fault+0x2c4/0x4aa
Aug 17 21:17:52 k3 kernel:  [<c011a6e0>] do_page_fault+0x0/0x4aa
Aug 17 21:17:52 k3 kernel:  [<c010a119>] error_code+0x2d/0x38
Aug 17 21:17:52 k3 kernel: 
Aug 17 21:17:52 k3 kernel:  printing eip:
Aug 17 21:17:52 k3 kernel: 080741cb
Aug 17 21:17:52 k3 kernel: Oops: 0007 [#2]
Aug 17 21:17:52 k3 kernel: CPU:    0
Aug 17 21:17:52 k3 kernel: EIP:    0073:[<080741cb>]    Not tainted
Aug 17 21:17:52 k3 kernel: EFLAGS: 00010206
Aug 17 21:17:52 k3 kernel: EIP is at 0x80741cb
Aug 17 21:17:52 k3 kernel: eax: 00001469   ebx: 000063bb   ecx: 00000000   edx: 00000000
Aug 17 21:17:52 k3 kernel: esi: bfffd870   edi: 00000000   ebp: bfffd988   esp: bfffd860
Aug 17 21:17:52 k3 kernel: ds: 007b   es: 007b   ss: 007b
Aug 17 21:17:52 k3 kernel: Process sh (pid: 24819, threadinfo=d23f2000 task=cdd060c0)
Aug 17 21:17:52 k3 kernel:  <6>note: sh[24819] exited with preempt_count 1
Aug 17 21:17:52 k3 kernel: Call Trace:
Aug 17 21:17:52 k3 kernel:  [<c011cce0>] schedule+0x500/0x510
Aug 17 21:17:52 k3 kernel:  [<c015abe1>] unmap_page_range+0x41/0x70
Aug 17 21:17:52 k3 kernel:  [<c015adf0>] unmap_vmas+0x1e0/0x340
Aug 17 21:17:52 k3 kernel:  [<c0160599>] exit_mmap+0xc9/0x2a0
Aug 17 21:17:52 k3 kernel:  [<c011fd94>] mmput+0xa4/0x130
Aug 17 21:17:52 k3 kernel:  [<c0125d05>] do_exit+0x265/0x810
Aug 17 21:17:52 k3 kernel:  [<c010a89c>] die+0x1fc/0x200
Aug 17 21:17:52 k3 kernel:  [<c011a9a4>] do_page_fault+0x2c4/0x4aa
Aug 17 21:17:52 k3 kernel:  [<c010a322>] show_trace+0x42/0x90
Aug 17 21:17:52 k3 kernel:  [<c0109f96>] work_resched+0x5/0x16
Aug 17 21:17:52 k3 kernel:  [<c011c9ce>] schedule+0x1ee/0x510
Aug 17 21:17:52 k3 kernel:  [<c0107a78>] sys_fork+0x38/0x40
Aug 17 21:17:52 k3 kernel:  [<c011a6e0>] do_page_fault+0x0/0x4aa
Aug 17 21:17:52 k3 kernel:  [<c010a119>] error_code+0x2d/0x38
Aug 17 21:17:52 k3 kernel: 
Aug 17 21:17:52 k3 kernel: Call Trace:
Aug 17 21:17:52 k3 kernel:  [<c011cce0>] schedule+0x500/0x510
Aug 17 21:17:52 k3 kernel:  [<c022a250>] blk_run_queues+0x120/0x300
Aug 17 21:17:52 k3 kernel:  [<c022bf74>] generic_make_request+0x144/0x1e0
Aug 17 21:17:52 k3 kernel:  [<c011ec3e>] io_schedule+0xe/0x20
Aug 17 21:17:52 k3 kernel:  [<c0171f9f>] __wait_on_buffer+0xcf/0xe0
Aug 17 21:17:52 k3 kernel:  [<c011f950>] autoremove_wake_function+0x0/0x50
Aug 17 21:17:52 k3 kernel:  [<c011f950>] autoremove_wake_function+0x0/0x50
Aug 17 21:17:52 k3 kernel:  [<c01742c3>] mark_buffer_dirty+0x33/0x50
Aug 17 21:17:52 k3 kernel:  [<c01ddbb4>] flush_commit_list+0x254/0x440
Aug 17 21:17:52 k3 kernel:  [<c01e23fb>] do_journal_end+0x5fb/0xc00
Aug 17 21:17:52 k3 kernel:  [<c01dd53b>] get_cnode+0x1b/0xa0
Aug 17 21:17:52 k3 kernel:  [<c01e1679>] flush_old_commits+0x139/0x1d0
Aug 17 21:17:52 k3 kernel:  [<c01cf410>] reiserfs_write_super+0x30/0x40
Aug 17 21:17:52 k3 kernel:  [<c01790ff>] sync_supers+0x1ef/0x280
Aug 17 21:17:52 k3 kernel:  [<c014e2c3>] wb_kupdate+0x63/0x160
Aug 17 21:17:52 k3 kernel:  [<c011c9ce>] schedule+0x1ee/0x510
Aug 17 21:17:52 k3 kernel:  [<c014ec8c>] __pdflush+0x21c/0x5f0
Aug 17 21:17:52 k3 kernel:  [<c014f060>] pdflush+0x0/0x20
Aug 17 21:17:52 k3 kernel:  [<c014f071>] pdflush+0x11/0x20
Aug 17 21:17:52 k3 kernel:  [<c014e260>] wb_kupdate+0x0/0x160
Aug 17 21:17:53 k3 kernel:  [<c0107229>] kernel_thread_helper+0x5/0xc
Aug 17 21:17:53 k3 kernel: 
[...]

