Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWFBBfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWFBBfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWFBBfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:35:30 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:35273 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750903AbWFBBf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:35:29 -0400
Message-ID: <447F95DF.8030106@bigpond.net.au>
Date: Fri, 02 Jun 2006 11:35:27 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Kirill Korotaev <dev@sw.ru>, Kirill Korotaev <dev@openvz.org>,
       balbir@in.ibm.com, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>, Kingsley Cheung <kingsley@aurema.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest>	 <661de9470605262331w2e2258a7r41e2aab10895955f@mail.gmail.com>	 <4477F9DC.8090107@bigpond.net.au> <4478EA9D.4030201@bigpond.net.au>	 <661de9470605280038l40e53357ka3043dabd95de5fc@mail.gmail.com>	 <4479A71C.4060604@bigpond.net.au> <661de9470605280742o70fb6fc9g34ead234d377a1e0@mail.gmail.com> <447A31DE.3060601@bigpond.net.au> <447D975B.3070700@openvz.org> <447E2934.5090907@bigpond.net.au> <447EA0C3.3060407@sw.ru> <447F7A75.4000101@bigpond.net.au>
In-Reply-To: <447F7A75.4000101@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 2 Jun 2006 01:35:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Kirill Korotaev wrote:
>>> I think more needs to be said about the fairness issue.
>>>
>>> 1. If a task is getting its cap or more then it's getting its fair 
>>> share as specified by that cap.  Yes?
>>>
>>> 2. If a task is getting less CPU usage then its cap then it will be 
>>> being scheduled just as if it had no cap and will be getting its fair 
>>> share just as much as any task is.
>>>
>>> So there is no fairness problem.
>> the problem is that O(1) cpu scheduler doesn't keep the history of 
>> execution and consumed time which is required for fairness. So I'm 
>> pretty sure, that fairness will decrease when one of the tasks is 
>> being capped/uncapped constanntly.
> 
> Why would you want to keep capping and uncapping a task?
> 
>>
>> Can you check the behavior of 2 tasks, having different priorites with 
>> the range of possible cpu limits implied on one of them.
> 
> It works OK.
> 
>>
>>> I tend to test by observing the results of setting caps on running 
>>> tasks and this doesn't generate something that can be e-mailed.
>> plot?
> 
> Plot what?  I'll see if I can come up with some tests that have 
> plottable results.  Unless you already have some that I could use?
> 
>>
>>> Observations indicate that hard caps are enforced to less than 1% and 
>>> ditto for soft caps except for small soft caps where the fact (stated 
>>> in the patches) that enforcement is not fully strict in order to 
>>> prevent priority inversion or starvation means that the cap is 
>>> generally exceeded.  I'm currently making modifications (based on 
>>> suggestions by Con Kolivas) that implement an alternative method for 
>>> avoiding priority inversion and starvation and allow the enforcement 
>>> to be more strict.
>> running tasks are also not very good for such testing. it is too 
>> simple load. It would be nice if you could test the results with wide 
>> range of limits on Java Volano benchmark (loopback mode).
> 
> I'm interested in three things:
> 
> 1. that the capping works pretty well,
> 2. that if the capping code is present in the kernel but no tasks are 
> actually capped then the extra over head is minimal, and
> 3. that if capping is used then the overhead involved is minimal.
> 
> I do informal checks for 1), use kernbench to test 2) (know noticeable 

I'm having a bad day word selection wise that "know" should be "no".

> overhead has been observed) and haven't been able to think of a way to 
> test 3) yet as applying caps small enough that they'd actually be 
> enforced to something like kernbench would clearly cause it to take 
> longer :-(.
> 
> Feel free to run any other tests that you think are necessary.
> 
> Peter


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
