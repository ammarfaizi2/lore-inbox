Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269107AbRG3WsR>; Mon, 30 Jul 2001 18:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269106AbRG3WsH>; Mon, 30 Jul 2001 18:48:07 -0400
Received: from nrg.org ([216.101.165.106]:54602 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S269099AbRG3Wrs>;
	Mon, 30 Jul 2001 18:47:48 -0400
Date: Mon, 30 Jul 2001 15:47:51 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Ingo Molnar <mingo@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
In-Reply-To: <Pine.LNX.4.33.0107301444430.28294-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.05.10107301529300.11108-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Ingo Molnar wrote:
> > > I think the latency issue was really the fact that we weren't always
> > > running softirqs in a timely fashion after they had been disabled by a
> > > "disable_bh()". That is fixed with the new softirq stuff, regardless of
> > > the other issues.
> 
> nope. i observed latency issues with restart + ksoftirqd as well. [when i
> first saw these latency problems i basically had ksoftirqd implemented
> independently from your patch, and threw the idea away because it was
> insufficient from the latency point of view.] Those latencies are harder
> to observe because they are not 1/HZ anymore but several hundred millisecs
> at most. Plus, like i said previously, pushing IRQ context work into a
> scheduler-level context 'feels' incorrect to me - it only makes the
> latencies less visible. I'll do some measurements.

If you schedule ksoftirqd as SCHED_FIFO or SCHED_RR, and run with the
preemptible kernel patch, you can get maximum latencies down to a few
hundred microseconds most of the time, with typical latencies of a few
tens of microseconds.   Perhaps you could also measure that
configuration?  (Latest preemptible kernel patch is available at
kpreempt.sourceforge.net).

I'd like to see all the various execution contexts of Linux (irqs,
softirqs, tasklets, kernel daemons) all become (real-time where
necessary) kernel threads like ksoftirqd, scheduled with the appropriate
scheduling class and priority.  The resulting kernel code would be much
simpler and more maintainable; and it would make it possible to change
the scheduling priority of the threads to optimize for different
application loads.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

