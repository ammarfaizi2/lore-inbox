Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbSBGGLv>; Thu, 7 Feb 2002 01:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbSBGGLl>; Thu, 7 Feb 2002 01:11:41 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:55031 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S279798AbSBGGL0>; Thu, 7 Feb 2002 01:11:26 -0500
Date: Thu, 7 Feb 2002 11:44:13 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Ingo's smptimers patch experiment
Message-ID: <20020207114413.A10060@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020206211925.A8720@in.ibm.com> <200202061727.g16HRkG12893@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202061727.g16HRkG12893@ns.caldera.de>; from hch@ns.caldera.de on Wed, Feb 06, 2002 at 06:27:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 06:27:46PM +0100, Christoph Hellwig wrote:
> In article <20020206211925.A8720@in.ibm.com> you wrote:
> > Hi Ingo,
> >
> > I ported your smptimers patch to 2.5.3 and experimented with 
> > it a little bit. Basically I am curious about why we
> > we need to call run_all_timers() (which runs timers for all
> > CPUs) through the timer bh if locking fails in run_local_timers(). 
> 
> Some driver do ugly things with TIMER_BH, and Ingo's 2.4 patched
> tried to stayed source compatible with 2.4 drivers.
> 
> For 2.5 I'd really like to see TIMER_BH (all BH's in fact) to gone.

I can see that net driver relies on being able to disable all timers 
by doing in net/core/dev.c -

        tasklet_disable(bh_task_vec+TIMER_BH);

But this doesn't completely disable timers in Ingo's patch 
since timers can also be fired through run_local_timers() if 
locking succeeds, no TIMER_BH in that case.

There are only a few places where TIMER_BH is used. I will see if
I can make another smptimers patch that gets rid of them.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
