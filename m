Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSGEGQI>; Fri, 5 Jul 2002 02:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSGEGQH>; Fri, 5 Jul 2002 02:16:07 -0400
Received: from admin.nni.com ([216.107.0.51]:45318 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S315442AbSGEGQG>;
	Fri, 5 Jul 2002 02:16:06 -0400
Date: Fri, 5 Jul 2002 02:18:27 -0400
From: Andrew Rodland <arodland@noln.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Re: [OKS] O(1) scheduler in 2.4
Message-Id: <20020705021827.713e4cc6.arodland@noln.com>
In-Reply-To: <Pine.LNX.4.44.0207040846340.3309-100000@e2>
References: <Pine.LNX.3.96.1020703232322.2248C-100000@gatekeeper.tmr.com>
	<Pine.LNX.4.44.0207040846340.3309-100000@e2>
X-Mailer: Sylpheed version 0.7.6claws16 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002 08:56:01 +0200 (CEST)
Ingo Molnar <mingo@elte.hu> wrote:

> 
> On Wed, 3 Jul 2002, Bill Davidsen wrote:
> 
> > > it might be a candidate for inclusion once it has _proven_
> > > stability and robustness (in terms of tester and developer
> > > exposion), on the same order of magnitude as the 2.4 kernel - but
> > > that needs time and exposure in trees like the -ac tree and vendor
> > > trees. It might not happen at all, during the lifetime of 2.4.
> > 
> > It has already proven to be stable and robust in the sense that it
> > isn't worse than the stock scheduler on typical loads and is vastly
> > better on some.
> 
> this is your experience, and i'm happy about that. Whether it's the
> same experience for 90% of Linux users, time will tell.
> 
> > > Note that the O(1) scheduler isnt a security or stability fix,
> > > neither is it a driver backport. It isnt a feature backport that
> > > enables hardware that couldnt be used in 2.4 before. The VM was a
> > > special case because most people agreed that it truly sucked, and
> > > even though people keep disagreeing about that decision, the VM is
> > > in a pretty good shape now - and we still have good correlation
> > > between the VM in 2.5, and the VM in 2.4. The 2.4 scheduler on the
> > > other hand doesnt suck for 99% of the people, so our hands are not
> > > forced in any way - we have the choice of a'proven-rock-solid good
> > > scheduler' vs. an 'even better, but still young scheduler'.
> > 
> > Here I disagree. Sure behaves like a stability fix to me. On a
> > system with a mix of interractive and cpu-bound processes, including
> > processes with hundreds of threads, you just can't get reasonable
> > performance balancing with nice() because it is totally impractical
> > to keep tuning a thread which changes from hog to disk io to socket
> > waits with a human in the loop. The new scheduler notices this stuff
> > and makes it work, I don't even know for sure (as in tried it) if
> > you can have different nice on threads of the same process.
> 
> (yes, it's possible to nice() individual threads.)
> 
> > This is not some neat feature to buy a few percent better this or
> > that, this is roughly 50% more users on the server before it falls
> > over, and no total bogs when many threads change to hog mode at
> > once.
> 
> are these hard numbers? I havent seen much hard data yet from
> real-life servers using the O(1) scheduler. There was lots of feedback
> from desktop-class systems that behave better, but servers used to be
> pretty good with the previous scheduler as well.
> 
> > You will not hear me saying this about preempt, or low-latency, and
> > I bet that after I try lock-break this weekend I won't fell that I
> > have to have that either. The O(1) scheduler is self defense against
> > badly behaved processes, and the reason it should go in mainline is
> > so it won't depend on someone finding the time to backport the fun
> > stuff from 2.5 as a patch every time.
> 
> well, the O(1) scheduler indeed tries to put up as much defense
> against'badly behaved' processes as possible. In fact you should try
> to start up your admin shells via nice -20, that gives much more
> priority than it used to under the previous scheduler - it's very
> close to the RT priorities, but without the risks. This works in the
> other direction as well: nice +19 has a much stronger meaning (in
> terms of preemption and timeslice distribution) than it used to.

Very nearly off topic, but I've had a few people on IRC tell me that
they love O(1) specifically because it has a 'nice that actually does
something'. As a matter of fact, I've had to change my X startup
scripts, to make it a bit less selfish; the defaults are just plain
silly, now.

I had thought before that I had a complaint about processes that spawn a
large number of children, and then reap them all at once, but it turns
out that I was just running myself out of memory while conducting the
test, and that if I avoid swapping, I don't run into any problems. I'm
running 2.4.19-pre10-ac2 + preempt + some little things, on a 400mhz
laptop, and it's just about as smooth as I could ask for.

As for O(1) in mainline, I think that it's better than what we've got.
But as for me, as long as O(1)-sched keeps moving, and AC keeps cranking
out the patches, I'll be happy. >:) 
> 
> 	Ingo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
