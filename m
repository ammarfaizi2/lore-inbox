Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268497AbTBOBdD>; Fri, 14 Feb 2003 20:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268501AbTBOBdD>; Fri, 14 Feb 2003 20:33:03 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:58247 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S268497AbTBOBdC>; Fri, 14 Feb 2003 20:33:02 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Feb 2003 17:50:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <20030215010153.GE4333@bjl1.jlokier.co.uk>
Message-ID: <Pine.LNX.4.50.0302141744070.988-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
 <20030214024046.GA18214@bjl1.jlokier.co.uk>
 <Pine.LNX.4.50.0302141603220.988-100000@blue1.dev.mcafeelabs.com>
 <20030215010153.GE4333@bjl1.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > > And when that's done you have some nice bonuses:
> > >
> > > 	- All event types are reported equally fast, and in a single
> > > 	  system call (read()).
> > >
> > > 	- The order in which events occurred is preserved.
> > > 	  (This is lost when you have to scan multiple queues).
> > >
> > > 	- Hierarchies of event sets of any kind are possible.
> > > 	  (epoll has solved the logical problems of this already).
> > >
> > > 	- Less code duplicated.
> > >
> > > 	- Adding new kinds of kernel events becomes _very_ simple.
> >
> > Hmm ... using read() you'll lose the timeout capability, that IMHO is
> > pretty nice.
>
> Very good point.
>
> Timeouts could be events too - probably a good idea as they can then
> be absolute, relative, attached to different system clocks (monotonic
> vs. timeofday).  I think the POSIX timer work is like that.

POSIX timers might work, and events might be captured using the sigfd()
descriptor.



> It seems like a good idea to be able to attach one timeout event in
> the same system call as the event_read call itself - because it is
> _so_ common to vary the expiry time every time.
>
> Then again, it is also extremely common to write this:
>
> 	gettimeofday(...)
> 	// calculate time until next application timer expires.
> 	// Note also race condition here, if we're preempted.
> 	read_events(..., next_app_time - timeofday)
> 	// we need to know the current time.
> 	gettimeofday(...)
>
> So perhaps the current select/poll/epoll timeout method is not
> particularly optimal as it is?

What's bad in epoll_wait() to get events from all pollable descriptors ?




- Davide

