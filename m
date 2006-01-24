Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWAXGWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWAXGWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 01:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWAXGWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 01:22:42 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:36093 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030290AbWAXGWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 01:22:41 -0500
Message-ID: <43D5C7AE.6040207@bigpond.net.au>
Date: Tue, 24 Jan 2006 17:22:38 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C5BD8F.3000307@bigpond.net.au> <43C5BE4A.9030105@google.com> <200601121739.17886.kernel@kolivas.org> <43D52E6F.7040808@google.com> <43D5821A.7050001@bigpond.net.au> <43D5A3F0.1000206@bigpond.net.au> <43D5AFF9.10608@google.com>
In-Reply-To: <43D5AFF9.10608@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 24 Jan 2006 06:22:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> 
>> Oops.  I was looking at the graphs for Moe but 
>> <http://test.kernel.org/perf/dbench.elm3b132.png> doesn't appear to be 
>> demonstrating a problem either.  Given the fluctuation in the 
>> 2.6.16-rc1 results (235, 234, 211, 228.5 and 237.5), the results for 
>> 2.6.16-rc1-mm1 (229) and 2.6.16-mm2 (219) aren't significantly different.
> 
> 
> I disagree. Look at the graph. mm results are consistent and stable, and 
> significantly worse than mainline.
> 
>> Peter
>> PS I have a modification for kernbench that calculates and displays 
>> the standard deviations for the various averages if you're 
>> interested.  This would enable you to display 95% (say) confidence 
>> bars on the graphed results which in turn makes it easier to spot 
>> significant differences.
> 
> 
> Thanks, but I have that. What do you think those vertical bars on the 
> graph are for? ;-) They're deviation of 5 runs. I throw away the best 
> and worst first.

Not very good scientific practice :-)

> If it was just random noise, then you'd get the same 
> variance *between* runs inside the -mm train and inside mainline. You 
> don't see that ...

I was still looking at the wrong graph this time the dbench instead of 
kernbench :-( (explains why I didn't see the error bars).  Now I see it.

Looking at the other 6 kernbench graphs, I see that it also occurs for 
elm3b70 but no others (including elm3b6 and elm3b67).  Are there any 
differences between the various elm3b systems that could explain this?

> Use the visuals in the graph .. it's very telling. -mm is *broken*.
> It may well not be the same issue as last time though, I shouldn't
> have jumped to that conclusion.

It's very hard to understand how it could be an issue on a system that 
doesn't have a lot of abnormally niced (i.e. non zero) tasks that are 
fairly active as it's now mathematically equivalent to the original in 
the absence of such tasks.  Do these two systems have many such tasks 
running?

Would it be possible to get a run with the following patches backed out:

+sched-modified-nice-support-for-smp-load-balancing-fix.patch
+sched-modified-nice-support-for-smp-load-balancing-fix-fix.patch

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
