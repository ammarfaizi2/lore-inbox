Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283755AbRLEQPn>; Wed, 5 Dec 2001 11:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283759AbRLEQPd>; Wed, 5 Dec 2001 11:15:33 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:27308 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S283755AbRLEQPZ>;
	Wed, 5 Dec 2001 11:15:25 -0500
Date: Wed, 5 Dec 2001 21:09:38 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011205210938.D5254@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20011205163153.E16315@in.ibm.com> <Pine.LNX.4.33L.0112051109340.4079-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0112051109340.4079-100000@imladris.surriel.com>; from riel@conectiva.com.br on Wed, Dec 05, 2001 at 11:13:19AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Wed, Dec 05, 2001 at 11:13:19AM -0200, Rik van Riel wrote:
> On Wed, 5 Dec 2001, Ravikiran G Thirumalai wrote:
> 
> > Here is a RFC for Scalable Statistics Counters.
> 
> > Initial results of micro benchmarking on 3 cpus showed a 65% reduction
> > in cpu cycles used to update the proposed statistics counter, over
> > global non atomic counter.
> 
> I'd use it, if there were a really easy interface to the thing.
> 
> This would include both an interface to automagically use it from
> the routines where we increase variables to some automagic reporting
> in /proc ;)

Which interfaces would you consider complicated ? 

I guess currently one would do -

struct yyy {
	int blah1;
	void *blah2;
	int stats;
};

void some_init_routine(struct another_struct *op)
{
	op->yyy = kmalloc(sizeof(struct yyy), GFP_KERNEL);	
	if (op->yyy == NULL)
		return;
	memset(op->yyy, 0, sizeof(struct yyy));
}

void do_something(struct another_struct *op)
{
	op->yyy.stats++;
}

int get_stats(struct another_struct *op)
{
	return op->yyy.stats;
}

statctr just provides interfaces to do all these three operations.
Did I miss something here ?

What would be your ideal way of using a statistics counter ?


> 
> (it'd be so cool if we could just start using a statistic variable
> through some macro and it'd be automatically declared and visible
> in /proc ;))
> 

Given a parent /proc directory, it would be possible for statctr to
automatically create corresponding proc entries and automatically
reflect the combined per-cpu counter value.
However if you want to club multiple statctrs together in
a single /proc entry, then it gets complicated and it might
just be easier for the driver to maintain its proc entries.


Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
