Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVDDXLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVDDXLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDDXKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:10:49 -0400
Received: from omc3-s42.bay6.hotmail.com ([65.54.249.116]:36217 "EHLO
	omc3-s42.bay6.hotmail.com") by vger.kernel.org with ESMTP
	id S261481AbVDDXGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:06:49 -0400
Message-ID: <BAY10-F37D1DA55DA1E869AA5A34DD93B0@phx.gbl>
X-Originating-IP: [146.229.224.123]
X-Originating-Email: [getarunsri@hotmail.com]
In-Reply-To: <1112569686.27149.138.camel@localhost.localdomain>
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: rostedt@goodmis.org
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: scheduler/SCHED_FIFO behaviour
Date: Tue, 05 Apr 2005 04:36:42 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 04 Apr 2005 23:06:42.0908 (UTC) FILETIME=[F75979C0:01C5396A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am scheduling 2 SCHED_FIFO processes and set them affinity( process A runs 
on processor 1 and process B runs on processor 2), on a HT processor.(I did 
this cause I wanted to run them together).Now, in schedule() I measure the 
timedifference between when they are scheduled. I found that when I 
introduce these 2 processes as SCHED_FIFO they are

1)scheduled only once and run till completion ( they running time is around 
2 mins.)
2)entire system appears frozen....no mouse/key presses detected until the 
processes exit.

>From what I observed does it mean that even the OS / interrupt handler does 
not occur during the entire period of time these real time processes run?? 
(as I said the processes run in minutes).
How can I verify that?

Thanks
Arun

>From: Steven Rostedt <rostedt@goodmis.org>
>To: Arun Srinivas <getarunsri@hotmail.com>
>CC: juhl-lkml@dif.dk, LKML <linux-kernel@vger.kernel.org>
>Subject: Re: sched /HT processor
>Date: Sun, 03 Apr 2005 19:08:06 -0400
>
>On Mon, 2005-04-04 at 04:22 +0530, Arun Srinivas wrote:
> > Thanks. yes, a reschedule may not take place after a ms, if the 
>currently
> > running task cannot be preempted by another task.
> >
> > (1) But, can a reschedule happen within a millisec (or once a process is
> > scheduled can schedule() be called before the next millisec.) ?
> >
>
>Yes.  For example: a high priority task may be waiting for some IO to
>come in. Right after the normal timer interrupt scheduled another task,
>the IO may come in and wake the high priority process up. This process
>will preempt the other task right away. (ie. less than 1 ms).
>
> > 2) Also in case argument (1) is not true, and I want rescheduling to be 
>done
> > (i.e., schedule() called) in less than 1 ms , can I directly change the 
>HZ
> > value in <asm-i386/param.h> and recompile my kernel so that my timer
> > interrupt will occur frequently?
> >
>
>Well, 1) is true, but you can also increase HZ over 1000 if you like,
>but that will usually cause more overhead, since, although a schedule
>may not take place every HZ, a timer interrupt will.
>
>-- Steve
>
>

_________________________________________________________________
Want to meet David Beckham? http://www.msn.co.in/gillette/ Fly to Madrid 
with Gillette!

