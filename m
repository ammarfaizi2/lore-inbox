Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWEJNGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWEJNGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 09:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWEJNGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 09:06:08 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:26004 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S964951AbWEJNGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 09:06:06 -0400
Message-ID: <4461E53B.7050905@compro.net>
Date: Wed, 10 May 2006 09:06:03 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net> <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> (It is expected on LKML to not touch the CC list, and especially keep the
> one you are replying to)
> 
Ok. I'm on so many it's hard to remember what each want.

> On Tue, 9 May 2006, Mark Hounschell wrote:
> 
>> Daniel Walker wrote:
>>> On Tue, 2006-05-09 at 08:23 -0400, Mark Hounschell wrote:
>>>> Can I assume configuring 'Complete preemption' is the same as
>>>> configuring ('Voluntary preemption' + 'Hardirq' + 'Softirq' + default
>>>> proc settings)?
>>> Not Voluntary preemption, and I'm not sure what default proc settings is
>>> referring too .
>> The proc settings or boot options to enable or disable hardirq or
>> softirq threading that you have avaialable in Voluntary preemption.
>>
>>> Complete preemption is like CONFIG_PREEMPT and softirq
>>> and hardirq threading .. The preemption isn't voluntary, it's forced .
>>>
>> Complete preemption you have no choice of threading hard or soft irqs.
>> They are threaded.
>>
>> So If I config Voluntary preemption + Hardirq and Softirq threading and
>> do not disable hardirq or softirq via proc or boot cmdline, is that the
>> same as configuring Complete preemption?
>>
> 
> No not at all.
> 
> First Voluntary preemption means that when you are executing in the
> kernel, and a higher priority process needs to run, the kernel will _not_
> be preempted!  Voluntary preemption means that there are places in the
> kernel that are marked as preemption points.  So if you are in the kernel
> and you hit a preemption point, a check is made then to see if the
> scheduler should be called. So, really this is not a true preemptive
> kernel.
> 
> Next you have "Preemptible Kernel (Low Latency Desktop)".  This _is_ a
> preemptive kernel.  Which means that, unless preemption is disabled, the
> default is to preempt a process whether or not it's in the kernel if
> either it finished it's run time, or a higher priority process wants to
> run.  There is protective places in the kernel that disallow preemption
> (basically between spinlocks and preempt_enable/disable).
> 
> But even with Preemptible Kernel + Hardirq and Softirq threading, you
> still don't have the same as complete preemption.  This is because the
> full preemption turns the spinlocks into mutexes that are not only
> preemptible, but schedule on contention.  To do this, Hard and Soft irqs
> must be threaded.  This is because they use spinlocks, and to schedule
> in an interrupt, it must be acting as a thread.  So you can't have full
> complete preemption without threading the Hard and Soft irqs, and that's
> why there is no option to not have them threaded.
> 
> Without full preemption, you also lose out on having the PI for the
> spinlock mutexes.
> 
> -- Steve
> 
> 

Thank you. That is exactly what I wanted to know. I ask because when I
run my app in complete preemption mode I have random periods where the
machine stops for many seconds at a time. Only in complete preemption
mode does this happen. In Voluntary and Preempt modes this does not
occure. I'm having a hard time trying to determine if the problem is in
my application.

Mark
