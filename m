Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWEINYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWEINYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 09:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWEINYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 09:24:20 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:21446 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932506AbWEINYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 09:24:20 -0400
Date: Tue, 9 May 2006 18:50:36 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [Lse-tech] Re: [Patch 1/8] Setup
Message-ID: <20060509132036.GA7722@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061255.GL13962@in.ibm.com> <1147175206.7392.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147175206.7392.39.camel@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 11:46:46AM +0000, Thomas Gleixner wrote:
> On Tue, 2006-05-02 at 11:42 +0530, Balbir Singh wrote:
> >  /*
> > + * sub = end - start, in normalized form
> > + */
> > +static inline void timespec_sub(struct timespec *start, struct timespec *end,
> > +				struct timespec *sub)
> > +{
> > +	set_normalized_timespec(sub, end->tv_sec - start->tv_sec,
> > +				end->tv_nsec - start->tv_nsec);
> > +}
> 
> Please use the existing ktime_t functions for that purpose. The ktime_t
> format has nanosecond resolution and is optimized for 32/64bit machines.
> 
> > +static inline void delayacct_start(struct timespec *start)
> > +{
> > +	do_posix_clock_monotonic_gettime(start);
> > +}
> 
> Please get rid of this wrapper and use the ktime based functions for
> that.
> 
> > +/*
> > + * Finish delay accounting for a statistic using
> > + * its timestamps (@start, @end), accumalator (@total) and @count
> > + */
> > +
> > +static inline void delayacct_end(struct timespec *start, struct timespec *end,
> > +				u64 *total, u32 *count)
> 
> Please use ktime_t for total.
> 			
> > +{
> > +	struct timespec ts = {0, 0};
> > +	s64 ns;
> > +
> > +	do_posix_clock_monotonic_gettime(end);
> > +	timespec_sub(&ts, start, end);
> > +	ns = timespec_to_ns(&ts);
> > +	if (ns < 0)
> > +		return;
> 
> monotonic time is monotonic increasing. So delta is always >= 0 !
> 
> 	tglx
> 
> 
> 
>

I am going through the ktime interface and it seems interesting.
I will look into it and see if we can migrate the interface
to use ktime
 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
