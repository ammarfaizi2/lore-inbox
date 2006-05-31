Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965261AbWEaXjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbWEaXjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbWEaXjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:39:35 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:44659 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965261AbWEaXje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:39:34 -0400
Message-ID: <447E2934.5090907@bigpond.net.au>
Date: Thu, 01 Jun 2006 09:39:32 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
CC: balbir@in.ibm.com, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest>	 <661de9470605262331w2e2258a7r41e2aab10895955f@mail.gmail.com>	 <4477F9DC.8090107@bigpond.net.au> <4478EA9D.4030201@bigpond.net.au>	 <661de9470605280038l40e53357ka3043dabd95de5fc@mail.gmail.com>	 <4479A71C.4060604@bigpond.net.au> <661de9470605280742o70fb6fc9g34ead234d377a1e0@mail.gmail.com> <447A31DE.3060601@bigpond.net.au> <447D975B.3070700@openvz.org>
In-Reply-To: <447D975B.3070700@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 31 May 2006 23:39:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>>> I understand that, I was talking about fairness between capped tasks
>>> and what might be considered fair or intutive between capped tasks and
>>> regular tasks. Of course, the last point is debatable ;)
>>
>>
>> Well, the primary fairness mechanism in the scheduler is the time 
>> slice allocation and the capping code doesn't fiddle with those so 
>> there should be a reasonable degree of fairness (taking into account 
>> "nice") between capped tasks.  To improve that would require 
>> allocating several new priority slots for use by tasks exceeding their 
>> caps and fiddling with those.  I don't think that it's worth the bother.

I think more needs to be said about the fairness issue.

1. If a task is getting its cap or more then it's getting its fair share 
as specified by that cap.  Yes?

2. If a task is getting less CPU usage then its cap then it will be 
being scheduled just as if it had no cap and will be getting its fair 
share just as much as any task is.

So there is no fairness problem.

> I suppose it should be handled still. a subjective feeling :)
> 
> BTW, do you have any test results for your patch?
> It would be interesting to see how precise these limitations are and 
> whether or not we should bother for the above...

I tend to test by observing the results of setting caps on running tasks 
and this doesn't generate something that can be e-mailed.

Observations indicate that hard caps are enforced to less than 1% and 
ditto for soft caps except for small soft caps where the fact (stated in 
the patches) that enforcement is not fully strict in order to prevent 
priority inversion or starvation means that the cap is generally 
exceeded.  I'm currently making modifications (based on suggestions by 
Con Kolivas) that implement an alternative method for avoiding priority 
inversion and starvation and allow the enforcement to be more strict.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
