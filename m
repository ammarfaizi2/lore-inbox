Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbULCUsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbULCUsj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbULCUsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:48:39 -0500
Received: from mail.velocity.net ([66.211.211.55]:39331 "EHLO
	mail.velocity.net") by vger.kernel.org with ESMTP id S262257AbULCUsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:48:25 -0500
X-AV-Checked: Fri Dec  3 15:48:24 2004 clean
Subject: kjournald oops in 2.6.9
From: Dale Blount <linux-kernel@dale.us>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-1iAhnY+J5AqQ7eCZ5DK5"
Date: Fri, 03 Dec 2004 15:48:24 -0500
Message-Id: <1102106904.19817.26.camel@dale.velocity.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1iAhnY+J5AqQ7eCZ5DK5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello List,

Hardware Specs:
Dual Xeon 2.8 (Dell PE2650)
2Gb RAM (Highmem on)
md raid, 4 md partitions (/, /boot, /var, /var/spool) all ext3.
2x Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet (rev 2).

Vanilla 2.6.9 with these patches applied:
http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-ck2/patches/vm-pages_scanned-active_list.patch
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/26-stable-release/acpi-20041015-26-latest-release.diff.bz2

Oops is attached (captured via serial console).  Box oopses every 1-7
days since upgrade from 2.4.23 to 2.6.9 (about a month ago).

Also attached is a page allocation error that showed up a couple times
before the OOPS.  After the OOPS the box is still pingable, but needs a
hard reset before services continue working.


Thanks,

Dale

--=-1iAhnY+J5AqQ7eCZ5DK5
Content-Disposition: attachment; filename=oops1.txt
Content-Type: text/plain; name=oops1.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: tg3 rtc
CPU:    2
EIP:    0060:[<c01e7ece>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9-ARCH)
EIP is at journal_commit_transaction+0x55e/0x1420
eax: cdb61f5c   ebx: 00000000   ecx: 00000000   edx: cdb61f5c
esi: eee3bb0c   edi: f7140000   ebp: f47c9b80   esp: f7141dc4
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 817, threadinfo=f7140000 task=f712b0d0)
Stack: eee3bb0c f47c9b80 00000008 00006ded c7f60030 f7140000 c218dec0 f47c9bb8
       c218de14 00000000 c201d020 00000000 f7140000 00000000 00000000 00000000
       00000000 00000000 c9124c8c ef0e02cc 00006ded 00000000 f712b0d0 c0120070
Call Trace:
 [<c0120070>] autoremove_wake_function+0x0/0x60
 [<c0120070>] autoremove_wake_function+0x0/0x60
 [<c011da70>] find_busiest_group+0xe0/0x370
 [<c011d8d5>] move_tasks+0x1b5/0x270
 [<c011e003>] load_balance_newidle+0x93/0xb0
 [<c011d09c>] finish_task_switch+0x3c/0x90
 [<c05be5ca>] schedule+0x34a/0xc10
 [<c012ae2f>] del_timer_sync+0x9f/0xf0
 [<c01eb5e4>] kjournald+0xc4/0x240
 [<c0120070>] autoremove_wake_function+0x0/0x60
 [<c0120070>] autoremove_wake_function+0x0/0x60
 [<c0106162>] ret_from_fork+0x6/0x14
 [<c01eb500>] commit_timeout+0x0/0x10
 [<c01eb520>] kjournald+0x0/0x240
 [<c01042d5>] kernel_thread_helper+0x5/0x10
Code: 14 8b 47 08 a8 08 0f 85 6f 0c 00 00 f0 ff 4b 0c 8b 4c 24 14 8b 41 08 a8 08 0f 85 3a 0c 00 00 8b 45 18 85 c0 74 3e 8b 70 20 8b 1e <f0> ff 43 0c 8b 03 
a8 04 0f 85 c0 00 00 00 89 5c 24 04 8b 94 24
 <0>Fatal exception: panic in 5 seconds
bad: scheduling while atomic!
 [<c05bec5d>] schedule+0x9dd/0xc10
 [<c0122652>] __call_console_drivers+0x62/0x70
 [<c0122770>] call_console_drivers+0x70/0x150
 [<c012abdf>] __mod_timer+0x12f/0x170
 [<c05bf336>] schedule_timeout+0x66/0xc0
 [<c0122a8a>] vprintk+0x13a/0x180
 [<c012b7c0>] process_timeout+0x0/0x10
 [<c0107552>] die+0x162/0x1a0
 [<c011b4f0>] do_page_fault+0x410/0x5ee
 [<c011cc36>] try_to_wake_up+0x216/0x2c0
 [<c05be8bb>] schedule+0x63b/0xc10
 [<c011e801>] __wake_up_common+0x41/0x70
 [<c011b0e0>] do_page_fault+0x0/0x5ee
 [<c0106cf5>] error_code+0x2d/0x38
 [<c01e7ece>] journal_commit_transaction+0x55e/0x1420
 [<c0120070>] autoremove_wake_function+0x0/0x60
 [<c0120070>] autoremove_wake_function+0x0/0x60
 [<c011da70>] find_busiest_group+0xe0/0x370
 [<c011d8d5>] move_tasks+0x1b5/0x270
 [<c011e003>] load_balance_newidle+0x93/0xb0
 [<c011d09c>] finish_task_switch+0x3c/0x90
 [<c05be5ca>] schedule+0x34a/0xc10
 [<c012ae2f>] del_timer_sync+0x9f/0xf0
 [<c01eb5e4>] kjournald+0xc4/0x240
 [<c0120070>] autoremove_wake_function+0x0/0x60
 [<c0120070>] autoremove_wake_function+0x0/0x60
 [<c0106162>] ret_from_fork+0x6/0x14
 [<c01eb500>] commit_timeout+0x0/0x10
 [<c01eb520>] kjournald+0x0/0x240
 [<c01042d5>] kernel_thread_helper+0x5/0x10

--=-1iAhnY+J5AqQ7eCZ5DK5
Content-Disposition: attachment; filename=page_allocation_error.txt
Content-Type: text/plain; name=page_allocation_error.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

smtpd: page allocation failure. order:1, mode:0x20
 [<c0144b44>] __alloc_pages+0x224/0x360
 [<c0144c9b>] __get_free_pages+0x1b/0x40
 [<c01485d3>] kmem_getpages+0x23/0xd0
 [<c0550a11>] tcp_v4_route_req+0xd1/0x1b0
 [<c01493e0>] cache_grow+0xc0/0x190
 [<c0149691>] cache_alloc_refill+0x1e1/0x220
 [<c01498d3>] kmem_cache_alloc+0x43/0x50
 [<c0512aa4>] sk_alloc+0x34/0xb0
 [<c0554b13>] tcp_create_openreq_child+0x33/0x540
 [<c0551287>] tcp_v4_syn_recv_sock+0x47/0x320
 [<c054fc94>] tcp_v4_synq_add+0xd4/0x120
 [<c0555188>] tcp_check_req+0x168/0x530
 [<f8984c7a>] tg3_start_xmit+0x44a/0x530 [tg3]
 [<f8984c7a>] tg3_start_xmit+0x44a/0x530 [tg3]
 [<c0528ce3>] qdisc_restart+0x23/0x230
 [<c0528ce3>] qdisc_restart+0x23/0x230
 [<c051a33a>] dev_queue_xmit+0x26a/0x300
 [<c0537bcd>] ip_finish_output+0xdd/0x270
 [<c0538405>] ip_queue_xmit+0x245/0x500
 [<c011c510>] recalc_task_prio+0xc0/0x1c0
 [<c011c6a2>] activate_task+0x92/0xb0
 [<c011cc36>] try_to_wake_up+0x216/0x2c0
 [<c011c510>] recalc_task_prio+0xc0/0x1c0
 [<c011c2e6>] task_rq_lock+0x36/0x70
 [<c011cc36>] try_to_wake_up+0x216/0x2c0
 [<c011e86e>] __wake_up+0x3e/0x60
 [<c011e801>] __wake_up_common+0x41/0x70
 [<c012abdf>] __mod_timer+0x12f/0x170
 [<c05137dc>] sk_reset_timer+0x1c/0x30
 [<c054c5dd>] tcp_send_delayed_ack+0x9d/0x140
 [<c05515c6>] tcp_v4_hnd_req+0x66/0x210
 [<c05519dc>] tcp_v4_do_rcv+0xfc/0x140
 [<c055226b>] tcp_v4_rcv+0x84b/0x970
 [<c0534475>] ip_local_deliver+0xa5/0x2b0
 [<c0534c53>] ip_rcv+0x3a3/0x540
 [<c0513e73>] alloc_skb+0x53/0x100
 [<c051aa0c>] netif_receive_skb+0x26c/0x2c0
 [<f8983f98>] tg3_rx+0x208/0x450 [tg3]
 [<f898427a>] tg3_poll+0x9a/0x170 [tg3]
 [<c051ac03>] net_rx_action+0x83/0x120
 [<c0127063>] __do_softirq+0x63/0xe0
 [<c012710d>] do_softirq+0x2d/0x30
 [<c0109247>] do_IRQ+0x127/0x140
 [<c0106bf8>] common_interrupt+0x18/0x20
 [<c05bfa7a>] _spin_unlock_irq+0xa/0x20
 [<c011d09c>] finish_task_switch+0x3c/0x90
 [<c05be5ca>] schedule+0x34a/0xc10
 [<c01449c8>] __alloc_pages+0xa8/0x360
 [<c05bf336>] schedule_timeout+0x66/0xc0
 [<c0576562>] unix_poll+0xb2/0xc0
 [<c012b7c0>] process_timeout+0x0/0x10
 [<c0174e18>] do_select+0x298/0x2e0
 [<c01749b0>] __pollwait+0x0/0xd0
 [<c017512f>] sys_select+0x28f/0x540
 [<c012660d>] do_setitimer+0x1fd/0x210
 [<c012670b>] sys_time+0x1b/0x60
 [<c0106239>] sysenter_past_esp+0x52/0x71

--=-1iAhnY+J5AqQ7eCZ5DK5--

