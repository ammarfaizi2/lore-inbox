Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbUJ1JSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbUJ1JSg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbUJ1JSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:18:36 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:22790 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262847AbUJ1JSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:18:30 -0400
Message-ID: <26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
In-Reply-To: <20041028085656.GA21535@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu>
    <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
    <20041027135309.GA8090@elte.hu>
    <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
    <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu>
    <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
    <20041028063630.GD9781@elte.hu>
    <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
    <20041028085656.GA21535@elte.hu>
Date: Thu, 28 Oct 2004 10:17:31 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 28 Oct 2004 09:18:29.0020 (UTC) FILETIME=[16376DC0:01C4BCCF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Rui Nuno Capela wrote:
>
>> The following table compares the state between my RT-U3 and RT-V0.4.3
>> configurations, regarding only the mentioned options:
>>
>>   option                       RT-U3.0    RT-V0.4.3
>>   ---------------------------- ---------- ---------
>>   CONFIG_DEBUG_SLAB              n          n
>>   CONFIG_DEBUG_PREEMPT           y          y
>>   CONFIG_DEBUG_SPINLOCK_SLEEP    n          -
>>   CONFIG_PREEMPT_TIMING          n          n
>>   CONFIG_RWSEM_DEADLOCK_DETECT   -          y
>>   CONFIG_FRAME_POINTER           y          y
>>   CONFIG_DEBUG_STACKOVERFLOW     y          y
>>   CONFIG_DEBUG_STACK_USAGE       n          n
>>   CONFIG_DEBUG_PAGEALLOC         n          n
>>
>> (dash "-" means that the option is not available in the config).
>>
>> As you can see, it can only be CONFIG_RWSEM_DEADLOCK_DETECT, being new
>> in RT-V0.4.3, that is probably affecting on RT-V0.4.3. I'll try to
>> rebuild and test all over without it, and see if it gets any better.
>
> note that DEBUG_PREEMPT got more expensive in the -V kernels. I'd
> suggest to disable all the 'y' ones in both the -U and -V kernel and
> compare them then.
>
> but especially the userspace overhead seems to be significantly higher
> in the -V kernel so i'm not quite sure it can all be attributed to
> debugging overhead. We'll see.
>
> also, how does the context-switching rate compare between the two tests?
> This test is pretty steady when it's running, so the context-switch
> rates can be directly compared, correct?
>

OK. That was it. After switching off CONFIG_RWSEM_DEADLOCK_DETECT on
RT-V0.4.3, I can say that it's now on par to RT-U3.

Later today, I will conduct some extendeded testing, where I'll able to
compare the jackd performance between vanilla, RT-U3 and RT-V0.4.3, on my
UP laptop. All kernel configurations will be stripped off from all the
debug options.

I will take note of xrun rate, jackd scheduling delay histogram, and cpu
usage. Context switch rate will be also acquainted.

Anything else?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

