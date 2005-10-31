Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVJaSOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVJaSOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 13:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVJaSOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 13:14:20 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:7365 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S932291AbVJaSOU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 13:14:20 -0500
Subject: Re: 2.6.14-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Mark Knecht <markknecht@gmail.com>, john stultz <johnstul@us.ibm.com>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20051030133316.GA11225@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 10:13:16 -0800
Message-Id: <1130782396.4775.2.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-30 at 14:33 +0100, Ingo Molnar wrote:
> i have released the 2.6.14-rt1 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this release is mainly about ktimer fixes: it updates to the latest 
> ktimer tree from Thomas Gleixner (which includes John Stultz's latest 
> GTOD tree), it fixes TSC synchronization problems on HT systems, and 
> updates the ktimers debugging code.
> 
> These together could fix most of the timer warnings and annoyances 
> reported for 2.6.14-rc5-rt kernels. In particular the new 
> TSC-synchronization code could fix SMP systems: the upstream TSC 
> synchronization method is fine for 1 usec resolution, but it was not 
> good enough for 1 nsec resolution and likely caused the SMP bugs 
> reported by Fernando Lopez-Lezcano and Rui Nuno Capela.

I just booted into 2.6.14-rt1 (SMP, no HIGH_REG_TIMERS) and got these:

... ITSC warped from 000000622fc9fbbf [0] to 000000622fc87638 [1].
softirq-timer/1/13[CPU#1]: BUG in __get_nsec_offset at
kernel/time/timeofday.c:181
 [<c0128167>] __WARN_ON+0x67/0x90 (8)
 [<c0143d16>] get_realtime_clock+0x266/0x2d0 (48)
 [<c014104f>] ktimer_run_queues+0x2f/0x130 (96)
 [<c01317ee>] run_timer_softirq+0xde/0x380 (48)
 [<c03750b5>] schedule+0x85/0x100 (24)
 [<c012d588>] ksoftirqd+0x118/0x1e0 (28)
 [<c012d470>] ksoftirqd+0x0/0x1e0 (44)
 [<c013d31c>] kthread+0xac/0xb0 (4)
 [<c013d270>] kthread+0x0/0xb0 (12)
 [<c0101545>] kernel_thread_helper+0x5/0x10 (16)
... ITSC warped from 00000064bbf83c4f [0] to 00000064bbf216ec [1].
softirq-timer/1/13[CPU#1]: BUG in __get_nsec_offset at
kernel/time/timeofday.c:181
 [<c0128167>] __WARN_ON+0x67/0x90 (8)
 [<c0143d16>] get_realtime_clock+0x266/0x2d0 (48)
 [<c014104f>] ktimer_run_queues+0x2f/0x130 (96)
 [<c01317ee>] run_timer_softirq+0xde/0x380 (48)
 [<c03750b5>] schedule+0x85/0x100 (24)
 [<c012d588>] ksoftirqd+0x118/0x1e0 (28)
 [<c012d470>] ksoftirqd+0x0/0x1e0 (44)
 [<c013d31c>] kthread+0xac/0xb0 (4)
 [<c013d270>] kthread+0x0/0xb0 (12)
 [<c0101545>] kernel_thread_helper+0x5/0x10 (16)
... ITSC warped from 0000006748267cdf [0] to 00000067481d6636 [1].
softirq-timer/1/13[CPU#1]: BUG in __get_nsec_offset at
kernel/time/timeofday.c:181
 [<c0128167>] __WARN_ON+0x67/0x90 (8)
 [<c0143d16>] get_realtime_clock+0x266/0x2d0 (48)
 [<c014104f>] ktimer_run_queues+0x2f/0x130 (96)
 [<c01317ee>] run_timer_softirq+0xde/0x380 (48)
 [<c03750b5>] schedule+0x85/0x100 (24)
 [<c012d588>] ksoftirqd+0x118/0x1e0 (28)
 [<c012d470>] ksoftirqd+0x0/0x1e0 (44)
 [<c013d31c>] kthread+0xac/0xb0 (4)
 [<c013d270>] kthread+0x0/0xb0 (12)
 [<c0101545>] kernel_thread_helper+0x5/0x10 (16)
... ITSC warped from 00000069d454bd6f [0] to 00000069d44857fc [1].
softirq-timer/1/13[CPU#1]: BUG in __get_nsec_offset at
kernel/time/timeofday.c:181
 [<c0128167>] __WARN_ON+0x67/0x90 (8)
 [<c0143d16>] get_realtime_clock+0x266/0x2d0 (48)
 [<c014104f>] ktimer_run_queues+0x2f/0x130 (96)
 [<c01317ee>] run_timer_softirq+0xde/0x380 (48)
 [<c03750b5>] schedule+0x85/0x100 (24)
 [<c012d588>] ksoftirqd+0x118/0x1e0 (28)
 [<c012d470>] ksoftirqd+0x0/0x1e0 (44)
 [<c013d31c>] kthread+0xac/0xb0 (4)
 [<c013d270>] kthread+0x0/0xb0 (12)
 [<c0101545>] kernel_thread_helper+0x5/0x10 (16)
... ITSC warped from 00000069d454bd6f [1] to 00000069d4515d11 [1].
softirq-timer/1/13[CPU#1]: BUG in __get_nsec_offset at
kernel/time/timeofday.c:181
 [<c0128167>] __WARN_ON+0x67/0x90 (8)
 [<c01436e6>] get_monotonic_clock+0x246/0x2b0 (48)
 [<c014104f>] ktimer_run_queues+0x2f/0x130 (96)
 [<c01317ee>] run_timer_softirq+0xde/0x380 (48)
 [<c03750b5>] schedule+0x85/0x100 (24)
 [<c012d588>] ksoftirqd+0x118/0x1e0 (28)
 [<c012d470>] ksoftirqd+0x0/0x1e0 (44)
 [<c013d31c>] kthread+0xac/0xb0 (4)
 [<c013d270>] kthread+0x0/0xb0 (12)
 [<c0101545>] kernel_thread_helper+0x5/0x10 (16)

-- Fernando


