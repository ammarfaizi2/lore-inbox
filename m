Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVL1NQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVL1NQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 08:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVL1NQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 08:16:22 -0500
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:65122 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964808AbVL1NQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 08:16:21 -0500
Message-ID: <43B29023.8080306@bigpond.net.au>
Date: Thu, 29 Dec 2005 00:16:19 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] CPU scheduler: Simplified interactive bonus mechanism
References: <43B22FBA.5040008@bigpond.net.au> <20051228080029.GA5641@elte.hu> <20051228083615.GA12180@elte.hu>
In-Reply-To: <20051228083615.GA12180@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 28 Dec 2005 13:16:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>* Peter Williams <pwil3058@bigpond.net.au> wrote:
>>
>>
>>>This patch implements a prototype version of a simplified interactive 
>>>bonus mechanism.  The mechanism does not attempt to identify 
>>>interactive tasks and give them a bonus (like the current mechanism 
>>>does) but instead attacks the problem that the bonuses are supposed to 
>>>fix, unacceptable interactive latency, directly.
>>
>>i think we could give this one a workout in -mm, to see the actual 
>>effects. Would you mind to merge this to -mm's scheduler queue, to right 
>>after sched-add-sched_batch-policy.patch?
> 
> 
> i have done this for latest -mm, see the patch below (i also merged your 
> patch to the SCHED_BATCH patch's effects), but the resulting kernel has 
> really bad interactivity: e.g. simply starting 4 CPU hogs on a 2-CPU 
> system slows down shell commands like 'ls' noticeably. So NACK for the 
> time being.

OK.  I didn't really think this was ready for the big time yet without 
some refinement which is why I RFC'd it rather than posting it as a patch.

How good the interactive responsiveness really was one of my concerns as 
it's hard to evaluate.  Just because it seemed to work well on my system 
doesn't mean that it works well everywhere.  I did test it with 16 hard 
spinners on my SMT workstation but I was mainly looking at things like X 
responsiveness and the rythmbox music player and not shell commands.

I think that from a theoretical point of view shell commands won't do 
well with this scheduler (as it stands) as they don't do many 
interactive sleeps and hence are unlikely to accrue any bonuses.  So 
that means back to the drawing board.  It also means that interactive 
latency isn't the only important latency.  Perhaps all latencies need to 
be considered with interactive latencies being given more weight.  (This 
would be consistent with the current scheduler which only completely 
discounts sleep that is marked TASK_NONINTERACTIVE and just heavily 
discounts uninterruptible sleep.)

Thanks for the feed back.  You've given me something to think about and 
I think these issues can be addressed without very little extra 
complexity.  If not I'll just shelve the idea.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
