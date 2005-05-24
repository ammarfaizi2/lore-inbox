Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVEXQA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVEXQA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVEXP7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:59:45 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:51601 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262130AbVEXP7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:59:18 -0400
Message-ID: <42934F4F.2060305@yahoo.com.au>
Date: Wed, 25 May 2005 01:59:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Voluntary Kernel Preemption, 2.6.12-rc4-mm2
References: <20050524121541.GA17049@elte.hu> <20050524132105.GA29477@elte.hu> <20050524145636.GA15943@infradead.org> <20050524150950.GA10736@elte.hu> <4293466B.5070200@yahoo.com.au> <20050524153937.GA14792@elte.hu>
In-Reply-To: <20050524153937.GA14792@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>(then you must be disagreeing with CONFIG_PREEMPT too to a certain 
>>>degree i guess?)
>>
>>CONFIG_PREEMPT is different in that it explicitly defines and delimits 
>>preempt critical sections, and allows maximum possible preemption 
>>(whether or not the critical sections themselves are too big is not 
>>really a CONFIG_PREEMPT issue).
> 
> 
> from a theoretical POV, this categorization into 'preempt critical' vs.  
> 'preempt-noncritical' sections is pretty arbitrary too.
> 

Not really, is it? If so then wouldn't that be a bug.

I guess some code might hold a critical section open for longer than
it absolutely needs to, in order to gain efficiency, but basically
your're bound pretty well by critical section size.

> from a practical POV the amount of code that is non-preemptible is not 
> controllable under CONFIG_PREEMPT. So the end-result is that 
> CONFIG_PREEMPT is just as nondeterministic.
> 

It is determined by the amount of code that is not preemptible, rather
than the maximum amount of time between sucessive calls to cond_resched.
IMO the former is cleaner.

> polling need_resched after reaching a zero preempt_count() is ugly 
> (doing cond_resched() in might_sleep() is ugly too) - pretty much the 
> only difference is overhead.
> 
> 
>>Jamming in cond_resched in as many places as possible seems to work 
>>quite well pragmatically, [...]
> 
> 
> yes, and that's what matters. It's just a single #ifdef in kernel.h, and 
> at least one major distribution would make use of it because it 
> significantly improves soft-RT latencies at a minimal cost. We can 

Yeah definitely. And in practice distos sometimes have to just go with
what works at the time. So it might be a fine solution for them indeed.

> remove it if it's not being used, but right now the only choice that 
> distributions have is no preemption or full-blown CONFIG_PREEMPT. Ask 
> the kernel maintainers at SuSE why they havent enabled CONFIG_PREEMPT in 
> their kernels.
> 

I guess it is a number of reasons. Probably the main one had
traditionally been the chance of bugs. I guess the next big one is
return on overhead (ie. the scheduling latency soon runs into the
problem of long critical sections), although thanks to you and
others, I understand that is becoming less and less of an issue over
time too.

If a new SUSE kernel branch was started from 2.6.12 with VP turned on
rather than PREEMPT then I would probably argue against it a little
bit ;)

-- 
SUSE Labs, Novell Inc.

