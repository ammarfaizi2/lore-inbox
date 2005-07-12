Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVGLR6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVGLR6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVGLR4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:56:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3297 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261892AbVGLR4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:56:24 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: john stultz <johnstul@us.ibm.com>
To: George Anzinger <george@mvista.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Lee Revell <rlrevell@joe-job.com>,
       Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org,
       Andrew Morton <akpm@osdl.org>, cw@f00f.org,
       lkml <linux-kernel@vger.kernel.org>, torvalds@osdl.org,
       christoph@lameter.org
In-Reply-To: <42D310ED.2000407@mvista.com>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <20050709203920.394e970d.diegocg@gmail.com>
	 <1120934466.6488.77.camel@mindpipe> <176640000.1121107087@flay>
	 <42D310ED.2000407@mvista.com>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 10:56:15 -0700
Message-Id: <1121190975.7673.83.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 17:38 -0700, George Anzinger wrote:
> Martin J. Bligh wrote:
> >>>Lots of people have switched from 2.4 to 2.6 (100 Hz to 1000 Hz) with no impact in
> >>>stability, AFAIK. (I only remember some weird warning about HZ with debian woody's
> >>>ps).
> >>>
> >>
> >>Yes, that's called "progress" so no one complained.  Going back is
> >>called a "regression".  People don't like those as much.
> > 
> > 
> > That's a very subjective viewpoint. Realize that this is a balancing
> > act between latency and overhead ... and you're firmly only looking
> > at one side of the argument, instead of taking a compromise in the
> > middle ...
> > 
> > If I start arguing for 100HZ on the grounds that it's much more efficient,
> > will that make 250/300 look much better to you? ;-)
> 
> I would like to interject an addition data point, and I will NOT be subjective. 
>   The nature of the PIT is that it can _hit_ some frequencies better than 
> others.  We have had complaints about repeating timers not keeping good time. 
> These are not jitter issues, but drift issues.  The standard says we may not 
> return early from a timer so any timer will either be on time or late.  The 
> amount of lateness depends very much on the HZ value.  Here is what the values 
> are for the standard CLOCK_TICK_RATE:
> 
> HZ  	TICK RATE	jiffie(ns)	second(ns)	 error (ppbillion)
>   100	 1193180	10000000	1000000000	       0
>   200	 1193180	 5000098	1000019600	   19600
>   250	 1193180	 4000250	1000062500	   62500
>   500	 1193180	 1999703	1001851203	 1851203
> 1000	 1193180	  999848	1000847848	  847848
> 
> The jiffie values here are exactly what the kernel uses and are based on the 
> best one can do with the PIT hardware.
> 
> I am not suggesting any given default HZ, but rather an argumentation of the 
> help text that goes with it.  For those who want timers to repeat at one second 
> (or multiples there of) this is useful info.
> 
> For you enjoyment I have attached the program used to print this.  It allows you 
> to try additional values...

If I recall, 1001 was a decent choice and is relatively close the the
expected frequency. Also I think the error is positive instead of
negative, so it avoids the "jiffies are shorter then I expected!"
issues.

>From your program's output:
HZ      TICK RATE       jiffie(ns)      second(ns)       error (ppbillion)
1001     1193180          999013        1000012013         12013

thanks
-john


