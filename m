Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268031AbTCFNBI>; Thu, 6 Mar 2003 08:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268032AbTCFNBI>; Thu, 6 Mar 2003 08:01:08 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:52461 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S268031AbTCFNBH>;
	Thu, 6 Mar 2003 08:01:07 -0500
References: <courier.3E646584.000059D3@softhome.net>
            <1046800283.999.59.camel@phantasy.awol.org>
In-Reply-To: <1046800283.999.59.camel@phantasy.awol.org> 
From: prash_t@softhome.net
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inconsistency in changing the state of task ??
Date: Thu, 06 Mar 2003 06:11:30 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [32.97.110.66]
Message-ID: <courier.3E674902.000007D9@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Robert for the reply.
But I notice that __set_current_state() is same as current->state. So, I 
didn't understand the safety factor on using __set_current_state( ). 

Also why should I use __set_current_state() instead of set_current_state() 
when the later is SMP safe. 

Thanks in advance....
Prashanth 

Robert Love writes: 

> On Tue, 2003-03-04 at 03:36, prash_t@softhome.net wrote: 
> 
>>      while browsing through fs/select.c file of 2.4.19, I came across two 
>> DIFFERENT ways of changing the state of the current task in do_select():  
>> 
>>             set_current_state = TASK_INTERRUPTIBLE;
>>      AND    current->state = TASK_RUNNING;  
>> 
>> I am curious to know if the second line of code doesn't cause any problem in 
>> SMP systems.  I also see the same situation in do_poll().
> 
> You normally want to use set_current_state(), which is a nice
> abstraction and safe for SMP. 
> 
> Sometimes it is safe to use __set_current_state(), which does not
> provide a memory barrier. 
> 
> The above open-coded line can be changed to
> __set_current_state(TASK_RUNNING). 
> 
> 	Robert Love 
> 
 
