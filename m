Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWEIEEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWEIEEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 00:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWEIEEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 00:04:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:899 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751367AbWEIEEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 00:04:32 -0400
Date: Tue, 9 May 2006 09:30:50 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: Re: [Patch 3/8] cpu delay collection via schedstats
Message-ID: <20060509040050.GE784@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061505.GN13962@in.ibm.com> <20060508142640.675665c7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508142640.675665c7.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 02:26:40PM -0700, Andrew Morton wrote:
> Balbir Singh <balbir@in.ibm.com> wrote:
> >
> > +/*
> > + * Expects runqueue lock to be held for atomicity of update
> > + */
> > +static inline void rq_sched_info_arrive(struct runqueue *rq,
> > +						unsigned long diff)
> > +{
> > +	if (rq) {
> > +		rq->rq_sched_info.run_delay += diff;
> > +		rq->rq_sched_info.pcnt++;
> > +	}
> > +}
> > +
> > +/*
> > + * Expects runqueue lock to be held for atomicity of update
> > + */
> > +static inline void rq_sched_info_depart(struct runqueue *rq,
> > +						unsigned long diff)
> > +{
> > +	if (rq)
> > +		rq->rq_sched_info.cpu_time += diff;
> > +}
> 
> The kernel has many different units of time - jiffies, cpu ticks, ns, us,
> ms, etc.  So the reader of these functions doesn't have a clue what "diff"
> is.
> 
> A good way to remove all doubt in all cases is to include the units in the
> variable's name.  Something like delta_jiffies, perhaps.

Yes, that makes sense and enhances readability. We will fix the naming
convention. "diff" is indeed "delta_jiffies"


	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
