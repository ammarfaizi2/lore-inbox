Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290843AbSB0A4v>; Tue, 26 Feb 2002 19:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSB0A4n>; Tue, 26 Feb 2002 19:56:43 -0500
Received: from nrg.org ([216.101.165.106]:16412 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S291020AbSB0A4a>;
	Tue, 26 Feb 2002 19:56:30 -0500
Date: Tue, 26 Feb 2002 16:56:24 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: schedule()
In-Reply-To: <3C7BEA6F.97CB8AD4@mandrakesoft.com>
Message-ID: <Pine.LNX.4.40.0202261638230.20308-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Jeff Garzik wrote:
> "Richard B. Johnson" wrote:
> >
> > I just read on this list that:
> >
> >     while(something)
> >     {
> >       current->policy |= SCHED_YIELD;
> >       schedule();
> >     }
> >
> > Will no longer be allowed in a kernel module! If this is true, how
> > do I loop, waiting for a bit in a port, without wasting CPU time?
>
> Call yield() or better yet, schedule_timeout()

Yes, please use schedule_timeout() if at all possible, or make sure that
the loop will only ever execute for a few 100us at most.

One thing to bear in mind is that using yield() will waste CPU time if
the code is ever called by a real-time process (unless it is a SCHED_RR
process with other runnable SCHED_RR processes at the same priority),
because there will be no other process that the scheduler is allowed to
run, so the RT process will just be chosen to run again, with no delay.

We really need high resolution timers, so that schedule_timeout() can be
used for delays of less than one jiffy.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

