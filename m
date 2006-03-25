Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWCYFLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWCYFLO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 00:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWCYFLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 00:11:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:5504 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750806AbWCYFLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 00:11:14 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <442490CC.8090200@bigpond.net.au>
References: <1143198208.7741.8.camel@homer>
	 <442490CC.8090200@bigpond.net.au>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 06:11:59 +0100
Message-Id: <1143263519.7930.21.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-25 at 11:37 +1100, Peter Williams wrote:
> Mike Galbraith wrote:
> > Greetings,
> > 
> > I've broken down my throttling tree into 6 patches, which I'll send as
> > replies to this start-point.
> > 
> > Patch 1/6
> > 
> > Ignore timewarps caused by SMP timestamp rounding.  Also, don't stamp a
> > task with a computed timestamp, stamp with the already called clock.
> > 
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
> > 
> > --- linux-2.6.16-mm1/kernel/sched.c.org	2006-03-23 15:01:41.000000000 +0100
> > +++ linux-2.6.16-mm1/kernel/sched.c	2006-03-23 15:02:25.000000000 +0100
> > @@ -805,6 +805,16 @@
> >  	unsigned long long __sleep_time = now - p->timestamp;
> >  	unsigned long sleep_time;
> >  
> > +	/*
> > +	 * On SMP systems, a task can go to sleep on one CPU and
> > +	 * wake up on another.  When this happens, the timestamp
> > +	 * is rounded to the nearest tick,
> 
> Is this true?  There's no rounding that I can see.

Instrumenting it looked the same as rounding down, putting now in the
past was the result.

> Of course, that doesn't mean that this chunk of code isn't required just 
> that the comment is misleading.

I'm not attached to the comment.

	-Mike

