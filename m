Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUJFAsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUJFAsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 20:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUJFAsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 20:48:14 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:16862 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266538AbUJFAsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 20:48:09 -0400
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
Message-ID: <cone.1097023654.564251.26724.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: =?ISO-8859-1?B?Q2hlbiw=?= Kenneth W <kenneth.w.chen@intel.com>
Cc: =?ISO-8859-1?B?J0luZ28gTW9sbmFyJw==?= <mingo@redhat.com>,
       linux-kernel@vger.kernel.org,
       =?ISO-8859-1?B?J0FuZHJldyBNb3J0b24n?= <akpm@osdl.org>,
       =?ISO-8859-1?B?J05pY2sgUGlnZ2luJw==?= <nickpiggin@yahoo.com.au>
Subject: Re: Default cache_hot_time value back to 10ms
Date: Wed, 06 Oct 2004 10:47:34 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W writes:

> Chen, Kenneth W wrote on Tuesday, October 05, 2004 10:31 AM
>> We have experimented with similar thing, via bumping up sd->cache_hot_time to
>> a very large number, like 1 sec.  What we measured was a equally low throughput.
>> But that was because of not enough load balancing.
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
> 
> This value was default to 10ms before domain scheduler, why does domain
> scheduler need to change it to 2.5ms? And on what bases does that decision
> take place?  We are proposing change that number back to 10ms.

Should it not be based on the cache flush time? We measure that and set the 
cache_decay_ticks and can base it on that. What is the cache_decay_ticks 
value reported in the dmesg of your hardware?

Cheers,
Con

