Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVFHDbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVFHDbI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 23:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVFHDbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 23:31:08 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:34536 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261977AbVFHDbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 23:31:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.12-rc6-mm1
Date: Wed, 8 Jun 2005 13:33:18 +1000
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@engr.sgi.com>,
       mbligh@mbligh.org, lkml <linux-kernel@vger.kernel.org>
References: <1004450000.1118188239@flay> <20050607170853.3f81007a.akpm@osdl.org> <1118200638.10122.6.camel@npiggin-nld.site>
In-Reply-To: <1118200638.10122.6.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506081333.18511.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2005 01:17 pm, Nick Piggin wrote:
> On Tue, 2005-06-07 at 17:08 -0700, Andrew Morton wrote:
> > Christoph Lameter <clameter@engr.sgi.com> wrote:
> > > On Tue, 7 Jun 2005, Andrew Morton wrote:
> > > > > Diffprofile is wacko (HZ seems to be defaulting to 250 in -mm).
> > > >
> > > > Oh crap, so it does.  That's wrong.
> > >
> > > Email by you and Linus indicated that 250 should be the default.
> >
> > Oh, OK. hrm.
> >
> > Martin, it would be useful if you could determine whether the kernbench
> > slowdown was due to the 1000Hz->250Hz change, thanks.
> >
> > I'm assuming it was the CPU scheduler patches.  There are 36 of them ;)
>
> I'm looking at some issues with the scheduler patches.
>
> To start with, it looks like the smp-nice patches are broken. Even if
> they weren't I think it might be a good idea just to put them on hold
> until we work out what to do with the other sched patches... 

I originally said I'd wait till the sched patches settled down before tackling 
it but it didn't look like that was ever going to happen and broken nice on 
SMP is a real bug biting people now so I figured I should just tackle it 
anyway. I don't mind if we just work on it later though.

> Anyway, Con, this is what it is doing on a 64-way Altix running aim7:
> (compare imbalances, task move rates, wakeup move rates, etc).

Definitely different I agree. As for the performance impact the statistics 
alone don't tell us if they're for good or evil, but we can look at it again 
separately when we tackle smp nice again. It is a real issue for users now, 
though so it would be good if we can have a calmer period in the future to do 
this (smp nice) by itself.

These are the four patches Andrew:
sched-implement-nice-support-across-physical-cpus-on-smp.patch
sched-change_prio_bias_only_if_queued.patch
sched-account_rt_tasks_in_prio_bias.patch
sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch

The other HT patch by me is separate and a bugfix so please leave that in.

Cheers,
Con
