Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWFBTDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWFBTDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWFBTDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:03:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:14568 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750841AbWFBTDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:03:47 -0400
Message-ID: <44808A52.9040100@in.ibm.com>
Date: Sat, 03 Jun 2006 00:28:26 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, dev@openvz.org, Srivatsa <vatsa@in.ibm.com>,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Sam Vilain <sam@vilain.net>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <peterw@aurema.com>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	<20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	<661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>	<44781167.6060700@bigpond.net.au>	<447D95DE.1080903@sw.ru>	<447DBD44.5040602@in.ibm.com>	<447E9A1D.9040109@openvz.org>	<447EA694.8060407@in.ibm.com>	<1149187413.13336.24.camel@linuxchandra>	<447F77A4.3000102@bigpond.net.au>	<1149213759.10377.7.camel@linuxchandra>	<447FAEB0.3060103@aurema.com> <447FF7BB.9000104@in.ibm.com> <44803D5D.20303@bigpond.net.au>
In-Reply-To: <44803D5D.20303@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Balbir Singh wrote:
> 
>>Peter Williams wrote:
>><snip>
>>
>>>>>But you don't need something as complex as CKRM either.  This capping
>>>>
>>>>All CKRM^W Resource Groups does is to group unrelated/related tasks to a
>>>>group and apply resource limits.
>>>>
>>>>
>>>>>functionality coupled with (the lamented) PAGG patches (should have 
>>>>>been called TAGG for "task aggregation" instead of PAGG for "process 
>>>>>aggregation") would allow you to implement a kernel module that 
>>>>>could apply caps to arbitrary groups of tasks.
>>>>
>>>>I do not follow how PAGG + this cap feature can be used to put cap of
>>>>related/unrelated tasks. Can you provide little more explanation,
>>>>please.
>>>
>>>
>>>I would have thought it was fairly obvious.  PAGG supplies the task 
>>>aggregation mechanism, these patches provide per task caps and all 
>>>that's needed is the code that marries the two.
>>>
>>
>>The problem is that with per-task caps, if I have a resource group A
>>and I want to limit it to 10%, I need to limit each task in resource
>>group A to 10% (which makes resource groups not so useful). Is my
>>understanding correct?
> 
> 
> Well the general idea is correct but your maths is wrong.  You'd have to 
> give each of them a cap somewhere between 10% and 10% divided by the 
> number of tasks in group A.  Exactly where in that range would vary 
> depending on the CPU demand of each task and would need to be adjusted 
> dynamically (unless they were very boring tasks whose demands were 
> constant over time).
>


Hmm.. I thought my math was reasonable (but there is always so much to learn)
>From your formula, if I have 1 task in group A, I need to provide it with
a cap of b/w 10 to 11%. For two tasks, I need to give them b/w 10 to 10.5%.
If I have a hundred, it needs to be b/w 10% and 10.01%
 
> 
>>Is there a way to distribute the group limit
>>across tasks in the resource group?
> 
> 
> Not as part of this patch but it could be done from outside the 
> scheduler either in the kernel or in user space.
> 
> 
>>>>Also, i do not think it can provide guarantees to that group of tasks.
>>>>can it ?
>>>
>>>
>>>It could do that by manipulating nice which is already available in 
>>>the kernel.
>>>
>>>I.e. these patches plus improved statistics (which are coming, I hope) 
>>>together with the existing policy controls provide all that is 
>>>necessary to do comprehensive CPU resource control.  If there is an 
>>>efficient way to get the statistics out to user space (also coming, I 
>>>hope) this control could be exercised from user space.
>>
>>Could you please provide me with a link to the new improved statistics.
> 
> 
> No.  Read LKML and you'll know as much as I do.
> 
> 
>>What do the new statistics contain - any heads up on them?
> 
> 
> There're several contenders (including some from IBM) that periodically 
> post patches to LKML.  That's where I'm aware of them from.  As I say, 
> I'm hoping that they get together and come up with something generally 
> useful (as opposed to just meeting each contenders needs). I may be 
> being overly optimistic but you never know.

Yes, thats the whole point of the discussion and everybody is free to
participate.


> 
> Peter


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
