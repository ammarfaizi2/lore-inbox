Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTJPJFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 05:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTJPJFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 05:05:44 -0400
Received: from dyn-ctb-210-9-241-190.webone.com.au ([210.9.241.190]:64523 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262762AbTJPJFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 05:05:30 -0400
Message-ID: <3F8E5EF1.8000807@cyberone.com.au>
Date: Thu, 16 Oct 2003 19:03:45 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Piet Delaney <piet@www.piet.net>
CC: Jamie Lokier <jamie@shareable.org>, George Anzinger <george@mvista.com>,
       Clayton Weaver <cgweav@email.com>, linux-kernel@vger.kernel.org
Subject: Re: Circular Convolution scheduler
References: <20031006161733.24441.qmail@email.com>	<3F833C06.7000802@mvista.com> <1066120643.25020.121.camel@www.piet.net>	<20031014094655.GC24812@mail.shareable.org>	<3F8BCAB3.2070609@cyberone.com.au>	<20031014101853.GA28905@mail.shareable.org> 	<3F8BCFEB.1010306@cyberone.com.au> <1066293245.1481.150.camel@www.piet.net>
In-Reply-To: <1066293245.1481.150.camel@www.piet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Piet Delaney wrote:

>On Tue, 2003-10-14 at 03:28, Nick Piggin wrote:
>
>>
>>Jamie Lokier wrote:
>>
>>
>>>Nick Piggin wrote:
>>>
>>>
>>>>I don't know anything about it, but I don't see what exactly you'd be
>>>>trying to predict: the kernel's scheduler _dictates_ scheduling behaviour,
>>>>obviously. Also, "best use of system resources" wrt scheduling is a big
>>>>ask considering there isn't one ideal scheduling pattern for all but the
>>>>most trivial loads, even on a single processor computer (fairness, latency,
>>>>priority, thoughput, etc). Its difficult to even say one pattern is better
>>>>than another.
>>>>
>>>>
>>>Hmm.  Prediction is potentially useful.
>>>
>>>Instead of an educated ad-hoc pile of heuristics for _dictating_
>>>scheduling behaviour, you can systematically analyse just what is it
>>>you're trying to achieve, and design a behaviour which achieves that
>>>as closely as possible.
>>>
>>>
>>Maybe, although as I said, I just don't know what exactly you would
>>predict and what the goals would be.
>>
>>And often you'll be left with an ad-hoc pile of heuristics driving
>>(or being driven by) your ad-hoc analysis / prediction thingy. Analysing
>>the end result becomes very difficult. See drivers/block/as-iosched.c :P
>>
>>
>>>This is where good predictors come in: you feed all the possible
>>>scheduling decisions at any point in time into the predictor, and use
>>>the output to decide which decision gave the most desired result -
>>>taking into account the likelihood of future behaviours.  Of course
>>>you have to optimise this calculation.
>>>
>>>This is classical control theory.  In practice it comes up with
>>>something like what we have already :)  But the design path is
>>>different, and if you're very thoroughly analytical about it, maybe
>>>there's a chance of avoiding weird corner behaviours that weren't
>>>intended.
>>>
>
>I was wondering about an application in user space that monitors
>various time series within the system. It would periodically 
>perform System Identification by placing the samples
>into a matrix and find the cross correlation coefficients by 
>minimizing the noise of their combination. This matrix would then
>by run in real time, perhaps in the kernel, to crank a Kalman Filter
>to predict the least squares best estimate for the values of the
>system time series. Here is where ad-hoc algorithms then use these
>precicted values to dynamically change the system behavior. I would
>expect the scheduler and pageout code could do better if they knew
>that the odds are high that in 10 seconds a huge demand is going
>to be made on the system memory for example.
>

I don't expect the scheduler would benefit at all from this sort of future
knowledge or knowledge of each task's patterns.

>
>Things like effects of lunch and dinner breaks, weekend, holidays, 
>stock market activity, number of servers up, could be combined with
>the servers time series. System Identification and Kalman filters 
>could be run in Long Term, Medium Term, and Sort Term time frames
>to predict in these various time frames; similar to how some commodity
>traders trade in multiple time frames.
>
>You can get very fancy and even add seasonal and non-linear support
>like Dr.Harvey did at the London School of Economics.
>

I fail to see how this would be simpler or more provably "right" than a
manually designed system.

I would rather not continue in this discussion as I'm not at all
qualified to give further input, and I'm just speculating. I'd love to
see a working implementation though.


