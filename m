Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292228AbSBYUQo>; Mon, 25 Feb 2002 15:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292327AbSBYUQh>; Mon, 25 Feb 2002 15:16:37 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:34572 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S292228AbSBYUQD>; Mon, 25 Feb 2002 15:16:03 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 25 Feb 2002 12:18:43 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Larry McVoy <lm@bitmover.com>
cc: Bill Davidsen <davidsen@tmr.com>, <lse-tech@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] NUMA scheduling
In-Reply-To: <20020225120242.F22497@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0202251215510.1499-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Larry McVoy wrote:

> On Mon, Feb 25, 2002 at 02:49:40PM -0500, Bill Davidsen wrote:
> > On Mon, 25 Feb 2002, Larry McVoy wrote:
> >
> > > If you read the early hardware papers on SMP, they all claim "Symmetric
> > > Multi Processor", i.e., you can run any process on any CPU.  Skip forward
> > > 3 years, now read the cache affinity papers from the same hardware people.
> > > You have to step back and squint but what you'll see is that these papers
> > > could be summarized on one sentence:
> > >
> > > 	"Oops, we lied, it's not really symmetric at all"
> > >
> > > You should treat each CPU as a mini system and think of a process reschedule
> > > someplace else as a checkpoint/restart and assume that is heavy weight.  In
> > > fact, I'd love to see the scheduler code forcibly sleep the process for
> > > 500 milliseconds each time it lands on a different CPU.  Tune the system
> > > to work well with that, then take out the sleep, and you'll have the right
> > > answer.
> >
> >   Unfortunately this is an overly simple view of how SMP works. The only
> > justification for CPU latency is to preserve cache contents. Trying to
> > express this as a single number is bound to produce suboptimal results.
>
> And here is the other side of the coin.  Remember what we are doing.
> We're in the middle of a context switch, trying to figure out where we
> should run this process.  We would like context switches to be fast.
> Any work we do here is at direct odds with our goals.  SGI took the
> approach that your statements would imply, i.e., approximate the
> cache footprint, figure out if it was big or small, and use that to
> decide where to land the process.  This has two fatal flaws:
> a) Because there is no generic hardware interface to say "how many cache
>    lines are mine", you approximate that by looking at how much of the
>    process timeslice this process used, if it used a lot, you guess it
>    filled the cache.  This doesn't work at all for I/O bound processes,
>    who typically run in short bursts.  So IRIX would bounce these around
>    for no good reason, resulting in crappy I/O perf.  I got about another
>    20% in BDS by locking down the processes (BDS delivered 3.2GBytes/sec
>    of NFS traffic, sustained, in 1996).
> b) all of the "thinking" you do to figure out where to land the process
>    contributes directly to the cost of the context switch.  Linux has
>    nice light context switches, let's keep it that way.

Obviously Larry you do not want to do such work on an active CPU. Idle
time is balancing time ...




- Davide


