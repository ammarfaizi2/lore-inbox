Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317277AbSGZHXA>; Fri, 26 Jul 2002 03:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317279AbSGZHXA>; Fri, 26 Jul 2002 03:23:00 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:5820 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317277AbSGZHW7>;
	Fri, 26 Jul 2002 03:22:59 -0400
Date: Fri, 26 Jul 2002 12:56:05 +0530
From: Kiran <geekazoid@phreaker.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Patch 2.5.25: Ensure xtime_lock and timerlist_lock are on difft cachelines
Message-ID: <20020726125605.A2822@phreaker.net>
References: <20020725204512.E3594@in.ibm.com> <20020726063124.5114E45D6@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020726063124.5114E45D6@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Jul 26, 2002 at 04:24:51PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 04:24:51PM +1000, Rusty Russell wrote:
> In message <20020725204512.E3594@in.ibm.com> you write:
> > I've noticed that xtime_lock and timerlist_lock ends up on the same
> > cacheline  all the time (atleaset on x86).  Not a good thing for
> > loads with high xxx_timer and do_gettimeofday counts I guess (networking etc)
> ..
> 
> Better might be to use the x86-64 trick of using sequence counters
> around do_gettimeofday, and avoid the xtime lock altogether.  That
> will improve gettimeofday performance as well.  Or you could try
> changing xtime lock to a brlock.
>

Ok, I'll look at the x86-64 code
 
> FYI: as policy, I don't take optimization patches without
> measurements.  I'm just not that smart.
> 

This patch was not meant to be a definitive fix for do_gettimeofday.
I thought having diffrent locks  on the same cacheline was bad. Atleast, 
I don't think there'd be any negative performance impact due to my patch.  
Pls correct me if I am wrong. 

I want to get some nos too .. and probably will...(still waiting for my 
turn to use the 4way here :-) ).  But, I decided to post this patch 
as a follow up to the 2.5 profiler discussion on lse-tech.  
Anywayz, point taken. Next time I submit an optimization patch to you,
I'll post the measuements too.

Thanks,
Kiran

