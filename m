Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVFNSZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVFNSZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVFNSZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:25:36 -0400
Received: from mail1.utc.com ([192.249.46.190]:46234 "EHLO mail1.utc.com")
	by vger.kernel.org with ESMTP id S261283AbVFNSZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:25:14 -0400
Message-ID: <42AF20F9.20704@cybsft.com>
Date: Tue, 14 Jun 2005 13:24:57 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu>
In-Reply-To: <20050608112801.GA31084@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0.7.48-00 Real-Time Preemption patch, which can be 
> downloaded from the usual place:

Ingo,

I just got this soft lock with -RT-2.6.12-rc6-V0.7.48-32 on my dual 2.6G 
Xeon W/HT. Not sure what causes it. Just typing away and its like a key 
sticks. It keeps printing the same key, even if I use the mouse to 
change focus the typing follows the focus, and then it finally hangs.


Jun 14 13:07:40 swdev14 kernel: BUG: soft lockup detected on CPU#1!
Jun 14 13:07:40 swdev14 kernel:
Jun 14 13:07:40 swdev14 kernel: Pid: 13, comm:      softirq-timer/1
Jun 14 13:07:40 swdev14 kernel: EIP: 0060:[<c02c5608>] CPU: 1
Jun 14 13:07:40 swdev14 kernel: EIP is at _raw_spin_lock+0x69/0x85
Jun 14 13:07:40 swdev14 kernel:  EFLAGS: 00000202    Not tainted 
(2.6.12-rc6-RT-V0.7.48-32)
Jun 14 13:07:40 swdev14 kernel: EAX: 00000001 EBX: c141f804 ECX: 
c02c55ba EDX: 00000000
Jun 14 13:07:40 swdev14 kernel: ESI: c1560000 EDI: c0727520 EBP: 
c1561e2c DS: 007b ES: 007b
Jun 14 13:07:40 swdev14 kernel: CR0: 8005003b CR2: b7fe0000 CR3: 
1ff55000 CR4: 000006d0
Jun 14 13:07:40 swdev14 kernel:  [<c01014d2>] show_regs+0x14b/0x175 (36)
Jun 14 13:07:40 swdev14 kernel:  [<c01436b2>] softlockup_tick+0x75/0x86 (28)
Jun 14 13:07:40 swdev14 kernel:  [<c010815c>] timer_interrupt+0x39/0x9e (20)
Jun 14 13:07:40 swdev14 kernel:  [<c0143981>] handle_IRQ_event+0x6a/0xe4 
(52)
Jun 14 13:07:40 swdev14 kernel:  [<c0143b03>] __do_IRQ+0xec/0x159 (52)
Jun 14 13:07:40 swdev14 kernel:  [<c01059fa>] do_IRQ+0x3a/0x4b (28)
Jun 14 13:07:40 swdev14 kernel:  [<c0103d26>] common_interrupt+0x1a/0x20 
(72)
Jun 14 13:07:40 swdev14 kernel:  [<c0127a17>] __mod_timer+0xaa/0x17c (44)
Jun 14 13:07:40 swdev14 kernel:  [<c020d302>] i8042_interrupt+0x26/0x241 
(56)
Jun 14 13:07:40 swdev14 kernel:  [<c0143981>] handle_IRQ_event+0x6a/0xe4 
(52)
Jun 14 13:07:40 swdev14 kernel:  [<c0143b03>] __do_IRQ+0xec/0x159 (52)
Jun 14 13:07:40 swdev14 kernel:  [<c01059fa>] do_IRQ+0x3a/0x4b (28)
Jun 14 13:07:40 swdev14 kernel:  [<c0103d26>] common_interrupt+0x1a/0x20 
(64)
Jun 14 13:07:40 swdev14 kernel:  [<c0128562>] 
run_timer_softirq+0x25c/0x404 (64)
Jun 14 13:07:40 swdev14 kernel:  [<c01245b2>] ksoftirqd+0xe9/0x19d (32)
Jun 14 13:07:40 swdev14 kernel:  [<c013416b>] kthread+0xab/0xd3 (48)
Jun 14 13:07:40 swdev14 kernel:  [<c0101501>] 
kernel_thread_helper+0x5/0xb (1051320348)
Jun 14 13:07:40 swdev14 kernel: ---------------------------
Jun 14 13:07:40 swdev14 kernel: | preempt count: 20020005 ]
Jun 14 13:07:40 swdev14 kernel: | 5-level deep critical section nesting:
Jun 14 13:07:40 swdev14 kernel: ----------------------------------------
Jun 14 13:07:40 swdev14 kernel: .. [<c02c55ba>] .... 
_raw_spin_lock+0x1b/0x85
Jun 14 13:07:40 swdev14 kernel: .....[<c012841e>] ..   ( <= 
run_timer_softirq+0x118/0x404)
Jun 14 13:07:40 swdev14 kernel: .. [<c02c55ba>] .... 
_raw_spin_lock+0x1b/0x85
Jun 14 13:07:40 swdev14 kernel: .....[<c01279b1>] ..   ( <= 
__mod_timer+0x44/0x17c)
Jun 14 13:07:40 swdev14 kernel: .. [<c02c55ba>] .... 
_raw_spin_lock+0x1b/0x85
Jun 14 13:07:40 swdev14 kernel: .....[<c010813c>] ..   ( <= 
timer_interrupt+0x19/0x9e)
Jun 14 13:07:40 swdev14 kernel: .. [<c02c55ba>] .... 
_raw_spin_lock+0x1b/0x85
Jun 14 13:07:40 swdev14 kernel: .....[<c0143697>] ..   ( <= 
softlockup_tick+0x5a/0x86)
Jun 14 13:07:40 swdev14 kernel: .. [<c013d423>] .... print_traces+0x1b/0x52
Jun 14 13:07:40 swdev14 kernel: .....[<c01014d2>] ..   ( <= 
show_regs+0x14b/0x175)

-- 
    kr
