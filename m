Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268503AbTBOB4m>; Fri, 14 Feb 2003 20:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268507AbTBOB4l>; Fri, 14 Feb 2003 20:56:41 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:11392 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S268503AbTBOB4l>; Fri, 14 Feb 2003 20:56:41 -0500
Date: Sat, 15 Feb 2003 02:08:38 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030215020838.GH4333@bjl1.jlokier.co.uk>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com> <20030214024046.GA18214@bjl1.jlokier.co.uk> <Pine.LNX.4.50.0302141603220.988-100000@blue1.dev.mcafeelabs.com> <20030215010153.GE4333@bjl1.jlokier.co.uk> <Pine.LNX.4.50.0302141744070.988-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302141744070.988-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > Then again, it is also extremely common to write this:
> >
> > 	gettimeofday(...)
> > 	// calculate time until next application timer expires.
> > 	// Note also race condition here, if we're preempted.
> > 	read_events(..., next_app_time - timeofday)
> > 	// we need to know the current time.
> > 	gettimeofday(...)
> >
> > So perhaps the current select/poll/epoll timeout method is not
> > particularly optimal as it is?
> 
> What's bad in epoll_wait() to get events from all pollable descriptors ?

Nothing wrong with that.  It's the "relative to now" timeout argument
that is a bit racy, and the fact that you need a gettimeofday() system
call just before - every time - _purely_ to calculate the time until
the next application timer event.

If you must have a separate system call every time round your event
loop, it may as well set up a timerfd and let that be another pollable
descriptor.

In which case, read() is just fine for getting events :)

-- Jamie

