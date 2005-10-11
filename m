Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVJKVAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVJKVAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 17:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVJKVAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 17:00:19 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:8965 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750752AbVJKVAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 17:00:18 -0400
Message-ID: <434C2811.2090802@tmr.com>
Date: Tue, 11 Oct 2005 17:01:05 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Seigh <jseigh_02@xemaps.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i386 spinlock fairness: bizarre test results
References: <4WjCM-7Aq-7@gated-at.bofh.it> <434B404F.9020508@shaw.ca> <digb50$4bd$1@sea.gmane.org>
In-Reply-To: <digb50$4bd$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Seigh wrote:
> Robert Hancock wrote:
> 
>> Chuck Ebbert wrote:
>>
>>>   After seeing Kirill's message about spinlocks I decided to do my own
>>> testing with the userspace program below; the results were very strange.
>>>
>>>   When using the 'mov' instruction to do the unlock I was able to 
>>> reproduce
>>> hogging of the spinlock by a single CPU even on Pentium II under some
>>> conditions, while using 'xchg' always allowed the other CPU to get the
>>> lock:
>>
>>
>>
>> This might not necessarily be a win in all situations. If two CPUs A 
>> and  B are trying to get into a spinlock-protected critical section to 
>> do 5 operations, it may well be more efficient for them to do 
>> AAAAABBBBB as opposed to ABABABABAB, as the second situation may 
>> result in cache lines bouncing between the two CPUs each time, etc.
>>
>> I don't know that making spinlocks "fairer" is really very worthwhile. 
>> If some spinlocks are so heavily contented that fairness becomes an 
>> issue, it would be better to find a way to reduce that contention.
>>
> 
> You're right that it wouldn't be an issue on a system with relatively few
> cpu's since that amount of contention would cripple the system.  Though
> with 100's of cpu's you could get contention hotspots with some spin locks
> being concurrently accessed by some subset of the cpu's for periods of 
> time.
> 
> The real issue is scalability or how gracefully does a system degrade
> when it starts to hit its contention limits.  It's not a good thing when
> a system appears to run fine and then catastrophically hangs when it
> bumps across its critical limit.  It's better when a system exhibit's
> some sort of linear degradation.  The former exhibits bistable behavior
> which requires a drastic, probably impossible, reduction in work load
> to regain normal performance.  Reboots are the normal course of correction.
> The linearly degrading systems just require moderation of the workload
> to move back into acceptable performance.
> 
> Anyway, if you want to build a scalable system, it makes sense to build it
> out of scalable components.  Right?
> 
Joe, I totally agree. That type of non-linear performance is sometimes 
called a "jackpot condition," and you see it in various algorithms. The 
comment that depending on fairness is poor design is correct, but 
because loads may be vastly higher than the original program design, 
it's sometimes not obvious that there could be high contention.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
