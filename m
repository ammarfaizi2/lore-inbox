Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbUKJUYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbUKJUYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUKJUYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:24:23 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:49539 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262117AbUKJUWK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:22:10 -0500
Message-ID: <41926BED.7040400@tmr.com>
Date: Wed, 10 Nov 2004 14:28:45 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Warren <SWarren@nvidia.com>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: SCHED_RR and kernel threads
References: <DBFABB80F7FD3143A911F9E6CFD477B002A7F144@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B002A7F144@hqemmail02.nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Warren wrote:
>>From: Con Kolivas [mailto:kernel@kolivas.org] 
>>Stephen Warren writes:
>>
>>>I guess we could have most threads stay at SCHED_NORMAL, and just
> 
> make
> 
>>>the few critical threads SCHED_RR, but I'm getting a lot of push-back
> 
> on
> 
>>>this, since it makes our thread API a lot more complex.
>>
>>Your workaround is not suitable for the kernel at large.
> 
> 
> You mean the official kernel.org kernel? I wasn't implying that the
> patch should be part of that!
> 
> In our system we have literally EVERY single thread (kernel, user-space
> daemons, and user-space applications) all setup as SCHED_RR with
> identical priority at present, except a couple higher priority threads.
> We did this initially for user-space by replacing /sbin/init with a
> wrapper that set the scheduler policy and default priority, and verified
> that this was inherited by all daemons & application threads. Then, we
> found that the kernel threads could get starved in some situations,
> hence the kernel change.
> 
> Our threading model dictates that every thread have a priority (so that
> the thread model is portable between Linux, embedded RTOSs etc.), and in
> Linux AFAIK, the only way to implement priorities is to use a real-time
> scheduling policy. Some threads do a lot of calculation. We want to make
> them equal (or probably, lower) priority to the kernel threads, so
> therefore the kernel threads must then be SCHED_RR.
> 
> Can you elaborate on specific conditions that would cause the kernel
> threads to suck up unusual amounts of CPU time?
> 
> In our application, keyboard processing is a real-time requirement, so
> if that is performed in a kernel thread, that kernel thread should be
> real-time. We basically want the control to insert e.g. the keyboard
> processing kernel thread into the middle of our priority hierarchy,
> rather than having it forced as the lowest possible priority.

Perhaps someone could comment on why the keyboard thread is NOT higher 
priority? The whole functionality of SysReq key combinations would seem 
to depend on actually seeing the strokes. I would cautiously suggest 
that a priority control in /proc/sys might be a useful interface, 
certainly compared to patching the kernel and rebuilding.

Yes, I mean an option in the mainline kernel, so when debugging hangs 
the keyboard could be used.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

