Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVDGH6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVDGH6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVDGH6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:58:52 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:62369 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261997AbVDGH6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:58:44 -0400
Message-ID: <4254E830.5040703@yahoo.com.au>
Date: Thu, 07 Apr 2005 17:58:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 4/5] sched: RCU sched domains
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au> <20050406061838.GB5973@elte.hu> <4253975E.20804@yahoo.com.au> <20050407071101.GA26607@elte.hu>
In-Reply-To: <20050407071101.GA26607@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>At a minimum i think we need the fix+comment below.
>>
>>Well if we say "this is actually RCU", then yes. And we should 
>>probably change the preempt_{dis|en}ables in other places to 
>>rcu_read_lock.
>>
>>OTOH, if we say we just want all running threads to process through a 
>>preemption stage, then this would just be a preempt_disable/enable 
>>pair.
>>
>>In practice that makes no difference yet, but it looks like you and 
>>Paul are working to distinguish these two cases in the RCU code, to 
>>accomodate your low latency RCU stuff?
> 
> 
> it doesnt impact PREEMPT_RCU/PREEMPT_RT directly, because the scheduler 
> itself always needs to be non-preemptible.
> 
> those few places where we currently do preempt_disable(), which should 
> thus be rcu_read_lock(), are never in codepaths that can take alot of 
> time.
> 
> but yes, in principle you are right, but in this particular (and 
> special) case it's not a big issue. We should document the RCU read-lock 
> dependencies cleanly and make all rcu-read-lock cases truly 
> rcu_read_lock(), but it's not a pressing issue even considering possible 
> future features like PREEMPT_RT.
> 
> the only danger in this area is to PREEMPT_RT: it is a bug on PREEMPT_RT 
> if kernel code has an implicit 'spinlock means preempt-off and thus 
> RCU-read-lock' assumption. Most of the time these get discovered via 
> PREEMPT_DEBUG. (preempt_disable() disables preemption on PREEMPT_RT too, 
> so that is not a problem either.)
> 

OK thanks for the good explanation. So I'll keep it as is for now,
and whatever needs cleaning up later can be worked out as it comes
up.

-- 
SUSE Labs, Novell Inc.

