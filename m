Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUKICW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUKICW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 21:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUKICW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 21:22:27 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:7614 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261252AbUKICWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 21:22:21 -0500
References: <DBFABB80F7FD3143A911F9E6CFD477B002A7F144@hqemmail02.nvidia.com>
Message-ID: <cone.1099966935.602631.13436.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Stephen Warren <SWarren@nvidia.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: SCHED_RR and kernel threads
Date: Tue, 09 Nov 2004 13:22:15 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Warren writes:

>> From: Con Kolivas [mailto:kernel@kolivas.org] 
>> Stephen Warren writes:
>>> I guess we could have most threads stay at SCHED_NORMAL, and just
> make
>>> the few critical threads SCHED_RR, but I'm getting a lot of push-back
> on
>>> this, since it makes our thread API a lot more complex.
>>
>>Your workaround is not suitable for the kernel at large.
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
> 
> I get the impression you're implying that scheduling doesn't work
> correctly in this situation - that if kernel threads are set to
> SCHED_RR, they can still lock out user-space threads of the same or
> higher priority? Is this what you're saying, or do you mean that the
> kernel threads can lock out user-space threads of *lower* priority,
> which is to be expected. In all the RTOS's I've seen, all threads are
> SCHED_RR, thus mimicking the situation we've creating by patching our
> kernel...

If everything is the same priority then you've created a simple round robin 
scheduler out of the kernel and that's fine for your setting. If you're 
looking for another alternative to this, check out the email I posted in the 
last week for implementing a sched bound policy. We will be looking at 
implementing that in the near future.

Cheers,
Con

