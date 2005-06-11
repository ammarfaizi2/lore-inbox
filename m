Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVFKBlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVFKBlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 21:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVFKBlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 21:41:36 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13745 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261510AbVFKBlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 21:41:11 -0400
Date: Fri, 10 Jun 2005 18:41:33 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Karim Yaghmour <karim@opersys.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050611014133.GO1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com> <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random> <20050610230836.GD21618@nietzsche.lynx.com> <20050610232955.GH6564@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610232955.GH6564@g5.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 01:29:55AM +0200, Andrea Arcangeli wrote:
> On Fri, Jun 10, 2005 at 04:08:36PM -0700, Bill Huey wrote:
> > On Sat, Jun 11, 2005 at 12:52:31AM +0200, Andrea Arcangeli wrote:
> > > Just tell me how can you go to a customer and tell him that your
> > > linux-RTOS has a guaranteed worst case latency of 50usec.  How can you
> > > tell that? Did you exercise all possible scheduler paths with cache
> > > disabled and calculated the worst case latency with rdtsc + math?
> > 
> > Ask Ingo. I'm through with this track and your misinformed comments
> 
> You didn't provide an answer yourself, and you fallback on somebody else
> cause there's no valid answer to this question. All I've seen so far are
> measurements backed by some statistical significance, that's very far
> from the meaning I give to the word _guarantee_.

I just -know- I am going to regret stepping into the middle of
this one...

[Hey, Karim!!!  Any extra room in that bunker of yours?]

All I have seen Ingo claim is that -some- hardware configurations running
-some- specific workloads had excellent -measured- maximum scheduling
latencies.  I have not seen Ingo claim that he has mathematically proven
that CONFIG_PREEMPT_RT's worst-case scheduling latency is bounded, let
alone make any claim of what such a mathematically proven bound might be.
Nor have I seen Ingo claim that CONFIG_PREEMPT_RT has passed any sort of
industry-standard acceptance test.  If I missed such a mathematical proof,
or such an industry-standard acceptance test, please send me the URL.

Ingo -has- greatly reduced the amount of kernel code that must
be inspected to guarantee realtime response, and this is a great
accomplishment and a great contribution.  I believe that his approach
is more than "good enough" for a great number of applications that are
traditionally thought of as "hard realtime".  But, unless I missed
something, it is not mathematically proven, nor is it in any way
"certified".

Some of the approaches involving separate RTOSes -can- legitimately claim
have mathematically proven worst-case scheduling latencies.  For example,
the dual-OS/dual-core approach can do so, particularly in the case where
the "RTOS" is a tight loop written on bare metal in hand-coded assembly.
One might consider this to be a trivial example, perhaps even a stupid
example, but there are a lot of apps out there that use exactly this
approach.

The migration-between-OSes approach, such as RTAI Fusion, might also be
able to mathematically guarantee RTOS scheduling latencies.  And, unlike
the dual-OS/dual-core approaches, it does provide a single environment
to applications.  However, it still results in two separate OS instances
to administer, and, as near as I can tell, the RTOS has to stick its
hands so deeply into Linux's internals that it might as well be part
of the Linux kernel.  Unless I am missing something, any sort of bug
in the Linux kernel has a reasonable chance of messing up the RTOS,
since the RTOS must paw through Linux's tasks.

Can we say that one of these approaches is definitely "good enough" for
all reasonable Linux RT work, and that we should therefore stop working on 
the other approach?

I might well be missing something, but I don't believe so, at least
not yet.

In the meantime, the more time anyone spends sending flames on LKML, the
less time that person is putting into improving his/her favorite approach.
So the greater number of flames one sends, the smaller one's favorite
approach's chance of success!

							Thanx, Paul

> I fully acknowledge there are some problems that aren't more equally
> easily solved with full userland code, for those problems keeping things
> simpler by making the kernel more RT aware has a value.
> 
> I fully acknowledge that simulating infinite cpus has a value too in
> discovering race conditions too ;).
> 
> But I personally dislike all things that works by luck, preempt-RT that
> aims to provide guarantees about worst case latencies is no exception,
> so you shoudln't be surprised if I'm not a RTOS backer for problems that
> can be more easily solved with ruby-hard RT designs like RTAI and
> rtlinux. I don't care how things have worked in the past on non-linux
> OS. Most of the time even current not-RT linux will work fine if it's
> idle as it would be on some embedded usages like the printer example.
> 
> This even ignoring the fact all those context switch will not be cheap,
> kernel can execute a lot more hard-irqs than context switches per
> second, and this is another fact. On a 4ghz cpu it doesn't matter, but
> on a embedded it can matter, so the more reliable solution is obviously
> higher performant too. Of the 50usec it takes to such project on
> linuxdevices to execute probably a 10% of that is wasted in the irq
> handling itself (ioapic hardware proper stuff).
> 
> Anyway I've more fun things to do on than to talk about hard-RT, which
> I'm doing just with the aim to provide my little contribution in form of
> IMHO valid criticism that you clearly don't appreciate.
> 
