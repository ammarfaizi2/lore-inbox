Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUGFJe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUGFJe6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 05:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUGFJe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 05:34:58 -0400
Received: from math.ut.ee ([193.40.5.125]:64511 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S263741AbUGFJez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 05:34:55 -0400
Date: Tue, 6 Jul 2004 12:34:53 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.7+BK bad: scheduling while atomic! (ALSA?)
Message-ID: <Pine.GSO.4.44.0407061231580.25111-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running alsamixergui -c 2, I got alsamixergui killed with SEGV and
the following in dmesg. Additionally, mplayer has big problems playing
through ALSA with messages
alsa-space: xrun of at least 30,716 msecs. resetting stream 0,0% 0 0 90%
and I haven't yet found the place where to turn on xrun debugging.

x86 UP PREEMPT.

bad: scheduling while atomic!
 [<c02989a3>] schedule+0x463/0x470
 [<c014a984>] vfs_write+0xe4/0x120
 [<c014aa58>] sys_write+0x38/0x60
 [<c0103eee>] work_resched+0x5/0x16
bad: scheduling while atomic!
 [<c02989a3>] schedule+0x463/0x470
 [<c0113aa4>] do_page_fault+0x104/0x4ff
 [<c023e91f>] __kfree_skb+0xaf/0x140
 [<c011635f>] sys_sched_yield+0x3f/0x50
 [<c0155621>] coredump_wait+0x31/0xa0
 [<c0155783>] do_coredump+0xf3/0x1b1
 [<c01e405c>] pty_write+0x10c/0x110
 [<c0114f5b>] recalc_task_prio+0x8b/0x180
 [<c01139a0>] do_page_fault+0x0/0x4ff
 [<c01048d1>] error_code+0x2d/0x38
 [<c0120ed6>] __dequeue_signal+0xc6/0x160
 [<c0120f93>] dequeue_signal+0x23/0x80
 [<c012284b>] get_signal_to_deliver+0x24b/0x330
 [<c0103c85>] do_signal+0x85/0x100
 [<c012787c>] __kernel_text_address+0x1c/0x30
 [<c0104b03>] print_context_stack+0x23/0x60
 [<c0103eee>] work_resched+0x5/0x16
 [<c0114f5b>] recalc_task_prio+0x8b/0x180
 [<c0104b83>] show_trace+0x43/0x80
 [<c02987b8>] schedule+0x278/0x470
 [<c014a984>] vfs_write+0xe4/0x120
 [<c01139a0>] do_page_fault+0x0/0x4ff
 [<c0103d35>] do_notify_resume+0x35/0x38
 [<c0103f12>] work_notifysig+0x13/0x15
note: alsamixergui[3027] exited with preempt_count 1
bad: scheduling while atomic!
 [<c02989a3>] schedule+0x463/0x470
 [<c013c21f>] zap_pmd_range+0x3f/0x60
 [<c0115186>] try_to_wake_up+0x96/0xb0
 [<c013c27d>] unmap_page_range+0x3d/0x70
 [<c013c46e>] unmap_vmas+0x1be/0x1f0
 [<c0140087>] exit_mmap+0x77/0x150
 [<c0116e55>] mmput+0x55/0x70
 [<c011ad23>] do_exit+0x143/0x3e0
 [<c011b052>] do_group_exit+0x32/0xa0
 [<c0122839>] get_signal_to_deliver+0x239/0x330
 [<c0103c85>] do_signal+0x85/0x100
 [<c012787c>] __kernel_text_address+0x1c/0x30
 [<c0104b03>] print_context_stack+0x23/0x60
 [<c0103eee>] work_resched+0x5/0x16
 [<c0114f5b>] recalc_task_prio+0x8b/0x180
 [<c0104b83>] show_trace+0x43/0x80
 [<c02987b8>] schedule+0x278/0x470
 [<c014a984>] vfs_write+0xe4/0x120
 [<c01139a0>] do_page_fault+0x0/0x4ff
 [<c0103d35>] do_notify_resume+0x35/0x38
 [<c0103f12>] work_notifysig+0x13/0x15

-- 
Meelis Roos (mroos@linux.ee)

