Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261826AbSJJRnE>; Thu, 10 Oct 2002 13:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261852AbSJJRnE>; Thu, 10 Oct 2002 13:43:04 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20239 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261826AbSJJRnB>; Thu, 10 Oct 2002 13:43:01 -0400
Date: Thu, 10 Oct 2002 13:40:49 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Con Kolivas <conman@kolivas.net>
cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.40-mm2 with contest
In-Reply-To: <1034041272.3da237b8b7908@kolivas.net>
Message-ID: <Pine.LNX.3.96.1021010133332.17862B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Con Kolivas wrote:

> > Problem is, users have said they don't want that.  They say that they
> > want to copy ISO images about all day and not swap.  I think.
> 
> But do they really want that or do they think they want that without knowing the
> consequences of such a setting?

I have been able to tune bdflush in 2.4-aa kernels to be much more
aggressive about moving data to disk under write pressure, and that has
been a big plus in terms of both getting the write completed in less real
time and fewer big pauses doing trivial things like uncovering a window. I
see less swap used.

> 
> > It worries me.  It means that we'll be really slow to react to sudden
> > load swings, and it increases the complexity of the analysis and
> > testing.  And I really do want to give the user a single knob,
> > which has understandable semantics and for which I can feasibly test
> > all operating regions.
> > 
> > I really, really, really, really don't want to get too fancy in there.
> 
> Well I made it as simple as I possibly could. It seems to do what they want (not
> swappy) but not at the expense of making the machine never swapping when it
> really needs to - and the performance seems to be better all round in real
> usage. I guess the only thing is it isn't a fixed number... unless we set a
> maximum swappiness level or... but then it starts getting unnecessarily
> complicated with questionable benefits.

I'm going to try this patch, but building a kernel on my standard test
machine is painfully slow, so it will come after 41-ac2. It appears to
address the balance issue dynamically.
 
> > I have changed this code a bit, and have added other things.  Mainly
> > over on the writer throttling side, which tends to be the place where
> > the stress comes from in the first place.
> 
> /me waits but is a little disappointed

I actually like the idea of writer throttling, I just wonder how it will
work at the corner cases like only one big writer (mkisofs) or the
alternative, lots of little writers. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

