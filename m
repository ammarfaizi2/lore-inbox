Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268523AbTBODwd>; Fri, 14 Feb 2003 22:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268526AbTBODwd>; Fri, 14 Feb 2003 22:52:33 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:42635 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S268523AbTBODwc>; Fri, 14 Feb 2003 22:52:32 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Feb 2003 20:09:34 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <20030215020838.GH4333@bjl1.jlokier.co.uk>
Message-ID: <Pine.LNX.4.50.0302142005550.988-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
 <20030214024046.GA18214@bjl1.jlokier.co.uk>
 <Pine.LNX.4.50.0302141603220.988-100000@blue1.dev.mcafeelabs.com>
 <20030215010153.GE4333@bjl1.jlokier.co.uk>
 <Pine.LNX.4.50.0302141744070.988-100000@blue1.dev.mcafeelabs.com>
 <20030215020838.GH4333@bjl1.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > > Then again, it is also extremely common to write this:
> > >
> > > 	gettimeofday(...)
> > > 	// calculate time until next application timer expires.
> > > 	// Note also race condition here, if we're preempted.
> > > 	read_events(..., next_app_time - timeofday)
> > > 	// we need to know the current time.
> > > 	gettimeofday(...)
> > >
> > > So perhaps the current select/poll/epoll timeout method is not
> > > particularly optimal as it is?
> >
> > What's bad in epoll_wait() to get events from all pollable descriptors ?
>
> Nothing wrong with that.  It's the "relative to now" timeout argument
> that is a bit racy, and the fact that you need a gettimeofday() system
> call just before - every time - _purely_ to calculate the time until
> the next application timer event.
>
> If you must have a separate system call every time round your event
> loop, it may as well set up a timerfd and let that be another pollable
> descriptor.
>
> In which case, read() is just fine for getting events :)

Many ( many ) times, when you're going to wait for events, you want to
specify a maximum wait time ( reletive time ) and not an absolute time.
This is how ppl think about "timeouts". Different beast is the absolute
timer, that you can easily achieve with POSIX timers ( TIMER_ABSTIME ) and
a sigfd() dropped inside an event retrieval interface.




- Davide

