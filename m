Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290250AbSAOSur>; Tue, 15 Jan 2002 13:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290243AbSAOSui>; Tue, 15 Jan 2002 13:50:38 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:6411 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S290248AbSAOSu0>; Tue, 15 Jan 2002 13:50:26 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Jan 2002 10:56:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -I1
In-Reply-To: <Pine.LNX.4.33.0201152022590.14517-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201151050080.1460-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Ingo Molnar wrote:

>
> On Tue, 15 Jan 2002, Davide Libenzi wrote:
>
> > >  - RT scheduling is broken.
> >
> > Why ?
>
> RR tasks were queued to the expired array.

Doh (1) !! true

>
> > [...] Ingo, IMHO is not correct to give time slices depending on
> > priority and we should return to the old TS(nice) behavior.
>
> i agree - but your new patch is broken still, you have the timeslice range
> inverted(!) :-)

Doh (2) !! true



> > [...] IMVHO is not correct to have new tasks to fully inherit parent
> > priority because :
>
> i fully agree - in -I0 i have kept the 'child gets 10% less priority than
> parent' rule. This works really well in fork-bomb situations, i've tested
> this with -I0. (and -I1 as well.) It also works well with interactive
> shells, which want to start processes which will inherit *some* of their
> parent's priority, but not all of it.

I give them 1/3 to match it with PRIO_INTERACTIVE rule




> > 2) if an interactive task is born we do not need an immediate priority
> > boost
>
> Think about starting a simple 'ls' under X if under some high load. This
> works just fine under 2.5.2-vanilla and 2.5.2-I0 as well. We should give
> the task a chance to finish within ... 500 or 1000 msecs (or so), most
> shell commands that fork do so.

Lower priority start point in do_fork() helps, IMHO, real interactive
tasks like editors, X, ...
Try different values with make -j40 running ...



> > 3) if a cpu bound task born from an interactive task ( very very common )
> > 	it'll make a long run on the cpu before falling in the hell of cpu
> > 	bound tasks
> >
> > I've also decreased the minimum time slice to 10ms and increased the
> > max to 160ms and this should cast back niced tasks to low cpu usages.
>
> (i've done this already in -I0, based on earlier comments of yours.)
>
> > I'm using it in my desk and just to have fun i keep running make -j20
> > in background:-)
>
> please re-test this with -I1. (i've tested it and it works just fine, but
> more testing cannot hurt.)
>
> are there any other items in your patch that are not yet in -I1?

I'll take a closer look asap ...




- Davide


