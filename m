Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269018AbTBWXum>; Sun, 23 Feb 2003 18:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269027AbTBWXum>; Sun, 23 Feb 2003 18:50:42 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20235 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S269018AbTBWXud>; Sun, 23 Feb 2003 18:50:33 -0500
Date: Sun, 23 Feb 2003 18:57:09 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <20030222231552.GA31268@work.bitmover.com>
Message-ID: <Pine.LNX.3.96.1030223183404.999F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003, Larry McVoy wrote:

> > We would never try to propose such a change, and never have. 
> > Name a scalability change that's hurt the performance of UP by 5%.
> > There isn't one.
> 
> This is *exactly* the reasoning that every OS marketing weenie has used
> for the last 20 years to justify their "feature" of the week.
> 
> The road to slow bloated code is paved one cache miss at a time.  You
> may quote me on that.  In fact, print it out and put it above your
> monitor and look at it every day.  One cache miss at a time.  How much
> does one cache miss add to any benchmark?  .001%?  Less.  
> 
> But your pet features didn't slow the system down.  Nope, they just made
> the cache smaller, which you didn't notice because whatever artificial
> benchmark you ran didn't happen to need the whole cache.  

Clearly this is the case, the benefit of a change must balance the
negative effects. Making the code paths longer hurts free cache, having
more of them should not. More code is not always slower code, and doesn't
always have more impact on cache use. You identify something which must be
considered, but it's not the only thing to consider. Linux shouild be
stable, not moribund.

> You need to understand that system resources belong to the user.  Not the
> kernel.  The goal is to have all of the kernel code running under any 
> load be less than 1% of the CPU.  Your 5% number up there would pretty 
> much double the amount of time we spend in the kernel for most workloads.

Who profits? For most users a bit more system time resulting in better
disk performance would be a win, or at least non-lose. This isn't black
and white.


On Sat, 22 Feb 2003, Larry McVoy wrote:

> Let's get back to your position.  You want to shovel stuff in the kernel
> for the benefit of the 32 way / 64 way etc boxes.  I don't see that as
> wise.  You could prove me wrong.  Here's how you do it: go get oprofile
> or whatever that tool is which lets you run apps and count cache misses.
> Start including before/after runs of each microbench in lmbench and 
> some time sharing loads with and without your changes.  When you can do
> that and you don't add any more bus traffic, you're a genius and 
> I'll shut up.

Code only costs when it's executed. Linux is somewhat heading to the place
where a distro has a few useful configs and then people who care for the
last bit of whatever they see as a bottleneck can build their own fro
"make config." So it is possible to add features for big machines without
any impact on the builds which don't use the features. it goes without
saying that this is hard. I would guess that it results in more bugs as
well, if one path or another is "the less-traveled way."

> 
> But that's a false promise because by definition, fine grained threading
> adds more bus traffic.  It's kind of hard to not have that happen, the
> caches have to stay coherent somehow.

Clearly. And things which require more locking will pay some penalty for
this. But a quick scan of this list on keyword "lockless' will show that
people are thinking about this.

I don't think developers will buy ignoring part of the market to
completely optimize for another. Linux will grow by being ubiquitious, not
by winning some battle and losing the war. It's not a niche market os.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

