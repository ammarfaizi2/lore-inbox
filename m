Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275074AbTHLHHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 03:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275079AbTHLHHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 03:07:40 -0400
Received: from dyn-ctb-210-9-241-99.webone.com.au ([210.9.241.99]:42758 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275074AbTHLHHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 03:07:37 -0400
Message-ID: <3F389221.6080202@cyberone.com.au>
Date: Tue, 12 Aug 2003 17:07:13 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: rob@landley.net, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308110248.09399.rob@landley.net> <200308050207.18096.kernel@kolivas.org> <200308052022.01377.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au> <200308110248.09399.rob@landley.net> <5.2.1.1.2.20030812075224.01988de8@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030812075224.01988de8@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Galbraith wrote:

> At 12:51 PM 8/12/2003 +1000, Nick Piggin wrote:
>
>
>> Rob Landley wrote:
>>
>>> On Tuesday 05 August 2003 06:32, Nick Piggin wrote:
>>>
>>>
>>>> But by employing the kernel's services in the shape of a blocking
>>>> syscall, all sleeps are intentional.
>>>
>>>
>>> Wrong.  Some sleeps indicate "I have run out of stuff to do right 
>>> now, I'm going to wait for a timer or another process or something 
>>> to wake me up with new work".
>>>
>>>
>>>
>>> Some sleeps indicate "ideally this would run on an enormous ramdisk 
>>> attached to gigabit ethernet, but hard drives and internet 
>>> connections are just too slow so my true CPU-hogness is hidden by 
>>> the fact I'm running on a PC instead of a mainframe."
>>
>>
>> I don't quite understand what you are getting at, but if you don't 
>> want to
>> sleep you should be able to use a non blocking syscall. But in some 
>> cases
>> I think there are times when you may not be able to use a non 
>> blocking call.
>> And if a process is a CPU hog, its a CPU hog. If its not its not. 
>> Doesn't
>> matter how it would behave on another system.
>
>
> Ah, but there is something there.  Take the X and xmms's gl thread 
> thingy I posted a while back.  (X runs long enough to expire in the 
> presence of a couple of low priority cpu hogs.  gl thread, which is a 
> mondo cpu hog, and normally runs and runs and runs at cpu hog 
> priority, suddenly acquires extreme interactive priority, and X, which 
> is normally sleepy suddenly becomes permanently runnable at cpu hog 
> priority)  The gl thread starts sleeping because X isn't getting 
> enough cpu to be able to get it's work done and go to sleep.  The gl 
> thread isn't voluntarily sleeping, and X isn't voluntarily running.  
> The behavior change is forced upon both.


It does... It is I tell ya!

Look, the gl thread is probably _very_ explicitly asking to sleep. No I
don't know how X works, but I have an idea that select is generally used
as an event notification, right?

Now the gl thread is essentially saying "wait until X finishes the work
I've given it, or I get some other event": ie. "put me to sleep until
this fd becomes readable".

OK maybe your scenario is a big problem. Its not due to any imagined
semantics in the way things are sleeping. Its due to the scheduler.


