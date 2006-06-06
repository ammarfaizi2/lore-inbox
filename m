Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWFFTAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWFFTAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 15:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWFFTAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 15:00:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:45738 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750965AbWFFTAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 15:00:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=aOcjZMKtteA6RWen1D4L/prC03CylSV8e7ERvZcJsmAflJUJK+mNEI9rM7yTsS+9ABF1qt62DhgYrEWwQvxkiOcUGtyFxwGisQphrpP1SWhDkg4gVjIh1WvnKziQ1VfmVttQQRYl7OyWN43oQldy2ugfJ7y5ikNGhn/O5vdMnfM=
Message-ID: <d166fa5e0606061200x690a064fv4988dedaf0204c0e@mail.gmail.com>
Date: Tue, 6 Jun 2006 15:00:15 -0400
From: "Massimiliano Poletto" <max.poletto+usenet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: soft lockup detected with 2.6.16 kernel + e1000 driver under load
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 3159e7ab70283935
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: running tcpdump on an e1000 gig-e interface under heavy load
(line rate, minimum-size packets) causes "soft lockup detected" error
messages on the console.  The machine becomes unresponsive (no ping,
console freezes), but after the traffic stops it usually comes back.
The same experiment with a Broadcom gig-e card and a tg3 driver
succeeded: there were no lockups, and the machine continued to be
reachable and somewhat responsive even under load.

I would appreciate any help or advice.  Details are below.

Thanks,
max


- Hardware: IBM x346 dual-Xeon server with dual on-board Broadcom
NetXtreme (95721) 100/1000 interfaces (tg3 driver) and one dual-port
Intel e1000 card.

- Linux  kernel versions: several versions of 2.6.16, including the
latest 2.6.16.19.

- Intel e1000 driver versions: several, including 6.3.9-k4 (which is in
the kernel.org sources) and the latest 7.0.41 from sourceforge.  NAPI
disabled.

- Test traffic: random 64-byte TCP packets at 1.4Mpps from an Ixia
device.

- Kernel config: see http://maxp.net/linux/config-2.6.16.19-1

- Ring buffer output (dmesg): see http://maxp.net/linux/dmesg-11541-1

- Sample error messages (driver 7.0.41):

BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<c0158b9f>] CPU: 0
EIP is at kfree+0x4f/0x61
 EFLAGS: 00000286    Not tainted  (2.6.16.19 #1)
EAX: 00000004 EBX: f7ff8380 ECX: f7d08188 EDX: f7d08188
ESI: f7fff880 EDI: f5483600 EBP: 00000286 DS: 007b ES: 007b
CR0: 8005003b CR2: 081df780 CR3: 042b2ce0 CR4: 000006f0
 [<c0356573>] kfree_skbmem+0x8/0x73
 [<c035b40e>] netif_rx+0x149/0x18b
 [<f88cf3a2>] e1000_clean_rx_irq+0x1c3/0x555 [e1000]
 [<f88cf841>] e1000_intr+0x10d/0x3c9 [e1000]
 [<c010d81e>] mark_offset_tsc+0x1a7/0x2c9
 [<c01245a8>] do_timer+0x3b/0x439
 [<c013c64d>] handle_IRQ_event+0x2e/0x5a
 [<c013c70a>] __do_IRQ+0x91/0xe7
 [<c01058d0>] do_IRQ+0x4e/0x86
 =======================
 [<c0104286>] common_interrupt+0x1a/0x20
 [<c01e2462>] _raw_spin_unlock+0x3b/0x74
 [<c03b22df>] packet_rcv+0xb8/0x3a9
 [<c0104286>] common_interrupt+0x1a/0x20
 [<c0106880>] do_gettimeofday+0x20/0xd1
 [<c035b688>] netif_receive_skb+0x206/0x291
 [<c035b795>] process_backlog+0x82/0x107
 [<c03597a7>] net_rx_action+0x74/0x107
 [<c0121472>] __do_softirq+0x70/0xda
 [<c0105953>] do_softirq+0x4b/0x4f
 =======================
 [<c01058d7>] do_IRQ+0x55/0x86
 [<c0104286>] common_interrupt+0x1a/0x20
 [<c01026e7>] mwait_idle+0x2a/0x34
 [<c01026a8>] cpu_idle+0x61/0x76
 [<c04cb49d>] start_kernel+0x2db/0x387
 [<c04cb549>] unknown_bootoption+0x0/0x257
BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<f88cbed2>] CPU: 0
EIP is at e1000_alloc_rx_buffers+0x12e/0x461 [e1000]
 EFLAGS: 00000282    Not tainted  (2.6.16.19 #1)
EAX: 00000000 EBX: 35c80812 ECX: 0000008e EDX: f7d16ac0
ESI: 0000008e EDI: f6138380 EBP: 000005ee DS: 007b ES: 007b
CR0: 8005003b CR2: 081df780 CR3: 042b2ce0 CR4: 000006f0
 [<f88cf613>] e1000_clean_rx_irq+0x434/0x555 [e1000]
 [<f88cf841>] e1000_intr+0x10d/0x3c9 [e1000]
 [<c010d81e>] mark_offset_tsc+0x1a7/0x2c9
 [<c01245a8>] do_timer+0x3b/0x439
 [<c013c64d>] handle_IRQ_event+0x2e/0x5a
 [<c013c70a>] __do_IRQ+0x91/0xe7
 [<c01058d0>] do_IRQ+0x4e/0x86
 =======================
 [<c0104286>] common_interrupt+0x1a/0x20
 [<f881d623>] tg3_poll+0x5d4/0x93d [tg3]
 [<c03b525d>] _spin_unlock_irqrestore+0xa/0xc
 [<c0104286>] common_interrupt+0x1a/0x20
 [<c03597a7>] net_rx_action+0x74/0x107
 [<c0121472>] __do_softirq+0x70/0xda
 [<c0105953>] do_softirq+0x4b/0x4f
 =======================
 [<c01058d7>] do_IRQ+0x55/0x86
 [<c0104286>] common_interrupt+0x1a/0x20
 [<c01026e7>] mwait_idle+0x2a/0x34
 [<c01026a8>] cpu_idle+0x61/0x76
 [<c04cb49d>] start_kernel+0x2db/0x387
 [<c04cb549>] unknown_bootoption+0x0/0x257

BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<c035b3f6>] CPU: 0
EIP is at netif_rx+0x131/0x18b
 EFLAGS: 00000246    Not tainted  (2.6.16.19 #1)
EAX: 00000000 EBX: f210cc80 ECX: c0514680 EDX: c3fa4560
ESI: c3fa45e0 EDI: c051a000 EBP: 00000246 DS: 007b ES: 007b
CR0: 8005003b CR2: 080f5d20 CR3: 37ec2fc0 CR4: 000006f0
 [<f88bd9ea>] e1000_clean_rx_irq+0x214/0x63b [e1000]
 [<f88c116c>] e1000_intr+0x13f/0x47d [e1000]
 [<c0110447>] smp_apic_timer_interrupt+0x55/0x5e
 [<c0104314>] apic_timer_interrupt+0x1c/0x24
 [<c01245a8>] do_timer+0x3b/0x439
 [<c013c64d>] handle_IRQ_event+0x2e/0x5a
 [<c013c70a>] __do_IRQ+0x91/0xe7
 [<c01058d0>] do_IRQ+0x4e/0x86
 =======================
 [<c0104286>] common_interrupt+0x1a/0x20
 [<c01026e7>] mwait_idle+0x2a/0x34
 [<c01026a8>] cpu_idle+0x61/0x76
 [<c04cb49d>] start_kernel+0x2db/0x387
 [<c04cb549>] unknown_bootoption+0x0/0x257
BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<c01586b6>] CPU: 0
EIP is at kmem_cache_free+0x29/0x3a
 EFLAGS: 00000246    Not tainted  (2.6.16.19 #1)
EAX: 0000000d EBX: f7fdee00 ECX: f7eec9c0 EDX: f210cc80
ESI: 00000246 EDI: f210cc80 EBP: 00000246 DS: 007b ES: 007b
CR0: 8005003b CR2: 080f5d20 CR3: 37ec2fc0 CR4: 000006f0
 [<c035b40e>] netif_rx+0x149/0x18b
 [<f88bd9ea>] e1000_clean_rx_irq+0x214/0x63b [e1000]
 [<f88c116c>] e1000_intr+0x13f/0x47d [e1000]
 [<c0110447>] smp_apic_timer_interrupt+0x55/0x5e
 [<c0104314>] apic_timer_interrupt+0x1c/0x24
 [<c01245a8>] do_timer+0x3b/0x439
 [<c013c64d>] handle_IRQ_event+0x2e/0x5a
 [<c013c70a>] __do_IRQ+0x91/0xe7
 [<c01058d0>] do_IRQ+0x4e/0x86
 =======================
 [<c0104286>] common_interrupt+0x1a/0x20
 [<c01026e7>] mwait_idle+0x2a/0x34
 [<c01026a8>] cpu_idle+0x61/0x76
 [<c04cb49d>] start_kernel+0x2db/0x387
 [<c04cb549>] unknown_bootoption+0x0/0x257

- Sample error messages (driver 6.3.9-k4):

BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<c0158b9f>] CPU: 0
EIP is at kfree+0x4f/0x61
 EFLAGS: 00000286    Not tainted  (2.6.16.19 #1)
EAX: 00000004 EBX: f7ff8380 ECX: c0438270 EDX: c0438270
ESI: f7fff880 EDI: f1a5b600 EBP: 00000286 DS: 007b ES: 007b
CR0: 8005003b CR2: 435eef86 CR3: 37ec2fc0 CR4: 000006f0
 [<c0356573>] kfree_skbmem+0x8/0x73
 [<c035b40e>] netif_rx+0x149/0x18b
 [<f88bd9ea>] e1000_clean_rx_irq+0x214/0x63b [e1000]
 [<f88c116c>] e1000_intr+0x13f/0x47d [e1000]
 [<c0110447>] smp_apic_timer_interrupt+0x55/0x5e
 [<c01245a8>] do_timer+0x3b/0x439
 [<c013c64d>] handle_IRQ_event+0x2e/0x5a
 [<c013c70a>] __do_IRQ+0x91/0xe7
 [<c01058d0>] do_IRQ+0x4e/0x86
 =======================
 [<c0104286>] common_interrupt+0x1a/0x20
 [<c01026e7>] mwait_idle+0x2a/0x34
 [<c01026a8>] cpu_idle+0x61/0x76
 [<c04cb49d>] start_kernel+0x2db/0x387
 [<c04cb549>] unknown_bootoption+0x0/0x257

BUG: soft lockup detected on CPU#0!

Pid: 1581, comm:                klogd
EIP: 0060:[<f88bd8a6>] CPU: 0
EIP is at e1000_clean_rx_irq+0xd0/0x63b [e1000]
 EFLAGS: 00010282    Not tainted  (2.6.16.19 #1)
EAX: f2628000 EBX: f28f0d80 ECX: 00000003 EDX: f62b7c80
ESI: f288f040 EDI: f1bdf640 EBP: 0000003e DS: 007b ES: 007b
CR0: 8005003b CR2: 081ed000 CR3: 04356da0 CR4: 000006f0
 [<f88c116c>] e1000_intr+0x13f/0x47d [e1000]
 [<c0110447>] smp_apic_timer_interrupt+0x55/0x5e
 [<c0104314>] apic_timer_interrupt+0x1c/0x24
 [<c01245a8>] do_timer+0x3b/0x439
 [<c013c64d>] handle_IRQ_event+0x2e/0x5a
 [<c013c70a>] __do_IRQ+0x91/0xe7
 [<c01058d0>] do_IRQ+0x4e/0x86
 =======================
 [<c0104286>] common_interrupt+0x1a/0x20
BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<f88c03e1>] CPU: 0
EIP is at e1000_alloc_rx_buffers+0x102/0x4ad [e1000]
 EFLAGS: 00000283    Not tainted  (2.6.16.19 #1)
EAX: 00000089 EBX: f88d7aa0 ECX: f2f5f880 EDX: 00000000
ESI: f2b8eb40 EDI: f1949480 EBP: 00000800 DS: 007b ES: 007b
CR0: 8005003b CR2: 081ed000 CR3: 04356da0 CR4: 000006f0
 [<f88bdccf>] e1000_clean_rx_irq+0x4f9/0x63b [e1000]
 [<f88c116c>] e1000_intr+0x13f/0x47d [e1000]
 [<c02d5ad4>] ips_next+0x4ec/0xdf8
 [<c03b521e>] _spin_lock_irqsave+0x9/0xd
 [<c0221932>] __add_entropy_words+0x62/0x192
 [<c01245a8>] do_timer+0x3b/0x439
 [<c013c64d>] handle_IRQ_event+0x2e/0x5a
 [<c013c70a>] __do_IRQ+0x91/0xe7
 [<c01058d0>] do_IRQ+0x4e/0x86
 =======================
 [<c0104286>] common_interrupt+0x1a/0x20
 [<c01026e7>] mwait_idle+0x2a/0x34
 [<c01026a8>] cpu_idle+0x61/0x76
 [<c04cb49d>] start_kernel+0x2db/0x387
 [<c04cb549>] unknown_bootoption+0x0/0x257
BUG: soft lockup detected on CPU#0!

Pid: 0, comm:              swapper
EIP: 0060:[<c035b3f6>] CPU: 0
EIP is at netif_rx+0x131/0x18b
 EFLAGS: 00000282    Not tainted  (2.6.16.19 #1)
EAX: 00000000 EBX: f2781a80 ECX: c0514680 EDX: c3fa4560
ESI: c3fa45e0 EDI: c051a000 EBP: 00000282 DS: 007b ES: 007b
CR0: 8005003b CR2: 081ed000 CR3: 04356da0 CR4: 000006f0
 [<f88bd9ea>] e1000_clean_rx_irq+0x214/0x63b [e1000]
 [<f88c116c>] e1000_intr+0x13f/0x47d [e1000]
 [<c02d5ad4>] ips_next+0x4ec/0xdf8
 [<c03b521e>] _spin_lock_irqsave+0x9/0xd
 [<c0221932>] __add_entropy_words+0x62/0x192
 [<c01245a8>] do_timer+0x3b/0x439
 [<c013c64d>] handle_IRQ_event+0x2e/0x5a
 [<c013c70a>] __do_IRQ+0x91/0xe7
 [<c01058d0>] do_IRQ+0x4e/0x86
 =======================
 [<c0104286>] common_interrupt+0x1a/0x20
 [<c01026e7>] mwait_idle+0x2a/0x34
 [<c01026a8>] cpu_idle+0x61/0x76
 [<c04cb49d>] start_kernel+0x2db/0x387
 [<c04cb549>] unknown_bootoption+0x0/0x257
