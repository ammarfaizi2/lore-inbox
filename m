Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTJPIev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTJPIev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:34:51 -0400
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:27811
	"EHLO www.piet.net") by vger.kernel.org with ESMTP id S262790AbTJPIes
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:34:48 -0400
Subject: Re: Circular Convolution scheduler
From: Piet Delaney <piet@www.piet.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Jamie Lokier <jamie@shareable.org>, George Anzinger <george@mvista.com>,
       Clayton Weaver <cgweav@email.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3F8BCFEB.1010306@cyberone.com.au>
References: <20031006161733.24441.qmail@email.com>
	<3F833C06.7000802@mvista.com> <1066120643.25020.121.camel@www.piet.net>
	<20031014094655.GC24812@mail.shareable.org>
	<3F8BCAB3.2070609@cyberone.com.au>
	<20031014101853.GA28905@mail.shareable.org> 
	<3F8BCFEB.1010306@cyberone.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Oct 2003 01:34:05 -0700
Message-Id: <1066293245.1481.150.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-14 at 03:28, Nick Piggin wrote:
> 
> 
> Jamie Lokier wrote:
> 
> >Nick Piggin wrote:
> >
> >>I don't know anything about it, but I don't see what exactly you'd be
> >>trying to predict: the kernel's scheduler _dictates_ scheduling behaviour,
> >>obviously. Also, "best use of system resources" wrt scheduling is a big
> >>ask considering there isn't one ideal scheduling pattern for all but the
> >>most trivial loads, even on a single processor computer (fairness, latency,
> >>priority, thoughput, etc). Its difficult to even say one pattern is better
> >>than another.
> >>
> >
> >Hmm.  Prediction is potentially useful.
> >
> >Instead of an educated ad-hoc pile of heuristics for _dictating_
> >scheduling behaviour, you can systematically analyse just what is it
> >you're trying to achieve, and design a behaviour which achieves that
> >as closely as possible.
> >
> 
> Maybe, although as I said, I just don't know what exactly you would
> predict and what the goals would be.
> 
> And often you'll be left with an ad-hoc pile of heuristics driving
> (or being driven by) your ad-hoc analysis / prediction thingy. Analysing
> the end result becomes very difficult. See drivers/block/as-iosched.c :P
> 
> >
> >This is where good predictors come in: you feed all the possible
> >scheduling decisions at any point in time into the predictor, and use
> >the output to decide which decision gave the most desired result -
> >taking into account the likelihood of future behaviours.  Of course
> >you have to optimise this calculation.
> >
> >This is classical control theory.  In practice it comes up with
> >something like what we have already :)  But the design path is
> >different, and if you're very thoroughly analytical about it, maybe
> >there's a chance of avoiding weird corner behaviours that weren't
> >intended.

I was wondering about an application in user space that monitors
various time series within the system. It would periodically 
perform System Identification by placing the samples
into a matrix and find the cross correlation coefficients by 
minimizing the noise of their combination. This matrix would then
by run in real time, perhaps in the kernel, to crank a Kalman Filter
to predict the least squares best estimate for the values of the
system time series. Here is where ad-hoc algorithms then use these
precicted values to dynamically change the system behavior. I would
expect the scheduler and pageout code could do better if they knew
that the odds are high that in 10 seconds a huge demand is going
to be made on the system memory for example.

Things like effects of lunch and dinner breaks, weekend, holidays, 
stock market activity, number of servers up, could be combined with
the servers time series. System Identification and Kalman filters 
could be run in Long Term, Medium Term, and Sort Term time frames
to predict in these various time frames; similar to how some commodity
traders trade in multiple time frames.

You can get very fancy and even add seasonal and non-linear support
like Dr.Harvey did at the London School of Economics.

-piet

> >
> 
> You still have an ad-hoc starting point because it is not clear what
> scheduling choices are the best.
> 
> >
> >The down side is that crafted heuristics, like the ones we have, tend
> >to run a _lot_ faster.
> >
> 
> That too
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
piet@www.piet.net

