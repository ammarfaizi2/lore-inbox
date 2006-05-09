Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWEIDwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWEIDwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 23:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWEIDwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 23:52:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:48778 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751362AbWEIDwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 23:52:21 -0400
Date: Tue, 9 May 2006 09:18:39 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch 1/8] Setup
Message-ID: <20060509034839.GB784@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061255.GL13962@in.ibm.com> <20060508141713.60c9d33e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508141713.60c9d33e.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 02:17:13PM -0700, Andrew Morton wrote:
> Balbir Singh <balbir@in.ibm.com> wrote:
> >
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
> The interface might not be right here.
> 
> - I think "lhs" and "rhs" would be better names than "start" and "end". 
>   After all, we don't _know_ that the caller is using the two times as a
>   start and an end.  The caller might be taking the difference between two
>   differences, for example.
> 
> - The existing timespec and timeval funtions tend to do return-by-value. 
>   So this would become
> 
> 	static inline struct timespec timespec_sub(struct timespec lhs,
> 							struct timespec rhs)
> 
>   (and given that it's inlined, the added overhead of passing the
>   arguments by value will be zero)

Agreed, I will make these changes.

> 
> - If we don't want to do that then at least let's get the arguments in a
>   sane order:
> 
> 	static inline void timespec_sub(struct timespec *result,
> 				struct timespec lhs, struct timespec rhs)
>

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
