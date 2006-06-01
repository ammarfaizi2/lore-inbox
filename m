Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWFAILh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWFAILh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 04:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWFAILh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 04:11:37 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:48166 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750776AbWFAILg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 04:11:36 -0400
Message-ID: <447EA0C3.3060407@sw.ru>
Date: Thu, 01 Jun 2006 12:09:39 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Kirill Korotaev <dev@openvz.org>, balbir@in.ibm.com,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest>	 <661de9470605262331w2e2258a7r41e2aab10895955f@mail.gmail.com>	 <4477F9DC.8090107@bigpond.net.au> <4478EA9D.4030201@bigpond.net.au>	 <661de9470605280038l40e53357ka3043dabd95de5fc@mail.gmail.com>	 <4479A71C.4060604@bigpond.net.au> <661de9470605280742o70fb6fc9g34ead234d377a1e0@mail.gmail.com> <447A31DE.3060601@bigpond.net.au> <447D975B.3070700@openvz.org> <447E2934.5090907@bigpond.net.au>
In-Reply-To: <447E2934.5090907@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think more needs to be said about the fairness issue.
> 
> 1. If a task is getting its cap or more then it's getting its fair share 
> as specified by that cap.  Yes?
> 
> 2. If a task is getting less CPU usage then its cap then it will be 
> being scheduled just as if it had no cap and will be getting its fair 
> share just as much as any task is.
> 
> So there is no fairness problem.
the problem is that O(1) cpu scheduler doesn't keep the history of 
execution and consumed time which is required for fairness. So I'm 
pretty sure, that fairness will decrease when one of the tasks is being 
capped/uncapped constanntly.

Can you check the behavior of 2 tasks, having different priorites with 
the range of possible cpu limits implied on one of them.

> I tend to test by observing the results of setting caps on running tasks 
> and this doesn't generate something that can be e-mailed.
plot?

> Observations indicate that hard caps are enforced to less than 1% and 
> ditto for soft caps except for small soft caps where the fact (stated in 
> the patches) that enforcement is not fully strict in order to prevent 
> priority inversion or starvation means that the cap is generally 
> exceeded.  I'm currently making modifications (based on suggestions by 
> Con Kolivas) that implement an alternative method for avoiding priority 
> inversion and starvation and allow the enforcement to be more strict.
running tasks are also not very good for such testing. it is too simple 
load. It would be nice if you could test the results with wide range of 
limits on Java Volano benchmark (loopback mode).

Thanks,
Kirill
