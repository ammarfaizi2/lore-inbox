Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWFAXn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWFAXn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWFAXn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:43:58 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:48371 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750985AbWFAXnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:43:46 -0400
Message-ID: <447F7BAD.1060306@bigpond.net.au>
Date: Fri, 02 Jun 2006 09:43:41 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Kirill Korotaev <dev@sw.ru>, Balbir Singh <bsingharora@gmail.com>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest> <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com> <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru> <447DBD44.5040602@in.ibm.com>
In-Reply-To: <447DBD44.5040602@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 1 Jun 2006 23:43:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Kirill Korotaev wrote:
>>>> Using a timer for releasing tasks from their sinbin sounds like a  bit
>>>> of an overhead. Given that there could be 10s of thousands of tasks.
>>>
>>>
>>>
>>> The more runnable tasks there are the less likely it is that any of 
>>> them is exceeding its hard cap due to normal competition for the 
>>> CPUs.  So I think that it's unlikely that there will ever be a very 
>>> large number of tasks in the sinbin at the same time.
>>
>> for containers this can be untrue... :( actually even for 1000 tasks 
>> (I suppose this is the maximum in your case) it can slowdown 
>> significantly as well.
> 
> Do you have any documented requirements for container resource management?
> Is there a minimum list of features and nice to have features for 
> containers
> as far as resource management is concerned?
> 
> 
>>
>>>> Is it possible to use the scheduler_tick() function take a look at all
>>>> deactivated tasks (as efficiently as possible) and activate them when
>>>> its time to activate them or just fold the functionality by defining a
>>>> time quantum after which everyone is worken up. This time quantum
>>>> could be the same as the time over which limits are honoured.
>>
>> agree with it.
> 
> Thinking a bit more along these lines, it would probably break O(1). But 
> I guess a good
> algorithm can amortize the cost.

It's also unlikely to be less overhead than using timers.  In fact, my 
gut feeling is that you'd actually be doing something very similar to 
how timers work only cruder.  I.e. reinventing the wheel.

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
