Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbUJYNYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUJYNYD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUJYNYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:24:02 -0400
Received: from pop.gmx.de ([213.165.64.20]:32913 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261799AbUJYNXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:23:03 -0400
X-Authenticated: #4399952
Date: Mon, 25 Oct 2004 15:39:40 +0200
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
Message-ID: <20041025153940.1de340b4@mango.fruits.de>
In-Reply-To: <20041025121210.GA6555@elte.hu>
References: <20041019124605.GA28896@elte.hu>
	<20041019180059.GA23113@elte.hu>
	<20041020094508.GA29080@elte.hu>
	<20041021132717.GA29153@elte.hu>
	<20041022133551.GA6954@elte.hu>
	<20041022155048.GA16240@elte.hu>
	<20041022175633.GA1864@elte.hu>
	<20041025104023.GA1960@elte.hu>
	<417CDE90.6040201@cybsft.com>
	<20041025111046.GA3630@elte.hu>
	<20041025121210.GA6555@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004 14:12:10 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> i think i found the bug - now selinux boots fine. I've uploaded -V0.1
> with the fix included. This fix could solve a number of other complaints
> as well.

some more:

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

mozilla-bin/753: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c01ef27b>] __up_write+0x13b/0x320 (84)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (16)
 [<c02b9880>] down_write+0xd0/0x2b0 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c02b9880>] down_write+0xd0/0x2b0 (4)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (8)
 [<c01ef27b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef27b>] __up_write+0x13b/0x320 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (72)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

