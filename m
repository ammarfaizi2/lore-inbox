Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWGEAtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWGEAtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 20:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWGEAtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 20:49:42 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:29653 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932369AbWGEAtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 20:49:41 -0400
Message-ID: <44AB0CA2.5080908@bigpond.net.au>
Date: Wed, 05 Jul 2006 10:49:38 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest> <200607051014.48089.kernel@kolivas.org>
In-Reply-To: <200607051014.48089.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 5 Jul 2006 00:49:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wednesday 05 July 2006 09:35, Peter Williams wrote:
>> Problem:
>>
>> There is a genuine need for the ability to put tasks in the background
>> (a la the SCHED_IDLEPRIO policy in Con Kolivas's -sc kernels) as is
>> evidenced by comments in LKML re a desire for SCHED_BATCH tasks
>> to run completely in the background.
>>
>> Solution:
>>
>> Of course, one option would have been to just modify SCHED_BATCH so
>> that tasks with that policy run completely in the background but there is a
>> genuine need for a non background batch policy so the solution adopted
>> is to implementa a new policy SCHED_BGND.
>>
>> SCHED_BATCH means that it's a normal process and should get a fair
>> share of the CPU in accordance with its "nice" setting but it is NOT an
>> interactive task and should NOT receive any of the special treatment
>> that a task that is adjudged to be interactive receives.  In particular,
>> it should always be moved to the expired array at the end of its time
>> slice as to do otherwise might result in CPU starvation for other tasks.
>>
>> SCHED_BGND means it's totally unimportant and should only be given the
>> CPU if no one else wants it OR if not giving it the CPU could lead to
>> priority inversion or starvation of other tasks due to this tasks holding
>> system resources.
> 
> Could we just call it SCHED_IDLEPRIO since it's the same thing and there are 
> tools out there that already use this name?
> 

I'm easy.  Which user space visible headers contain the definition? 
That's the only place that it matters.  When I was writing a program to 
use this feature, I couldn't find a header that defined any of the 
scheduler policies that was visible in user space (of course, that 
doesn't mean there isn't one - just that I couldn't find it).

Peter
PS Any programs that use SCHED_IDLEPRIO should work as long as its value 
is defined as 4.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
