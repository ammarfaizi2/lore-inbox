Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWBGNXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWBGNXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbWBGNXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:23:30 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:8886 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S965075AbWBGNX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:23:29 -0500
Date: Tue, 7 Feb 2006 14:23:27 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.15] frequent "BUG: soft lockup detected on CPU#0" in IDE
	subsystem
Message-ID: <20060207132255.GX4305@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Tue Feb  7 12:52:36 CET 2006
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel: 2.6.15
system: 3.2GHz P4 hyperthreading, 1xIDE, 2GB ram
it seems to happen (altough I'm really not sure!) when the system is
under heavily load: > 8.0, while running sa-learn (the spamassassin
bayes training tool)

[17864.859378] BUG: soft lockup detected on CPU#0!
[17864.859431]
[17864.859474] Pid: 4, comm:           watchdog/0
[17864.859516] EIP: 0060:[<c022ef4c>] CPU: 0
[17864.859562] EIP is at ide_pio_sector+0xb2/0xdf
[17864.859606]  EFLAGS: 00000206    Not tainted  (2.6.15-pwc-ara)
[17864.859651] EAX: c2148000 EBX: eed00e00 ECX: 00000000 EDX: 00000005
[17864.859695] ESI: f7d0b000 EDI: c03f4c00 EBP: c03f4c94 DS: 007b ES: 007b
[17864.859775] CR0: 8005003b CR2: 40001000 CR3: 003b4000 CR4: 000006d0
[17864.859841]  [<c022efab>] ide_pio_multi+0x32/0x3b
[17864.859957]  [<c022f253>] task_out_intr+0xc3/0xe5
[17864.860071]  [<c01231e6>] del_timer+0x56/0x58
[17864.860250]  [<c022f190>] task_out_intr+0x0/0xe5
[17864.860364]  [<c022ab5f>] ide_intr+0xbe/0x139
[17864.860487]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[17864.860608]  [<c013a264>] __do_IRQ+0x80/0xe0
[17864.860728]  [<c0104dc6>] do_IRQ+0x36/0x66
[17864.860905]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[17864.861019]  [<c01034f2>] common_interrupt+0x1a/0x20
[17864.861145]  [<c02a7a69>] tcp_v4_rcv+0x8b6/0x92e
[17864.861263]  [<c01034f2>] common_interrupt+0x1a/0x20
[17864.861394]  [<c028d6e3>] ip_local_deliver+0xe3/0x250
[17864.861573]  [<c028dd8b>] ip_local_deliver_finish+0x0/0x1cc
[17864.861695]  [<c028dae5>] ip_rcv+0x295/0x53b
[17864.861810]  [<c028df57>] ip_rcv_finish+0x0/0x295
[17864.861939]  [<c0274629>] netif_receive_skb+0x283/0x352
[17864.862055]  [<c0104dcb>] do_IRQ+0x3b/0x66
[17864.862179]  [<c027477e>] process_backlog+0x86/0x106
[17864.862367]  [<c0274886>] net_rx_action+0x88/0x160
[17864.862487]  [<c011fb34>] __do_softirq+0xbc/0xce
[17864.862605]  [<c013a06c>] watchdog+0x0/0x62
[17864.862716]  [<c011fb78>] do_softirq+0x32/0x34
[17864.862830]  [<c0104dcb>] do_IRQ+0x3b/0x66
[17864.863008]  [<c02c9b9c>] schedule_timeout+0x61/0xa6
[17864.863123]  [<c01034f2>] common_interrupt+0x1a/0x20
[17864.863242]  [<c013a06c>] watchdog+0x0/0x62
[17864.863357]  [<c0123d4d>] msleep_interruptible+0x39/0x44
[17864.863473]  [<c013a0b1>] watchdog+0x45/0x62
[17864.863653]  [<c012d42e>] kthread+0x9c/0xa1
[17864.863770]  [<c012d392>] kthread+0x0/0xa1
[17864.863886]  [<c0101065>] kernel_thread_helper+0x5/0xb

0 folkert@muur:~$ cat /proc/interrupts
           CPU0       CPU1
  0:   33442442          0    IO-APIC-edge  timer
  1:       2640          0    IO-APIC-edge  i8042
  4:     332867          0    IO-APIC-edge  serial
  7:          0          0    IO-APIC-edge  parport0
  9:          0          0   IO-APIC-level  acpi
 12:        101          0    IO-APIC-edge  i8042
 14:   10824921          0    IO-APIC-edge  ide0
 15:        290          0    IO-APIC-edge  ide1
 16:   32379849      37126   IO-APIC-level  eth0, eth1
 17:          0          0   IO-APIC-level  uhci_hcd:usb5
 18:  342596358          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb8, wcfxo
 19:     336293          0   IO-APIC-level  ehci_hcd:usb2, bttv0
 20:   11248924          0   IO-APIC-level  uhci_hcd:usb3, uhci_hcd:usb6
 21:      60570          0   IO-APIC-level  uhci_hcd:usb4
 22:   70615362          0   IO-APIC-level  uhci_hcd:usb7
 23:         10          0   IO-APIC-level  Intel ICH5
NMI:   33442403   33442390
LOC:   33444212   33444195
ERR:          0
MIS:      37126


Some more dumps from the same running system (from dmesg):


[46902.405002] BUG: soft lockup detected on CPU#0!
[46902.405060]
[46902.405105] Pid: 4, comm:           watchdog/0
[46902.405148] EIP: 0060:[<c022ef4c>] CPU: 0
[46902.405193] EIP is at ide_pio_sector+0xb2/0xdf
[46902.405235]  EFLAGS: 00000202    Not tainted  (2.6.15-pwc-ara)
[46902.405279] EAX: c2148000 EBX: ecb1c200 ECX: 00000000 EDX: 00000005
[46902.405323] ESI: f7d0b000 EDI: c03f4c00 EBP: c03f4c94 DS: 007b ES: 007b
[46902.405401] CR0: 8005003b CR2: 410ebcb0 CR3: 003b4000 CR4: 000006d0
[46902.405466]  [<c022efab>] ide_pio_multi+0x32/0x3b
[46902.405583]  [<c022f253>] task_out_intr+0xc3/0xe5
[46902.405697]  [<c01231e6>] del_timer+0x56/0x58
[46902.405880]  [<c022f190>] task_out_intr+0x0/0xe5
[46902.405996]  [<c022ab5f>] ide_intr+0xbe/0x139
[46902.406107]  [<c022f190>] task_out_intr+0x0/0xe5
[46902.406227]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[46902.406346]  [<c013a264>] __do_IRQ+0x80/0xe0
[46902.406531]  [<c0104dc6>] do_IRQ+0x36/0x66
[46902.406647]  [<f888e130>] death_by_timeout+0x0/0x4f [ip_conntrack]
[46902.406772]  [<c01034f2>] common_interrupt+0x1a/0x20
[46902.406898]  [<f888007b>] init_netconsole+0x22/0x7a [netconsole]
[46902.407017]  [<c0126e05>] notifier_call_chain+0xb/0x2b
[46902.407200]  [<f888e130>] death_by_timeout+0x0/0x4f [ip_conntrack]
[46902.407318]  [<f888e12b>] destroy_conntrack+0xf7/0xfc [ip_conntrack]
[46902.407438]  [<f888e17d>] death_by_timeout+0x4d/0x4f [ip_conntrack]
[46902.407557]  [<c0123766>] run_timer_softirq+0xc7/0x18a
[46902.407688]  [<c011fb34>] __do_softirq+0xbc/0xce
[46902.407807]  [<c011fb78>] do_softirq+0x32/0x34
[46902.407985]  [<c0104dcb>] do_IRQ+0x3b/0x66
[46902.408099]  [<c0123048>] lock_timer_base+0x20/0x45
[46902.408213]  [<c01034f2>] common_interrupt+0x1a/0x20
[46902.408340]  [<c02c8d1a>] schedule+0x4de/0xc46
[46902.408476]  [<c011fe21>] tasklet_action+0x6a/0xb6
[46902.408676]  [<c013a06c>] watchdog+0x0/0x62
[46902.408787]  [<c02c9b8e>] schedule_timeout+0x53/0xa6
[46902.408899]  [<c01034f2>] common_interrupt+0x1a/0x20
[46902.409019]  [<c01239e2>] process_timeout+0x0/0x5
[46902.409139]  [<c0123d4d>] msleep_interruptible+0x39/0x44
[46902.409316]  [<c013a0b1>] watchdog+0x45/0x62
[46902.409429]  [<c012d42e>] kthread+0x9c/0xa1
[46902.409543]  [<c012d392>] kthread+0x0/0xa1
[46902.409660]  [<c0101065>] kernel_thread_helper+0x5/0xb

[133279.324446] BUG: soft lockup detected on CPU#0!
[133279.324496]
[133279.324539] Pid: 14541, comm:               mklogs
[133279.324582] EIP: 0060:[<c022ef4c>] CPU: 0
[133279.324629] EIP is at ide_pio_sector+0xb2/0xdf
[133279.324672]  EFLAGS: 00200206    Not tainted  (2.6.15-pwc-ara)
[133279.324716] EAX: d084c000 EBX: dc035000 ECX: 00000000 EDX: 00000005
[133279.324760] ESI: f7d0b000 EDI: c03f4c00 EBP: c03f4c94 DS: 007b ES: 007b
[133279.324838] CR0: 8005003b CR2: 080eac58 CR3: 23bd3000 CR4: 000006d0
[133279.324902]  [<c022efab>] ide_pio_multi+0x32/0x3b
[133279.325017]  [<c022f253>] task_out_intr+0xc3/0xe5
[133279.325127]  [<c01231e6>] del_timer+0x56/0x58
[133279.325308]  [<c022f190>] task_out_intr+0x0/0xe5
[133279.325422]  [<c022ab5f>] ide_intr+0xbe/0x139
[133279.325545]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[133279.325665]  [<c013a264>] __do_IRQ+0x80/0xe0
[133279.325785]  [<c0104dc6>] do_IRQ+0x36/0x66
[133279.325961]  [<f888e130>] death_by_timeout+0x0/0x4f [ip_conntrack]
[133279.326085]  [<c01034f2>] common_interrupt+0x1a/0x20
[133279.326208]  [<f888007b>] init_netconsole+0x22/0x7a [netconsole]
[133279.326326]  [<c0144bb2>] kmem_cache_free+0x34/0x50
[133279.326445]  [<f888e130>] death_by_timeout+0x0/0x4f [ip_conntrack]
[133279.326630]  [<f888e17d>] death_by_timeout+0x4d/0x4f [ip_conntrack]
[133279.326748]  [<c0123766>] run_timer_softirq+0xc7/0x18a
[133279.326876]  [<c011fb34>] __do_softirq+0xbc/0xce
[133279.326994]  [<c011fb78>] do_softirq+0x32/0x34
[133279.327105]  [<c0104dcb>] do_IRQ+0x3b/0x66
[133279.327221]  [<c01034f2>] common_interrupt+0x1a/0x20
[133279.327413]  [<c0161533>] copy_strings+0x115/0x212
[133279.327528]  [<c01034f2>] common_interrupt+0x1a/0x20
[133279.327663]  [<c0161650>] copy_strings_kernel+0x20/0x2e
[133279.327777]  [<c0162965>] do_execve+0x102/0x1c8
[133279.327895]  [<c01018f5>] sys_execve+0x39/0x82
[133279.328076]  [<c0102b25>] syscall_call+0x7/0xb

[219632.784839] BUG: soft lockup detected on CPU#0!
[219632.784911]
[219632.784954] Pid: 4, comm:           watchdog/0
[219632.784997] EIP: 0060:[<c022ef4c>] CPU: 0
[219632.785042] EIP is at ide_pio_sector+0xb2/0xdf
[219632.785086]  EFLAGS: 00000206    Not tainted  (2.6.15-pwc-ara)
[219632.785130] EAX: c2148000 EBX: e829ea00 ECX: 00000000 EDX: 00000005
[219632.785175] ESI: f7d0b000 EDI: c03f4c00 EBP: c03f4c94 DS: 007b ES: 007b
[219632.785258] CR0: 8005003b CR2: 080e594c CR3: 003b4000 CR4: 000006d0
[219632.785324]  [<c022efab>] ide_pio_multi+0x32/0x3b
[219632.785442]  [<c022f253>] task_out_intr+0xc3/0xe5
[219632.785554]  [<c01231e6>] del_timer+0x56/0x58
[219632.785732]  [<c022f190>] task_out_intr+0x0/0xe5
[219632.785845]  [<c022ab5f>] ide_intr+0xbe/0x139
[219632.785967]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[219632.786087]  [<c013a264>] __do_IRQ+0x80/0xe0
[219632.786209]  [<c0104dc6>] do_IRQ+0x36/0x66
[219632.786392]  [<c01034f2>] common_interrupt+0x1a/0x20
[219632.786518]  [<c02ca4a7>] _spin_unlock_irqrestore+0x5/0x6
[219632.786633]  [<c0244f88>] ehci_hub_status_data+0x90/0xf4
[219632.786752]  [<c023943e>] rh_timer_func+0x0/0x5
[219632.786864]  [<c0239343>] usb_hcd_poll_rh_status+0x3b/0x136
[219632.787046]  [<c023943e>] rh_timer_func+0x0/0x5
[219632.787160]  [<c0123766>] run_timer_softirq+0xc7/0x18a
[219632.787290]  [<c011fb34>] __do_softirq+0xbc/0xce
[219632.787408]  [<c011fb78>] do_softirq+0x32/0x34
[219632.787519]  [<c0104dcb>] do_IRQ+0x3b/0x66
[219632.787629]  [<c024fe9b>] uhci_irq+0xf5/0x161
[219632.787808]  [<c01034f2>] common_interrupt+0x1a/0x20
[219632.787933]  [<c02c8d1a>] schedule+0x4de/0xc46
[219632.788046]  [<c013a28c>] __do_IRQ+0xa8/0xe0
[219632.788204]  [<c013a06c>] watchdog+0x0/0x62
[219632.788314]  [<c02c9b8e>] schedule_timeout+0x53/0xa6
[219632.788493]  [<c01034f2>] common_interrupt+0x1a/0x20
[219632.788612]  [<c01239e2>] process_timeout+0x0/0x5
[219632.788732]  [<c0123d4d>] msleep_interruptible+0x39/0x44
[219632.788844]  [<c013a0b1>] watchdog+0x45/0x62
[219632.788956]  [<c012d42e>] kthread+0x9c/0xa1
[219632.789141]  [<c012d392>] kthread+0x0/0xa1
[219632.789257]  [<c0101065>] kernel_thread_helper+0x5/0xb

[239017.686265] BUG: soft lockup detected on CPU#0!
[239017.686316]
[239017.686361] Pid: 30133, comm:             asterisk
[239017.686406] EIP: 0060:[<c022ef4c>] CPU: 0
[239017.686456] EIP is at ide_pio_sector+0xb2/0xdf
[239017.686503]  EFLAGS: 00000202    Not tainted  (2.6.15-pwc-ara)
[239017.686549] EAX: e0602000 EBX: cec1fc00 ECX: 00000000 EDX: 00000005
[239017.686596] ESI: f7d0b000 EDI: c03f4c00 EBP: c03f4c94 DS: 007b ES: 007b
[239017.686682] CR0: 8005003b CR2: bfa283ac CR3: 1d3c3000 CR4: 000006d0
[239017.686748]  [<c022efab>] ide_pio_multi+0x32/0x3b
[239017.686871]  [<c022f253>] task_out_intr+0xc3/0xe5
[239017.686989]  [<c01231e6>] del_timer+0x56/0x58
[239017.687171]  [<c022f190>] task_out_intr+0x0/0xe5
[239017.687295]  [<c022ab5f>] ide_intr+0xbe/0x139
[239017.687425]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[239017.687553]  [<c013a264>] __do_IRQ+0x80/0xe0
[239017.687682]  [<c0104dc6>] do_IRQ+0x36/0x66
[239017.687869]  [<c012007b>] cpu_callback+0x20/0xca
[239017.687992]  [<c01034f2>] common_interrupt+0x1a/0x20
[239017.688120]  [<c021007b>] con_font_set+0x4e/0x15a
[239017.688238]  [<c026ef3a>] __kfree_skb+0x11/0x108
[239017.688365]  [<c02158e7>] i8042_timer_func+0x0/0xb
[239017.688560]  [<c0274233>] net_tx_action+0x4d/0x119
[239017.688692]  [<c011fb34>] __do_softirq+0xbc/0xce
[239017.688819]  [<c011fb78>] do_softirq+0x32/0x34
[239017.688940]  [<c0104dcb>] do_IRQ+0x3b/0x66
[239017.689059]  [<c0104dcb>] do_IRQ+0x3b/0x66
[239017.689176]  [<c01034f2>] common_interrupt+0x1a/0x20
[239017.689375]  [<c0158fe6>] fput+0x6/0x15
[239017.689500]  [<c0169f14>] do_pollfd+0x52/0x8b
[239017.689627]  [<c0169fa2>] do_poll+0x55/0xb1
[239017.689759]  [<c016a121>] sys_poll+0x123/0x1de
[239017.689887]  [<c01696d5>] __pollwait+0x0/0xc1
[239017.690083]  [<c0102b25>] syscall_call+0x7/0xb

[306008.724808] BUG: soft lockup detected on CPU#0!
[306008.724874]
[306008.724921] Pid: 0, comm:              swapper
[306008.724965] EIP: 0060:[<c022ef4c>] CPU: 0
[306008.725015] EIP is at ide_pio_sector+0xb2/0xdf
[306008.725061]  EFLAGS: 00200206    Not tainted  (2.6.15-pwc-ara)
[306008.725110] EAX: c0384000 EBX: ee7f3c00 ECX: 00000000 EDX: 00000005
[306008.725157] ESI: f7d0b000 EDI: c03f4c00 EBP: c03f4c94 DS: 007b ES: 007b
[306008.725239] CR0: 8005003b CR2: b7fd9000 CR3: 003b4000 CR4: 000006d0
[306008.725312]  [<c022efab>] ide_pio_multi+0x32/0x3b
[306008.725437]  [<c022f253>] task_out_intr+0xc3/0xe5
[306008.725551]  [<c01231e6>] del_timer+0x56/0x58
[306008.725665]  [<c022f190>] task_out_intr+0x0/0xe5
[306008.725796]  [<c022ab5f>] ide_intr+0xbe/0x139
[306008.727748]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[306008.727870]  [<c013a264>] __do_IRQ+0x80/0xe0
[306008.727995]  [<c0104dc6>] do_IRQ+0x36/0x66
[306008.728116]  [<c01034f2>] common_interrupt+0x1a/0x20
[306008.728251]  [<f88bc9a2>] boomerang_start_xmit+0x8a/0x314 [3c59x]
[306008.728388]  [<c01034f2>] common_interrupt+0x1a/0x20
[306008.728532]  [<c027ffbb>] qdisc_restart+0x5c/0x1d4
[306008.728652]  [<c028007b>] qdisc_restart+0x11c/0x1d4
[306008.728786]  [<c0280382>] pfifo_fast_enqueue+0x0/0x8b
[306008.728904]  [<c0273f40>] dev_queue_xmit+0x1f4/0x27f
[306008.729058]  [<c0290c07>] ip_output+0x113/0x269
[306008.729214]  [<c029315c>] ip_finish_output2+0x0/0x1a9
[306008.729368]  [<c02910c5>] ip_queue_xmit+0x368/0x4ce
[306008.729542]  [<c029313e>] dst_output+0x0/0x1e
[306008.729719]  [<c022aba2>] ide_intr+0x101/0x139
[306008.729862]  [<c022aba2>] ide_intr+0x101/0x139
[306008.730002]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[306008.730137]  [<c013a28c>] __do_IRQ+0xa8/0xe0
[306008.730275]  [<c0104dcb>] do_IRQ+0x3b/0x66
[306008.730397]  [<c0104dcb>] do_IRQ+0x3b/0x66
[306008.730510]  [<c01034f2>] common_interrupt+0x1a/0x20
[306008.730644]  [<c02a0ee8>] tcp_transmit_skb+0x462/0x733
[306008.730780]  [<c02a3953>] tcp_send_ack+0xa2/0xee
[306008.730897]  [<c029f7f6>] tcp_rcv_established+0x61a/0x7ea
[306008.731026]  [<c02a71ae>] tcp_v4_do_rcv+0xe5/0xea
[306008.731149]  [<c02a78a9>] tcp_v4_rcv+0x6f6/0x92e
[306008.731303]  [<c028d6e3>] ip_local_deliver+0xe3/0x250
[306008.731428]  [<c028dd8b>] ip_local_deliver_finish+0x0/0x1cc
[306008.731560]  [<c028dae5>] ip_rcv+0x295/0x53b
[306008.731680]  [<c028df57>] ip_rcv_finish+0x0/0x295
[306008.731807]  [<c027431b>] ing_filter+0x1c/0xa7
[306008.731973]  [<c0274629>] netif_receive_skb+0x283/0x352
[306008.732137]  [<c027477e>] process_backlog+0x86/0x106
[306008.732319]  [<c0274886>] net_rx_action+0x88/0x160
[306008.732491]  [<c011fb34>] __do_softirq+0xbc/0xce
[306008.732650]  [<c011fb78>] do_softirq+0x32/0x34
[306008.732761]  [<c0104dcb>] do_IRQ+0x3b/0x66
[306008.732875]  [<c01034f2>] common_interrupt+0x1a/0x20
[306008.732999]  [<c02c88ae>] schedule+0x72/0xc46
[306008.733153]  [<c02c007b>] xfrm_state_find+0xf/0xd7b
[306008.733265]  [<c0100d59>] cpu_idle+0x79/0x7b
[306008.733374]  [<c0386838>] start_kernel+0x149/0x162
[306008.733480]  [<c03862fc>] unknown_bootoption+0x0/0x1a0

[329131.145470] BUG: soft lockup detected on CPU#0!
[329131.145524]
[329131.145568] Pid: 2, comm:          migration/0
[329131.145612] EIP: 0060:[<c022ef4c>] CPU: 0
[329131.145658] EIP is at ide_pio_sector+0xb2/0xdf
[329131.145701]  EFLAGS: 00000206    Not tainted  (2.6.15-pwc-ara)
[329131.145744] EAX: c2144000 EBX: c59a6200 ECX: 00000000 EDX: 00000005
[329131.145788] ESI: f7d0b000 EDI: c03f4c00 EBP: c03f4c94 DS: 007b ES: 007b
[329131.145869] CR0: 8005003b CR2: 4d5591e4 CR3: 003b4000 CR4: 000006d0
[329131.145935]  [<c022efab>] ide_pio_multi+0x32/0x3b
[329131.146054]  [<c022f253>] task_out_intr+0xc3/0xe5
[329131.146166]  [<c01231e6>] del_timer+0x56/0x58
[329131.146345]  [<c022f190>] task_out_intr+0x0/0xe5
[329131.146460]  [<c022ab5f>] ide_intr+0xbe/0x139
[329131.146583]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[329131.146703]  [<c013a264>] __do_IRQ+0x80/0xe0
[329131.146825]  [<c0104dc6>] do_IRQ+0x36/0x66
[329131.147006]  [<c01034f2>] common_interrupt+0x1a/0x20
[329131.147134]  [<f886b09f>] ipt_do_table+0x77/0x315 [ip_tables]
[329131.147262]  [<c0104dcb>] do_IRQ+0x3b/0x66
[329131.147392]  [<f88d1029>] ipt_hook+0x29/0x31 [iptable_filter]
[329131.147513]  [<c02884e9>] nf_iterate+0x69/0x83
[329131.147693]  [<c028dd8b>] ip_local_deliver_finish+0x0/0x1cc
[329131.147814]  [<c028dd8b>] ip_local_deliver_finish+0x0/0x1cc
[329131.147926]  [<c0288560>] nf_hook_slow+0x5d/0xea
[329131.148040]  [<c028dd8b>] ip_local_deliver_finish+0x0/0x1cc
[329131.148162]  [<c028d820>] ip_local_deliver+0x220/0x250
[329131.148276]  [<c028dd8b>] ip_local_deliver_finish+0x0/0x1cc
[329131.148459]  [<c028dae5>] ip_rcv+0x295/0x53b
[329131.148573]  [<c028df57>] ip_rcv_finish+0x0/0x295
[329131.148701]  [<c0274629>] netif_receive_skb+0x283/0x352
[329131.148836]  [<c027477e>] process_backlog+0x86/0x106
[329131.148961]  [<c0274886>] net_rx_action+0x88/0x160
[329131.149147]  [<c011fb34>] __do_softirq+0xbc/0xce
[329131.149266]  [<c011fb78>] do_softirq+0x32/0x34
[329131.149378]  [<c0104dcb>] do_IRQ+0x3b/0x66
[329131.149490]  [<c0104dcb>] do_IRQ+0x3b/0x66
[329131.149606]  [<c01034f2>] common_interrupt+0x1a/0x20
[329131.149799]  [<c012d332>] kthread_should_stop+0x6/0x16
[329131.149914]  [<c0118723>] migration_thread+0x39/0xf1
[329131.150033]  [<c01186ea>] migration_thread+0x0/0xf1
[329131.150143]  [<c012d42e>] kthread+0x9c/0xa1
[329131.150258]  [<c012d392>] kthread+0x0/0xa1
[329131.150372]  [<c0101065>] kernel_thread_helper+0x5/0xb
[329160.501774] BUG: soft lockup detected on CPU#0!
[329160.501836]
[329160.501879] Pid: 2, comm:          migration/0
[329160.501923] EIP: 0060:[<c022ef4c>] CPU: 0
[329160.501969] EIP is at ide_pio_sector+0xb2/0xdf
[329160.502012]  EFLAGS: 00200202    Not tainted  (2.6.15-pwc-ara)
[329160.502056] EAX: c2144000 EBX: d60d4200 ECX: 00000000 EDX: 00000005
[329160.502103] ESI: f7d0b000 EDI: c03f4c00 EBP: c03f4c94 DS: 007b ES: 007b
[329160.502183] CR0: 8005003b CR2: b7f53000 CR3: 003b4000 CR4: 000006d0
[329160.502246]  [<c022efab>] ide_pio_multi+0x32/0x3b
[329160.502363]  [<c022f253>] task_out_intr+0xc3/0xe5
[329160.502476]  [<c01231e6>] del_timer+0x56/0x58
[329160.502667]  [<c022f190>] task_out_intr+0x0/0xe5
[329160.502780]  [<c022ab5f>] ide_intr+0xbe/0x139
[329160.502904]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[329160.503024]  [<c013a264>] __do_IRQ+0x80/0xe0
[329160.503148]  [<c0104dc6>] do_IRQ+0x36/0x66
[329160.503327]  [<c022aba2>] ide_intr+0x101/0x139
[329160.503440]  [<c01034f2>] common_interrupt+0x1a/0x20
[329160.503569]  [<f886b0d4>] ipt_do_table+0xac/0x315 [ip_tables]
[329160.503720]  [<f88d6029>] ipt_route_hook+0x29/0x31 [iptable_mangle]
[329160.503839]  [<c02884e9>] nf_iterate+0x69/0x83
[329160.504018]  [<c028df57>] ip_rcv_finish+0x0/0x295
[329160.504138]  [<c028df57>] ip_rcv_finish+0x0/0x295
[329160.504251]  [<c0288560>] nf_hook_slow+0x5d/0xea
[329160.504367]  [<c028df57>] ip_rcv_finish+0x0/0x295
[329160.504488]  [<c028dc84>] ip_rcv+0x434/0x53b
[329160.504601]  [<c028df57>] ip_rcv_finish+0x0/0x295
[329160.504792]  [<c0274629>] netif_receive_skb+0x283/0x352
[329160.504927]  [<c027477e>] process_backlog+0x86/0x106
[329160.505053]  [<c0274886>] net_rx_action+0x88/0x160
[329160.505175]  [<c011fb34>] __do_softirq+0xbc/0xce
[329160.505295]  [<c011fb78>] do_softirq+0x32/0x34
[329160.505471]  [<c0104dcb>] do_IRQ+0x3b/0x66
[329160.505587]  [<c01034f2>] common_interrupt+0x1a/0x20
[329160.505714]  [<c02c8d1a>] schedule+0x4de/0xc46
[329160.505880]  [<c0118764>] migration_thread+0x7a/0xf1
[329160.506002]  [<c01186ea>] migration_thread+0x0/0xf1
[329160.506179]  [<c012d42e>] kthread+0x9c/0xa1
[329160.506296]  [<c012d392>] kthread+0x0/0xa1
[329160.506411]  [<c0101065>] kernel_thread_helper+0x5/0xb

[333721.677320] BUG: soft lockup detected on CPU#0!
[333721.677370]
[333721.677412] Pid: 1547, comm:                 pptp
[333721.677456] EIP: 0060:[<c022ef4c>] CPU: 0
[333721.677501] EIP is at ide_pio_sector+0xb2/0xdf
[333721.677547]  EFLAGS: 00000202    Not tainted  (2.6.15-pwc-ara)
[333721.677591] EAX: f6d7a000 EBX: d2f71000 ECX: 00000000 EDX: 00000005
[333721.677636] ESI: f7d0b000 EDI: c03f4c00 EBP: c03f4c94 DS: 007b ES: 007b
[333721.677717] CR0: 8005003b CR2: 080b4862 CR3: 36d50000 CR4: 000006d0
[333721.677783]  [<c022efab>] ide_pio_multi+0x32/0x3b
[333721.677902]  [<c022f253>] task_out_intr+0xc3/0xe5
[333721.678011]  [<c01231e6>] del_timer+0x56/0x58
[333721.678188]  [<c022f190>] task_out_intr+0x0/0xe5
[333721.678303]  [<c022ab5f>] ide_intr+0xbe/0x139
[333721.678419]  [<c022f190>] task_out_intr+0x0/0xe5
[333721.678540]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[333721.678661]  [<c013a264>] __do_IRQ+0x80/0xe0
[333721.678836]  [<c022aba2>] ide_intr+0x101/0x139
[333721.678954]  [<c02158e7>] i8042_timer_func+0x0/0xb
[333721.679066]  [<c0104dc6>] do_IRQ+0x36/0x66
[333721.679176]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[333721.679291]  [<c01034f2>] common_interrupt+0x1a/0x20
[333721.679477]  [<c02158e7>] i8042_timer_func+0x0/0xb
[333721.679592]  [<c012007b>] cpu_callback+0x20/0xca
[333721.679708]  [<c02ca4a7>] _spin_unlock_irqrestore+0x5/0x6
[333721.679825]  [<c0215781>] i8042_interrupt+0x208/0x246
[333721.679938]  [<c01034f2>] common_interrupt+0x1a/0x20
[333721.680055]  [<c02158e7>] i8042_timer_func+0x0/0xb
[333721.680242]  [<c02158e7>] i8042_timer_func+0x0/0xb
[333721.680355]  [<c0123766>] run_timer_softirq+0xc7/0x18a
[333721.680470]  [<c012a825>] __rcu_process_callbacks+0x85/0xcd
[333721.680600]  [<c011fb34>] __do_softirq+0xbc/0xce
[333721.680721]  [<c011fb78>] do_softirq+0x32/0x34
[333721.680899]  [<c0104dcb>] do_IRQ+0x3b/0x66
[333721.681015]  [<c01034f2>] common_interrupt+0x1a/0x20
[333721.681144]  [<c0205b91>] normal_poll+0xf0/0x134
[333721.681261]  [<c0205aa1>] normal_poll+0x0/0x134
[333721.681374]  [<c0201f8e>] tty_poll+0x7a/0x7f
[333721.681561]  [<c0169aa0>] do_select+0x22e/0x287
[333721.681707]  [<c01696d5>] __pollwait+0x0/0xc1
[333721.681829]  [<c0169d57>] sys_select+0x249/0x3b4
[333721.681972]  [<c0102b25>] syscall_call+0x7/0xb

[333751.673421] BUG: soft lockup detected on CPU#0!
[333751.673469]
[333751.673511] Pid: 2922, comm:             scanlogd
[333751.673558] EIP: 0060:[<c022ef4c>] CPU: 0
[333751.673603] EIP is at ide_pio_sector+0xb2/0xdf
[333751.673646]  EFLAGS: 00000202    Not tainted  (2.6.15-pwc-ara)
[333751.673690] EAX: f6228000 EBX: f08d2800 ECX: 00000000 EDX: 00000005
[333751.673735] ESI: f7d0b000 EDI: c03f4c00 EBP: c03f4c94 DS: 007b ES: 007b
[333751.673813] CR0: 8005003b CR2: 080b0724 CR3: 36c8b000 CR4: 000006d0
[333751.675396]  [<c022efab>] ide_pio_multi+0x32/0x3b
[333751.675511]  [<c022f253>] task_out_intr+0xc3/0xe5
[333751.675626]  [<c01231e6>] del_timer+0x56/0x58
[333751.675806]  [<c022f190>] task_out_intr+0x0/0xe5
[333751.675920]  [<c022ab5f>] ide_intr+0xbe/0x139
[333751.676030]  [<c022aba2>] ide_intr+0x101/0x139
[333751.676151]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[333751.676269]  [<c013a264>] __do_IRQ+0x80/0xe0
[333751.676456]  [<c0104dc6>] do_IRQ+0x36/0x66
[333751.676576]  [<c01034f2>] common_interrupt+0x1a/0x20
[333751.676698]  [<c024007b>] proc_do_submiturb+0x12a/0x758
[333751.676814]  [<c02ca4a7>] _spin_unlock_irqrestore+0x5/0x6
[333751.676931]  [<c024f629>] uhci_hub_status_data+0xb9/0x128
[333751.677117]  [<c023943e>] rh_timer_func+0x0/0x5
[333751.677229]  [<c0239343>] usb_hcd_poll_rh_status+0x3b/0x136
[333751.677348]  [<c023943e>] rh_timer_func+0x0/0x5
[333751.677459]  [<c0123766>] run_timer_softirq+0xc7/0x18a
[333751.677589]  [<c011fb34>] __do_softirq+0xbc/0xce
[333751.677709]  [<c011fb78>] do_softirq+0x32/0x34
[333751.677889]  [<c0104dcb>] do_IRQ+0x3b/0x66
[333751.678005]  [<c01034f2>] common_interrupt+0x1a/0x20
[333751.678131]  [<c026d674>] sock_rfree+0xd/0xe
[333751.678244]  [<c026ef76>] __kfree_skb+0x4d/0x108
[333751.678359]  [<c02714c5>] skb_free_datagram+0x0/0x28
[333751.678539]  [<c02aaf40>] raw_recvmsg+0x12a/0x186
[333751.678667]  [<c026e2c7>] sock_common_recvmsg+0x47/0x66
[333751.678792]  [<c026af91>] sock_aio_read+0xd7/0xec
[333751.678940]  [<f88bd0a6>] boomerang_interrupt+0xea/0x415 [3c59x]
[333751.679065]  [<c015807a>] do_sync_read+0xb2/0xf7
[333751.679286]  [<c012d85e>] autoremove_wake_function+0x0/0x43
[333751.679404]  [<c01034f2>] common_interrupt+0x1a/0x20
[333751.679527]  [<c01581ed>] vfs_read+0x12e/0x13d
[333751.679647]  [<c015847a>] sys_read+0x47/0x76
[333751.679771]  [<c0102b25>] syscall_call+0x7/0xb

[333766.686386] BUG: soft lockup detected on CPU#0!
[333766.686441]
[333766.686482] Pid: 14, comm:            kblockd/0
[333766.686527] EIP: 0060:[<c022ef4c>] CPU: 0
[333766.686573] EIP is at ide_pio_sector+0xb2/0xdf
[333766.686615]  EFLAGS: 00000202    Not tainted  (2.6.15-pwc-ara)
[333766.686658] EAX: c2188000 EBX: c8bdf600 ECX: 00000000 EDX: 00000005
[333766.686702] ESI: f7d0b000 EDI: c03f4c00 EBP: c03f4c94 DS: 007b ES: 007b
[333766.686780] CR0: 8005003b CR2: 4000f070 CR3: 003b4000 CR4: 000006d0
[333766.686844]  [<c022efab>] ide_pio_multi+0x32/0x3b
[333766.686962]  [<c022f253>] task_out_intr+0xc3/0xe5
[333766.687073]  [<c01231e6>] del_timer+0x56/0x58
[333766.687255]  [<c022f190>] task_out_intr+0x0/0xe5
[333766.687369]  [<c022ab5f>] ide_intr+0xbe/0x139
[333766.687493]  [<c013a1b1>] handle_IRQ_event+0x26/0x59
[333766.687612]  [<c013a264>] __do_IRQ+0x80/0xe0
[333766.687732]  [<c0104dc6>] do_IRQ+0x36/0x66
[333766.687914]  [<c01034f2>] common_interrupt+0x1a/0x20
[333766.688042]  [<f886b0d4>] ipt_do_table+0xac/0x315 [ip_tables]
[333766.688197]  [<f88d1029>] ipt_hook+0x29/0x31 [iptable_filter]
[333766.688317]  [<c02884e9>] nf_iterate+0x69/0x83
[333766.688431]  [<c028dd8b>] ip_local_deliver_finish+0x0/0x1cc
[333766.688615]  [<c028dd8b>] ip_local_deliver_finish+0x0/0x1cc
[333766.688726]  [<c0288560>] nf_hook_slow+0x5d/0xea
[333766.688841]  [<c028dd8b>] ip_local_deliver_finish+0x0/0x1cc
[333766.688963]  [<c028d820>] ip_local_deliver+0x220/0x250
[333766.689076]  [<c028dd8b>] ip_local_deliver_finish+0x0/0x1cc
[333766.689199]  [<c028dae5>] ip_rcv+0x295/0x53b
[333766.689378]  [<c028df57>] ip_rcv_finish+0x0/0x295
[333766.689506]  [<c0274629>] netif_receive_skb+0x283/0x352
[333766.689639]  [<c027477e>] process_backlog+0x86/0x106
[333766.689763]  [<c0274886>] net_rx_action+0x88/0x160
[333766.689882]  [<c011fb34>] __do_softirq+0xbc/0xce
[333766.690064]  [<c011fb78>] do_softirq+0x32/0x34
[333766.690178]  [<c0104dcb>] do_IRQ+0x3b/0x66
[333766.690296]  [<c01034f2>] common_interrupt+0x1a/0x20
[333766.690424]  [<c01297e5>] worker_thread+0x11e/0x21a
[333766.690544]  [<c01c19d6>] as_work_handler+0x0/0x42
[333766.690730]  [<c011770a>] default_wake_function+0x0/0xc
[333766.690853]  [<c011770a>] default_wake_function+0x0/0xc
[333766.690976]  [<c01296c7>] worker_thread+0x0/0x21a
[333766.691086]  [<c012d42e>] kthread+0x9c/0xa1
[333766.691207]  [<c012d392>] kthread+0x0/0xa1
[333766.691323]  [<c0101065>] kernel_thread_helper+0x5/0xb


Folkert van Heusden

www.vanheusden.com/multitail - multitail is tail on steroids. multiple
               windows, filtering, coloring, anything you can think of
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
