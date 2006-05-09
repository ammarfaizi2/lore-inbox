Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWEID7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWEID7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 23:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWEID7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 23:59:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:2000 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751364AbWEID7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 23:59:50 -0400
Date: Tue, 9 May 2006 09:26:09 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: Re: [Patch 1/8] Setup
Message-ID: <20060509035609.GD784@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061255.GL13962@in.ibm.com> <20060508142322.71e88a54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508142322.71e88a54.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 02:23:22PM -0700, Andrew Morton wrote:
> Balbir Singh <balbir@in.ibm.com> wrote:
> >
> > +static inline void delayacct_end(struct timespec *start, struct timespec *end,
> > +				u64 *total, u32 *count)
> > +{
> > +	struct timespec ts = {0, 0};
> > +	s64 ns;
> > +
> > +	do_posix_clock_monotonic_gettime(end);
> > +	timespec_sub(&ts, start, end);
> > +	ns = timespec_to_ns(&ts);
> > +	if (ns < 0)
> > +		return;
> > +
> > +	spin_lock(&current->delays->lock);
> > +	*total += ns;
> > +	(*count)++;
> > +	spin_unlock(&current->delays->lock);
> > +}
> 
> - too large to be inlined

I will un-inline it.

> 
> - The initialisation of `ts' is unneeded (maybe it generated a bogus
>   warning, but it won't do that if you switch timespec_sub to
>   return-by-value)

gcc-4.1 does generate a bogus warning. I will switch to return by value
and remove the initialization of `ts'


	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
