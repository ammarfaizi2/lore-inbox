Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWAFAka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWAFAka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWAFAka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:40:30 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:13429 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932338AbWAFAk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:40:29 -0500
Message-ID: <43BDBC7A.6050105@bigpond.net.au>
Date: Fri, 06 Jan 2006 11:40:26 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Mike Galbraith <efault@gmx.de>, Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client   on interactive
 response
References: <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net> <200601061033.10001.kernel@kolivas.org> <43BDB37D.1030601@bigpond.net.au> <200601061108.26561.kernel@kolivas.org>
In-Reply-To: <200601061108.26561.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 6 Jan 2006 00:40:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Fri, 6 Jan 2006 11:02 am, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>>
>>>On Fri, 6 Jan 2006 10:13 am, Peter Williams wrote:
>>>
>>>>If the plugsched patches were included in -mm we could get wider testing
>>>>of alternative scheduling mechanisms.  But I think it will take a lot of
>>>>testing of the new schedulers to allay fears that they may introduce new
>>>>problems of their own.
>>>
>>>When I first generated plugsched and posted it to lkml for inclusion in
>>>-mm it was blocked as having no chance of being included by both Ingo and
>>>Linus and I doubt they've changed their position since then. As you're
>>>well aware this is why I gave up working on it and let you maintain it
>>>since then. Obviously I thought it was a useful feature or I wouldn't
>>>have worked on it.
>>
>>I've put a lot of effort into reducing code duplication and reducing the
>>size of the interface and making it completely orthogonal to load
>>balancing so I'm hopeful (perhaps mistakenly) that this makes it more
>>acceptable (at least in -mm).
> 
> 
> The objection was to dilution of developer effort towards one cpu scheduler to 
> rule them all.

I think that I've partially addressed that objection by narrowing the 
focus of the alternative schedulers so that the dilution of effort is 
reduced.  The dichotomy between the dual array schedulers (ingosched and 
nicksched) and the single array schedulers (staircase and the SPA 
schedulers) is the main stumbling block to narrowing the focus further.

> Linus' objection was against specialisation - he preferred one 
> cpu scheduler that could do everything rather than unique cpu schedulers for 
> NUMA, SMP, UP, embedded...

kernbench results show that the penalties for an all purpose scheduler 
aren't very big so it's probably not a bad philosophy.  In spite of this 
I think specialization is worth pursuing if it can be achieved with very 
small configurable differences to the mechanism.  If the configuration 
change can be done at boot time or on a running system then it's even 
better e.g. your "compute" switch in staircase.

> Each approach has its own arguments and there 
> isn't much point bringing them up again. We shall use Linux as the 
> "steamroller to crack a nut" no matter what that nut is.
> 

Even if plugsched has no hope of getting into the mainline kernel, I see 
it as a useful tool for the practical evaluation of the various 
approaches.  If it could go into -mm for a while this evaluation could 
be more widespread.

In it's current state it should not interfere with other scheduling 
related development such as the load balancing changes, cpusets etc.

> 
>>My testing shows that there's no observable difference in performance
>>between a stock kernel and plugsched with ingosched selected at the
>>total system level (although micro benchmarking may show slight
>>increases in individual operations).
> 
> 
> I could find no difference either, but IA64 which does not cope with 
> indirection well would probably suffer a demonstrable performance hit I have 
> been told.

I wasn't aware of that.

> I do not have access to such hardware.

Nor do I.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
