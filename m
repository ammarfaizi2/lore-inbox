Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292866AbSCOQYW>; Fri, 15 Mar 2002 11:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292878AbSCOQYM>; Fri, 15 Mar 2002 11:24:12 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:35085 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S292866AbSCOQYB>; Fri, 15 Mar 2002 11:24:01 -0500
Message-ID: <3C922005.50608@loewe-komp.de>
Date: Fri, 15 Mar 2002 17:23:33 +0100
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: de, en
MIME-Version: 1.0
To: Martin Wirth <martin.wirth@dlr.de>
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16lmBj-0003v4-00@wagner.rustcorp.com.au> <3C91B3A1.7030709@dlr.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wirth wrote:

> 
> Rusty Russell wrote:
> 
>>
>> Discussions with Ulrich have reaffirmed my opinion that pthreads are
>> crap.  Hence I'm not all that tempted to warp the (nice, clean,
>> usable) futex code too far to meet pthreads' wierd needs.
>>
> Crap or not, there are tons of software based on pthreads and at least 
> the NGPT team says that Linus
> agreed to implement for necessary kernel-infrastructure for a full, fast 
> pthread implementation.
> 
> Now, if you want to implement mutexes and condition variables with the 
> attribute
> PTHREAD_PROCESS_SHARED then you need some functionality like the futexes.
> Or NGPT will add his own syscalls to handle these things, which is simply
> unnecessary double functionality.
> 


I think the "crap" refers to current missing meatures of linuxthreads
(most notable: PTHREAD_PROCESS_SHARED on cond and mutex, don't know about sema)

BTW, NGPT introduces two new syscalls: gettid and tkill

>>
>> However, it's not too hard to implement condition variables using an
>> unavailable mutex, if we go for "full" semaphores: ie. not just
>> mutexes.  It requires a bit more of a stretch for kernel atomic ops...
>>
> A full semaphore is nice, but not a full replacement for a waitqueue (or 
> a pthread condition variable brr..).
> For the semaphore you always have to assure that the ups and downs are 
> balanced, what is not the case
> for the condition variable.
> 

also remember pthread_cond_broadcast - waking up _all_ waiting threads.
If the woken up threads check their condition and go to sleep again, is
up to them ( read: the standard mandates that _all_ get woken up)

pthread_cond_signal notifies _one_ thread - which one depends on implementation
( I would like to see a priority based decision )

