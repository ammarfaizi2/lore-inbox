Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWG1IJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWG1IJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWG1IJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:09:41 -0400
Received: from tornado.reub.net ([202.89.145.182]:52926 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1161091AbWG1IJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:09:38 -0400
Message-ID: <44C9C63F.7010801@reub.net>
Date: Fri, 28 Jul 2006 20:09:35 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 2.0a1 (Windows/20060727)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>,
       herbert@gondor.apana.org.au
Subject: Re: 2.6.18-rc2-mm1
References: <20060727015639.9c89db57.akpm@osdl.org>
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/07/2006 8:56 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
> 
> - git-klibc has been dropped due to very bad parallel-make problems.
> 
> - Added a new line to the boilerplate, below!
> 
> - Added Sam's lxdialog tree, as git-lxdialog.patch.  You no longer need
>   x-ray spectacles to read the menuconfig screens.
> 
> - Lots of random patches.  Many of them are bugfixes and I shall, as usual,
>   go through them all identifying 2.6.18 material.  But I can miss things, so
>   please don't be afraid to point 2.6.18 candidates out to me.
> 
>   I also have, as usual, a number of bugfixes agains the git trees.  I'll
>   send these to the maintainers until they stick and then I lose track of
>   them.  So don't be afraid to send reminders to the subsystem maintainers
>   either.

Still seeing breakage with the e1000/NAT.  Now the problem isn't so much that 
the bug exists, but that unlike in -rc1-mm2, the trace scrolls over and over and 
over (with some variation down into it) until the kernel completely panics and 
the box has to be rebooted.

http://www.ussg.iu.edu/hypermail/linux/kernel/0607.1/2689.html from Herbert Xu 
talks about the original problem.

It's a regression from the previous -mm whereby the trace would print out just once.

Starting Dovecot Imap: [  OK  ]
Starting clamd: [  OK  ]
Starting amavisd: BUG: warning at net/core/dev.c:1168/skb_checksum_help()

Call Trace:
  [<ffffffff80269c65>] show_trace+0xb5/0x324
  [<ffffffff80269ee9>] dump_stack+0x15/0x1c
  [<ffffffff8043d4e8>] skb_checksum_help+0x63/0x13b
  [<ffffffff8802f35f>] :iptable_nat:ip_nat_fn+0x5f/0x1d2
  [<ffffffff8802f71b>] :iptable_nat:ip_nat_local_fn+0x33/0xbc
  [<ffffffff80234c9e>] nf_iterate+0x5a/0x9b
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff80235174>] ip_queue_xmit+0x444/0x4c0
  [<ffffffff8022157f>] tcp_transmit_skb+0x68f/0x6cf
  [<ffffffff80233b67>] __tcp_push_pending_frames+0x867/0x95a
  [<ffffffff8021b9fc>] tcp_rcv_established+0x72c/0x7c4
  [<ffffffff8023c60e>] tcp_v4_do_rcv+0x2e/0x317
  [<ffffffff8022719c>] tcp_v4_rcv+0x9fc/0xa79
  [<ffffffff80235389>] ip_local_deliver+0x199/0x270
  [<ffffffff802363c3>] ip_rcv+0x4d3/0x52b
  [<ffffffff8021fdcb>] netif_receive_skb+0x1eb/0x27b
  [<ffffffff803c9491>] e1000_clean_rx_irq_ps+0x5c1/0x6a0
  [<ffffffff803c7b45>] e1000_clean+0x325/0x45b
  [<ffffffff8020c9b7>] net_rx_action+0x8e/0x147
  [<ffffffff80211663>] __do_softirq+0x78/0x105
  [<ffffffff80260716>] call_softirq+0x1e/0x28
DWARF2 unwinder stuck at call_softirq+0x1e/0x28
Leftover inexact backtrace:
  <IRQ> [<ffffffff8026b679>] do_softirq+0x39/0xa4
  [<ffffffff802888b8>] irq_exit+0x58/0x5a
  [<ffffffff8026b798>] do_IRQ+0xb4/0xbe
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [1] SMP
last sysfs file: /class/net/sit0/address
CPU 0
Modules linked in: hidp rfcomm l2cap bluetooth ipv6 ip_gre iptable_filter 
iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle

ip_tables binfmt_misc iTCO_wdt i2c_i801 serio_raw
Pid: 2127, comm: imap Not tainted 2.6.18-rc2-mm1 #1
RIP: 0010:[<ffffffff80269e6f>]  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
RSP: 0000:ffffffff806366f0  EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
RDX: 0000000000000010 RSI: ffff81003d95c840 RDI: ffff81003d95c140
RBP: ffffffff806367f0 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000002 R11: 0000000000000001 R12: ffffffff827ffff9
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80907000
FS:  00002ab5ab544860(0000) GS:ffffffff808b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000029dea000 CR4: 00000000000006e0
Process imap (pid: 2127, threadinfo ffff810029e62000, task ffff81003d95c140)
Stack:  ffffffff806cec48 ffffffff80636fc0 0000000000000001 ffff81002c9d78f8
  0000000000000000 0000000000000000 00007fffff571020 ffff810029e63f58
  ffffffff80636f80 0000000000000046 0000000000000000 0000000000000000
Call Trace:
  [<ffffffff80269ee9>] dump_stack+0x15/0x1c
  [<ffffffff8043d4e8>] skb_checksum_help+0x63/0x13b
  [<ffffffff8802f35f>] :iptable_nat:ip_nat_fn+0x5f/0x1d2
  [<ffffffff8802f71b>] :iptable_nat:ip_nat_local_fn+0x33/0xbc
  [<ffffffff80234c9e>] nf_iterate+0x5a/0x9b
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff80235174>] ip_queue_xmit+0x444/0x4c0
  [<ffffffff8022157f>] tcp_transmit_skb+0x68f/0x6cf
  [<ffffffff80233b67>] __tcp_push_pending_frames+0x867/0x95a
  [<ffffffff8021b9fc>] tcp_rcv_established+0x72c/0x7c4
  [<ffffffff8023c60e>] tcp_v4_do_rcv+0x2e/0x317
  [<ffffffff8022719c>] tcp_v4_rcv+0x9fc/0xa79
  [<ffffffff80235389>] ip_local_deliver+0x199/0x270
  [<ffffffff802363c3>] ip_rcv+0x4d3/0x52b
  [<ffffffff8021fdcb>] netif_receive_skb+0x1eb/0x27b
  [<ffffffff803c9491>] e1000_clean_rx_irq_ps+0x5c1/0x6a0
  [<ffffffff803c7b45>] e1000_clean+0x325/0x45b
  [<ffffffff8020c9b7>] net_rx_action+0x8e/0x147
  [<ffffffff80211663>] __do_softirq+0x78/0x105
  [<ffffffff80260716>] call_softirq+0x1e/0x28
DWARF2 unwinder stuck at call_softirq+0x1e/0x28
Leftover inexact backtrace:
  <IRQ> [<ffffffff8026b679>] do_softirq+0x39/0xa4
  [<ffffffff802888b8>] irq_exit+0x58/0x5a
  [<ffffffff8026b798>] do_IRQ+0xb4/0xbe
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [2] SMP
last sysfs file: /class/net/sit0/address
CPU 0
Modules linked in: hidp rfcomm l2cap bluetooth ipv6 ip_gre iptable_filter 
iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle

ip_tables binfmt_misc iTCO_wdt i2c_i801 serio_raw
Pid: 2127, comm: imap Not tainted 2.6.18-rc2-mm1 #1
RIP: 0010:[<ffffffff80269e6f>]  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
RSP: 0000:ffffffff80636378  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff880a3808
RDX: ffff81003d95c140 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff80636478 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff8029fae0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80907000
FS:  00002ab5ab544860(0000) GS:ffffffff808b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000029dea000 CR4: 00000000000006e0
Process imap (pid: 2127, threadinfo ffff810029e62000, task ffff81003d95c140)
Stack:  000000000000000b ffffffff80636fc0 0000000080632fc0 0000000000000000
  0000000000000000 0000000000000000 00007fffff571020 ffff810029e63f58
  ffffffff80636f80 0000000000000046 0000000000000001 0000000000000002
Call Trace:
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff802601ed>] error_exit+0x0/0x96
DWARF2 unwinder stuck at error_exit+0x0/0x96
Leftover inexact backtrace:
  <IRQ> [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff80269ee9>] dump_stack+0x15/0x1c
  [<ffffffff8043d4e8>] skb_checksum_help+0x63/0x13b
  [<ffffffff8802f35f>] :iptable_nat:ip_nat_fn+0x5f/0x1d2
  [<ffffffff8802f71b>] :iptable_nat:ip_nat_local_fn+0x33/0xbc
  [<ffffffff80234c9e>] nf_iterate+0x5a/0x9b
  [<ffffffff804579a6>] dst_output+0x0/0x10
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff804579a6>] dst_output+0x0/0x10
  [<ffffffff80265999>] _spin_unlock_irqrestore+0x3f/0x47
  [<ffffffff80235174>] ip_queue_xmit+0x444/0x4c0
  [<ffffffff8024bc5d>] tso_fragment+0x5d/0x20e
  [<ffffffff80210009>] __kmalloc_track_caller+0x109/0x11b
  [<ffffffff8022157f>] tcp_transmit_skb+0x68f/0x6cf
  [<ffffffff8024bda6>] tso_fragment+0x1a6/0x20e
  [<ffffffff80233b67>] __tcp_push_pending_frames+0x867/0x95a
  [<ffffffff80228ef8>] __kfree_skb+0xfc/0x101
  [<ffffffff80236fe1>] tcp_data_queue+0x651/0xc39
  [<ffffffff8021b9fc>] tcp_rcv_established+0x72c/0x7c4
  [<ffffffff8023c60e>] tcp_v4_do_rcv+0x2e/0x317
  [<ffffffff8022719c>] tcp_v4_rcv+0x9fc/0xa79
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff804552b0>] ip_local_deliver_finish+0x0/0x1fb
  [<ffffffff80235389>] ip_local_deliver+0x199/0x270
  [<ffffffff802363c3>] ip_rcv+0x4d3/0x52b
  [<ffffffff80439ccc>] kfree_skb+0x2c/0x31
  [<ffffffff8021fdcb>] netif_receive_skb+0x1eb/0x27b
  [<ffffffff803c9491>] e1000_clean_rx_irq_ps+0x5c1/0x6a0
  [<ffffffff803c7b45>] e1000_clean+0x325/0x45b
  [<ffffffff8020c9b7>] net_rx_action+0x8e/0x147
  [<ffffffff8021164f>] __do_softirq+0x64/0x105
  [<ffffffff80211663>] __do_softirq+0x78/0x105
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff8026b679>] do_softirq+0x39/0xa4
  [<ffffffff802888b8>] irq_exit+0x58/0x5a
  [<ffffffff8026b798>] do_IRQ+0xb4/0xbe
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [3] SMP
last sysfs file: /class/net/sit0/address
CPU 0
Modules linked in: hidp rfcomm l2cap bluetooth ipv6 ip_gre iptable_filter 
iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle

ip_tables binfmt_misc iTCO_wdt i2c_i801 serio_raw
Pid: 2127, comm: imap Not tainted 2.6.18-rc2-mm1 #1
RIP: 0010:[<ffffffff80269e6f>]  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
RSP: 0000:ffffffff80635ff8  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff880a3808
RDX: ffff81003d95c140 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff806360f8 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff8029fae0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80907000
FS:  00002ab5ab544860(0000) GS:ffffffff808b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000029dea000 CR4: 00000000000006e0
Process imap (pid: 2127, threadinfo ffff810029e62000, task ffff81003d95c140)
Stack:  000000000000000b ffffffff80636fc0 0000000080632fc0 0000000000000000
  ffffffff80907000 0000000000000000 0000000000000000 ffffffff827ffff9
  000000008025fa27 0000000000000001 0000000000000000 ffffffff8029fae0
Call Trace:
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff802601ed>] error_exit+0x0/0x96
DWARF2 unwinder stuck at error_exit+0x0/0x96
Leftover inexact backtrace:
  <IRQ> [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80269e7b>] show_trace+0x2cb/0x324
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff8029a627>] mark_held_locks+0x5d/0x96
  [<ffffffff8029a7e7>] trace_hardirqs_on+0xec/0x12c
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff80269ee9>] dump_stack+0x15/0x1c
  [<ffffffff8043d4e8>] skb_checksum_help+0x63/0x13b
  [<ffffffff8802f35f>] :iptable_nat:ip_nat_fn+0x5f/0x1d2
  [<ffffffff8802f71b>] :iptable_nat:ip_nat_local_fn+0x33/0xbc
  [<ffffffff80234c9e>] nf_iterate+0x5a/0x9b
  [<ffffffff804579a6>] dst_output+0x0/0x10
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff804579a6>] dst_output+0x0/0x10
  [<ffffffff80265999>] _spin_unlock_irqrestore+0x3f/0x47
  [<ffffffff80235174>] ip_queue_xmit+0x444/0x4c0
  [<ffffffff8024bc5d>] tso_fragment+0x5d/0x20e
  [<ffffffff80210009>] __kmalloc_track_caller+0x109/0x11b
  [<ffffffff8022157f>] tcp_transmit_skb+0x68f/0x6cf
  [<ffffffff8024bda6>] tso_fragment+0x1a6/0x20e
  [<ffffffff80233b67>] __tcp_push_pending_frames+0x867/0x95a
  [<ffffffff80228ef8>] __kfree_skb+0xfc/0x101
  [<ffffffff80236fe1>] tcp_data_queue+0x651/0xc39
  [<ffffffff8021b9fc>] tcp_rcv_established+0x72c/0x7c4
  [<ffffffff8023c60e>] tcp_v4_do_rcv+0x2e/0x317
  [<ffffffff8022719c>] tcp_v4_rcv+0x9fc/0xa79
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff804552b0>] ip_local_deliver_finish+0x0/0x1fb
  [<ffffffff80235389>] ip_local_deliver+0x199/0x270
  [<ffffffff802363c3>] ip_rcv+0x4d3/0x52b
  [<ffffffff80439ccc>] kfree_skb+0x2c/0x31
  [<ffffffff8021fdcb>] netif_receive_skb+0x1eb/0x27b
  [<ffffffff803c9491>] e1000_clean_rx_irq_ps+0x5c1/0x6a0
  [<ffffffff803c7b45>] e1000_clean+0x325/0x45b
  [<ffffffff8020c9b7>] net_rx_action+0x8e/0x147
  [<ffffffff8021164f>] __do_softirq+0x64/0x105
  [<ffffffff80211663>] __do_softirq+0x78/0x105
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff8026b679>] do_softirq+0x39/0xa4
  [<ffffffff802888b8>] irq_exit+0x58/0x5a
  [<ffffffff8026b798>] do_IRQ+0xb4/0xbe
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [4] SMP
last sysfs file: /class/net/sit0/address
CPU 0
Modules linked in: hidp rfcomm l2cap bluetooth ipv6 ip_gre iptable_filter 
iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle

ip_tables binfmt_misc iTCO_wdt i2c_i801 serio_raw
Pid: 2127, comm: imap Not tainted 2.6.18-rc2-mm1 #1
RIP: 0010:[<ffffffff80269e6f>]  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
RSP: 0000:ffffffff80635c78  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff880a3808
RDX: ffff81003d95c140 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff80635d78 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff8029fae0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80907000
FS:  00002ab5ab544860(0000) GS:ffffffff808b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000029dea000 CR4: 00000000000006e0
Process imap (pid: 2127, threadinfo ffff810029e62000, task ffff81003d95c140)
Stack:  000000000000000b ffffffff80636fc0 0000000080632fc0 0000000000000000
  ffffffff80907000 0000000000000000 0000000000000000 ffffffff827ffff9
  000000008025fa27 0000000000000001 0000000000000000 ffffffff8029fae0
Call Trace:
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff802601ed>] error_exit+0x0/0x96
DWARF2 unwinder stuck at error_exit+0x0/0x96
Leftover inexact backtrace:
  <IRQ> [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80269e7b>] show_trace+0x2cb/0x324
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff80285f9f>] vprintk+0x30f/0x35d
  [<ffffffff802a2f8a>] kallsyms_lookup+0xea/0x1b5
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80269e7b>] show_trace+0x2cb/0x324
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff8029a627>] mark_held_locks+0x5d/0x96
  [<ffffffff8029a7e7>] trace_hardirqs_on+0xec/0x12c
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff80269ee9>] dump_stack+0x15/0x1c
  [<ffffffff8043d4e8>] skb_checksum_help+0x63/0x13b
  [<ffffffff8802f35f>] :iptable_nat:ip_nat_fn+0x5f/0x1d2
  [<ffffffff8802f71b>] :iptable_nat:ip_nat_local_fn+0x33/0xbc
  [<ffffffff80234c9e>] nf_iterate+0x5a/0x9b
  [<ffffffff804579a6>] dst_output+0x0/0x10
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff804579a6>] dst_output+0x0/0x10
  [<ffffffff80265999>] _spin_unlock_irqrestore+0x3f/0x47
  [<ffffffff80235174>] ip_queue_xmit+0x444/0x4c0
  [<ffffffff8024bc5d>] tso_fragment+0x5d/0x20e
  [<ffffffff80210009>] __kmalloc_track_caller+0x109/0x11b
  [<ffffffff8022157f>] tcp_transmit_skb+0x68f/0x6cf
  [<ffffffff8024bda6>] tso_fragment+0x1a6/0x20e
  [<ffffffff80233b67>] __tcp_push_pending_frames+0x867/0x95a
  [<ffffffff80228ef8>] __kfree_skb+0xfc/0x101
  [<ffffffff80236fe1>] tcp_data_queue+0x651/0xc39
  [<ffffffff8021b9fc>] tcp_rcv_established+0x72c/0x7c4
  [<ffffffff8023c60e>] tcp_v4_do_rcv+0x2e/0x317
  [<ffffffff8022719c>] tcp_v4_rcv+0x9fc/0xa79
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff804552b0>] ip_local_deliver_finish+0x0/0x1fb
  [<ffffffff80235389>] ip_local_deliver+0x199/0x270
  [<ffffffff802363c3>] ip_rcv+0x4d3/0x52b
  [<ffffffff80439ccc>] kfree_skb+0x2c/0x31
  [<ffffffff8021fdcb>] netif_receive_skb+0x1eb/0x27b
  [<ffffffff803c9491>] e1000_clean_rx_irq_ps+0x5c1/0x6a0
  [<ffffffff803c7b45>] e1000_clean+0x325/0x45b
  [<ffffffff8020c9b7>] net_rx_action+0x8e/0x147
  [<ffffffff8021164f>] __do_softirq+0x64/0x105
  [<ffffffff80211663>] __do_softirq+0x78/0x105
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff8026b679>] do_softirq+0x39/0xa4
  [<ffffffff802888b8>] irq_exit+0x58/0x5a
  [<ffffffff8026b798>] do_IRQ+0xb4/0xbe
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [5] SMP
last sysfs file: /class/net/sit0/address
CPU 0
Modules linked in: hidp rfcomm l2cap bluetooth ipv6 ip_gre iptable_filter 
iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle

ip_tables binfmt_misc iTCO_wdt i2c_i801 serio_raw
Pid: 2127, comm: imap Not tainted 2.6.18-rc2-mm1 #1
RIP: 0010:[<ffffffff80269e6f>]  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
RSP: 0000:ffffffff806358f8  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff880a3808
RDX: ffff81003d95c140 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff806359f8 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff8029fae0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80907000
FS:  00002ab5ab544860(0000) GS:ffffffff808b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000029dea000 CR4: 00000000000006e0
Process imap (pid: 2127, threadinfo ffff810029e62000, task ffff81003d95c140)
Stack:  000000000000000b ffffffff80636fc0 0000000080632fc0 0000000000000000
  ffffffff80907000 0000000000000000 0000000000000000 ffffffff827ffff9
  000000008025fa27 0000000000000001 0000000000000000 ffffffff8029fae0
Call Trace:
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff802601ed>] error_exit+0x0/0x96
DWARF2 unwinder stuck at error_exit+0x0/0x96
Leftover inexact backtrace:
  <IRQ> [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80269e7b>] show_trace+0x2cb/0x324
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff80285f9f>] vprintk+0x30f/0x35d
  [<ffffffff8802f71b>] :iptable_nat:ip_nat_local_fn+0x33/0xbc
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80269e7b>] show_trace+0x2cb/0x324
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff80285f9f>] vprintk+0x30f/0x35d
  [<ffffffff802a2f8a>] kallsyms_lookup+0xea/0x1b5
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80269e7b>] show_trace+0x2cb/0x324
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff8029a627>] mark_held_locks+0x5d/0x96
  [<ffffffff8029a7e7>] trace_hardirqs_on+0xec/0x12c
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff80269ee9>] dump_stack+0x15/0x1c
  [<ffffffff8043d4e8>] skb_checksum_help+0x63/0x13b
  [<ffffffff8802f35f>] :iptable_nat:ip_nat_fn+0x5f/0x1d2
  [<ffffffff8802f71b>] :iptable_nat:ip_nat_local_fn+0x33/0xbc
  [<ffffffff80234c9e>] nf_iterate+0x5a/0x9b
  [<ffffffff804579a6>] dst_output+0x0/0x10
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff804579a6>] dst_output+0x0/0x10
  [<ffffffff80265999>] _spin_unlock_irqrestore+0x3f/0x47
  [<ffffffff80235174>] ip_queue_xmit+0x444/0x4c0
  [<ffffffff8024bc5d>] tso_fragment+0x5d/0x20e
  [<ffffffff80210009>] __kmalloc_track_caller+0x109/0x11b
  [<ffffffff8022157f>] tcp_transmit_skb+0x68f/0x6cf
  [<ffffffff8024bda6>] tso_fragment+0x1a6/0x20e
  [<ffffffff80233b67>] __tcp_push_pending_frames+0x867/0x95a
  [<ffffffff80228ef8>] __kfree_skb+0xfc/0x101
  [<ffffffff80236fe1>] tcp_data_queue+0x651/0xc39
  [<ffffffff8021b9fc>] tcp_rcv_established+0x72c/0x7c4
  [<ffffffff8023c60e>] tcp_v4_do_rcv+0x2e/0x317
  [<ffffffff8022719c>] tcp_v4_rcv+0x9fc/0xa79
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff804552b0>] ip_local_deliver_finish+0x0/0x1fb
  [<ffffffff80235389>] ip_local_deliver+0x199/0x270
  [<ffffffff802363c3>] ip_rcv+0x4d3/0x52b
  [<ffffffff80439ccc>] kfree_skb+0x2c/0x31
  [<ffffffff8021fdcb>] netif_receive_skb+0x1eb/0x27b
  [<ffffffff803c9491>] e1000_clean_rx_irq_ps+0x5c1/0x6a0
  [<ffffffff803c7b45>] e1000_clean+0x325/0x45b
  [<ffffffff8020c9b7>] net_rx_action+0x8e/0x147
  [<ffffffff8021164f>] __do_softirq+0x64/0x105
  [<ffffffff80211663>] __do_softirq+0x78/0x105
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff8026b679>] do_softirq+0x39/0xa4
  [<ffffffff802888b8>] irq_exit+0x58/0x5a
  [<ffffffff8026b798>] do_IRQ+0xb4/0xbe
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [6] SMP
last sysfs file: /class/net/sit0/address
CPU 0
Modules linked in: hidp rfcomm l2cap bluetooth ipv6 ip_gre iptable_filter 
iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle

ip_tables binfmt_misc iTCO_wdt i2c_i801 serio_raw
Pid: 2127, comm: imap Not tainted 2.6.18-rc2-mm1 #1
RIP: 0010:[<ffffffff80269e6f>]  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
RSP: 0000:ffffffff80635578  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff880a3808
RDX: ffff81003d95c140 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff80635678 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff8029fae0 R11: 0000000000000000 R12: ffffffff827ffff9
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80907000
FS:  00002ab5ab544860(0000) GS:ffffffff808b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000029dea000 CR4: 00000000000006e0
Process imap (pid: 2127, threadinfo ffff810029e62000, task ffff81003d95c140)
Stack:  000000000000000b ffffffff80636fc0 0000000080632fc0 0000000000000000
  ffffffff80907000 0000000000000000 0000000000000000 ffffffff827ffff9
  000000008025fa27 0000000000000001 0000000000000000 ffffffff8029fae0
Call Trace:
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff802601ed>] error_exit+0x0/0x96
DWARF2 unwinder stuck at error_exit+0x0/0x96
Leftover inexact backtrace:
  <IRQ> [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80269e7b>] show_trace+0x2cb/0x324
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff80285f9f>] vprintk+0x30f/0x35d
  [<ffffffff8802f71b>] :iptable_nat:ip_nat_local_fn+0x33/0xbc
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80269e7b>] show_trace+0x2cb/0x324
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff80285f9f>] vprintk+0x30f/0x35d
  [<ffffffff8802f71b>] :iptable_nat:ip_nat_local_fn+0x33/0xbc
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80269e7b>] show_trace+0x2cb/0x324
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff80285f9f>] vprintk+0x30f/0x35d
  [<ffffffff802a2f8a>] kallsyms_lookup+0xea/0x1b5
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff8029fae0>] module_text_address+0x16/0x46
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80269e7b>] show_trace+0x2cb/0x324
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff80269fdf>] _show_stack+0xef/0xfe
  [<ffffffff8026a07a>] show_registers+0x8c/0x101
  [<ffffffff8026a18f>] __die+0xa0/0xe3
  [<ffffffff8020af95>] do_page_fault+0x785/0x89d
  [<ffffffff8029a627>] mark_held_locks+0x5d/0x96
  [<ffffffff8029a7e7>] trace_hardirqs_on+0xec/0x12c
  [<ffffffff802601ed>] error_exit+0x0/0x96
  [<ffffffff80269e6f>] show_trace+0x2bf/0x324
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff80269ee9>] dump_stack+0x15/0x1c
  [<ffffffff8043d4e8>] skb_checksum_help+0x63/0x13b
  [<ffffffff8802f35f>] :iptable_nat:ip_nat_fn+0x5f/0x1d2
  [<ffffffff8802f71b>] :iptable_nat:ip_nat_local_fn+0x33/0xbc
  [<ffffffff80234c9e>] nf_iterate+0x5a/0x9b
  [<ffffffff804579a6>] dst_output+0x0/0x10
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff804579a6>] dst_output+0x0/0x10
  [<ffffffff80265999>] _spin_unlock_irqrestore+0x3f/0x47
  [<ffffffff80235174>] ip_queue_xmit+0x444/0x4c0
  [<ffffffff8024bc5d>] tso_fragment+0x5d/0x20e
  [<ffffffff80210009>] __kmalloc_track_caller+0x109/0x11b
  [<ffffffff8022157f>] tcp_transmit_skb+0x68f/0x6cf
  [<ffffffff8024bda6>] tso_fragment+0x1a6/0x20e
  [<ffffffff80233b67>] __tcp_push_pending_frames+0x867/0x95a
  [<ffffffff80228ef8>] __kfree_skb+0xfc/0x101
  [<ffffffff80236fe1>] tcp_data_queue+0x651/0xc39
  [<ffffffff8021b9fc>] tcp_rcv_established+0x72c/0x7c4
  [<ffffffff8023c60e>] tcp_v4_do_rcv+0x2e/0x317
  [<ffffffff8022719c>] tcp_v4_rcv+0x9fc/0xa79
  [<ffffffff80258960>] nf_hook_slow+0x60/0xcd
  [<ffffffff804552b0>] ip_local_deliver_finish+0x0/0x1fb
  [<ffffffff80235389>] ip_local_deliver+0x199/0x270
  [<ffffffff802363c3>] ip_rcv+0x4d3/0x52b
  [<ffffffff80439ccc>] kfree_skb+0x2c/0x31
  [<ffffffff8021fdcb>] netif_receive_skb+0x1eb/0x27b
  [<ffffffff803c9491>] e1000_clean_rx_irq_ps+0x5c1/0x6a0
  [<ffffffff803c7b45>] e1000_clean+0x325/0x45b
  [<ffffffff8020c9b7>] net_rx_action+0x8e/0x147
  [<ffffffff8021164f>] __do_softirq+0x64/0x105
  [<ffffffff80211663>] __do_softirq+0x78/0x105
  [<ffffffff80260716>] call_softirq+0x1e/0x28
  [<ffffffff8026b679>] do_softirq+0x39/0xa4
  [<ffffffff802888b8>] irq_exit+0x58/0x5a
  [<ffffffff8026b798>] do_IRQ+0xb4/0xbe
  [<ffffffff8025f9a1>] ret_from_intr+0x0/0xf
  <EOI>

Thanks,
Reuben
