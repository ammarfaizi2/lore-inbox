Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUK0Hef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUK0Hef (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 02:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbUK0G7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 01:59:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18110 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261290AbUKZTHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:07:46 -0500
Date: Fri, 26 Nov 2004 09:52:39 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041126003713.GA5352@elte.hu>
Message-Id: <Pine.OSF.4.05.10411260942260.27209-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will look through your arguments when I get time (probably not
before Sunday :-(). It does fit with the meassurements I have so far.

The reason for running 100000 samples is that for high depth and many
tasks the statistics is quite pure at the end. So I can just as well set
it high and do all the daily life stuff.

Esben

On Fri, 26 Nov 2004, Ingo Molnar wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > the additional +1 msec comes from the fact that 1-deep lock/unlock of
> > > lock1 is an allowed operation too - 2 msec would be the limit if the
> > > only sequence is the 2-deep one.
> > > 
> > > so i think the numbers, at least in the 2-deep case, are quite close
> > > to the theoretical boundary.
> > 
> > in the generic case i think the theoretical boundary should be something
> > like:
> > 
> >    sum(i=1...n)(i) == (n+1) * n / 2
> > 
> > 	n=1	limit=1
> > 	n=2	limit=3
> > 	n=3	limit=6
> > 	n=4	limit=10
> > 
> > this is quite close to what you have measured for n=1,2,3, and i think
> > it's becoming exponentially harder to trigger the worst-case with higher
> > N, so the measured results will likely be lower than that.
> 
> also, you might want to try the simpler N-deep-locking-only variant,
> where the maximum latency should be 'n'. This likely needs some changes
> to the blocker.c code though - i.e. set 'max' always to lock_depth.
> 
> 	Ingo
> 

