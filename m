Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTHLJS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 05:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTHLJSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 05:18:20 -0400
Received: from mail.gmx.de ([213.165.64.20]:19670 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262123AbTHLJSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 05:18:17 -0400
Message-Id: <5.2.1.1.2.20030812105738.019ca6e8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 12 Aug 2003 11:22:25 +0200
To: Nick Piggin <piggin@cyberone.com.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O13int for interactivity
Cc: rob@landley.net, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <3F389221.6080202@cyberone.com.au>
References: <5.2.1.1.2.20030812075224.01988de8@pop.gmx.net>
 <200308110248.09399.rob@landley.net>
 <200308050207.18096.kernel@kolivas.org>
 <200308052022.01377.kernel@kolivas.org>
 <3F2F87DA.7040103@cyberone.com.au>
 <200308110248.09399.rob@landley.net>
 <5.2.1.1.2.20030812075224.01988de8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:07 PM 8/12/2003 +1000, Nick Piggin wrote:


>Mike Galbraith wrote:
>
>>At 12:51 PM 8/12/2003 +1000, Nick Piggin wrote:
>>
>>
>>>Rob Landley wrote:
>>>
>>>>On Tuesday 05 August 2003 06:32, Nick Piggin wrote:
>>>>
>>>>
>>>>>But by employing the kernel's services in the shape of a blocking
>>>>>syscall, all sleeps are intentional.
>>>>
>>>>
>>>>Wrong.  Some sleeps indicate "I have run out of stuff to do right now, 
>>>>I'm going to wait for a timer or another process or something to wake 
>>>>me up with new work".
>>>>
>>>>
>>>>
>>>>Some sleeps indicate "ideally this would run on an enormous ramdisk 
>>>>attached to gigabit ethernet, but hard drives and internet connections 
>>>>are just too slow so my true CPU-hogness is hidden by the fact I'm 
>>>>running on a PC instead of a mainframe."
>>>
>>>
>>>I don't quite understand what you are getting at, but if you don't want to
>>>sleep you should be able to use a non blocking syscall. But in some cases
>>>I think there are times when you may not be able to use a non blocking call.
>>>And if a process is a CPU hog, its a CPU hog. If its not its not. Doesn't
>>>matter how it would behave on another system.
>>
>>
>>Ah, but there is something there.  Take the X and xmms's gl thread thingy 
>>I posted a while back.  (X runs long enough to expire in the presence of 
>>a couple of low priority cpu hogs.  gl thread, which is a mondo cpu hog, 
>>and normally runs and runs and runs at cpu hog priority, suddenly 
>>acquires extreme interactive priority, and X, which is normally sleepy 
>>suddenly becomes permanently runnable at cpu hog priority)  The gl thread 
>>starts sleeping because X isn't getting enough cpu to be able to get it's 
>>work done and go to sleep.  The gl thread isn't voluntarily sleeping, and 
>>X isn't voluntarily running.
>>The behavior change is forced upon both.
>
>
>It does... It is I tell ya!
>
>Look, the gl thread is probably _very_ explicitly asking to sleep. No I
>don't know how X works, but I have an idea that select is generally used
>as an event notification, right?

Oh, sure, it blocks because it asks for it... but not because it _wants_ to 
:)  It wants to create work for X fast enough to make a nice stutter free 
bit of eye-candy.

>Now the gl thread is essentially saying "wait until X finishes the work
>I've given it, or I get some other event": ie. "put me to sleep until
>this fd becomes readable".

Yes.  Voluntary or involuntary is just a matter of point of view.

>OK maybe your scenario is a big problem. Its not due to any imagined
>semantics in the way things are sleeping. Its due to the scheduler.

It's due to the scheduler to a point... only in that it doesn't recognize 
the problem and correct it (that might be pretty hard to do).  If my 
hardware were fast enough that X could get the work done in the allotted 
time, the problem wouldn't arise in the first place.  I bet it's fairly 
hard to reproduce on a really fast box.  It happens easily on my box 
because the combination of X and the gl thread need most of what my 
hardware has to offer.

         -Mike 

