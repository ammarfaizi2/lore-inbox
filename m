Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUFVN5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUFVN5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUFVN5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:57:07 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:28050 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263709AbUFVNzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:55:50 -0400
Date: Tue, 22 Jun 2004 15:55:29 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: 2.6.7-bk5 scheduling while atomic
Message-ID: <20040622135529.GA838@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Seen: false
X-ID: XpwzMZZ6QeUjNoHmqIcGg++2yGVW44UH-02JQI631iASvS7MHuUzQa
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System smp (2 x XEON, I7505) preemptive 

With kernel-2.6.7-bk5 I get a lot of 
"kernel: bad: scheduling while atomic!" messages 
during startup.

2.6.7 runs fine using the basically the same configuration.

Did anybody else see this ? 

Here is an excerpt of /var/log/messages  ..

Jun 22 14:58:52 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:58:52 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:58:52 xeon2 kernel:  [schedule+2000/2064]  [schedule+2000/2064] schedule+0x7d0/0x810
Jun 22 14:58:52 xeon2 kernel:  [copy_from_user+52/98] schedule+0x7d0/0x810
Jun 22 14:58:52 xeon2 kernel:  [sock_sendmsg+134/204] copy_from_user+0x34/0x62
Jun 22 14:58:52 xeon2 kernel:  [sys_recvmsg+415/491] sock_sendmsg+0x86/0xcc
Jun 22 14:58:52 xeon2 kernel:  [sys_sched_yield+71/93] sys_sched_yield+0x47/0x5d
Jun 22 14:58:52 xeon2 kernel: sys_recvmsg+0x19f/0x1eb
Jun 22 14:58:52 xeon2 kernel:  [schedule_timeout+173/175]  [coredump_wait+52/149] coredump_wait+0x34/0x95
Jun 22 14:58:52 xeon2 kernel:  [do_coredump+315/545] do_coredump+0x13b/0x221
Jun 22 14:58:52 xeon2 kernel:  [sys_sendto+235/274] schedule_timeout+0xad/0xaf
Jun 22 14:58:52 xeon2 kernel:  [get_futex_key+67/439] get_futex_key+0x43/0x1b7
Jun 22 14:58:53 xeon2 kernel:  [unqueue_me+108/225] unqueue_me+0x6c/0xe1
Jun 22 14:58:53 xeon2 kernel:  [futex_wait+292/393] sys_sendto+0xeb/0x112
Jun 22 14:58:53 xeon2 kernel: futex_wait+0x124/0x189
Jun 22 14:58:53 xeon2 kernel:  [handle_mm_fault+413/517] handle_mm_fault+0x19d/0x205
Jun 22 14:58:53 xeon2 kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
Jun 22 14:58:53 xeon2 kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
Jun 22 14:58:53 xeon2 kernel:  [do_futex+93/169] do_futex+0x5d/0xa9
Jun 22 14:58:53 xeon2 kernel:  [sys_socketcall+104/582]  [__dequeue_signal+223/319] __dequeue_signal+0xdf/0x13f
Jun 22 14:58:53 xeon2 kernel:  [dequeue_signal+35/128] dequeue_signal+0x23/0x80
Jun 22 14:58:53 xeon2 kernel: sys_socketcall+0x68/0x246
Jun 22 14:58:53 xeon2 kernel:  [sys_futex+109/247] sys_futex+0x6d/0xf7
Jun 22 14:58:53 xeon2 kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Jun 22 14:58:53 xeon2 kernel:  [get_signal_to_deliver+884/1089] get_signal_to_deliver+0x374/0x441
Jun 22 14:58:53 xeon2 kernel:  [do_signal+129/325] do_signal+0x81/0x145
Jun 22 14:58:53 xeon2 kernel:  [__sock_create+238/685] __sock_create+0xee/0x2ad
Jun 22 14:58:53 xeon2 kernel:  [dput+147/636] dput+0x93/0x27c
Jun 22 14:58:53 xeon2 kernel:  [sys_send+55/59] sys_send+0x37/0x3b
Jun 22 14:58:53 xeon2 kernel:  [sys_socketcall+322/582] sys_socketcall+0x142/0x246
Jun 22 14:58:53 xeon2 kernel:  [copy_to_user+50/69] copy_to_user+0x32/0x45
Jun 22 14:58:53 xeon2 kernel:  [do_page_fault+0/1245] do_page_fault+0x0/0x4dd
Jun 22 14:58:53 xeon2 kernel:  [do_notify_resume+55/57] do_notify_resume+0x37/0x39
Jun 22 14:58:53 xeon2 kernel:  [work_notifysig+19/21] work_notifysig+0x13/0x15
Jun 22 14:58:53 xeon2 kernel: note: ntpdate[501] exited with preempt_count 3
Jun 22 14:58:53 xeon2 ntpd[504]: ntpd 4.2.0@1.1161-r Thu Feb 19 22:07:29 CET 2004 (20)
Jun 22 14:58:53 xeon2 ntpd[504]: precision = 1.000 usec
Jun 22 14:58:53 xeon2 ntpd[504]: no IPv6 interfaces found
Jun 22 14:58:53 xeon2 ntpd[504]: kernel time sync status 0040
Jun 22 14:58:53 xeon2 ntpd[504]: frequency initialized 107.116 PPM from /etc/ntp.drift
Jun 22 14:58:53 xeon2 saslauthd[523]: detach_tty      : master pid is: 523
Jun 22 14:58:53 xeon2 saslauthd[523]: ipc_init        : listening on socket: /var/state/saslauthd/mux
Jun 22 14:58:53 xeon2 master[530]: setrlimit: Unable to set file descriptors limit to -1: Operation not permitted
Jun 22 14:58:53 xeon2 master[530]: retrying with 1024 (current max)
Jun 22 14:58:53 xeon2 master[530]: process started
Jun 22 14:58:53 xeon2 master[532]: about to exec /usr/cyrus/bin/ctl_cyrusdb
Jun 22 14:58:54 xeon2 FaxQueuer[542]: HylaFAX (tm) Version 4.1.8
Jun 22 14:58:54 xeon2 FaxQueuer[542]: Copyright (c) 1990-1996 Sam Leffler
Jun 22 14:58:54 xeon2 FaxQueuer[542]: Copyright (c) 1991-1996 Silicon Graphics, Inc.
Jun 22 14:58:54 xeon2 HylaFAX[540]: HylaFAX INET Protocol Server: restarted.
Jun 22 14:58:55 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:58:55 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:58:55 xeon2 kernel:  [schedule+2000/2064]  [schedule+2000/2064] schedule+0x7d0/0x810
Jun 22 14:58:55 xeon2 kernel:  [recalc_task_prio+311/424] schedule+0x7d0/0x810
Jun 22 14:58:55 xeon2 kernel: recalc_task_prio+0x137/0x1a8
Jun 22 14:58:55 xeon2 kernel:  [schedule_timeout+173/175]  [sock_sendmsg+134/204] schedule_timeout+0xad/0xaf
Jun 22 14:58:55 xeon2 kernel:  [get_futex_key+67/439] sock_sendmsg+0x86/0xcc
Jun 22 14:58:55 xeon2 kernel: get_futex_key+0x43/0x1b7
Jun 22 14:58:55 xeon2 kernel:  [unqueue_me+108/225] unqueue_me+0x6c/0xe1
Jun 22 14:58:55 xeon2 kernel:  [futex_wait+292/393] futex_wait+0x124/0x189
Jun 22 14:58:55 xeon2 kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
Jun 22 14:58:55 xeon2 kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
Jun 22 14:58:55 xeon2 kernel:  [do_futex+93/169] do_futex+0x5d/0xa9
Jun 22 14:58:55 xeon2 kernel:  [sys_socketcall+104/582]  [sys_sched_yield+71/93] sys_sched_yield+0x47/0x5d
Jun 22 14:58:55 xeon2 kernel: sys_socketcall+0x68/0x246
Jun 22 14:58:55 xeon2 kernel:  [sys_futex+109/247] sys_futex+0x6d/0xf7
Jun 22 14:58:55 xeon2 kernel:  [sys_gettimeofday+44/101] sys_gettimeofday+0x2c/0x65
Jun 22 14:58:55 xeon2 kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Jun 22 14:58:55 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:58:55 xeon2 kernel:  [schedule+2000/2064]  [coredump_wait+52/149] coredump_wait+0x34/0x95
Jun 22 14:58:55 xeon2 kernel: schedule+0x7d0/0x810
Jun 22 14:58:55 xeon2 kernel:  [fbcon_cursor+726/871]  [do_coredump+315/545] do_coredump+0x13b/0x221
Jun 22 14:58:55 xeon2 kernel:  [sys_sendto+235/274] fbcon_cursor+0x2d6/0x367
Jun 22 14:58:55 xeon2 kernel:  [__lock_sock+129/181] sys_sendto+0xeb/0x112
Jun 22 14:58:55 xeon2 kernel:  [__dequeue_signal+223/319] __dequeue_signal+0xdf/0x13f
Jun 22 14:58:55 xeon2 kernel: __lock_sock+0x81/0xb5
Jun 22 14:58:55 xeon2 kernel:  [autoremove_wake_function+0/67] autoremove_wake_function+0x0/0x43
Jun 22 14:58:55 xeon2 kernel:  [scsi_proc_hostdir_rm+21/108]  [dequeue_signal+35/128] dequeue_signal+0x23/0x80
Jun 22 14:58:55 xeon2 kernel: scsi_proc_hostdir_rm+0x15/0x6c
Jun 22 14:58:55 xeon2 kernel:  [autoremove_wake_function+0/67] autoremove_wake_function+0x0/0x43
Jun 22 14:58:55 xeon2 kernel:  [lock_sock+91/100]  [get_signal_to_deliver+884/1089] get_signal_to_deliver+0x374/0x441
Jun 22 14:58:55 xeon2 kernel:  [do_signal+129/325] do_signal+0x81/0x145
Jun 22 14:58:55 xeon2 kernel: lock_sock+0x5b/0x64
Jun 22 14:58:55 xeon2 kernel:  [udp_sendmsg+630/2033]  [__sock_create+238/685] udp_sendmsg+0x276/0x7f1
Jun 22 14:58:55 xeon2 kernel:  [scheduler_tick+400/1285] __sock_create+0xee/0x2ad
Jun 22 14:58:55 xeon2 kernel: scheduler_tick+0x190/0x505
Jun 22 14:58:55 xeon2 kernel:  [__wake_up_locked+31/33] __wake_up_locked+0x1f/0x21
Jun 22 14:58:55 xeon2 kernel:  [__down_failed_trylock+7/12]  [dput+147/636] dput+0x93/0x27c
Jun 22 14:58:55 xeon2 kernel:  [sys_send+55/59] __down_failed_trylock+0x7/0xc
Jun 22 14:58:55 xeon2 kernel:  [__print_symbol+177/376] __print_symbol+0xb1/0x178
Jun 22 14:58:55 xeon2 kernel:  [__print_symbol+64/376] __print_symbol+0x40/0x178
Jun 22 14:58:55 xeon2 kernel: sys_send+0x37/0x3b
Jun 22 14:58:55 xeon2 kernel:  [sys_socketcall+322/582]  [inet_sendmsg+74/98] sys_socketcall+0x142/0x246
Jun 22 14:58:55 xeon2 kernel:  [copy_to_user+50/69] inet_sendmsg+0x4a/0x62
Jun 22 14:58:55 xeon2 kernel:  [sock_sendmsg+134/204] copy_to_user+0x32/0x45
Jun 22 14:58:55 xeon2 kernel:  [do_page_fault+0/1245] do_page_fault+0x0/0x4dd
Jun 22 14:58:55 xeon2 kernel:  [do_notify_resume+55/57] do_notify_resume+0x37/0x39
Jun 22 14:58:55 xeon2 kernel:  [work_notifysig+19/21] work_notifysig+0x13/0x15
Jun 22 14:58:55 xeon2 kernel: sock_sendmsg+0x86/0xcc
Jun 22 14:58:55 xeon2 kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Jun 22 14:58:55 xeon2 kernel:  [kernel_text_address+43/53] kernel_text_address+0x2b/0x35
Jun 22 14:58:55 xeon2 kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Jun 22 14:58:55 xeon2 kernel:  [copy_from_user+52/98] copy_from_user+0x34/0x62
Jun 22 14:58:55 xeon2 kernel:  [copy_from_user+52/98] copy_from_user+0x34/0x62
Jun 22 14:58:55 xeon2 kernel:  [verify_iovec+50/123] <6>note: fetchmail[547] exited with preempt_count 3
Jun 22 14:58:55 xeon2 kernel: verify_iovec+0x32/0x7b
Jun 22 14:58:55 xeon2 kernel:  [sys_sendmsg+297/539] sys_sendmsg+0x129/0x21b
Jun 22 14:58:55 xeon2 kernel:  [schedule_timeout+173/175] schedule_timeout+0xad/0xaf
Jun 22 14:58:55 xeon2 kernel:  [get_futex_key+67/439] get_futex_key+0x43/0x1b7
Jun 22 14:58:55 xeon2 kernel:  [unqueue_me+108/225] unqueue_me+0x6c/0xe1
Jun 22 14:58:55 xeon2 kernel:  [futex_wait+311/393] futex_wait+0x137/0x189
Jun 22 14:58:55 xeon2 kernel:  [find_extend_vma+29/105] find_extend_vma+0x1d/0x69
Jun 22 14:58:55 xeon2 kernel:  [get_futex_key+67/439] get_futex_key+0x43/0x1b7
Jun 22 14:58:55 xeon2 kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
Jun 22 14:58:55 xeon2 kernel:  [futex_wake+64/234] futex_wake+0x40/0xea
Jun 22 14:58:55 xeon2 kernel:  [sys_socketcall+577/582] sys_socketcall+0x241/0x246
Jun 22 14:58:55 xeon2 kernel:  [sys_futex+109/247] sys_futex+0x6d/0xf7
Jun 22 14:58:55 xeon2 kernel:  [sys_gettimeofday+44/101] sys_gettimeofday+0x2c/0x65
Jun 22 14:58:55 xeon2 kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Jun 22 14:58:55 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:58:55 xeon2 kernel:  [schedule+2000/2064] schedule+0x7d0/0x810
Jun 22 14:58:55 xeon2 kernel:  [verify_iovec+50/123] verify_iovec+0x32/0x7b
Jun 22 14:58:55 xeon2 kernel:  [sys_sendmsg+443/539] sys_sendmsg+0x1bb/0x21b
Jun 22 14:58:55 xeon2 kernel:  [schedule_timeout+173/175] schedule_timeout+0xad/0xaf
Jun 22 14:58:55 xeon2 kernel:  [get_futex_key+67/439] get_futex_key+0x43/0x1b7
Jun 22 14:58:55 xeon2 kernel:  [unqueue_me+108/225] unqueue_me+0x6c/0xe1
Jun 22 14:58:55 xeon2 kernel:  [futex_wait+292/393] futex_wait+0x124/0x189
Jun 22 14:58:55 xeon2 kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
Jun 22 14:58:55 xeon2 kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
Jun 22 14:58:55 xeon2 kernel:  [do_futex+93/169] do_futex+0x5d/0xa9
Jun 22 14:58:55 xeon2 kernel:  [sys_socketcall+577/582] sys_socketcall+0x241/0x246
Jun 22 14:58:55 xeon2 kernel:  [sys_futex+109/247] sys_futex+0x6d/0xf7
Jun 22 14:58:55 xeon2 kernel:  [sys_gettimeofday+44/101] sys_gettimeofday+0x2c/0x65
Jun 22 14:58:55 xeon2 kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Jun 22 14:58:55 xeon2 kernel: note: named[456] exited with preempt_count 3
Jun 22 14:58:55 xeon2 sshd[556]: Server listening on 0.0.0.0 port 22.
Jun 22 14:58:55 xeon2 rpc.statd[565]: Version 1.0.6 Starting
Jun 22 14:58:55 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:58:55 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:58:55 xeon2 kernel:  [schedule+2000/2064]  [schedule+2000/2064] schedule+0x7d0/0x810
Jun 22 14:58:55 xeon2 kernel:  [__alloc_pages+148/702] __alloc_pages+0x94/0x2be
Jun 22 14:58:55 xeon2 kernel: schedule+0x7d0/0x810
Jun 22 14:58:55 xeon2 kernel:  [__alloc_pages+148/702] __alloc_pages+0x94/0x2be
Jun 22 14:58:55 xeon2 kernel:  [schedule_timeout+98/175]  [schedule_timeout+173/175] schedule_timeout+0x62/0xaf
Jun 22 14:58:55 xeon2 kernel:  [datagram_poll+254/259] schedule_timeout+0xad/0xaf
Jun 22 14:58:55 xeon2 kernel:  [sock_poll+18/20] datagram_poll+0xfe/0x103
Jun 22 14:58:55 xeon2 kernel:  [process_timeout+0/5] process_timeout+0x0/0x5
Jun 22 14:58:55 xeon2 kernel: sock_poll+0x12/0x14
Jun 22 14:58:55 xeon2 kernel:  [do_pollfd+74/127] do_pollfd+0x4a/0x7f
Jun 22 14:58:55 xeon2 kernel:  [do_poll+152/183] do_poll+0x98/0xb7
Jun 22 14:58:55 xeon2 kernel:  [sys_poll+418/558] sys_poll+0x1a2/0x22e
Jun 22 14:58:55 xeon2 kernel:  [__pollwait+0/193] __pollwait+0x0/0xc1
Jun 22 14:58:55 xeon2 kernel:  [filp_close+72/138] filp_close+0x48/0x8a
Jun 22 14:58:55 xeon2 kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Jun 22 14:58:55 xeon2 kernel:  [do_poll+152/183] do_poll+0x98/0xb7
Jun 22 14:58:55 xeon2 kernel:  [sys_poll+418/558] sys_poll+0x1a2/0x22e
Jun 22 14:58:55 xeon2 kernel:  [__pollwait+0/193] __pollwait+0x0/0xc1
Jun 22 14:58:55 xeon2 kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Jun 22 14:58:55 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:58:55 xeon2 kernel:  [schedule+2000/2064] schedule+0x7d0/0x810
Jun 22 14:58:55 xeon2 kernel:  [as_can_anticipate+22/32] as_can_anticipate+0x16/0x20
Jun 22 14:58:55 xeon2 kernel:  [as_dispatch_request+510/749] as_dispatch_request+0x1fe/0x2ed
Jun 22 14:58:55 xeon2 kernel:  [memcpy_toiovec+39/76] memcpy_toiovec+0x27/0x4c
Jun 22 14:58:55 xeon2 kernel:  [as_next_request+44/53] as_next_request+0x2c/0x35
Jun 22 14:58:55 xeon2 kernel:  [elv_next_request+40/242] elv_next_request+0x28/0xf2
Jun 22 14:58:55 xeon2 kernel:  [blk_remove_plug+48/103] blk_remove_plug+0x30/0x67
Jun 22 14:58:55 xeon2 kernel:  [io_schedule+38/48] io_schedule+0x26/0x30
Jun 22 14:58:55 xeon2 kernel:  [__lock_page+234/236] __lock_page+0xea/0xec
Jun 22 14:58:55 xeon2 kernel:  [page_wake_function+0/78] page_wake_function+0x0/0x4e
Jun 22 14:58:55 xeon2 kernel:  [page_wake_function+0/78] page_wake_function+0x0/0x4e
Jun 22 14:58:55 xeon2 kernel:  [find_get_page+46/96] find_get_page+0x2e/0x60
Jun 22 14:58:55 xeon2 kernel:  [do_generic_mapping_read+1066/1255] do_generic_mapping_read+0x42a/0x4e7
Jun 22 14:58:55 xeon2 kernel:  [__generic_file_aio_read+430/537] __generic_file_aio_read+0x1ae/0x219
Jun 22 14:58:55 xeon2 kernel:  [file_read_actor+0/226] file_read_actor+0x0/0xe2
Jun 22 14:58:55 xeon2 kernel:  [__find_get_block+130/178] __find_get_block+0x82/0xb2
Jun 22 14:58:55 xeon2 kernel:  [generic_file_read+106/136] generic_file_read+0x6a/0x88
Jun 22 14:58:55 xeon2 kernel:  [permission+100/119] permission+0x64/0x77
Jun 22 14:58:55 xeon2 kernel:  [may_open+78/481] may_open+0x4e/0x1e1
Jun 22 14:58:55 xeon2 kernel:  [get_empty_filp+141/235] get_empty_filp+0x8d/0xeb
Jun 22 14:58:55 xeon2 kernel:  [open_namei+276/996] open_namei+0x114/0x3e4
Jun 22 14:58:55 xeon2 kernel:  [dentry_open+173/572] dentry_open+0xad/0x23c
Jun 22 14:58:55 xeon2 kernel:  [filp_open+64/70] filp_open+0x40/0x46
Jun 22 14:58:55 xeon2 kernel:  [vfs_read+205/294] vfs_read+0xcd/0x126
Jun 22 14:58:55 xeon2 kernel:  [sys_read+56/89] sys_read+0x38/0x59
Jun 22 14:58:55 xeon2 kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Jun 22 14:58:55 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:58:55 xeon2 kernel:  [schedule+2000/2064] schedule+0x7d0/0x810
Jun 22 14:58:55 xeon2 kernel:  [as_next_request+44/53] as_next_request+0x2c/0x35
Jun 22 14:58:55 xeon2 kernel:  [elv_next_request+40/242] elv_next_request+0x28/0xf2
Jun 22 14:58:55 xeon2 kernel:  [scsi_request_fn+633/1175] scsi_request_fn+0x279/0x497
Jun 22 14:58:55 xeon2 kernel:  [io_schedule+38/48] io_schedule+0x26/0x30
Jun 22 14:58:55 xeon2 kernel:  [__wait_on_buffer+138/160] __wait_on_buffer+0x8a/0xa0
Jun 22 14:58:55 xeon2 kernel:  [bh_wake_function+0/65] bh_wake_function+0x0/0x41
Jun 22 14:58:55 xeon2 kernel:  [bh_wake_function+0/65] bh_wake_function+0x0/0x41
Jun 22 14:58:55 xeon2 kernel:  [ext2_update_inode+491/956] ext2_update_inode+0x1eb/0x3bc
Jun 22 14:58:55 xeon2 kernel:  [write_inode+68/70] write_inode+0x44/0x46
Jun 22 14:58:55 xeon2 kernel:  [__sync_single_inode+318/580] __sync_single_inode+0x13e/0x244
Jun 22 14:58:55 xeon2 kernel:  [sync_inode+50/106] sync_inode+0x32/0x6a
Jun 22 14:58:55 xeon2 kernel:  [ext2_sync_inode+44/56] ext2_sync_inode+0x2c/0x38
Jun 22 14:58:55 xeon2 kernel:  [ext2_sync_file+57/80] ext2_sync_file+0x39/0x50
Jun 22 14:58:55 xeon2 kernel:  [sys_fsync+148/197] sys_fsync+0x94/0xc5
Jun 22 14:58:55 xeon2 kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Jun 22 14:58:55 xeon2 kernel: note: rpc.statd[565] exited with preempt_count 3
Jun 22 14:58:56 xeon2 ctl_cyrusdb[532]: recovering cyrus databases
Jun 22 14:58:56 xeon2 ctl_cyrusdb[532]: skiplist: recovered /var/imap/mailboxes.db (2 records, 432 bytes) in 0 seconds
Jun 22 14:58:56 xeon2 ctl_cyrusdb[532]: done recovering cyrus databases
Jun 22 14:58:56 xeon2 master[530]: ready for work
Jun 22 14:58:56 xeon2 master[567]: about to exec /usr/cyrus/bin/ctl_cyrusdb
Jun 22 14:58:56 xeon2 ctl_cyrusdb[567]: checkpointing cyrus databases
Jun 22 14:58:56 xeon2 ctl_cyrusdb[567]: archiving database file: /var/imap/annotations.db
Jun 22 14:58:57 xeon2 ctl_cyrusdb[567]: archiving log file: /var/imap/db/log.0000000001
Jun 22 14:58:57 xeon2 ctl_cyrusdb[567]: archiving database file: /var/imap/mailboxes.db
Jun 22 14:58:57 xeon2 ctl_cyrusdb[567]: archiving log file: /var/imap/db/log.0000000001
Jun 22 14:58:57 xeon2 ctl_cyrusdb[567]: done checkpointing cyrus databases
Jun 22 14:58:57 xeon2 master[530]: process 567 exited, status 0
Jun 22 14:59:00 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:59:00 xeon2 kernel:  [schedule+2000/2064] schedule+0x7d0/0x810
Jun 22 14:59:00 xeon2 kernel:  [sock_sendmsg+134/204] sock_sendmsg+0x86/0xcc
Jun 22 14:59:00 xeon2 kernel:  [buffered_rmqueue+265/519] buffered_rmqueue+0x109/0x207
Jun 22 14:59:00 xeon2 kernel:  [sys_sched_yield+71/93] sys_sched_yield+0x47/0x5d
Jun 22 14:59:00 xeon2 kernel:  [coredump_wait+52/149] coredump_wait+0x34/0x95
Jun 22 14:59:00 xeon2 kernel:  [do_coredump+315/545] do_coredump+0x13b/0x221
Jun 22 14:59:00 xeon2 kernel:  [sys_sendto+235/274] sys_sendto+0xeb/0x112
Jun 22 14:59:00 xeon2 kernel:  [__dequeue_signal+223/319] __dequeue_signal+0xdf/0x13f
Jun 22 14:59:00 xeon2 kernel:  [dequeue_signal+35/128] dequeue_signal+0x23/0x80
Jun 22 14:59:00 xeon2 kernel:  [get_signal_to_deliver+884/1089] get_signal_to_deliver+0x374/0x441
Jun 22 14:59:00 xeon2 kernel:  [do_signal+129/325] do_signal+0x81/0x145
Jun 22 14:59:00 xeon2 kernel:  [__sock_create+238/685] __sock_create+0xee/0x2ad
Jun 22 14:59:00 xeon2 kernel:  [dput+147/636] dput+0x93/0x27c
Jun 22 14:59:00 xeon2 kernel:  [sys_send+55/59] sys_send+0x37/0x3b
Jun 22 14:59:00 xeon2 kernel:  [sys_socketcall+322/582] sys_socketcall+0x142/0x246
Jun 22 14:59:00 xeon2 kernel:  [copy_to_user+50/69] copy_to_user+0x32/0x45
Jun 22 14:59:00 xeon2 kernel:  [do_page_fault+0/1245] do_page_fault+0x0/0x4dd
Jun 22 14:59:00 xeon2 kernel:  [do_notify_resume+55/57] do_notify_resume+0x37/0x39
Jun 22 14:59:00 xeon2 kernel:  [work_notifysig+19/21] work_notifysig+0x13/0x15
Jun 22 14:59:00 xeon2 kernel: note: exportfs[575] exited with preempt_count 3
Jun 22 14:59:05 xeon2 kernel: bad: scheduling while atomic!
Jun 22 14:59:05 xeon2 kernel: bad: scheduling while atomic!


- 
Klaus 
