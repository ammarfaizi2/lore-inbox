Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUC2INp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUC2INo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:13:44 -0500
Received: from relay01.kbs.net.au ([203.220.32.149]:19917 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S262744AbUC2IL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:11:29 -0500
Message-ID: <20a401c41565$6dca6f40$cf01a8c0@internal.kbs.net.au>
From: "Paul" <paul@kbs.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.2 - kernel BUG at fs/jbd/journal.c:1784
Date: Mon, 29 Mar 2004 18:11:23 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

We have a box running 2.6.2 which killed itself one night and dumped the
below logs to syslog. I did some searching and found some issues mentioned
with 2.5.x but nothing in regards to 2.6.2
Have you guys seen this type of error/bug/crash before? Below is the full
dump from syslog. I will try 2.6.4 latest stable but would like to know of
any known issues/bugs before I try that.

Any help/ideas/feedback would be great, or even if its a newly found bug or
something? The server idles for most of the day and has some data copied to
it via samba at night via cron.
Hope this is the right place to post this type of stuff. When it experienced
the server wouldn't respond to ssh/ftp etc but it was pingable for some
time, just no one could login or anything so a forced reboot was done.

Mar 26 17:11:28 obb01 kernel: Assertion failure in
journal_put_journal_head() at fs/jbd/journal.c:1784: "jh->b_jcount > 0"
Mar 26 17:11:28 obb01 kernel: ------------[ cut here ]------------
Mar 26 17:11:28 obb01 kernel: kernel BUG at fs/jbd/journal.c:1784!
Mar 26 17:11:28 obb01 kernel: invalid operand: 0000 [#1]
Mar 26 17:11:28 obb01 kernel: CPU:    0
Mar 26 17:11:28 obb01 kernel: EIP:    0060:[<c019a60f>]    Not tainted
Mar 26 17:11:28 obb01 kernel: EFLAGS: 00010286
Mar 26 17:11:28 obb01 kernel: EIP is at journal_put_journal_head+0xa1/0xb1
Mar 26 17:11:28 obb01 kernel: eax: 00000060   ebx: f78aaac0   ecx: c1bdb2e0
edx: c0329398
Mar 26 17:11:28 obb01 kernel: esi: f78aaac0   edi: c1bd6000   ebp: c1975388
esp: c1bd7cf8
Mar 26 17:11:28 obb01 kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 17:11:28 obb01 kernel: Process kswapd0 (pid: 7, threadinfo=c1bd6000
task=c1bdb2e0)
Mar 26 17:11:28 obb01 kernel: Stack: c02f41c0 c02e2575 c02f18c8 000006f8
c02f19e0 f78aaa98 f78aaac0 c0194650
Mar 26 17:11:28 obb01 kernel:        f78aaac0 f78aaa98 f63e71c8 f794d38c
f794d424 00000000 c1414ce0 f7cdcc80
Mar 26 17:11:28 obb01 kernel:        c1bd7e64 f78aaa98 c01870dc f7cdcc80
c1414ce0 000000d0 f78aaa98 00000000
Mar 26 17:11:28 obb01 kernel: Call Trace:
Mar 26 17:11:28 obb01 kernel:  [<c0194650>]
journal_try_to_free_buffers+0x6a/0xef
Mar 26 17:11:28 obb01 kernel:  [<c01870dc>] ext3_releasepage+0x43/0x7a
Mar 26 17:11:28 obb01 kernel:  [<c014f67d>] try_to_release_page+0x5c/0x6c
Mar 26 17:11:28 obb01 kernel:  [<c013a6a0>] shrink_list+0x4bf/0x5cf
Mar 26 17:11:28 obb01 kernel:  [<c01091d8>] common_interrupt+0x18/0x20
Mar 26 17:11:28 obb01 kernel:  [<c013a959>] shrink_cache+0x1a9/0x335
Mar 26 17:11:28 obb01 kernel:  [<c010aca9>] do_IRQ+0x10d/0x140
Mar 26 17:11:28 obb01 kernel:  [<c01091d8>] common_interrupt+0x18/0x20
...skipping...
Mar 26 18:26:24 obb01 kernel:  [<c0299a59>] ip_queue_xmit+0x506/0x601
Mar 26 17:11:28 obb01 kernel: Assertion failure in
journal_put_journal_head() at fs/jbd/journal.c:1784: "jh->b_jcount > 0"
Mar 26 17:11:28 obb01 kernel: ------------[ cut here ]------------44
Mar 26 17:11:28 obb01 kernel: kernel BUG at fs/jbd/journal.c:1784!
Mar 26 17:11:28 obb01 kernel: invalid operand: 0000 [#1]
Mar 26 17:11:28 obb01 kernel: CPU:    0
Mar 26 17:11:28 obb01 kernel: EIP:    0060:[<c019a60f>]    Not tainted
Mar 26 17:11:28 obb01 kernel: EFLAGS: 00010286
Mar 26 17:11:28 obb01 kernel: EIP is at journal_put_journal_head+0xa1/0xb1
Mar 26 17:11:28 obb01 kernel: eax: 00000060   ebx: f78aaac0   ecx: c1bdb2e0
edx: c0329398
Mar 26 17:11:28 obb01 kernel: esi: f78aaac0   edi: c1bd6000   ebp: c1975388
esp: c1bd7cf8
Mar 26 17:11:28 obb01 kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 17:11:28 obb01 kernel: Process kswapd0 (pid: 7, threadinfo=c1bd6000
task=c1bdb2e0)
Mar 26 17:11:28 obb01 kernel: Stack: c02f41c0 c02e2575 c02f18c8 000006f8
c02f19e0 f78aaa98 f78aaac0 c0194650
Mar 26 17:11:28 obb01 kernel:        f78aaac0 f78aaa98 f63e71c8 f794d38c
f794d424 00000000 c1414ce0 f7cdcc80
Mar 26 17:11:28 obb01 kernel:        c1bd7e64 f78aaa98 c01870dc f7cdcc80
c1414ce0 000000d0 f78aaa98 00000000
Mar 26 17:11:28 obb01 kernel: Call Trace:
Mar 26 17:11:28 obb01 kernel:  [<c0194650>]
journal_try_to_free_buffers+0x6a/0xef
Mar 26 17:11:28 obb01 kernel:  [<c01870dc>] ext3_releasepage+0x43/0x7a
Mar 26 17:11:28 obb01 kernel:  [<c014f67d>] try_to_release_page+0x5c/0x6c
Mar 26 17:11:28 obb01 kernel:  [<c013a6a0>] shrink_list+0x4bf/0x5cf
Mar 26 17:11:28 obb01 kernel:  [<c01091d8>] common_interrupt+0x18/0x20
Mar 26 17:11:28 obb01 kernel:  [<c013a959>] shrink_cache+0x1a9/0x335
Mar 26 17:11:28 obb01 kernel:  [<c010aca9>] do_IRQ+0x10d/0x140
Mar 26 17:11:28 obb01 kernel:  [<c01091d8>] common_interrupt+0x18/0x20
Mar 26 17:11:28 obb01 kernel:  [<c013b4bf>] balance_pgdat+0x178/0x1f0
Mar 26 17:11:28 obb01 kernel:  [<c013b656>] kswapd+0x11f/0x121
Mar 26 17:11:28 obb01 kernel:  [<c01180de>]
autoremove_wake_function+0x0/0x4f
Mar 26 17:11:28 obb01 kernel:  [<c0108f42>] ret_from_fork+0x6/0x14
Mar 26 17:11:28 obb01 kernel:  [<c01180de>]
autoremove_wake_function+0x0/0x4f
Mar 26 17:11:28 obb01 kernel:  [<c013b537>] kswapd+0x0/0x121
Mar 26 17:11:28 obb01 kernel:  [<c0106f59>] kernel_thread_helper+0x5/0xb
Mar 26 17:11:28 obb01 kernel:
Mar 26 17:11:28 obb01 kernel: Code: 0f 0b f8 06 c8 18 2f c0 8b 43 04 e9 72
ff ff ff 83 ec 04 a1
Mar 26 17:11:28 obb01 kernel:  <6>note: kswapd0[7] exited with preempt_count
2
Mar 26 17:11:28 obb01 kernel: Debug: sleeping function called from invalid
context at include/linux/rwsem.h:43
Mar 26 17:11:28 obb01 kernel: in_atomic():1, irqs_disabled():0
Mar 26 17:11:28 obb01 kernel: Call Trace:
Mar 26 17:11:28 obb01 kernel:  [<c0117d10>] __might_sleep+0xab/0xcb
Mar 26 17:11:28 obb01 kernel:  [<c011abb8>] profile_exit_task+0x20/0x5e
Mar 26 17:11:28 obb01 kernel:  [<c011c43a>] do_exit+0x7a/0x3a6
Mar 26 17:11:28 obb01 kernel:  [<c0109bad>] do_invalid_op+0x0/0xcb
Mar 26 17:11:28 obb01 kernel:  [<c010986c>] do_divide_error+0x0/0xfb
Mar 26 17:11:28 obb01 kernel:  [<c0109c76>] do_invalid_op+0xc9/0xcb
Mar 26 17:11:28 obb01 kernel:  [<c019a60f>]
journal_put_journal_head+0xa1/0xb1
Mar 26 17:11:28 obb01 kernel:  [<c01169b4>] __wake_up_common+0x31/0x50
Mar 26 17:11:28 obb01 kernel:  [<c0109215>] error_code+0x2d/0x38
Mar 26 17:11:28 obb01 kernel:  [<c019a60f>]
journal_put_journal_head+0xa1/0xb1
Mar 26 17:11:28 obb01 kernel:  [<c0194650>]
journal_try_to_free_buffers+0x6a/0xef
Mar 26 17:11:28 obb01 kernel:  [<c01870dc>] ext3_releasepage+0x43/0x7a
Mar 26 17:11:28 obb01 kernel:  [<c014f67d>] try_to_release_page+0x5c/0x6c
Mar 26 17:11:28 obb01 kernel:  [<c013a6a0>] shrink_list+0x4bf/0x5cf
Mar 26 17:11:28 obb01 kernel:  [<c01091d8>] common_interrupt+0x18/0x20
Mar 26 17:11:28 obb01 kernel:  [<c013a959>] shrink_cache+0x1a9/0x335
Mar 26 17:11:28 obb01 kernel:  [<c010aca9>] do_IRQ+0x10d/0x140
Mar 26 17:11:28 obb01 kernel:  [<c01091d8>] common_interrupt+0x18/0x20
Mar 26 17:11:28 obb01 kernel:  [<c013b4bf>] balance_pgdat+0x178/0x1f0
Mar 26 17:11:28 obb01 kernel:  [<c013b656>] kswapd+0x11f/0x121
Mar 26 17:11:28 obb01 kernel:  [<c01180de>]
autoremove_wake_function+0x0/0x4f
Mar 26 17:11:28 obb01 kernel:  [<c0108f42>] ret_from_fork+0x6/0x14
Mar 26 17:11:28 obb01 kernel:  [<c01180de>]
autoremove_wake_function+0x0/0x4f
Mar 26 17:11:28 obb01 kernel:  [<c013b537>] kswapd+0x0/0x121
Mar 26 17:11:28 obb01 kernel:  [<c0106f59>] kernel_thread_helper+0x5/0xb
Mar 26 17:11:28 obb01 kernel:
Mar 26 18:26:08 obb01 kernel: Unable to handle kernel paging request at
virtual address 006b0430
Mar 26 18:26:08 obb01 kernel:  printing eip:
Mar 26 18:26:08 obb01 kernel: c013abaa
Mar 26 18:26:08 obb01 kernel: *pde = 00000000
Mar 26 18:26:08 obb01 kernel: Oops: 0002 [#2]
Mar 26 18:26:08 obb01 kernel: CPU:    0
Mar 26 18:26:08 obb01 kernel: EIP:    0060:[<c013abaa>]    Not tainted
Mar 26 18:26:08 obb01 kernel: EFLAGS: 00010086
Mar 26 18:26:08 obb01 kernel: EIP is at refill_inactive_zone+0xc5/0x58d
Mar 26 18:26:08 obb01 kernel: eax: c032bcc4   ebx: c032bcc4   ecx: c1414d20
edx: 006b0430
Mar 26 18:26:08 obb01 kernel: esi: c1414d08   edi: 00000010   ebp: 00000005
esp: c40afc48
Mar 26 18:26:08 obb01 kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 18:26:08 obb01 kernel: Process nrpe (pid: 8951, threadinfo=c40ae000
task=e3a83900)
Mar 26 18:26:08 obb01 kernel: Stack: f7c7d780 c02d2d00 c032bcc4 00000000
00000000 00000000 00000012 00000000
Mar 26 18:26:08 obb01 kernel:        c40afc68 c40afc68 c40afc70 c40afc70
c14d1e70 c17a1ba0 1000a8c0 00000000
Mar 26 18:26:08 obb01 kernel:        00000006 00000000 00000006 00000000
c02969d2 f7c7d780 00000000 c02968e2
Mar 26 18:26:08 obb01 kernel: Call Trace:
Mar 26 18:26:08 obb01 kernel:  [<c02d2d00>] ip_fw_check+0x51a/0x7c3
Mar 26 18:26:08 obb01 kernel:  [<c02969d2>]
ip_local_deliver_finish+0xf0/0x166
Mar 26 18:26:08 obb01 kernel:  [<c02968e2>]
ip_local_deliver_finish+0x0/0x166
Mar 26 18:26:08 obb01 kernel:  [<c028e830>] nf_hook_slow+0x11b/0x19f
Mar 26 18:26:08 obb01 kernel:  [<c013b11d>] shrink_zone+0xab/0xad
Mar 26 18:26:08 obb01 kernel:  [<c0296698>] ip_local_deliver+0x59/0x5d
Mar 26 18:26:08 obb01 kernel:  [<c013b1cf>] shrink_caches+0xb0/0xc6
Mar 26 18:26:08 obb01 kernel:  [<c013b284>] try_to_free_pages+0x9f/0x162
Mar 26 18:26:08 obb01 kernel:  [<c0134e6b>] __alloc_pages+0x1f2/0x365
Mar 26 18:26:08 obb01 kernel:  [<c01143cd>] pte_alloc_one+0x22/0x67
Mar 26 18:26:08 obb01 kernel:  [<c013cb12>] pte_alloc_map+0x39/0xb8
Mar 26 18:26:08 obb01 kernel:  [<c013cd65>] copy_page_range+0x10a/0x395
Mar 26 18:26:08 obb01 kernel:  [<c0118834>] copy_mm+0x379/0x46b
Mar 26 18:26:08 obb01 kernel:  [<c01191d6>] copy_process+0x413/0x97f
Mar 26 18:26:08 obb01 kernel:  [<c0119792>] do_fork+0x50/0x183
Mar 26 18:26:08 obb01 kernel:  [<c0107806>] sys_fork+0x37/0x3b
Mar 26 18:26:08 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 18:26:08 obb01 kernel:
Mar 26 18:26:08 obb01 kernel: Code: 89 02 c7 41 04 00 02 20 00 c7 01 00 01
10 00 8b 46 04 85 c0
Mar 26 18:26:08 obb01 kernel:  <6>note: nrpe[8951] exited with preempt_count
1
Mar 26 18:26:08 obb01 kernel: Debug: sleeping function called from invalid
context at include/linux/rwsem.h:43
Mar 26 18:26:08 obb01 kernel: in_atomic():1, irqs_disabled():0
Mar 26 18:26:08 obb01 kernel: Call Trace:
Mar 26 18:26:08 obb01 kernel:  [<c0117d10>] __might_sleep+0xab/0xcb
Mar 26 18:26:08 obb01 kernel:  [<c011abb8>] profile_exit_task+0x20/0x5e
Mar 26 18:26:08 obb01 kernel:  [<c011c43a>] do_exit+0x7a/0x3a6
Mar 26 18:26:08 obb01 kernel:  [<c010986c>] do_divide_error+0x0/0xfb
Mar 26 18:26:08 obb01 kernel:  [<c01149f2>] do_page_fault+0x1f8/0x532
Mar 26 18:26:08 obb01 kernel:  [<c027f2da>] sock_def_readable+0x82/0x84
Mar 26 18:26:08 obb01 kernel:  [<c0121bab>] __mod_timer+0x102/0x177
Mar 26 18:26:08 obb01 kernel:  [<c02ac6ab>] tcp_send_delayed_ack+0xc3/0xde
Mar 26 18:26:08 obb01 kernel:  [<c01147fa>] do_page_fault+0x0/0x532
Mar 26 18:26:08 obb01 kernel:  [<c0109215>] error_code+0x2d/0x38
Mar 26 18:26:08 obb01 kernel:  [<c013abaa>] refill_inactive_zone+0xc5/0x58d
Mar 26 18:26:08 obb01 kernel:  [<c02d2d00>] ip_fw_check+0x51a/0x7c3
Mar 26 18:26:08 obb01 kernel:  [<c02969d2>]
ip_local_deliver_finish+0xf0/0x166
Mar 26 18:26:08 obb01 kernel:  [<c02968e2>]
ip_local_deliver_finish+0x0/0x166
Mar 26 18:26:08 obb01 kernel:  [<c028e830>] nf_hook_slow+0x11b/0x19f
Mar 26 18:26:08 obb01 kernel:  [<c013b11d>] shrink_zone+0xab/0xad
Mar 26 18:26:08 obb01 kernel:  [<c0296698>] ip_local_deliver+0x59/0x5d
Mar 26 18:26:08 obb01 kernel:  [<c013b1cf>] shrink_caches+0xb0/0xc6
Mar 26 18:26:08 obb01 kernel:  [<c013b284>] try_to_free_pages+0x9f/0x162
Mar 26 18:26:08 obb01 kernel:  [<c0134e6b>] __alloc_pages+0x1f2/0x365
Mar 26 18:26:08 obb01 kernel:  [<c01143cd>] pte_alloc_one+0x22/0x67
Mar 26 18:26:08 obb01 kernel:  [<c013cb12>] pte_alloc_map+0x39/0xb8
Mar 26 18:26:08 obb01 kernel:  [<c013cd65>] copy_page_range+0x10a/0x395
Mar 26 18:26:08 obb01 kernel:  [<c0118834>] copy_mm+0x379/0x46b
Mar 26 18:26:08 obb01 kernel:  [<c01191d6>] copy_process+0x413/0x97f
Mar 26 18:26:08 obb01 kernel:  [<c0119792>] do_fork+0x50/0x183
Mar 26 18:26:08 obb01 kernel:  [<c0107806>] sys_fork+0x37/0x3b
Mar 26 18:26:08 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 18:26:08 obb01 kernel:
Mar 26 18:26:08 obb01 kernel: bad: scheduling while atomic!
Mar 26 18:26:08 obb01 kernel: Call Trace:
Mar 26 18:26:08 obb01 kernel:  [<c011691c>] schedule+0x59b/0x5a0
Mar 26 18:26:08 obb01 kernel:  [<c0109426>] show_trace+0x46/0x92
Mar 26 18:26:08 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 18:26:08 obb01 kernel:  [<c01f53cc>]
rwsem_down_read_failed+0x8c/0x12e
Mar 26 18:26:08 obb01 kernel:  [<c011d018>] .text.lock.exit+0x6b/0xcb
Mar 26 18:26:08 obb01 kernel:  [<c010986c>] do_divide_error+0x0/0xfb
Mar 26 18:26:08 obb01 kernel:  [<c01149f2>] do_page_fault+0x1f8/0x532
Mar 26 18:26:08 obb01 kernel:  [<c027f2da>] sock_def_readable+0x82/0x84
Mar 26 18:26:08 obb01 kernel:  [<c0121bab>] __mod_timer+0x102/0x177
Mar 26 18:26:08 obb01 kernel:  [<c02ac6ab>] tcp_send_delayed_ack+0xc3/0xde
Mar 26 18:26:08 obb01 kernel:  [<c01147fa>] do_page_fault+0x0/0x532
Mar 26 18:26:08 obb01 kernel:  [<c0109215>] error_code+0x2d/0x38
Mar 26 18:26:08 obb01 kernel:  [<c013abaa>] refill_inactive_zone+0xc5/0x58d
Mar 26 18:26:08 obb01 kernel:  [<c02d2d00>] ip_fw_check+0x51a/0x7c3
Mar 26 18:26:08 obb01 kernel:  [<c02969d2>]
ip_local_deliver_finish+0xf0/0x166
Mar 26 18:26:08 obb01 kernel:  [<c02968e2>]
ip_local_deliver_finish+0x0/0x166
Mar 26 18:26:08 obb01 kernel:  [<c028e830>] nf_hook_slow+0x11b/0x19f
Mar 26 18:26:08 obb01 kernel:  [<c013b11d>] shrink_zone+0xab/0xad
Mar 26 18:26:08 obb01 kernel:  [<c0296698>] ip_local_deliver+0x59/0x5d
Mar 26 18:26:08 obb01 kernel:  [<c013b1cf>] shrink_caches+0xb0/0xc6
Mar 26 18:26:08 obb01 kernel:  [<c013b284>] try_to_free_pages+0x9f/0x162
Mar 26 18:26:08 obb01 kernel:  [<c0134e6b>] __alloc_pages+0x1f2/0x365
Mar 26 18:26:08 obb01 kernel:  [<c01143cd>] pte_alloc_one+0x22/0x67
Mar 26 18:26:08 obb01 kernel:  [<c013cb12>] pte_alloc_map+0x39/0xb8
Mar 26 18:26:08 obb01 kernel:  [<c013cd65>] copy_page_range+0x10a/0x395
Mar 26 18:26:08 obb01 kernel:  [<c0118834>] copy_mm+0x379/0x46b
Mar 26 18:26:08 obb01 kernel:  [<c01191d6>] copy_process+0x413/0x97f
Mar 26 18:26:08 obb01 kernel:  [<c0119792>] do_fork+0x50/0x183
Mar 26 18:26:08 obb01 kernel:  [<c0107806>] sys_fork+0x37/0x3b
Mar 26 18:26:08 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 18:26:08 obb01 kernel:
Mar 26 18:26:24 obb01 kernel: Unable to handle kernel paging request at
virtual address 006b0434
Mar 26 18:26:24 obb01 kernel:  printing eip:
Mar 26 18:26:24 obb01 kernel: c013ab82
Mar 26 18:26:24 obb01 kernel: *pde = 00000000
Mar 26 18:26:24 obb01 kernel: Oops: 0000 [#3]
Mar 26 18:26:24 obb01 kernel: CPU:    0
Mar 26 18:26:24 obb01 kernel: EIP:    0060:[<c013ab82>]    Not tainted
Mar 26 18:26:24 obb01 kernel: EFLAGS: 00010006
Mar 26 18:26:24 obb01 kernel: EIP is at refill_inactive_zone+0x9d/0x58d
Mar 26 18:26:24 obb01 kernel: eax: c032bcb4   ebx: c032bcc4   ecx: 006b0430
edx: c032bcc4
Mar 26 18:26:24 obb01 kernel: esi: 006b0418   edi: 00000000   ebp: 00000005
esp: f4893c8c
Mar 26 18:26:24 obb01 kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 18:26:24 obb01 kernel: Process smbd (pid: 6020, threadinfo=f4892000
task=f77d66a0)
Mar 26 18:26:24 obb01 kernel: Stack: c0284092 c1b82980 c032bcc4 c1b40240
04000001 00000000 00000022 00000000
Mar 26 18:26:24 obb01 kernel:        f4893cac f4893cac f4893cb4 f4893cb4
f4893cbc f4893cbc c036a000 c010aca9
Mar 26 18:26:24 obb01 kernel:        0000000c c036a000 00000001 c1b40240
c032bcb4 00000020 f4893d80 00000040
Mar 26 18:26:24 obb01 kernel: Call Trace:
Mar 26 18:26:24 obb01 kernel:  [<c0284092>] net_tx_action+0x3c/0xd8
Mar 26 18:26:24 obb01 kernel:  [<c010aca9>] do_IRQ+0x10d/0x140
Mar 26 18:26:24 obb01 kernel:  [<c01091d8>] common_interrupt+0x18/0x20
Mar 26 18:26:24 obb01 kernel:  [<c02a007b>] tcp_sendmsg+0xc4b/0x1273
Mar 26 18:26:24 obb01 kernel:  [<c013b11d>] shrink_zone+0xab/0xad
Mar 26 18:26:24 obb01 kernel:  [<c013b1cf>] shrink_caches+0xb0/0xc6
Mar 26 18:26:24 obb01 kernel:  [<c013b284>] try_to_free_pages+0x9f/0x162
Mar 26 18:26:24 obb01 kernel:  [<c0134e6b>] __alloc_pages+0x1f2/0x365
Mar 26 18:26:24 obb01 kernel:  [<c0135003>] __get_free_pages+0x25/0x3f
Mar 26 18:26:24 obb01 kernel:  [<c015f1de>] __pollwait+0x41/0xc4
Mar 26 18:26:24 obb01 kernel:  [<c029dd1e>] tcp_poll+0x34/0x175
Mar 26 18:26:24 obb01 kernel:  [<c027c6d8>] sock_poll+0x29/0x31
Mar 26 18:26:24 obb01 kernel:  [<c015f60f>] do_select+0x2cc/0x2dc
Mar 26 18:26:24 obb01 kernel:  [<c015f19d>] __pollwait+0x0/0xc4
Mar 26 18:26:24 obb01 kernel:  [<c015f916>] sys_select+0x2d2/0x517
Mar 26 18:26:24 obb01 kernel:  [<c027db87>] sys_socketcall+0x18d/0x2c5
Mar 26 18:26:24 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 18:26:24 obb01 kernel:
Mar 26 18:26:24 obb01 kernel: Code: 8b 46 1c 39 d8 74 07 83 e8 18 8d 74 26
00 0f b3 69 e8 19 c0
Mar 26 18:26:24 obb01 kernel:  <6>note: smbd[6020] exited with preempt_count
1
Mar 26 18:26:24 obb01 kernel: Debug: sleeping function called from invalid
context at include/linux/rwsem.h:43
Mar 26 18:26:24 obb01 kernel: in_atomic():1, irqs_disabled():0
Mar 26 18:26:24 obb01 kernel: Call Trace:
Mar 26 18:26:24 obb01 kernel:  [<c0117d10>] __might_sleep+0xab/0xcb
Mar 26 18:26:24 obb01 kernel:  [<c011abb8>] profile_exit_task+0x20/0x5e
Mar 26 18:26:24 obb01 kernel:  [<c011c43a>] do_exit+0x7a/0x3a6
Mar 26 18:26:24 obb01 kernel:  [<c010986c>] do_divide_error+0x0/0xfb
Mar 26 18:26:24 obb01 kernel:  [<c01149f2>] do_page_fault+0x1f8/0x532
Mar 26 18:26:24 obb01 kernel:  [<c028e83d>] nf_hook_slow+0x128/0x19f
Mar 26 18:26:24 obb01 kernel:  [<c029b738>] dst_output+0x0/0x2d
Mar 26 18:26:24 obb01 kernel:  [<c0299a59>] ip_queue_xmit+0x506/0x601
Mar 26 18:26:24 obb01 kernel:  [<c029b738>] dst_output+0x0/0x2d
Mar 26 18:26:24 obb01 kernel:  [<c014dc21>] wake_up_buffer+0xf/0x26
Mar 26 18:26:24 obb01 kernel:  [<c0193351>] do_get_write_access+0x2fa/0x629
Mar 26 18:26:24 obb01 kernel:  [<c01147fa>] do_page_fault+0x0/0x532
Mar 26 18:26:24 obb01 kernel:  [<c0109215>] error_code+0x2d/0x38
Mar 26 18:26:24 obb01 kernel:  [<c013ab82>] refill_inactive_zone+0x9d/0x58d
Mar 26 18:26:24 obb01 kernel:  [<c0284092>] net_tx_action+0x3c/0xd8
Mar 26 18:26:24 obb01 kernel:  [<c010aca9>] do_IRQ+0x10d/0x140
Mar 26 18:26:24 obb01 kernel:  [<c01091d8>] common_interrupt+0x18/0x20
Mar 26 18:26:24 obb01 kernel:  [<c02a007b>] tcp_sendmsg+0xc4b/0x1273
Mar 26 18:26:24 obb01 kernel:  [<c013b11d>] shrink_zone+0xab/0xad
Mar 26 18:26:24 obb01 kernel:  [<c013b1cf>] shrink_caches+0xb0/0xc6
Mar 26 18:26:24 obb01 kernel:  [<c013b284>] try_to_free_pages+0x9f/0x162
Mar 26 18:26:24 obb01 kernel:  [<c0134e6b>] __alloc_pages+0x1f2/0x365
Mar 26 18:26:24 obb01 kernel:  [<c0135003>] __get_free_pages+0x25/0x3f
Mar 26 18:26:24 obb01 kernel:  [<c015f1de>] __pollwait+0x41/0xc4
Mar 26 18:26:24 obb01 kernel:  [<c029dd1e>] tcp_poll+0x34/0x175
Mar 26 18:26:24 obb01 kernel:  [<c027c6d8>] sock_poll+0x29/0x31
Mar 26 18:26:24 obb01 kernel:  [<c015f60f>] do_select+0x2cc/0x2dc
Mar 26 18:26:24 obb01 kernel:  [<c015f19d>] __pollwait+0x0/0xc4
Mar 26 18:26:24 obb01 kernel:  [<c015f916>] sys_select+0x2d2/0x517
Mar 26 18:26:24 obb01 kernel:  [<c027db87>] sys_socketcall+0x18d/0x2c5
Mar 26 18:26:24 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 18:26:24 obb01 kernel:
Mar 26 18:26:24 obb01 kernel: bad: scheduling while atomic!
Mar 26 18:26:24 obb01 kernel: Call Trace:
Mar 26 18:26:24 obb01 kernel:  [<c011691c>] schedule+0x59b/0x5a0
Mar 26 18:26:24 obb01 kernel:  [<c013d231>] unmap_page_range+0x43/0x69
Mar 26 18:26:24 obb01 kernel:  [<c013d417>] unmap_vmas+0x1c0/0x218
Mar 26 18:26:24 obb01 kernel:  [<c0141364>] exit_mmap+0x84/0x199
Mar 26 18:26:24 obb01 kernel:  [<c0118370>] mmput+0x67/0xb6
Mar 26 18:26:24 obb01 kernel:  [<c011c563>] do_exit+0x1a3/0x3a6
Mar 26 18:26:24 obb01 kernel:  [<c010986c>] do_divide_error+0x0/0xfb
Mar 26 18:26:24 obb01 kernel:  [<c01149f2>] do_page_fault+0x1f8/0x532
Mar 26 18:26:24 obb01 kernel:  [<c028e83d>] nf_hook_slow+0x128/0x19f
Mar 26 18:26:24 obb01 kernel:  [<c029b738>] dst_output+0x0/0x2d
Mar 26 18:26:24 obb01 kernel:  [<c0299a59>] ip_queue_xmit+0x506/0x601
Mar 26 18:26:24 obb01 kernel:  [<c029b738>] dst_output+0x0/0x2d
Mar 26 18:26:24 obb01 kernel:  [<c014dc21>] wake_up_buffer+0xf/0x26
Mar 26 18:26:24 obb01 kernel:  [<c0193351>] do_get_write_access+0x2fa/0x629
Mar 26 18:26:24 obb01 kernel:  [<c01147fa>] do_page_fault+0x0/0x532
Mar 26 18:26:24 obb01 kernel:  [<c0109215>] error_code+0x2d/0x38
Mar 26 18:26:24 obb01 kernel:  [<c013ab82>] refill_inactive_zone+0x9d/0x58d
Mar 26 18:26:24 obb01 kernel:  [<c0284092>] net_tx_action+0x3c/0xd8
Mar 26 18:26:24 obb01 kernel:  [<c010aca9>] do_IRQ+0x10d/0x140
Mar 26 18:26:24 obb01 kernel:  [<c01091d8>] common_interrupt+0x18/0x20
Mar 26 18:26:24 obb01 kernel:  [<c02a007b>] tcp_sendmsg+0xc4b/0x1273
Mar 26 18:26:24 obb01 kernel:  [<c013b11d>] shrink_zone+0xab/0xad
Mar 26 18:26:24 obb01 kernel:  [<c013b1cf>] shrink_caches+0xb0/0xc6
Mar 26 18:26:24 obb01 kernel:  [<c013b284>] try_to_free_pages+0x9f/0x162
Mar 26 18:26:24 obb01 kernel:  [<c0134e6b>] __alloc_pages+0x1f2/0x365
Mar 26 18:26:24 obb01 kernel:  [<c0135003>] __get_free_pages+0x25/0x3f
Mar 26 18:26:24 obb01 kernel:  [<c015f1de>] __pollwait+0x41/0xc4
Mar 26 18:26:24 obb01 kernel:  [<c029dd1e>] tcp_poll+0x34/0x175
Mar 26 18:26:24 obb01 kernel:  [<c027c6d8>] sock_poll+0x29/0x31
Mar 26 18:26:24 obb01 kernel:  [<c015f60f>] do_select+0x2cc/0x2dc
Mar 26 18:26:24 obb01 kernel:  [<c015f19d>] __pollwait+0x0/0xc4
Mar 26 18:26:24 obb01 kernel:  [<c015f916>] sys_select+0x2d2/0x517
Mar 26 18:26:24 obb01 kernel:  [<c027db87>] sys_socketcall+0x18d/0x2c5
Mar 26 18:26:24 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 18:26:24 obb01 kernel:
Mar 26 19:15:34 obb01 kernel: Unable to handle kernel paging request at
virtual address 006b0434
Mar 26 19:15:34 obb01 kernel:  printing eip:
Mar 26 19:15:34 obb01 kernel: c013ab82
Mar 26 19:15:34 obb01 kernel: *pde = 00000000
Mar 26 19:15:34 obb01 kernel: Oops: 0000 [#4]
Mar 26 19:15:34 obb01 kernel: CPU:    0
Mar 26 19:15:34 obb01 kernel: EIP:    0060:[<c013ab82>]    Not tainted
Mar 26 19:15:34 obb01 kernel: EFLAGS: 00010002
Mar 26 19:15:34 obb01 kernel: EIP is at refill_inactive_zone+0x9d/0x58d
Mar 26 19:15:34 obb01 kernel: eax: c032bcb4   ebx: c032bcc4   ecx: 006b0430
edx: c032bcc4
Mar 26 19:15:34 obb01 kernel: esi: 006b0418   edi: 00000000   ebp: 00000005
esp: cf075b88
Mar 26 19:15:34 obb01 kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 19:15:34 obb01 kernel: Process top (pid: 28893, threadinfo=cf074000
task=c1bdb900)
Mar 26 19:15:34 obb01 kernel: Stack: 00000000 cf075bcc c032bcc4 c0185fc9
cef3521c 00000000 00000022 00000000
Mar 26 19:15:34 obb01 kernel:        cf075ba8 cf075ba8 cf075bb0 cf075bb0
cf075bb8 cf075bb8 00000020 00000000
Mar 26 19:15:34 obb01 kernel:        c1bdb900 c01180de cf075bf0 cf075bf0
00027569 00000000 c0133c92 0195ad02
Mar 26 19:15:34 obb01 kernel: Call Trace:
Mar 26 19:15:34 obb01 kernel:  [<c0185fc9>]
ext3_get_block_handle+0x249/0x361
Mar 26 19:15:34 obb01 kernel:  [<c01180de>]
autoremove_wake_function+0x0/0x4f
Mar 26 19:15:34 obb01 kernel:  [<c0133c92>] mempool_alloc+0x91/0x180
Mar 26 19:15:34 obb01 kernel:  [<c013b11d>] shrink_zone+0xab/0xad
Mar 26 19:15:34 obb01 kernel:  [<c013b1cf>] shrink_caches+0xb0/0xc6
Mar 26 19:15:34 obb01 kernel:  [<c013b284>] try_to_free_pages+0x9f/0x162
Mar 26 19:15:34 obb01 kernel:  [<c0134e6b>] __alloc_pages+0x1f2/0x365
Mar 26 19:15:34 obb01 kernel:  [<c0131306>] find_or_create_page+0xa4/0xb2
Mar 26 19:15:34 obb01 kernel:  [<c014eebc>] grow_dev_page+0x2f/0x14c
Mar 26 19:15:34 obb01 kernel:  [<c014f088>] __getblk_slow+0xaf/0x10a
Mar 26 19:15:34 obb01 kernel:  [<c014f4c6>] __getblk+0x63/0x65
Mar 26 19:15:34 obb01 kernel:  [<c0188524>] ext3_get_inode_loc+0x7a/0x27b
Mar 26 19:15:34 obb01 kernel:  [<c0165144>] alloc_inode+0x1c/0x148
Mar 26 19:15:34 obb01 kernel:  [<c01887b3>] ext3_read_inode+0x29/0x2bc
Mar 26 19:15:34 obb01 kernel:  [<c0166133>] iget_locked+0x96/0xc0
Mar 26 19:15:34 obb01 kernel:  [<c018a82a>] ext3_lookup+0x9b/0xc4
Mar 26 19:15:34 obb01 kernel:  [<c015a04f>] real_lookup+0xdc/0xfe
Mar 26 19:15:34 obb01 kernel:  [<c015a2c8>] do_lookup+0x96/0xa1
Mar 26 19:15:34 obb01 kernel:  [<c015a3fa>] link_path_walk+0x127/0x911
Mar 26 19:15:34 obb01 kernel:  [<c015b09f>] __user_walk+0x49/0x5e
Mar 26 19:15:34 obb01 kernel:  [<c014b46a>] sys_access+0x93/0x150
Mar 26 19:15:34 obb01 kernel:  [<c014bf64>] sys_open+0x7e/0x8b
Mar 26 19:15:34 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 19:15:34 obb01 kernel:
Mar 26 19:15:34 obb01 kernel: Code: 8b 46 1c 39 d8 74 07 83 e8 18 8d 74 26
00 0f b3 69 e8 19 c0
Mar 26 19:15:34 obb01 kernel:  <6>note: top[28893] exited with preempt_count
1
Mar 26 19:15:34 obb01 kernel: Debug: sleeping function called from invalid
context at include/linux/rwsem.h:43
Mar 26 19:15:34 obb01 kernel: in_atomic():1, irqs_disabled():0
Mar 26 19:15:34 obb01 kernel: Call Trace:
Mar 26 19:15:34 obb01 kernel:  [<c0117d10>] __might_sleep+0xab/0xcb
Mar 26 19:15:34 obb01 kernel:  [<c011abb8>] profile_exit_task+0x20/0x5e
Mar 26 19:15:34 obb01 kernel:  [<c011c43a>] do_exit+0x7a/0x3a6
Mar 26 19:15:34 obb01 kernel:  [<c010986c>] do_divide_error+0x0/0xfb
Mar 26 19:15:34 obb01 kernel:  [<c01149f2>] do_page_fault+0x1f8/0x532
Mar 26 19:15:34 obb01 kernel:  [<c014f3d2>] __find_get_block+0x74/0x105
Mar 26 19:15:34 obb01 kernel:  [<c0135094>] __pagevec_free+0x19/0x21
Mar 26 19:15:34 obb01 kernel:  [<c01147fa>] do_page_fault+0x0/0x532
Mar 26 19:15:34 obb01 kernel:  [<c0109215>] error_code+0x2d/0x38
Mar 26 19:15:34 obb01 kernel:  [<c013ab82>] refill_inactive_zone+0x9d/0x58d
Mar 26 19:15:34 obb01 kernel:  [<c0185fc9>]
ext3_get_block_handle+0x249/0x361
Mar 26 19:15:34 obb01 kernel:  [<c01180de>]
autoremove_wake_function+0x0/0x4f
Mar 26 19:15:34 obb01 kernel:  [<c0133c92>] mempool_alloc+0x91/0x180
Mar 26 19:15:34 obb01 kernel:  [<c013b11d>] shrink_zone+0xab/0xad
Mar 26 19:15:34 obb01 kernel:  [<c013b1cf>] shrink_caches+0xb0/0xc6
Mar 26 19:15:34 obb01 kernel:  [<c013b284>] try_to_free_pages+0x9f/0x162
Mar 26 19:15:34 obb01 kernel:  [<c0134e6b>] __alloc_pages+0x1f2/0x365
Mar 26 19:15:34 obb01 kernel:  [<c0131306>] find_or_create_page+0xa4/0xb2
Mar 26 19:15:34 obb01 kernel:  [<c014eebc>] grow_dev_page+0x2f/0x14c
Mar 26 19:15:34 obb01 kernel:  [<c014f088>] __getblk_slow+0xaf/0x10a
Mar 26 19:15:34 obb01 kernel:  [<c014f4c6>] __getblk+0x63/0x65
Mar 26 19:15:34 obb01 kernel:  [<c0188524>] ext3_get_inode_loc+0x7a/0x27b
Mar 26 19:15:34 obb01 kernel:  [<c0165144>] alloc_inode+0x1c/0x148
Mar 26 19:15:34 obb01 kernel:  [<c01887b3>] ext3_read_inode+0x29/0x2bc
Mar 26 19:15:34 obb01 kernel:  [<c0166133>] iget_locked+0x96/0xc0
Mar 26 19:15:34 obb01 kernel:  [<c018a82a>] ext3_lookup+0x9b/0xc4
Mar 26 19:15:34 obb01 kernel:  [<c015a04f>] real_lookup+0xdc/0xfe
Mar 26 19:15:34 obb01 kernel:  [<c015a2c8>] do_lookup+0x96/0xa1
Mar 26 19:15:34 obb01 kernel:  [<c015a3fa>] link_path_walk+0x127/0x911
Mar 26 19:15:34 obb01 kernel:  [<c015b09f>] __user_walk+0x49/0x5e
Mar 26 19:15:34 obb01 kernel:  [<c014b46a>] sys_access+0x93/0x150
Mar 26 19:15:34 obb01 kernel:  [<c014bf64>] sys_open+0x7e/0x8b
Mar 26 19:15:34 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 19:15:34 obb01 kernel:
Mar 26 19:15:34 obb01 kernel: bad: scheduling while atomic!
Mar 26 19:15:34 obb01 kernel: Call Trace:
Mar 26 19:15:34 obb01 kernel:  [<c011691c>] schedule+0x59b/0x5a0
Mar 26 19:15:34 obb01 kernel:  [<c013d231>] unmap_page_range+0x43/0x69
Mar 26 19:15:34 obb01 kernel:  [<c013d417>] unmap_vmas+0x1c0/0x218
Mar 26 19:15:34 obb01 kernel:  [<c0141364>] exit_mmap+0x84/0x199
Mar 26 19:15:34 obb01 kernel:  [<c0118370>] mmput+0x67/0xb6
Mar 26 19:15:34 obb01 kernel:  [<c011c563>] do_exit+0x1a3/0x3a6
Mar 26 19:15:34 obb01 kernel:  [<c010986c>] do_divide_error+0x0/0xfb
Mar 26 19:15:34 obb01 kernel:  [<c01149f2>] do_page_fault+0x1f8/0x532
Mar 26 19:15:34 obb01 kernel:  [<c014f3d2>] __find_get_block+0x74/0x105
Mar 26 19:15:34 obb01 kernel:  [<c0135094>] __pagevec_free+0x19/0x21
Mar 26 19:15:34 obb01 kernel:  [<c01147fa>] do_page_fault+0x0/0x532
Mar 26 19:15:34 obb01 kernel:  [<c0109215>] error_code+0x2d/0x38
Mar 26 19:15:34 obb01 kernel:  [<c013ab82>] refill_inactive_zone+0x9d/0x58d
Mar 26 19:15:34 obb01 kernel:  [<c0185fc9>]
ext3_get_block_handle+0x249/0x361
Mar 26 19:15:34 obb01 kernel:  [<c01180de>]
autoremove_wake_function+0x0/0x4f
Mar 26 19:15:34 obb01 kernel:  [<c0133c92>] mempool_alloc+0x91/0x180
Mar 26 19:15:34 obb01 kernel:  [<c013b11d>] shrink_zone+0xab/0xad
Mar 26 19:15:34 obb01 kernel:  [<c013b1cf>] shrink_caches+0xb0/0xc6
Mar 26 19:15:34 obb01 kernel:  [<c013b284>] try_to_free_pages+0x9f/0x162
Mar 26 19:15:34 obb01 kernel:  [<c0134e6b>] __alloc_pages+0x1f2/0x365
Mar 26 19:15:34 obb01 kernel:  [<c0131306>] find_or_create_page+0xa4/0xb2
Mar 26 19:15:34 obb01 kernel:  [<c014eebc>] grow_dev_page+0x2f/0x14c
Mar 26 19:15:34 obb01 kernel:  [<c014f088>] __getblk_slow+0xaf/0x10a
Mar 26 19:15:34 obb01 kernel:  [<c014f4c6>] __getblk+0x63/0x65
Mar 26 19:15:34 obb01 kernel:  [<c0188524>] ext3_get_inode_loc+0x7a/0x27b
Mar 26 19:15:34 obb01 kernel:  [<c0165144>] alloc_inode+0x1c/0x148
Mar 26 19:15:34 obb01 kernel:  [<c01887b3>] ext3_read_inode+0x29/0x2bc
Mar 26 19:15:34 obb01 kernel:  [<c0166133>] iget_locked+0x96/0xc0
Mar 26 19:15:34 obb01 kernel:  [<c018a82a>] ext3_lookup+0x9b/0xc4
Mar 26 19:15:34 obb01 kernel:  [<c015a04f>] real_lookup+0xdc/0xfe
Mar 26 19:15:34 obb01 kernel:  [<c015a2c8>] do_lookup+0x96/0xa1
Mar 26 19:15:34 obb01 kernel:  [<c015a3fa>] link_path_walk+0x127/0x911
Mar 26 19:15:34 obb01 kernel:  [<c015b09f>] __user_walk+0x49/0x5e
Mar 26 19:15:34 obb01 kernel:  [<c014b46a>] sys_access+0x93/0x150
Mar 26 19:15:34 obb01 kernel:  [<c014bf64>] sys_open+0x7e/0x8b
Mar 26 19:15:34 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 19:15:34 obb01 kernel:
Mar 26 19:44:49 obb01 kernel: Unable to handle kernel paging request at
virtual address 006b0434
Mar 26 19:44:49 obb01 kernel:  printing eip:
Mar 26 19:44:49 obb01 kernel: c013ab82
Mar 26 19:44:49 obb01 kernel: *pde = 00000000
Mar 26 19:44:49 obb01 kernel: Oops: 0000 [#5]
Mar 26 19:44:49 obb01 kernel: CPU:    0
Mar 26 19:44:49 obb01 kernel: EIP:    0060:[<c013ab82>]    Not tainted
Mar 26 19:44:49 obb01 kernel: EFLAGS: 00010002
Mar 26 19:44:49 obb01 kernel: EIP is at refill_inactive_zone+0x9d/0x58d
Mar 26 19:44:49 obb01 kernel: eax: c032bcb4   ebx: c032bcc4   ecx: 006b0430
edx: c032bcc4
Mar 26 19:44:49 obb01 kernel: esi: 006b0418   edi: 00000000   ebp: 00000005
esp: ee8e1b74
Mar 26 19:44:49 obb01 kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 19:44:49 obb01 kernel: Process sshd (pid: 649, threadinfo=ee8e0000
task=c5ba7900)
Mar 26 19:44:49 obb01 kernel: Stack: c1a27b80 c1b82180 c032bcc4 00000000
9f1042eb 00000000 00000022 00000000
Mar 26 19:44:49 obb01 kernel:        ee8e1b94 ee8e1b94 ee8e1b9c ee8e1b9c
ee8e1ba4 ee8e1ba4 c17bced8 c13b2f90
Mar 26 19:44:49 obb01 kernel:        c14a9688 c183f5b8 c1190e10 c16d0538
c11cb420 c11cb3a8 c13a38d8 c13a37c0
Mar 26 19:44:49 obb01 kernel: Call Trace:
Mar 26 19:44:49 obb01 kernel:  [<c0130f2d>] unlock_page+0x15/0x53
Mar 26 19:44:49 obb01 kernel:  [<c013b11d>] shrink_zone+0xab/0xad
Mar 26 19:44:49 obb01 kernel:  [<c013b1cf>] shrink_caches+0xb0/0xc6
Mar 26 19:44:49 obb01 kernel:  [<c013b284>] try_to_free_pages+0x9f/0x162
Mar 26 19:44:49 obb01 kernel:  [<c0134e6b>] __alloc_pages+0x1f2/0x365
Mar 26 19:44:49 obb01 kernel:  [<c0135003>] __get_free_pages+0x25/0x3f
Mar 26 19:44:49 obb01 kernel:  [<c013797e>] cache_grow+0xa5/0x28c
Mar 26 19:44:49 obb01 kernel:  [<c0137c35>] cache_alloc_refill+0xd0/0x200
Mar 26 19:44:49 obb01 kernel:  [<c0137f82>] kmem_cache_alloc+0x58/0x70
Mar 26 19:44:49 obb01 kernel:  [<c0114539>] pgd_alloc+0x18/0x1c
Mar 26 19:44:49 obb01 kernel:  [<c011828e>] mm_init+0x98/0xd2
Mar 26 19:44:49 obb01 kernel:  [<c01185af>] copy_mm+0xf4/0x46b
Mar 26 19:44:49 obb01 kernel:  [<c01191d6>] copy_process+0x413/0x97f
Mar 26 19:44:49 obb01 kernel:  [<c0159a5e>] do_pipe+0x189/0x209
Mar 26 19:44:49 obb01 kernel:  [<c0119792>] do_fork+0x50/0x183
Mar 26 19:44:49 obb01 kernel:  [<c0107806>] sys_fork+0x37/0x3b
Mar 26 19:44:49 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 19:44:49 obb01 kernel:
Mar 26 19:44:49 obb01 kernel: Code: 8b 46 1c 39 d8 74 07 83 e8 18 8d 74 26
00 0f b3 69 e8 19 c0
Mar 26 19:44:49 obb01 kernel:  <6>note: sshd[649] exited with preempt_count
1
Mar 26 19:44:49 obb01 kernel: Debug: sleeping function called from invalid
context at include/linux/rwsem.h:43
Mar 26 19:44:49 obb01 kernel: in_atomic():1, irqs_disabled():0
Mar 26 19:44:49 obb01 kernel: Call Trace:
Mar 26 19:44:49 obb01 kernel:  [<c0117d10>] __might_sleep+0xab/0xcb
Mar 26 19:44:49 obb01 kernel:  [<c011abb8>] profile_exit_task+0x20/0x5e
Mar 26 19:44:49 obb01 kernel:  [<c011c43a>] do_exit+0x7a/0x3a6
Mar 26 19:44:49 obb01 kernel:  [<c010986c>] do_divide_error+0x0/0xfb
Mar 26 19:44:49 obb01 kernel:  [<c01149f2>] do_page_fault+0x1f8/0x532
Mar 26 19:44:49 obb01 kernel:  [<c029b765>] ip_finish_output2+0x0/0x1b7
Mar 26 19:44:49 obb01 kernel:  [<c029b738>] dst_output+0x0/0x2d
Mar 26 19:44:49 obb01 kernel:  [<c029925c>]
ip_build_and_send_pkt+0x1a0/0x26d
Mar 26 19:44:49 obb01 kernel:  [<c01147fa>] do_page_fault+0x0/0x532
Mar 26 19:44:49 obb01 kernel:  [<c0109215>] error_code+0x2d/0x38
Mar 26 19:44:49 obb01 kernel:  [<c013ab82>] refill_inactive_zone+0x9d/0x58d
Mar 26 19:44:49 obb01 kernel:  [<c0130f2d>] unlock_page+0x15/0x53
Mar 26 19:44:49 obb01 kernel:  [<c013b11d>] shrink_zone+0xab/0xad
Mar 26 19:44:49 obb01 kernel:  [<c013b1cf>] shrink_caches+0xb0/0xc6
Mar 26 19:44:49 obb01 kernel:  [<c013b284>] try_to_free_pages+0x9f/0x162
Mar 26 19:44:49 obb01 kernel:  [<c0134e6b>] __alloc_pages+0x1f2/0x365
Mar 26 19:44:49 obb01 kernel:  [<c0135003>] __get_free_pages+0x25/0x3f
Mar 26 19:44:49 obb01 kernel:  [<c013797e>] cache_grow+0xa5/0x28c
Mar 26 19:44:49 obb01 kernel:  [<c0137c35>] cache_alloc_refill+0xd0/0x200
Mar 26 19:44:49 obb01 kernel:  [<c0137f82>] kmem_cache_alloc+0x58/0x70
Mar 26 19:44:49 obb01 kernel:  [<c0114539>] pgd_alloc+0x18/0x1c
Mar 26 19:44:49 obb01 kernel:  [<c011828e>] mm_init+0x98/0xd2
Mar 26 19:44:49 obb01 kernel:  [<c01185af>] copy_mm+0xf4/0x46b
Mar 26 19:44:49 obb01 kernel:  [<c01191d6>] copy_process+0x413/0x97f
Mar 26 19:44:49 obb01 kernel:  [<c0159a5e>] do_pipe+0x189/0x209
Mar 26 19:44:49 obb01 kernel:  [<c0119792>] do_fork+0x50/0x183
Mar 26 19:44:49 obb01 kernel:  [<c0107806>] sys_fork+0x37/0x3b
Mar 26 19:44:49 obb01 kernel:  [<c010906b>] syscall_call+0x7/0xb
Mar 26 19:44:49 obb01 kernel:
Mar 27 03:13:06 obb01 kernel: Linux version 2.6.2 (root@obb01) (gcc version
3.2.3) #2 Thu Mar 18 17:02:02 EST 2004
Mar 27 03:13:06 obb01 kernel:  BIOS-e820: 0000000000000000 -
00000000000a0000 (usable)
Mar 27 03:13:06 obb01 kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Mar 27 03:13:06 obb01 kernel:  BIOS-e820: 0000000000100000 -
000000003f7f0000 (usable)
Mar 27 03:13:06 obb01 kernel:  BIOS-e820: 000000003f7f0000 -
000000003f7f3000 (ACPI NVS)
Mar 27 03:13:06 obb01 kernel:  BIOS-e820: 000000003f7f3000 -
000000003f800000 (ACPI data)
Mar 27 03:13:06 obb01 kernel:  BIOS-e820: 000000003f800000 -
0000000040000000 (reserved)
Mar 27 03:13:06 obb01 kernel:  BIOS-e820: 00000000fec00000 -
0000000100000000 (reserved)
Mar 27 03:13:06 obb01 kernel: On node 0 totalpages: 260080
Mar 27 03:13:06 obb01 kernel:   DMA zone: 4096 pages, LIFO batch:1
Mar 27 03:13:06 obb01 kernel:   Normal zone: 225280 pages, LIFO batch:16
Mar 27 03:13:06 obb01 kernel:   HighMem zone: 30704 pages, LIFO batch:7
Mar 27 03:13:06 obb01 kernel: Building zonelist for node : 0
Mar 27 03:13:06 obb01 kernel: Kernel command line: auto
BOOT_IMAGE=HPTLinux-2.6.2 ro root=301
Mar 27 03:13:06 obb01 kernel: PID hash table entries: 4096 (order 12: 32768
bytes)
Mar 27 03:13:06 obb01 kernel: Detected 2430.450 MHz processor.
Mar 27 03:13:06 obb01 kernel: Console: colour VGA+ 80x25
Mar 27 03:13:06 obb01 kernel: Checking if this processor honours the WP bit
even in supervisor mode... Ok.
Mar 27 03:13:06 obb01 kernel: Calibrating delay loop... 4800.51 BogoMIPS
Mar 27 03:13:06 obb01 kernel: Inode-cache hash table entries: 65536 (order:
6, 262144 bytes)
Mar 27 03:13:06 obb01 kernel: Mount-cache hash table entries: 512 (order: 0,
4096 bytes)
Mar 27 03:13:06 obb01 kernel: CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping 07
Mar 27 03:13:06 obb01 kernel: POSIX conformance testing by UNIFIX
Mar 27 03:13:06 obb01 kernel: PCI: Probing PCI hardware
Mar 27 03:13:06 obb01 kernel: PCI: Probing PCI hardware (bus 00)
Mar 27 03:13:06 obb01 kernel: Transparent bridge - 0000:00:1e.0
Mar 27 03:13:06 obb01 kernel: PCI: IRQ 0 for device 0000:00:1f.1 doesn't
match PIRQ mask - try pci=usepirqmask
Mar 27 03:13:06 obb01 kernel: highmem bounce pool size: 64 pages
Mar 27 03:13:06 obb01 kernel: pty: 256 Unix98 ptys configured
Mar 27 03:13:06 obb01 kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar 27 03:13:06 obb01 kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar 27 03:13:06 obb01 kernel: Using anticipatory io scheduler
Mar 27 03:13:06 obb01 kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
Mar 27 03:13:06 obb01 kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg>
 and others
Mar 27 03:13:06 obb01 kernel: hda: ST360020A, ATA DISK drive
Mar 27 03:13:06 obb01 kernel: hdb: ST360020A, ATA DISK drive
Mar 27 03:13:06 obb01 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 27 03:13:06 obb01 kernel: hdc: WDC WD1200JB-00CRA1, ATA DISK drive
Mar 27 03:13:06 obb01 kernel: hdd: WDC WD1200JB-00DUA0, ATA DISK drive
Mar 27 03:13:06 obb01 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar 27 03:13:06 obb01 kernel: HPT37X: using 33MHz PCI clock
Mar 27 03:13:06 obb01 kernel: hde: WDC WD1200JB-00CRA1, ATA DISK drive
Mar 27 03:13:06 obb01 kernel: ide2 at 0xb000-0xb007,0xb402 on irq 11
Mar 27 03:13:06 obb01 kernel: hdg: WDC WD1200JB-00EVA0, ATA DISK drive
Mar 27 03:13:06 obb01 kernel: hdh: WDC WD1200JB-00DUA0, ATA DISK drive
Mar 27 03:13:06 obb01 kernel: ide3 at 0xb800-0xb807,0xbc02 on irq 11
Mar 27 03:13:06 obb01 kernel: hda: max request size: 128KiB
Mar 27 03:13:06 obb01 kernel: hdb: max request size: 128KiB
Mar 27 03:13:06 obb01 kernel: hdc: max request size: 128KiB
Mar 27 03:13:06 obb01 kernel: hdd: max request size: 1024KiB
Mar 27 03:13:06 obb01 kernel: hde: max request size: 128KiB
Mar 27 03:13:06 obb01 kernel: hdg: max request size: 1024KiB
Mar 27 03:13:06 obb01 kernel: hdh: max request size: 1024KiB
Mar 27 03:13:06 obb01 kernel: ip_conntrack version 2.1 (8127 buckets, 65016
max) - 296 bytes per conntrack

Thanks everyone

