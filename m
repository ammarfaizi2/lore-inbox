Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbVLONlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbVLONlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422727AbVLONlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:41:18 -0500
Received: from tornado.reub.net ([202.89.145.182]:64479 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1422689AbVLONlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:41:16 -0500
Message-ID: <43A17276.6010109@reub.net>
Date: Fri, 16 Dec 2005 00:41:10 +1100
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051214)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm2
References: <20051211041308.7bb19454.akpm@osdl.org>
In-Reply-To: <20051211041308.7bb19454.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/12/2005 11:13 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/
> 
> - Many new driver updates and architecture updates
> 
> - New CPU scheduler policy: SCHED_BATCH.
> 
> - New version of the hrtimers code.

I've just had my kernel suffer a meltdown with 2.6.15-rc5-mm2, there was a
massive amount of console output streaming for an hour or so till I got control
but this was logged in the messages log immediately after it went amiss.

I'm about to run up -mm3 but didn't see any obvious fix for this so possibly
it's still a problem in that one too?

Dec 16 00:01:41 tornado kernel: BUG: soft lockup detected on CPU#0!
Dec 16 00:01:41 tornado kernel:
Dec 16 00:01:41 tornado kernel: Pid: 8, comm:             events/0
Dec 16 00:01:41 tornado kernel: EIP: 0060:[<c031fb4b>] CPU: 0
Dec 16 00:01:41 tornado kernel: EIP is at _spin_unlock_irqrestore+0x5/0x6
Dec 16 00:01:41 tornado kernel:  EFLAGS: 00000286    Not tainted  (2.6.15-rc5-mm2)
Dec 16 00:01:41 tornado kernel: EAX: c0444e60 EBX: 0000003e ECX: 00000a19 EDX:
00000286
Dec 16 00:01:41 tornado kernel: ESI: 00000000 EDI: cecd5981 EBP: f76b7000 DS:
007b ES: 007b
Dec 16 00:01:41 tornado kernel: CR0: 8005003b CR2: b7aff004 CR3: 0040f000 CR4:
000006d0
Dec 16 00:01:41 tornado kernel:  [<c021f458>] n_tty_receive_buf+0x664/0xa03
Dec 16 00:01:41 tornado kernel:  [<c011635e>] load_balance+0x4e/0x1eb
Dec 16 00:01:41 tornado kernel:  [<c01169cb>] scheduler_tick+0x31/0x36f
Dec 16 00:01:41 tornado kernel:  [<c01107ba>] smp_apic_timer_interrupt+0xc1/0xca
Dec 16 00:01:41 tornado kernel:  [<c0104dd1>] do_IRQ+0x41/0x52
Dec 16 00:01:41 tornado kernel:  [<c01034e6>] common_interrupt+0x1a/0x20
Dec 16 00:01:41 tornado kernel:  [<c021d92a>] flush_to_ldisc+0x64/0xcb
Dec 16 00:01:41 tornado kernel:  [<c012a94e>] worker_thread+0x1bf/0x249
Dec 16 00:01:41 tornado kernel:  [<c021d8c6>] flush_to_ldisc+0x0/0xcb
Dec 16 00:01:41 tornado kernel:  [<c0116d09>] default_wake_function+0x0/0xc
Dec 16 00:01:41 tornado kernel:  [<c012a78f>] worker_thread+0x0/0x249
Dec 16 00:01:41 tornado kernel:  [<c012d8f9>] kthread+0x93/0x97
Dec 16 00:01:41 tornado kernel:  [<c012d866>] kthread+0x0/0x97
Dec 16 00:01:41 tornado kernel:  [<c0100fcd>] kernel_thread_helper+0x5/0xb
Dec 16 00:01:51 tornado kernel: BUG: soft lockup detected on CPU#0!
Dec 16 00:01:51 tornado kernel:
Dec 16 00:01:51 tornado kernel: Pid: 8, comm:             events/0
Dec 16 00:01:51 tornado kernel: EIP: 0060:[<c021f686>] CPU: 0
Dec 16 00:01:51 tornado kernel: EIP is at n_tty_receive_buf+0x892/0xa03
Dec 16 00:01:51 tornado kernel:  EFLAGS: 00000246    Not tainted  (2.6.15-rc5-mm2)
Dec 16 00:01:51 tornado kernel: EAX: f76b7404 EBX: f76b7404 ECX: f76b7000 EDX:
00000246
Dec 16 00:01:51 tornado kernel: ESI: 00000246 EDI: cecd59c6 EBP: f76b7000 DS:
007b ES: 007b
Dec 16 00:01:51 tornado kernel: CR0: 8005003b CR2: b7aff004 CR3: 0040f000 CR4:
000006d0
Dec 16 00:01:51 tornado kernel:  [<c011635e>] load_balance+0x4e/0x1eb
Dec 16 00:01:51 tornado kernel:  [<c01107ba>] smp_apic_timer_interrupt+0xc1/0xca
Dec 16 00:01:51 tornado kernel:  [<c0104dd1>] do_IRQ+0x41/0x52
Dec 16 00:01:51 tornado kernel:  [<c01034e6>] common_interrupt+0x1a/0x20
Dec 16 00:01:51 tornado kernel:  [<c021edf6>] n_tty_receive_buf+0x2/0xa03
Dec 16 00:01:51 tornado kernel:  [<c021d92a>] flush_to_ldisc+0x64/0xcb
Dec 16 00:01:51 tornado kernel:  [<c012a94e>] worker_thread+0x1bf/0x249
Dec 16 00:01:51 tornado kernel:  [<c021d8c6>] flush_to_ldisc+0x0/0xcb
Dec 16 00:01:51 tornado kernel:  [<c0116d09>] default_wake_function+0x0/0xc
Dec 16 00:01:51 tornado kernel:  [<c012a78f>] worker_thread+0x0/0x249
Dec 16 00:01:51 tornado kernel:  [<c012d8f9>] kthread+0x93/0x97
Dec 16 00:01:51 tornado kernel:  [<c012d866>] kthread+0x0/0x97
Dec 16 00:01:51 tornado kernel:  [<c0100fcd>] kernel_thread_helper+0x5/0xb
Dec 16 00:02:01 tornado kernel: BUG: soft lockup detected on CPU#0!
Dec 16 00:02:01 tornado kernel:
Dec 16 00:02:01 tornado kernel: Pid: 8, comm:             events/0
Dec 16 00:02:01 tornado kernel: EIP: 0060:[<c01674b4>] CPU: 0
Dec 16 00:02:01 tornado kernel: EIP is at kill_fasync+0x2d/0x39
Dec 16 00:02:01 tornado kernel:  EFLAGS: 00000246    Not tainted  (2.6.15-rc5-mm2)
Dec 16 00:02:01 tornado kernel: EAX: f76b70d4 EBX: f76b7404 ECX: 00000000 EDX:
0000001d
Dec 16 00:02:01 tornado kernel: ESI: 00000246 EDI: 0000001d EBP: f76b7000 DS:
007b ES: 007b
Dec 16 00:02:01 tornado kernel: CR0: 8005003b CR2: b7aff004 CR3: 0040f000 CR4:
000006d0
Dec 16 00:02:01 tornado kernel:  [<c021f69b>] n_tty_receive_buf+0x8a7/0xa03
Dec 16 00:02:01 tornado kernel:  [<c011635e>] load_balance+0x4e/0x1eb
Dec 16 00:02:01 tornado kernel:  [<c01169cb>] scheduler_tick+0x31/0x36f
Dec 16 00:02:01 tornado kernel:  [<c01107ba>] smp_apic_timer_interrupt+0xc1/0xca
Dec 16 00:02:01 tornado kernel:  [<c0104dd1>] do_IRQ+0x41/0x52
Dec 16 00:02:01 tornado kernel:  [<c01034e6>] common_interrupt+0x1a/0x20
Dec 16 00:02:01 tornado kernel:  [<c021007b>] acpi_ec_gpe_intr_handler+0x35/0xa6
Dec 16 00:02:01 tornado kernel:  [<c021d92a>] flush_to_ldisc+0x64/0xcb
Dec 16 00:02:01 tornado kernel:  [<c012a94e>] worker_thread+0x1bf/0x249
Dec 16 00:02:01 tornado kernel:  [<c021d8c6>] flush_to_ldisc+0x0/0xcb
Dec 16 00:02:01 tornado kernel:  [<c0116d09>] default_wake_function+0x0/0xc
Dec 16 00:02:01 tornado kernel:  [<c012a78f>] worker_thread+0x0/0x249
Dec 16 00:02:01 tornado kernel:  [<c012d8f9>] kthread+0x93/0x97
Dec 16 00:02:01 tornado kernel:  [<c012d866>] kthread+0x0/0x97
Dec 16 00:02:01 tornado kernel:  [<c0100fcd>] kernel_thread_helper+0x5/0xb
Dec 16 00:02:11 tornado kernel: BUG: soft lockup detected on CPU#0!
Dec 16 00:02:11 tornado kernel:
Dec 16 00:02:11 tornado kernel: Pid: 8, comm:             events/0
Dec 16 00:02:11 tornado kernel: EIP: 0060:[<c0230455>] CPU: 0
Dec 16 00:02:11 tornado kernel: EIP is at uart_write_room+0x0/0x18
Dec 16 00:02:11 tornado kernel:  EFLAGS: 00000286    Not tainted  (2.6.15-rc5-mm2)
Dec 16 00:02:11 tornado kernel: EAX: f76b7000 EBX: 0000000a ECX: 00000439 EDX:
f7cac400
Dec 16 00:02:11 tornado kernel: ESI: f76b7000 EDI: cecd593f EBP: f76b7000 DS:
007b ES: 007b
Dec 16 00:02:11 tornado kernel: CR0: 8005003b CR2: b7aff004 CR3: 0040f000 CR4:
000006d0
Dec 16 00:02:11 tornado kernel:  [<c021e5d2>] opost+0x12/0x1cd
Dec 16 00:02:11 tornado kernel:  [<c021f63a>] n_tty_receive_buf+0x846/0xa03
Dec 16 00:02:11 tornado kernel:  [<c011635e>] load_balance+0x4e/0x1eb
Dec 16 00:02:11 tornado kernel:  [<c011679f>] rebalance_tick+0xec/0x10b
Dec 16 00:02:11 tornado kernel:  [<c01107ba>] smp_apic_timer_interrupt+0xc1/0xca
Dec 16 00:02:11 tornado kernel:  [<c0104dd1>] do_IRQ+0x41/0x52
Dec 16 00:02:11 tornado kernel:  [<c01034e6>] common_interrupt+0x1a/0x20
Dec 16 00:02:11 tornado kernel:  [<c021007b>] acpi_ec_gpe_intr_handler+0x35/0xa6
Dec 16 00:02:11 tornado kernel:  [<c021d92a>] flush_to_ldisc+0x64/0xcb
Dec 16 00:02:11 tornado kernel:  [<c012a94e>] worker_thread+0x1bf/0x249
Dec 16 00:02:11 tornado kernel:  [<c021d8c6>] flush_to_ldisc+0x0/0xcb
Dec 16 00:02:11 tornado kernel:  [<c0116d09>] default_wake_function+0x0/0xc
Dec 16 00:02:11 tornado kernel:  [<c012a78f>] worker_thread+0x0/0x249
Dec 16 00:02:11 tornado kernel:  [<c012d8f9>] kthread+0x93/0x97
Dec 16 00:02:11 tornado kernel:  [<c012d866>] kthread+0x0/0x97
Dec 16 00:02:11 tornado kernel:  [<c0100fcd>] kernel_thread_helper+0x5/0xb
Dec 16 00:02:21 tornado kernel: BUG: soft lockup detected on CPU#0!
Dec 16 00:02:21 tornado kernel:

Usual details including .config are up at http://www.reub.net/files/kernel/

reuben

