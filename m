Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275060AbTHLGMd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 02:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275062AbTHLGMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 02:12:33 -0400
Received: from pop.gmx.net ([213.165.64.20]:33180 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S275060AbTHLGMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 02:12:31 -0400
Message-Id: <5.2.1.1.2.20030812075224.01988de8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 12 Aug 2003 08:16:38 +0200
To: Nick Piggin <piggin@cyberone.com.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O13int for interactivity
Cc: rob@landley.net, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <3F385633.3090807@cyberone.com.au>
References: <200308110248.09399.rob@landley.net>
 <200308050207.18096.kernel@kolivas.org>
 <200308052022.01377.kernel@kolivas.org>
 <3F2F87DA.7040103@cyberone.com.au>
 <200308110248.09399.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:51 PM 8/12/2003 +1000, Nick Piggin wrote:


>Rob Landley wrote:
>
>>On Tuesday 05 August 2003 06:32, Nick Piggin wrote:
>>
>>
>>>But by employing the kernel's services in the shape of a blocking
>>>syscall, all sleeps are intentional.
>>
>>Wrong.  Some sleeps indicate "I have run out of stuff to do right now, 
>>I'm going to wait for a timer or another process or something to wake me 
>>up with new work".
>>
>>
>>
>>Some sleeps indicate "ideally this would run on an enormous ramdisk 
>>attached to gigabit ethernet, but hard drives and internet connections 
>>are just too slow so my true CPU-hogness is hidden by the fact I'm 
>>running on a PC instead of a mainframe."
>
>I don't quite understand what you are getting at, but if you don't want to
>sleep you should be able to use a non blocking syscall. But in some cases
>I think there are times when you may not be able to use a non blocking call.
>And if a process is a CPU hog, its a CPU hog. If its not its not. Doesn't
>matter how it would behave on another system.

Ah, but there is something there.  Take the X and xmms's gl thread thingy I 
posted a while back.  (X runs long enough to expire in the presence of a 
couple of low priority cpu hogs.  gl thread, which is a mondo cpu hog, and 
normally runs and runs and runs at cpu hog priority, suddenly acquires 
extreme interactive priority, and X, which is normally sleepy suddenly 
becomes permanently runnable at cpu hog priority)  The gl thread starts 
sleeping because X isn't getting enough cpu to be able to get it's work 
done and go to sleep.  The gl thread isn't voluntarily sleeping, and X 
isn't voluntarily running.  The behavior change is forced upon both.

         -Mike 

