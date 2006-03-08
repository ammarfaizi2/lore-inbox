Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWCHIxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWCHIxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 03:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWCHIxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 03:53:07 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:48047 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932525AbWCHIxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 03:53:06 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [ck] Re: [PATCH] mm: yield during swap prefetching
Date: Wed, 8 Mar 2006 19:52:42 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
References: <200603081013.44678.kernel@kolivas.org> <20060307152636.1324a5b5.akpm@osdl.org> <20060308084824.GA4193@rhlx01.fht-esslingen.de>
In-Reply-To: <20060308084824.GA4193@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081952.42853.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 19:48, Andreas Mohr wrote:
> Hi,
>
> On Tue, Mar 07, 2006 at 03:26:36PM -0800, Andrew Morton wrote:
> > Con Kolivas <kernel@kolivas.org> wrote:
> > > Swap prefetching doesn't use very much cpu but spends a lot of time
> > > waiting on disk in uninterruptible sleep. This means it won't get
> > > preempted often even at a low nice level since it is seen as sleeping
> > > most of the time. We want to minimise its cpu impact so yield where
> > > possible.
> >
> > yield() really sucks if there are a lot of runnable tasks.  And the
> > amount of CPU which that thread uses isn't likely to matter anyway.
> >
> > I think it'd be better to just not do this.  Perhaps alter the thread's
> > static priority instead?  Does the scheduler have a knob which can be
> > used to disable a tasks's dynamic priority boost heuristic?
>
> This problem occurs due to giving a priority boost to processes that are
> sleeping a lot (e.g. in this case, I/O, from disk), right?
> Forgive me my possibly less insightful comments, but maybe instead of
> adding crude specific hacks (namely, yield()) to each specific problematic
> process as it comes along (it just happens to be the swap prefetch thread
> this time) there is a *general way* to give processes with lots of disk I/O
> sleeping much smaller amounts of boost in order to get them preempted more
> often in favour of an actually much more critical process (game)?
>
> >From the discussion here it seems this problem is caused by a *general*
>
> miscalculation of processes sleeping on disk I/O a lot.
>
> Thus IMHO this problem should be solved in a general way if at all
> possible.

No. We already do special things for tasks waiting on uninterruptible sleep. 
This is more about what is exaggerated on a dual array expiring scheduler 
design that mainline has.

Cheers,
Con
