Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbRFTN7A>; Wed, 20 Jun 2001 09:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264881AbRFTN6u>; Wed, 20 Jun 2001 09:58:50 -0400
Received: from fluent1.pyramid.net ([206.100.220.212]:51504 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S264614AbRFTN6e>; Wed, 20 Jun 2001 09:58:34 -0400
Message-Id: <4.3.2.7.2.20010620065742.00b5a8b0@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
X-Priority: 2 (High)
Date: Wed, 20 Jun 2001 06:58:06 -0700
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@fluent-access.com>
Subject: Threads FAQ entry incomplete (was: Alan Cox quote?)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:12 PM 6/19/01 -0600, Richard Gooch wrote:
>New FAQ entry: http://www.tux.org/lkml/#s7-21
>
>Yeah, it's probably a bit harsh :-)

It's also incomplete, in my view, to the point of being misleading.

Part of the reason I'm reacting so harshly to this FAQ entry is that it 
flies in the face of my own experience.  I do a lot of real-time and 
near-real-time programming, and find that the process and thread models are 
essential to the proper and expected operation of my code.  The FAQ answer 
neglects this entire area of applications.

For details:  I run a process (not threads as yet, but it will happen) for 
each event I need to react to in near real time.  The running priority of 
these processes are set as high as possible so that when the event occurs 
the newly-unblocked process is guaranteed to run almost immediately.  These 
processes, when unblocked, do the absolute minimum amount of work to meet 
the real-time requirements and then block again.  If an event requires 
extended processing to begin but not to complete in real time, the event 
process sends an appropriate signal to the main process to perform that 
extended processing.

The main problem with the comment in the FAQ entry that "it's easy to write 
an event callback system" is that the response time may not meet the needs 
of the application, particularly in computer systems that have multiple 
near-real-time applications running at the same time.

The key design point in this near-real-time model I have described is that 
it does not violate the rule of thumb described in the FAQ answer, that the 
Linux kernel is designed to work well with a small number of RUNNING 
processes/threads.  Ideally, a high-priority process should run for much, 
much less time than the standard time-slice so as to minimize the number of 
scheduler elements marked as "ready to run."  My standard is for a 
high-priority process driven by an event to run for no more than a 
millisecond or so, and leave any heavy lifting to the main process to take 
care of when the main process gets around to it.

For true real-time processing, you have to write device drivers to react to 
external events directly, a programming task that is more burdensome and 
error-prone.  Or, better, use a real RTOS instead of Linux.  When the 
real-time requirement isn't so critical, though, the method I have 
described allows the whole thing to be done in userland, where it can be 
debugged far more easily.

In summary, writing code to use many processes or threads is NOT lazy 
programming in all instances, as the FAQ answer implies.

Stephen Satchell
writing time-critical programs for only a short time -- 30 years.

