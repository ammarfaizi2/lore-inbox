Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWAYTAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWAYTAI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWAYTAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:00:08 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:30058 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932115AbWAYTAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:00:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kqoUnOtnXo9RM2BoyqX2+QAtWo5FtvplhHwDaqtX1jiWvmQ61qanz7qhFI4CVSBTvhvnURppA4EwlUKWb58cCU3u6dW6Dq9wAB1o+KVzTGZAexRNEnzk0R9CjYjMkIHR/rtlabCAMH8/NwWtotAQ51dvgUfV3sWRh5Q0Uk/tewo=  ;
Message-ID: <43D7CAAB.9070008@yahoo.com.au>
Date: Thu, 26 Jan 2006 05:59:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com> <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com>
In-Reply-To: <43D7C2F0.5020108@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> Christopher Friesen wrote:
> 
>> Howard Chu wrote:
>>
>>>
>>> Robert Hancock wrote:
>>
>>
>>>  > This says nothing about requiring a reschedule. The "scheduling 
>>> policy"
>>>  > can well decide that the thread which just released the mutex can
>>>  > re-acquire it.
>>>
>>> No, because the thread that just released the mutex is obviously not 
>>> one of  the threads blocked on the mutex. When a mutex is unlocked, 
>>> one of the *waiting* threads at the time of the unlock must acquire 
>>> it, and the scheduling policy can determine that. But the thread the 
>>> released the mutex is not one of the waiting threads, and is not 
>>> eligible for consideration.
>>
>>
>> Is it *required* that the new owner of the mutex is determined at the 
>> time of mutex release?
>>
>> If the kernel doesn't actually determine the new owner of the mutex 
>> until the currently running thread swaps out, it would be possible for 
>> the currently running thread to re-aquire the mutex.
> 
> 
> The SUSv3 text seems pretty clear. It says "WHEN pthread_mutex_unlock() 
> is called, ... the scheduling policy SHALL decide ..." It doesn't say 
> MAY, and it doesn't say "some undefined time after the call." There is 
> nothing optional or implementation-defined here. The only thing that is 
> not explicitly stated is what happens when there are no waiting threads; 
> in that case obviously the running thread can continue running.
> 

But it doesn't say the unlocking thread must yield to the new mutex
owner, only that the scheduling policy shall determine the which
thread aquires the lock.

It doesn't say that decision must be made immediately, either (eg.
it could be made as a by product of which contender is chosen to run
next).

I think the intention of the wording is that for deterministic policies,
it is clear that the waiting threads are actually worken and reevaluated
for scheduling. In the case of SCHED_OTHER, it means basically nothing,
considering the scheduling policy is arbitrary.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
