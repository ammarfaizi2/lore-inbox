Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272123AbTHRPoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272128AbTHRPoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:44:14 -0400
Received: from dyn-ctb-203-221-73-35.webone.com.au ([203.221.73.35]:60167 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272123AbTHRPoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:44:11 -0400
Message-ID: <3F40F43A.4050709@cyberone.com.au>
Date: Tue, 19 Aug 2003 01:43:54 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O16int for interactivity
References: <200308160149.29834.kernel@kolivas.org> <3F3D25D0.7010701@techsource.com> <200308161231.50661.kernel@kolivas.org> <3F40F4DA.5050705@techsource.com>
In-Reply-To: <3F40F4DA.5050705@techsource.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Timothy Miller wrote:

>
>
> Con Kolivas wrote:
>
>>>
>>> A hardware timer interrupt happens at timeslice granularity.  If the
>>> interrupt occurs, but the timeslice is not expired, then NORMALLY, the
>>> ISR would just return right back to the running task, but sometimes, it
>>> might decided to end the timeslice early and run some other task.
>>>
>>> Right?
>>
>>
>>
>> No, the timeslice granularity is a hard cut off where a task gets 
>> rescheduled and put at the back of the queue again. If there is no 
>> other task of equal or better priority it will just start again.
>
>
>
> Hmmm... I'm still having trouble making sense of this.
>
> So, it seems that you're saying that all tasks, regardless of 
> timeslice length, are interrupted every 10ms (at 100hz). 


Interrupted - in that scheduler_tick is run, yes. They don't get switched.

>   If another task exists at a higher priority, then it gets run at 
> that point.


Well loosely, yes. Actually, it happens if the task exists and is "running",
and has timeslice left. That only happens in scheduler_tick when the 
current
task has finished its timeslice and the priority arrays are about to be
switched. The required conditions for preemption can also occur when a task
is being woken up, (after sleeping or newly forked).

> However, if there is more than one task at a given priority level, 
> then they will not round-robin until the current task has used up all 
> of its timeslice (some integer multiple of 10ms). 


Thats right. Although I think Con or Ingo recently changed this in mm

>
>
> Am I finally correct, or do I still have it wrong?  :)
>

Sounds right to me.

