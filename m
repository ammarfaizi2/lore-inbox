Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbUJYPKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbUJYPKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUJYPIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:08:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:14804 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261880AbUJYOtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:49:31 -0400
X-Authenticated: #4399952
Date: Mon, 25 Oct 2004 17:06:12 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041025170612.6284923a@mango.fruits.de>
In-Reply-To: <20041025141008.GA13512@elte.hu>
References: <20041022133551.GA6954@elte.hu>
	<20041022155048.GA16240@elte.hu>
	<20041022175633.GA1864@elte.hu>
	<20041025104023.GA1960@elte.hu>
	<417CDE90.6040201@cybsft.com>
	<20041025111046.GA3630@elte.hu>
	<20041025121210.GA6555@elte.hu>
	<20041025152458.3e62120a@mango.fruits.de>
	<20041025132605.GA9516@elte.hu>
	<20041025160330.394e9071@mango.fruits.de>
	<20041025141008.GA13512@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004 16:10:08 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > Btw: i still experience some "pauses". They are different now though.
> > It seems i can trigger them by reloading a page in mozilla (not
> > always). This BUG definetly looks related. Dunno, when exactly it
> > happened (related to what i did at that moment), but it's the only one
> > in dmesg output on this bootup. Each of the pauses is accompanied by a
> > high cpu usage of ksoftirqd. I cannot retrigger the BUG though.
> 
> please try -V0.2 - maybe the delayed-put fix is somehow related. (but
> only maybe...)
> 

doesn't seem so. V0.2 doesn't fix this for me. This time i got a BUG storm
again in syslog (it kinda seems related to starting playback in xmms plus
loading pages in mozilla. will boot again to verify):

Oct 25 16:53:42 mango kernel: IRQ#3 thread RT prio: 43.
Oct 25 16:53:52 mango kernel: mozilla-bin/741: BUG in futex_wait at kernel/futex.c:542
Oct 25 16:53:52 mango kernel:  [add_preempt_count+130/224] futex_wait+0x192/0x1a0 (12)
Oct 25 16:53:52 mango kernel:  [zlib_inflate_blocks+1352/3088] __up_write+0x148/0x320 (100)
Oct 25 16:53:52 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (16)
Oct 25 16:53:52 mango kernel:  [__func__.13+351/922] down_write+0xd5/0x250 (8)
Oct 25 16:53:52 mango kernel:  [kthread_create+120/208] check_preempt_timing+0x58/0x290 (8)
Oct 25 16:53:52 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:52 mango kernel:  [__func__.13+351/922] down_write+0xd5/0x250 (4)
Oct 25 16:53:52 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (8)
Oct 25 16:53:52 mango kernel:  [zlib_inflate_blocks+1352/3088] __up_write+0x148/0x320 (8)
Oct 25 16:53:52 mango kernel:  [kthread_create+120/208] check_preempt_timing+0x58/0x290 (8)
Oct 25 16:53:52 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:56 mango kernel:  [zlib_inflate_blocks+1352/3088] __up_write+0x148/0x320 (4)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (72)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (32)
Oct 25 16:53:56 mango kernel:  [print_last_trace+247/256] do_futex+0x47/0xa0 (40)
Oct 25 16:53:56 mango kernel:  [get_futex_key+128/448] sys_futex+0xf0/0x100 (40)
Oct 25 16:53:56 mango kernel:  [syscall_fault+35/40] syscall_call+0x7/0xb (68)
Oct 25 16:53:56 mango kernel: preempt count: 00000001
Oct 25 16:53:56 mango kernel: . 1-level deep critical section nesting:
Oct 25 16:53:56 mango kernel: .. entry 1: print_traces+0x1d/0x70 [__kfifo_put+157/208] / (dump_stack+0x23/0x30 [show_registers+3/464])
Oct 25 16:53:56 mango kernel:
Oct 25 16:53:56 mango kernel: kernel/futex.c:542
Oct 25 16:53:56 mango kernel:  [add_preempt_count+130/224] futex_wait+0x192/0x1a0 (12)
Oct 25 16:53:56 mango kernel:  [dequeue_task+24/64] effective_prio+0x8/0x60 (80)
Oct 25 16:53:56 mango kernel:  [decay_avgs_and_calculate_rates+136/624] recalc_task_prio+0x98/0x190 (8)
Oct 25 16:53:56 mango kernel:  [task_rq_lock+98/112] enqueue_task+0x12/0x50 (24)
Oct 25 16:53:56 mango kernel:  [decay_avgs_and_calculate_rates+487/624] activate_task+0x67/0x80 (16)
Oct 25 16:53:56 mango kernel:  [__mon_yday+161/268] preempt_schedule+0x11/0x80 (12)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (16)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (8)
Oct 25 16:53:56 mango kernel:  [kthread_create+120/208] check_preempt_timing+0x58/0x290 (8)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (4)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (60)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (12)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (20)
Oct 25 16:53:56 mango kernel:  [print_last_trace+247/256] do_futex+0x47/0xa0 (40)
Oct 25 16:53:56 mango kernel:  [get_futex_key+128/448] sys_futex+0xf0/0x100 (40)
Oct 25 16:53:56 mango kernel:  [syscall_fault+35/40] syscall_call+0x7/0xb (68)
Oct 25 16:53:56 mango kernel: preempt count: 00000001
Oct 25 16:53:56 mango kernel: . 1-level deep critical section nesting:
Oct 25 16:53:56 mango kernel: .. entry 1: print_traces+0x1d/0x70 [__kfifo_put+157/208] / (dump_stack+0x23/0x30 [show_registers+3/464])
Oct 25 16:53:56 mango kernel:
Oct 25 16:53:56 mango kernel: mozilla-bin/741: BUG in futex_wait at kernel/futex.c:542
Oct 25 16:53:56 mango kernel:  [add_preempt_count+130/224] futex_wait+0x192/0x1a0 (12)
Oct 25 16:53:56 mango kernel:  [dequeue_task+24/64] effective_prio+0x8/0x60 (80)
Oct 25 16:53:56 mango kernel:  [decay_avgs_and_calculate_rates+136/624] recalc_task_prio+0x98/0x190 (8)
Oct 25 16:53:56 mango kernel:  [task_rq_lock+98/112] enqueue_task+0x12/0x50 (24)
Oct 25 16:53:56 mango kernel:  [decay_avgs_and_calculate_rates+487/624] activate_task+0x67/0x80 (16)
Oct 25 16:53:56 mango kernel:  [__mon_yday+161/268] preempt_schedule+0x11/0x80 (12)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (16)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (8)
Oct 25 16:53:56 mango kernel:  [kthread_create+120/208] check_preempt_timing+0x58/0x290 (8)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (4)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (60)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (12)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (20)
Oct 25 16:53:56 mango kernel:  [print_last_trace+247/256] do_futex+0x47/0xa0 (40)
Oct 25 16:53:56 mango kernel:  [get_futex_key+128/448] sys_futex+0xf0/0x100 (40)
Oct 25 16:53:56 mango kernel:  [syscall_fault+35/40] syscall_call+0x7/0xb (68)
Oct 25 16:53:56 mango kernel: preempt count: 00000001
Oct 25 16:53:56 mango kernel: . 1-level deep critical section nesting:
Oct 25 16:53:56 mango kernel: .. entry 1: print_traces+0x1d/0x70 [__kfifo_put+157/208] / (dump_stack+0x23/0x30 [show_registers+3/464])
Oct 25 16:53:56 mango kernel:
Oct 25 16:53:56 mango kernel: mozilla-bin/741: BUG in futex_wait at kernel/futex.c:542
Oct 25 16:53:56 mango kernel:  [add_preempt_count+130/224] futex_wait+0x192/0x1a0 (12)
Oct 25 16:53:56 mango kernel:  [dequeue_task+24/64] effective_prio+0x8/0x60 (80)
Oct 25 16:53:56 mango kernel:  [decay_avgs_and_calculate_rates+136/624] recalc_task_prio+0x98/0x190 (8)
Oct 25 16:53:56 mango kernel:  [task_rq_lock+98/112] enqueue_task+0x12/0x50 (24)
Oct 25 16:53:56 mango kernel:  [decay_avgs_and_calculate_rates+487/624] activate_task+0x67/0x80 (16)
Oct 25 16:53:56 mango kernel:  [__mon_yday+161/268] preempt_schedule+0x11/0x80 (12)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (16)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (8)
Oct 25 16:53:56 mango kernel:  [kthread_create+120/208] check_preempt_timing+0x58/0x290 (8)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (4)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (60)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (12)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (20)
Oct 25 16:53:56 mango kernel:  [print_last_trace+247/256] do_futex+0x47/0xa0 (40)
Oct 25 16:53:56 mango kernel:  [get_futex_key+128/448] sys_futex+0xf0/0x100 (40)
Oct 25 16:53:56 mango kernel:  [syscall_fault+35/40] syscall_call+0x7/0xb (68)
Oct 25 16:53:56 mango kernel: preempt count: 00000001
Oct 25 16:53:56 mango kernel: . 1-level deep critical section nesting:
Oct 25 16:53:56 mango kernel: .. entry 1: print_traces+0x1d/0x70 [__kfifo_put+157/208] / (dump_stack+0x23/0x30 [show_registers+3/464])
Oct 25 16:53:56 mango kernel:
Oct 25 16:53:56 mango kernel: mozilla-bin/741: BUG in futex_wait at kernel/futex.c:542
Oct 25 16:53:56 mango kernel:  [add_preempt_count+130/224] futex_wait+0x192/0x1a0 (12)
Oct 25 16:53:56 mango kernel:  [dequeue_task+24/64] effective_prio+0x8/0x60 (80)
Oct 25 16:53:56 mango kernel:  [decay_avgs_and_calculate_rates+136/624] recalc_task_prio+0x98/0x190 (8)
Oct 25 16:53:56 mango kernel:  [task_rq_lock+98/112] enqueue_task+0x12/0x50 (24)
Oct 25 16:53:56 mango kernel:  [decay_avgs_and_calculate_rates+487/624] activate_task+0x67/0x80 (16)
Oct 25 16:53:56 mango kernel:  [__mon_yday+161/268] preempt_schedule+0x11/0x80 (12)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (16)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (8)
Oct 25 16:53:56 mango kernel:  [kthread_create+120/208] check_preempt_timing+0x58/0x290 (8)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (4)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (60)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (12)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (20)
Oct 25 16:53:56 mango kernel:  [print_last_trace+247/256] do_futex+0x47/0xa0 (40)
Oct 25 16:53:56 mango kernel:  [get_futex_key+128/448] sys_futex+0xf0/0x100 (40)
Oct 25 16:53:56 mango kernel:  [syscall_fault+35/40] syscall_call+0x7/0xb (68)
Oct 25 16:53:56 mango kernel: preempt count: 00000001
Oct 25 16:53:56 mango kernel: . 1-level deep critical section nesting:
Oct 25 16:53:56 mango kernel: .. entry 1: print_traces+0x1d/0x70 [__kfifo_put+157/208] / (dump_stack+0x23/0x30 [show_registers+3/464])
Oct 25 16:53:56 mango kernel:
Oct 25 16:53:56 mango kernel: mozilla-bin/741: BUG in futex_wait at kernel/futex.c:542
Oct 25 16:53:56 mango kernel:  [add_preempt_count+130/224] futex_wait+0x192/0x1a0 (12)
Oct 25 16:53:56 mango kernel:  [dequeue_task+24/64] effective_prio+0x8/0x60 (80)
Oct 25 16:53:56 mango kernel:  [decay_avgs_and_calculate_rates+136/624] recalc_task_prio+0x98/0x190 (8)
Oct 25 16:53:56 mango kernel:  [task_rq_lock+98/112] enqueue_task+0x12/0x50 (24)
Oct 25 16:53:56 mango kernel:  [decay_avgs_and_calculate_rates+487/624] activate_task+0x67/0x80 (16)
Oct 25 16:53:56 mango kernel:  [__mon_yday+161/268] preempt_schedule+0x11/0x80 (12)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (16)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (8)
Oct 25 16:53:56 mango kernel:  [kthread_create+120/208] check_preempt_timing+0x58/0x290 (8)
Oct 25 16:53:56 mango kernel:  [wake_bit_function+5/96] sub_preempt_count+0x65/0xd0 (4)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (4)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (60)
Oct 25 16:53:56 mango kernel:  [__func__.5+7/19] preempt_schedule_irq+0x6f/0xa0 (12)
Oct 25 16:53:56 mango kernel:  [deactivate_task+0/64] default_wake_function+0x0/0x20 (20)
Oct 25 16:53:56 mango kernel:  [print_last_trace+247/256] do_futex+0x47/0xa0 (40)
Oct 25 16:53:56 mango kernel:  [get_futex_key+128/448] sys_futex+0xf0/0x100 (40)
Oct 25 16:53:56 mango kernel:  [syscall_fault+35/40] syscall_call+0x7/0xb (68)
Oct 25 16:53:56 mango kernel: preempt count: 00000001
Oct 25 16:53:56 mango kernel: . 1-level deep critical section nesting:
Oct 25 16:53:56 mango kernel: .. entry 1: print_traces+0x1d/0x70 [__kfifo_put+157/208] / (dump_stack+0x23/0x30 [show_registers+3/464])
Oct 25 16:53:56 mango kernel:

[gazillions more]

flo
