Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUJMAbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUJMAbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 20:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267953AbUJMAbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 20:31:31 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:762 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S268108AbUJMAbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 20:31:08 -0400
Message-ID: <416C773A.3060109@mvista.com>
Date: Tue, 12 Oct 2004 17:30:50 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven Dietrich <sdietrich@mvista.com>
CC: tglx@linutronix.de, dwalker@mvista.com, Andrew Morton <akpm@osdl.org>,
       amakarov@ru.mvista.com, Ingo Molnar <mingo@elte.hu>,
       ext-rt-dev@mvista.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
References: <EOEGJOIIAIGENMKBPIAEIEJEDKAA.sdietrich@mvista.com>
In-Reply-To: <EOEGJOIIAIGENMKBPIAEIEJEDKAA.sdietrich@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Dietrich wrote:
>>>I think patch size is an issue, but I also think that , eventually, we
>>>should change all spin_lock calls that actually lock a mutex to be more
>>>distinct so it's obvious what is going on. Sven and I both agree that
>>>this should be addressed. Is this a non-issue for you? What does the
>>>community want? I don't find your code or ours acceptable in it's
>>>current form , due to this issue.
>>>
>>>With the addition of PREEMPT_REALTIME it looks like you more than
>>>doubled the size of voluntary preempt. I really feel that it should
>>>remain as two distinct patches. They are dependent , but the scope of
>>>the changes are too vast to lump it all together. 
>>>
>>
>>
>>If there is the tendency to touch the concurrency controls in general
>>all over the kernel, then I would suggest a script driven overhaul of
>>all concurrency controls like spin_locks, mutexes and semaphores to
>>general macros like 
>>
>>enter_critical_section(TYPE, &var, &flags, whatever);
>>leave_critical_section(TYPE, &var, flags, whatever);

There is nothing here that can not be done with a macro.  Don't really need a 
script.  The optimizer would drop out unused code...

-g
>>
>>where TYPE might be SPIN_LOCK, SPIN_LOCK_IRQ, MUTEX, PMUTEX or whatever
>>we have and come up with in the future.
>>
>>This could be done in a first step and then it is clearly identifiable
>>and it gives us more flexibility to wrap different implementations and
>>lets us change particular points in a more clear way.
>>
>>I would be willing to provide some scripted conversion aid, if there is
>>enough interest to that. I started with some test files and the results
>>are quite encouraging.
>>
> 
> 
> 
> 
> Ideally we would eventually provide some level of tunability, i.e.
> if you want the spinlocks all the way around it should be possible 
> to have that, or one could enable degrees of enhancements, 
> expanding on the existing sequence starting with PREEMPT, IRQ_THREADS, 
> BKL, MUTEX, etc. In addition to that, once the minim set of spinlocks 
> necessary for RT is established, additional layers, corresponding to
> the lock nesting order, could be established, making the "mutex-depth"
> somewhat configurable based on the performance requirements.
> 
> The entire effort would have the side effect of making the locking and 
> critical sections more distinct, and reveal soft spots in concurrency
> code, as well as to raise awareness of the code density inside 
> critical sections.
> 
> The concept of tunable foreground / background responsiveness, 
> based on preemptability of low priority processes comes to mind.
> A lot of folks would probably not mind making  UI responsiveness 
> a little crisper, others will want the throughput.
> 
> I realize this is an early stage to be looking at it so high end,
> but I think in general this type of script would not be a bad addition
> to the patch kit(s).
> 
> 
> Sven
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

