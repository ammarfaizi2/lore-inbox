Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWFCFEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWFCFEt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 01:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWFCFEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 01:04:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:52431 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751407AbWFCFEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 01:04:48 -0400
Message-ID: <44811743.1050601@in.ibm.com>
Date: Sat, 03 Jun 2006 10:29:47 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
Cc: Andrew Morton <akpm@osdl.org>, dev@openvz.org, Srivatsa <vatsa@in.ibm.com>,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	<20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	<661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>	<44781167.6060700@bigpond.net.au>	<447D95DE.1080903@sw.ru>	<447DBD44.5040602@in.ibm.com>	<447E9A1D.9040109@openvz.org>	<447EA694.8060407@in.ibm.com>	<1149187413.13336.24.camel@linuxchandra>	<447F77A4.3000102@bigpond.net.au>	<1149213759.10377.7.camel@linuxchandra>	<447FAEB0.3060103@aurema.com>	<447FF7BB.9000104@in.ibm.com> <44803D5D.20303@bigpond.net.au>	<44808A52.9040100@in.ibm.com> <4480CE89.8080000@aurema.com>
In-Reply-To: <4480CE89.8080000@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
>>>>
>>>>The problem is that with per-task caps, if I have a resource group A
>>>>and I want to limit it to 10%, I need to limit each task in resource
>>>>group A to 10% (which makes resource groups not so useful). Is my
>>>>understanding correct?
>>>
>>>
>>>Well the general idea is correct but your maths is wrong.  You'd have 
>>>to give each of them a cap somewhere between 10% and 10% divided by 
>>>the number of tasks in group A.  Exactly where in that range would 
>>>vary depending on the CPU demand of each task and would need to be 
>>>adjusted dynamically (unless they were very boring tasks whose demands 
>>>were constant over time).
>>>
>>
>>
>>Hmm.. I thought my math was reasonable (but there is always so much to 
>>learn)
>> From your formula, if I have 1 task in group A, I need to provide it with
>>a cap of b/w 10 to 11%. For two tasks, I need to give them b/w 10 to 10.5%.
>>If I have a hundred, it needs to be b/w 10% and 10.01%
> 
> 
> Now your arithmetic is failing you.  According to my formula:
> 
> 1. With one task in group A you give it 10% which is what you get when 
> you divide 10% by one.
> 
> 2. With two tasks in group A you give them each somewhere between 5% 
> (which is 10% divided by 2) and 10%.  If they are equally busy you give 
> them each 5% and if they are not equally busy you give them you give 
> them larger caps.

Yes, I understand. I misinterpreted what you said earlier. I see you
clearly meant the range [cap_of_the_group/number_of_tasks, cap_of_the_group]

> 
> Another, probably a better but more expensive, formula is to divide the 
> 10% between them in proportion to their demand.  Being careful not to 
> give any of them a zero cap, of course.  I.e. in the two task 10% case 
> they each get 5% if they are equally busy but if one is twice as busy as 
> the other it gets a 6.6% cap and the other gets 3.3% (approximately).
> 

Yes, that makes a lot of sense

> Peter

Thanks for clarifying.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
