Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbULULKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbULULKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 06:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbULULKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 06:10:00 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:26497 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261490AbULULJz
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 21 Dec 2004 06:09:55 -0500
Message-ID: <41C8047E.1030403@cyberone.com.au>
Date: Tue, 21 Dec 2004 22:09:50 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Loic Domaigne <loic-dev@gmx.net>
CC: nptl@bullopensource.org, Linux-Kernel@Vger.Kernel.ORG, mingo@elte.hu
Subject: Re: OSDL Bug 3770
References: <9785.1103562168@www38.gmx.net>
In-Reply-To: <9785.1103562168@www38.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Loic Domaigne wrote:

>Hello Nick,
>
>Thanks for your reply! 
> 
>L = Loic 
>N = Nick 
>
>N> lkml: We're discussing the fact that on SMP machines, our realtime 
>N> scheduling policies are per-CPU only. This caused a problem where a 
>N> high priority task on one CPU caused all lower priority tasks on that 
>N> CPU to be starved, while tasks on another CPU with the same low 
>N> priority were able to run.
>
>That summary should readily motivate you to make a patch ;-) 
>
>But thing are a bit worse actually. It is easily to build an example 
>where a lower priority thread is executing while a higer priority thread
>is waiting. For instance, something like: 
>
>CPU0:
>Thread with prio 30 gets the CPU.
>Thread with prio 25 is waiting.
>
>CPU1:
>Thread with prio 20 gets the CPU.
>Thread with prio 15 is waiting.
>
>

Yep.


[snip]

>L> The reason is extremely simple: the application *CANNOT* necessarily 
>L> known that it gets stuck behind a higher-priority thread (though it 
>L> could had run on another CPU if the scheduler had decided otherwise). 
>L> That's *NOT* doable to program in a deterministic fashion in such 
>L> "realtime"-environement
>N>
>N>
>N> You could use CPU binding. I'd argue that this may be nearly a
>N> requirement for any realtime system of significant complexity on 
>N> an SMP system.
>
>Agree. Real-world system will likely want to have a control on which 
>CPU the threads runs on SMP machine. 
>
>Does Linux tolerate hard CPU binding? By hard CPU binding, I mean 
>that the application tells the scheduler "I want to run there", 
>and the scheduler schedules the thread(s) "there" regardless if it 
>makes sense or not ( The decision is left to the application). 
>
>With such hard CPU binding, it seems to me that our "unfortunate 
>behavior" isn't problematic anymore. Because the application can gain 
>control again over the scheduler (so to speak). 
>
>On the other hand, if the scheduler might ignore the CPU binding 
>(thus, not hard binding, but rather CPU affinity), then I am afraid 
>that the issue might remain problematic.  
>
>

Yes, it does support hard CPU binding - sched_setaffinity

[snip interesting dialogue]

Thanks for your detailed comments, they were interesting.

I hope that the fact we have hard CPU binding is a sufficient
solution to the problem.

Thanks
Nick

