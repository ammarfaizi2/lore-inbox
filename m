Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268977AbUJQAZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268977AbUJQAZe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268972AbUJQAZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:25:34 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:18126 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268977AbUJQAXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:23:18 -0400
Message-ID: <4171BB22.8070105@biomail.ucsd.edu>
Date: Sat, 16 Oct 2004 17:21:54 -0700
From: John Gilbert <jgilbert@biomail.ucsd.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: High latency reports for U3
Content-Type: multipart/mixed;
 boundary="------------060105080301010105020001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060105080301010105020001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,
I've been running 2.6.9-rc4-mm1-U3 on a few machines for a day now and 
it's been solid for me.
I'm including a list of >500us latency messages, there's usually a 
handful around 20-50 us, then a big jump to 500+.
If the kernel has latencies cleaned up down to <60us max, it will be 
good enough for pixel perfect NTSC video.
If it's clean down to <8us max, it will be capable of perfect HDTV (this 
is based on landing a page flip within the vertical refresh time after 
catching a video interrupt).
Of course there's still high resolution priority levels, frame based 
deadline process scheduling, guaranteed rate IO, XFS RT sub-partitions, 
time based resource reservations, and a user-land API to take advantage 
of all this. If Ingo, Bill, and the Montavista crew keep up this pace, 
there will be guaranteed frame perfect video and 
games^H^H^H^Hsimulations under Linux by Christmas.
John Gilbert
jgilbert@biomail.ucsd.edu

--------------060105080301010105020001
Content-Type: text/plain;
 name="u3report.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="u3report.txt"

High latency results on P3-1.2GHz Linux-2.6.9-rc4-mm1-VP-U3

(wget/2874): new 561 us maximum-latency critical section.
 => started at: <schedule+0x43/0x620>
 => ended at:   <finish_task_switch+0x4e/0xa0>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0425aa2>] schedule+0x2d2/0x620
 [<c0123c40>] __mod_timer+0x170/0x240
 [<c04264df>] schedule_timeout+0x5f/0xb0
 [<c042634c>] cond_resched+0xc/0x90
 [<c01248e0>] process_timeout+0x0/0x20
 [<c0426365>] cond_resched+0x25/0x90
 [<c0171ca6>] do_select+0x286/0x2c0
 [<c0171860>] __pollwait+0x0/0xd0
 [<c0171f7d>] sys_select+0x24d/0x4e0
 [<c013150d>] __mcount+0x1d/0x20
 [<c010711e>] math_state_restore+0x2e/0x60
 [<c010539f>] syscall_call+0x7/0xb
preempt count: 1
entry 1: schedule+0x43/0x620 / (schedule_timeout+0x5f/0xb0)

(kdeinit/2700): new 558 us maximum-latency critical section.
 => started at: <__wake_up+0x2e/0x90>
 => ended at:   <__wake_up+0x5c/0x90>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c01174dc>] __wake_up+0x5c/0x90
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c01174dc>] __wake_up+0x5c/0x90
 [<c01174dc>] __wake_up+0x5c/0x90
 [<c03a8b26>] sock_def_readable+0x96/0xa0
 [<c040fcd9>] unix_stream_sendmsg+0x1c9/0x3f0
 [<c015d26e>] do_sync_write+0xae/0x100
 [<c01140b0>] mcount+0x14/0x18
 [<c03a557d>] sock_aio_write+0xfd/0x120
 [<c01306d0>] autoremove_wake_function+0x0/0x60
 [<c013150d>] __mcount+0x1d/0x20
 [<c01140b0>] mcount+0x14/0x18
 [<c015d26e>] do_sync_write+0xae/0x100
 [<c0130bfc>] _mutex_unlock+0xc/0x60
 [<c013150d>] __mcount+0x1d/0x20
 [<c013150d>] __mcount+0x1d/0x20
 [<c0130bfc>] _mutex_unlock+0xc/0x60
 [<c01306d0>] autoremove_wake_function+0x0/0x60
 [<c013150d>] __mcount+0x1d/0x20
 [<c015d2d4>] vfs_write+0x14/0x150
 [<c01140b0>] mcount+0x14/0x18
 [<c015d35c>] vfs_write+0x9c/0x150
 [<c01140b0>] mcount+0x14/0x18
 [<c015d4e0>] sys_write+0x50/0x80
 [<c010539f>] syscall_call+0x7/0xb
preempt count: 1
entry 1: __wake_up+0x2e/0x90 / (sock_def_readable+0x96/0xa0)

(netscape-bin/2736): new 706 us maximum-latency critical section.
 => started at: <do_IRQ+0x18/0xa0>
 => ended at:   <irq_exit+0x3c/0x50>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c013babc>] irq_exit+0x3c/0x50
 [<c0107362>] do_softirq+0x12/0x60
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c013babc>] irq_exit+0x3c/0x50
 [<c013babc>] irq_exit+0x3c/0x50
 [<c0107278>] do_IRQ+0x78/0xa0
 [<c0107200>] do_IRQ+0x0/0xa0
 [<c010550c>] common_interrupt+0x18/0x20
preempt count: 1
entry 1: task_rq_lock+0x1e/0x30 / (try_to_wake_up+0x2d/0xe0)

(IRQ 10/795): new 726 us maximum-latency critical section.
 => started at: <preempt_schedule+0x3e/0x80>
 => ended at:   <finish_task_switch+0x4e/0xa0>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0425aa2>] schedule+0x2d2/0x620
 [<c013150d>] __mcount+0x1d/0x20
 [<c01201c2>] __do_softirq+0x12/0xa0
 [<c013c47f>] do_irqd+0x4f/0x80
 [<c013c484>] do_irqd+0x54/0x80
 [<c0130106>] kthread+0xa6/0xf0
 [<c013c430>] do_irqd+0x0/0x80
 [<c0130060>] kthread+0x0/0xf0
 [<c0103315>] kernel_thread_helper+0x5/0x10
preempt count: 1
entry 1: task_rq_lock+0x1e/0x30 / (try_to_wake_up+0x2d/0xe0)

(ksoftirqd/0/2): new 587 us maximum-latency critical section.
 => started at: <schedule+0x43/0x620>
 => ended at:   <finish_task_switch+0x4e/0xa0>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0425aa2>] schedule+0x2d2/0x620
 [<c0120638>] ksoftirqd+0xe8/0xf0
 [<c0130106>] kthread+0xa6/0xf0
 [<c0120550>] ksoftirqd+0x0/0xf0
 [<c0130060>] kthread+0x0/0xf0
 [<c0103315>] kernel_thread_helper+0x5/0x10
preempt count: 1
entry 1: __do_IRQ+0x7c/0x1a0 / (do_IRQ+0x71/0xa0)

(X/2629): new 575 us maximum-latency critical section.
 => started at: <schedule+0x43/0x620>
 => ended at:   <finish_task_switch+0x4e/0xa0>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0425aa2>] schedule+0x2d2/0x620
 [<c013babc>] irq_exit+0x3c/0x50
 [<c01053c6>] work_resched+0x5/0x16
preempt count: 1
entry 1: schedule+0x43/0x620 / (work_resched+0x5/0x16)

(IRQ 5/1689): new 558 us maximum-latency critical section.
 => started at: <__wake_up+0x2e/0x90>
 => ended at:   <__wake_up+0x5c/0x90>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c01174dc>] __wake_up+0x5c/0x90
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c01174dc>] __wake_up+0x5c/0x90
 [<c01174dc>] __wake_up+0x5c/0x90
 [<e19eea2f>] snd_pcm_period_elapsed+0x38f/0x460 [snd_pcm]
 [<c013150d>] __mcount+0x1d/0x20
 [<c0130bfc>] _mutex_unlock+0xc/0x60
 [<e19c3f63>] snd_m3_update_ptr+0x93/0xb0 [snd_maestro3]
 [<e19c3f6b>] snd_m3_update_ptr+0x9b/0xb0 [snd_maestro3]
 [<e19c4033>] snd_m3_interrupt+0xb3/0xd0 [snd_maestro3]
 [<c013bb7f>] handle_IRQ_event+0x4f/0x90
 [<c013c389>] do_hardirq+0x89/0x130
 [<c013c475>] do_irqd+0x45/0x80
 [<c0130106>] kthread+0xa6/0xf0
 [<c013c430>] do_irqd+0x0/0x80
 [<c0130060>] kthread+0x0/0xf0
 [<c0103315>] kernel_thread_helper+0x5/0x10
preempt count: 1
entry 1: __wake_up+0x2e/0x90 / (snd_pcm_period_elapsed+0x38f/0x460 [snd_pcm])

(ksoftirqd/0/2): new 598 us maximum-latency critical section.
 => started at: <schedule+0x43/0x620>
 => ended at:   <finish_task_switch+0x4e/0xa0>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0425aa2>] schedule+0x2d2/0x620
 [<c0120638>] ksoftirqd+0xe8/0xf0
 [<c0130106>] kthread+0xa6/0xf0
 [<c0120550>] ksoftirqd+0x0/0xf0
 [<c0130060>] kthread+0x0/0xf0
 [<c0103315>] kernel_thread_helper+0x5/0x10
preempt count: 1
entry 1: schedule+0x43/0x620 / (ksoftirqd+0xe8/0xf0)

(ksoftirqd/0/2): new 576 us maximum-latency critical section.
 => started at: <preempt_schedule+0x3e/0x80>
 => ended at:   <finish_task_switch+0x4e/0xa0>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c0425aa2>] schedule+0x2d2/0x620
 [<c0120638>] ksoftirqd+0xe8/0xf0
 [<c0130106>] kthread+0xa6/0xf0
 [<c0120550>] ksoftirqd+0x0/0xf0
 [<c0130060>] kthread+0x0/0xf0
 [<c0103315>] kernel_thread_helper+0x5/0x10
preempt count: 1
entry 1: schedule+0x43/0x620 / (ksoftirqd+0xe8/0xf0)

(netscape-bin/1592): new 555 us maximum-latency critical section.
 => started at: <buffered_rmqueue+0xff/0x210>
 => ended at:   <buffered_rmqueue+0x168/0x210>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0141e78>] buffered_rmqueue+0x168/0x210
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0141e78>] buffered_rmqueue+0x168/0x210
 [<c0141e78>] buffered_rmqueue+0x168/0x210
 [<c01140b0>] mcount+0x14/0x18
 [<c0142057>] __alloc_pages+0x137/0x400
 [<c01140b0>] mcount+0x14/0x18
 [<c0142340>] __get_free_pages+0x20/0x50
 [<c01718ec>] __pollwait+0x8c/0xd0
 [<c0410a20>] unix_poll+0xc0/0xd0
 [<c03a5b0c>] sock_poll+0x2c/0x40
 [<c01722a0>] do_pollfd+0x90/0xa0
 [<c017230d>] do_poll+0x5d/0xc0
 [<c01724e3>] sys_poll+0x173/0x230
 [<c015e148>] fput+0x8/0x20
 [<c0171860>] __pollwait+0x0/0xd0
 [<c010539f>] syscall_call+0x7/0xb
preempt count: 1
entry 1: buffered_rmqueue+0xff/0x210 / (__alloc_pages+0x137/0x400)

(X/2629): new 704 us maximum-latency critical section.
 => started at: <add_wait_queue+0x2a/0x80>
 => ended at:   <add_wait_queue+0x48/0x80>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c01303b8>] add_wait_queue+0x48/0x80
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c01303b8>] add_wait_queue+0x48/0x80
 [<c01303b8>] add_wait_queue+0x48/0x80
 [<c0410a20>] unix_poll+0xc0/0xd0
 [<c03a5b0c>] sock_poll+0x2c/0x40
 [<c0171bbd>] do_select+0x19d/0x2c0
 [<c0171860>] __pollwait+0x0/0xd0
 [<c0171f7d>] sys_select+0x24d/0x4e0
 [<c029643b>] copy_to_user+0x4b/0x60
 [<c010539f>] syscall_call+0x7/0xb
preempt count: 1
entry 1: add_wait_queue+0x2a/0x80 / (unix_poll+0xc0/0xd0)

(xargs/3474): new 727 us maximum-latency critical section.
 => started at: <do_IRQ+0x18/0xa0>
 => ended at:   <irq_exit+0x3c/0x50>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c013babc>] irq_exit+0x3c/0x50
 [<c0107362>] do_softirq+0x12/0x60
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c013babc>] irq_exit+0x3c/0x50
 [<c013babc>] irq_exit+0x3c/0x50
 [<c0107278>] do_IRQ+0x78/0xa0
 [<c0107200>] do_IRQ+0x0/0xa0
 [<c010550c>] common_interrupt+0x18/0x20
 [<c0130b61>] _mutex_lock+0x11/0x40
 [<c0176fb4>] __d_lookup+0xb4/0x140
 [<c013007b>] kthread+0x1b/0xf0
 [<c0131501>] __mcount+0x11/0x20
 [<c01140b0>] mcount+0x14/0x18
 [<c0130b61>] _mutex_lock+0x11/0x40
 [<c0176fb4>] __d_lookup+0xb4/0x140
 [<c013150d>] __mcount+0x1d/0x20
 [<c016bb44>] do_lookup+0x14/0xa0
 [<c016bb5b>] do_lookup+0x2b/0xa0
 [<c016c357>] link_path_walk+0x787/0xe00
 [<c042634c>] cond_resched+0xc/0x90
 [<c016cce6>] path_lookup+0xa6/0x1d0
 [<c01698d9>] do_execve+0x19/0x210
 [<c016886d>] open_exec+0x2d/0x100
 [<c013150d>] __mcount+0x1d/0x20
 [<c042634c>] cond_resched+0xc/0x90
 [<c013150d>] __mcount+0x1d/0x20
 [<c01698ce>] do_execve+0xe/0x210
 [<c0103e17>] sys_execve+0x47/0xd0
 [<c01140b0>] mcount+0x14/0x18
 [<c01698d9>] do_execve+0x19/0x210
 [<c016b398>] getname+0x68/0x110
 [<c0103e17>] sys_execve+0x47/0xd0
 [<c010539f>] syscall_call+0x7/0xb
preempt count: 1
entry 1: task_rq_lock+0x1e/0x30 / (try_to_wake_up+0x2d/0xe0)

(swapper/0): new 571 us maximum-latency critical section.
 => started at: <schedule+0x43/0x620>
 => ended at:   <preempt_schedule+0x5c/0x80>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0425e4c>] preempt_schedule+0x5c/0x80
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0425e4c>] preempt_schedule+0x5c/0x80
 [<c0425e4c>] preempt_schedule+0x5c/0x80
 [<c010312d>] cpu_idle+0x6d/0x70
 [<c051c82c>] start_kernel+0x15c/0x180
 [<c051c3f0>] unknown_bootoption+0x0/0x190
preempt count: 0

(md5sum/24488): new 577 us maximum-latency critical section.
 => started at: <buffered_rmqueue+0xff/0x210>
 => ended at:   <buffered_rmqueue+0x168/0x210>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0141e78>] buffered_rmqueue+0x168/0x210
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0141e78>] buffered_rmqueue+0x168/0x210
 [<c0141e78>] buffered_rmqueue+0x168/0x210
 [<c0142108>] __alloc_pages+0x1e8/0x400
 [<c01455f2>] do_page_cache_readahead+0x162/0x1e0
 [<c014586e>] page_cache_readahead+0x1fe/0x230
 [<c013d8a0>] do_generic_mapping_read+0x120/0x520
 [<c01140b0>] mcount+0x14/0x18
 [<c013dead>] __generic_file_aio_read+0x11d/0x230
 [<c013dca0>] file_read_actor+0x0/0xf0
 [<c013e0dc>] generic_file_read+0xac/0xd0
 [<c014fe5e>] do_mmap_pgoff+0x49e/0x750
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c01306d0>] autoremove_wake_function+0x0/0x60
 [<c015d084>] vfs_read+0x14/0x150
 [<c015d460>] sys_read+0x50/0x80
 [<c01140b0>] mcount+0x14/0x18
 [<c015d178>] vfs_read+0x108/0x150
 [<c01140b0>] mcount+0x14/0x18
 [<c015d460>] sys_read+0x50/0x80
 [<c010539f>] syscall_call+0x7/0xb
preempt count: 1
entry 1: task_rq_lock+0x1e/0x30 / (try_to_wake_up+0x2d/0xe0)

(bunzip2/16626): new 710 us maximum-latency critical section.
 => started at: <buffered_rmqueue+0xff/0x210>
 => ended at:   <buffered_rmqueue+0x168/0x210>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0141e78>] buffered_rmqueue+0x168/0x210
 [<c0142057>] __alloc_pages+0x137/0x400
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0141e78>] buffered_rmqueue+0x168/0x210
 [<c0141e78>] buffered_rmqueue+0x168/0x210
 [<c01140b0>] mcount+0x14/0x18
 [<c0142057>] __alloc_pages+0x137/0x400
 [<c01455f2>] do_page_cache_readahead+0x162/0x1e0
 [<c014586e>] page_cache_readahead+0x1fe/0x230
 [<c013d8a0>] do_generic_mapping_read+0x120/0x520
 [<c01140b0>] mcount+0x14/0x18
 [<c013dead>] __generic_file_aio_read+0x11d/0x230
 [<c013dca0>] file_read_actor+0x0/0xf0
 [<c013e0dc>] generic_file_read+0xac/0xd0
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0116d5e>] finish_task_switch+0x4e/0xa0
 [<c01306d0>] autoremove_wake_function+0x0/0x60
 [<c015d084>] vfs_read+0x14/0x150
 [<c015d460>] sys_read+0x50/0x80
 [<c01140b0>] mcount+0x14/0x18
 [<c015d178>] vfs_read+0x108/0x150
 [<c01140b0>] mcount+0x14/0x18
 [<c015d460>] sys_read+0x50/0x80
 [<c010539f>] syscall_call+0x7/0xb
preempt count: 1
entry 1: task_rq_lock+0x1e/0x30 / (try_to_wake_up+0x2d/0xe0)

(X/2629): new 572 us maximum-latency critical section.
 => started at: <do_IRQ+0x18/0xa0>
 => ended at:   <irq_exit+0x3c/0x50>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c013babc>] irq_exit+0x3c/0x50
 [<c0107362>] do_softirq+0x12/0x60
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c013babc>] irq_exit+0x3c/0x50
 [<c013babc>] irq_exit+0x3c/0x50
 [<c0107278>] do_IRQ+0x78/0xa0
 [<c0107200>] do_IRQ+0x0/0xa0
 [<c010550c>] common_interrupt+0x18/0x20
preempt count: 1
entry 1: task_rq_lock+0x1e/0x30 / (try_to_wake_up+0x2d/0xe0)

(X/2629): new 707 us maximum-latency critical section.
 => started at: <__mod_timer+0x45/0x240>
 => ended at:   <__mod_timer+0x170/0x240>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0123c40>] __mod_timer+0x170/0x240
 [<c01239f2>] internal_add_timer+0x12/0xf0
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0123c40>] __mod_timer+0x170/0x240
 [<c0123c40>] __mod_timer+0x170/0x240
 [<c04264da>] schedule_timeout+0x5a/0xb0
 [<c042634c>] cond_resched+0xc/0x90
 [<c01248e0>] process_timeout+0x0/0x20
 [<c0426365>] cond_resched+0x25/0x90
 [<c0171ca6>] do_select+0x286/0x2c0
 [<c0171860>] __pollwait+0x0/0xd0
 [<c0171f7d>] sys_select+0x24d/0x4e0
 [<c029643b>] copy_to_user+0x4b/0x60
 [<c010539f>] syscall_call+0x7/0xb
preempt count: 1
entry 1: __mod_timer+0x45/0x240 / (schedule_timeout+0x5a/0xb0)

(btdownloadcurse/27525): new 560 us maximum-latency critical section.
 => started at: <remove_wait_queue+0x1e/0x90>
 => ended at:   <remove_wait_queue+0x51/0x90>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c01304c1>] remove_wait_queue+0x51/0x90
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c01304c1>] remove_wait_queue+0x51/0x90
 [<c01304c1>] remove_wait_queue+0x51/0x90
 [<c017183e>] poll_freewait+0x3e/0x60
 [<c0172580>] sys_poll+0x210/0x230
 [<c0171860>] __pollwait+0x0/0xd0
 [<c010539f>] syscall_call+0x7/0xb
preempt count: 1
entry 1: remove_wait_queue+0x1e/0x90 / (poll_freewait+0x3e/0x60)

(IRQ 10/795): new 571 us maximum-latency critical section.
 => started at: <do_IRQ+0x18/0xa0>
 => ended at:   <irq_exit+0x3c/0x50>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c013babc>] irq_exit+0x3c/0x50
 [<c0107362>] do_softirq+0x12/0x60
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c013babc>] irq_exit+0x3c/0x50
 [<c013babc>] irq_exit+0x3c/0x50
 [<c0107278>] do_IRQ+0x78/0xa0
 [<c0107200>] do_IRQ+0x0/0xa0
 [<c010550c>] common_interrupt+0x18/0x20
 [<c037c070>] hcd_submit_urb+0x0/0x1b0
 [<c037007b>] ide_cdrom_setup+0x15b/0x490
 [<c01314f0>] __mcount+0x0/0x20
 [<c01140b0>] mcount+0x14/0x18
 [<c037c070>] hcd_submit_urb+0x0/0x1b0
 [<c03772cc>] usb_get_dev+0xc/0x30
 [<c037c117>] hcd_submit_urb+0xa7/0x1b0
 [<e1a8ea9e>] snd_complete_sync_urb+0xae/0x110 [snd_usb_audio]
 [<c037c749>] usb_hcd_giveback_urb+0x29/0x60
 [<c038a29d>] uhci_finish_urb+0x4d/0x70
 [<c038a318>] uhci_finish_completion+0x58/0x70
 [<c038a496>] uhci_irq+0x106/0x200
 [<c037c7c3>] usb_hcd_irq+0x43/0x80
 [<c013bb7f>] handle_IRQ_event+0x4f/0x90
 [<c013c389>] do_hardirq+0x89/0x130
 [<c013c475>] do_irqd+0x45/0x80
 [<c0130106>] kthread+0xa6/0xf0
 [<c013c430>] do_irqd+0x0/0x80
 [<c0130060>] kthread+0x0/0xf0
 [<c0103315>] kernel_thread_helper+0x5/0x10
preempt count: 1
entry 1: task_rq_lock+0x1e/0x30 / (try_to_wake_up+0x2d/0xe0)

(swapper/0): new 557 us maximum-latency critical section.
 => started at: <schedule+0x43/0x620>
 => ended at:   <preempt_schedule+0x5c/0x80>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c0425e4c>] preempt_schedule+0x5c/0x80
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0425e4c>] preempt_schedule+0x5c/0x80
 [<c0425e4c>] preempt_schedule+0x5c/0x80
 [<c010312d>] cpu_idle+0x6d/0x70
 [<c051c82c>] start_kernel+0x15c/0x180
 [<c051c3f0>] unknown_bootoption+0x0/0x190
preempt count: 0

(vi/27823): new 713 us maximum-latency critical section.
 => started at: <__wake_up+0x2e/0x90>
 => ended at:   <__wake_up+0x5c/0x90>
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c0131c90>] check_preempt_timing+0x160/0x200
 [<c01174dc>] __wake_up+0x5c/0x90
 [<c01140b0>] mcount+0x14/0x18
 [<c0131f1f>] sub_preempt_count+0x5f/0x90
 [<c01174dc>] __wake_up+0x5c/0x90
 [<c01174dc>] __wake_up+0x5c/0x90
 [<c02f3e4b>] tty_ldisc_deref+0x8b/0xc0
 [<c02f65ad>] tty_poll+0x8d/0xe0
 [<c0171bbd>] do_select+0x19d/0x2c0
 [<c0171860>] __pollwait+0x0/0xd0
 [<c0171f7d>] sys_select+0x24d/0x4e0
 [<c0425aa2>] schedule+0x2d2/0x620
 [<c010539f>] syscall_call+0x7/0xb
preempt count: 1
entry 1: __wake_up+0x2e/0x90 / (tty_ldisc_deref+0x8b/0xc0)

--------------060105080301010105020001--
