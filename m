Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268915AbUJFHqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268915AbUJFHqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 03:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269091AbUJFHqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 03:46:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36030 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268915AbUJFHqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 03:46:39 -0400
Date: Wed, 6 Oct 2004 09:48:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Ingo Molnar'" <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Subject: Re: Default cache_hot_time value back to 10ms
Message-ID: <20041006074815.GC1137@elte.hu>
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410060042.i960gn631637@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> Chen, Kenneth W wrote on Tuesday, October 05, 2004 10:31 AM
> > We have experimented with similar thing, via bumping up sd->cache_hot_time to
> > a very large number, like 1 sec.  What we measured was a equally low throughput.
> > But that was because of not enough load balancing.
> 
> Since we are talking about load balancing, we decided to measure various
> value for cache_hot_time variable to see how it affects app performance. We
> first establish baseline number with vanilla base kernel (default at 2.5ms),
> then sweep that variable up to 1000ms.  All of the experiments are done with
> Ingo's patch posted earlier.  Here are the result (test environment is 4-way
> SMP machine, 32 GB memory, 500 disks running industry standard db transaction
> processing workload):
> 
> cache_hot_time  | workload throughput
> --------------------------------------
>          2.5ms  - 100.0   (0% idle)
>          5ms    - 106.0   (0% idle)
>          10ms   - 112.5   (1% idle)
>          15ms   - 111.6   (3% idle)
>          25ms   - 111.1   (5% idle)
>          250ms  - 105.6   (7% idle)
>          1000ms - 105.4   (7% idle)
> 
> Clearly the default value for SMP has the worst application throughput (12%
> below peak performance).  When set too low, kernel is too aggressive on load
> balancing and we are still seeing cache thrashing despite the perf fix.
> However, If set too high, kernel gets too conservative and not doing enough
> load balance.

could you please try the test in 1 msec increments around 10 msec? It
would be very nice to find a good formula and the 5 msec steps are too
coarse. I think it would be nice to test 7,9,11,13 msecs first, and then
the remaining 1 msec slots around the new maximum. (assuming the
workload measurement is stable.)

> This value was default to 10ms before domain scheduler, why does domain
> scheduler need to change it to 2.5ms? And on what bases does that decision
> take place?  We are proposing change that number back to 10ms.

agreed. What value does cache_decay_ticks have on your box?

> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
