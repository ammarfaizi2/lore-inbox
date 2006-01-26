Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWAZIvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWAZIvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 03:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWAZIvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 03:51:19 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:8886 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751310AbWAZIvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 03:51:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qDBi0M93haXFkHbvA3MfRNC10MkIjgJbsB2gkxvZG0iz78gG1SNIl5hp3V8q2Hq7l4gi+aSJgI43wapdnS3vwE8/Ni2vOXUa4N/Ynb1TO2xlimumhedl9yWJV1HX49+ZD3xpIb+Biyg38Q94POScOXt1Kab83L0VkyCfb5x5B18=  ;
Message-ID: <43D88D7B.1030204@yahoo.com.au>
Date: Thu, 26 Jan 2006 19:51:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com> <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com> <43D7CAAB.9070008@yahoo.com.au> <43D7D234.6060005@symas.com>
In-Reply-To: <43D7D234.6060005@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> Nick Piggin wrote:
> 
>> Howard Chu wrote:
>>
>>> The SUSv3 text seems pretty clear. It says "WHEN 
>>> pthread_mutex_unlock() is called, ... the scheduling policy SHALL 
>>> decide ..." It doesn't say MAY, and it doesn't say "some undefined 
>>> time after the call." There is nothing optional or 
>>> implementation-defined here. The only thing that is not explicitly 
>>> stated is what happens when there are no waiting threads; in that 
>>> case obviously the running thread can continue running.
>>>
>>
>> But it doesn't say the unlocking thread must yield to the new mutex
>> owner, only that the scheduling policy shall determine the which
>> thread aquires the lock.
> 
> 
> True, the unlocking thread doesn't have to yield to the new mutex owner 
> as a direct consequence of the unlock. But logically, if the unlocking 
> thread subsequently calls mutex_lock, it must block, because some other 
> thread has already been assigned ownership of the mutex.
> 
>> It doesn't say that decision must be made immediately, either (eg.
>> it could be made as a by product of which contender is chosen to run
>> next).
> 
> 
> A straightforward reading of the language here says the decision happens 
> "when pthread_mutex_unlock() is called" and not at any later time. There 
> is nothing here to support your interpretation.
> 

OK, so what happens if my scheduling policy decides _right then_, that
the next _running_ thread that was being blocked on or tries to aquire
the mutex, is the next owner?

This is the logical way for a *scheduling* policy to determine which
thread gets the mutex. I don't know any other way that the scheduling
policy could determine the next thread to get the mutex.

>>
>> I think the intention of the wording is that for deterministic policies,
>> it is clear that the waiting threads are actually worken and reevaluated
>> for scheduling. In the case of SCHED_OTHER, it means basically nothing,
>> considering the scheduling policy is arbitrary.
>>
> Clearly the point is that one of the waiting threads is waken and gets 
> the mutex, and it doesn't matter which thread is chosen. I.e., whatever 
> thread the scheduling policy chooses. The fact that SCHED_OTHER can 
> choose arbitrarily is immaterial, it still can only choose one of the 
> waiting threads.
> 

I don't know that it exactly says one of the waiting threads must get the
mutex.

> The fact that SCHED_OTHER's scheduling behavior is undefined is not free 
> license to implement whatever you want. Scheduling policies are an 
> optional feature; the basic thread behavior must still be consistent 
> even on systems that don't implement scheduling policies.
> 

It just so happens that normal tasks in Linux run in SCHED_OTHER. It
is irrelevant whether it might be an optional feature or not.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
