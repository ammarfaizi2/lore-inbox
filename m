Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVDCWwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVDCWwY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 18:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVDCWwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 18:52:23 -0400
Received: from omc2-s17.bay6.hotmail.com ([65.54.249.27]:61828 "EHLO
	OMC2-S17.phx.gbl") by vger.kernel.org with ESMTP id S261941AbVDCWwO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 18:52:14 -0400
Message-ID: <BAY10-F33A32038B1B733A67892F7D93A0@phx.gbl>
X-Originating-IP: [68.62.238.188]
X-Originating-Email: [getarunsri@hotmail.com]
In-Reply-To: <1112542263.27149.113.camel@localhost.localdomain>
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: rostedt@goodmis.org, juhl-lkml@dif.dk
Cc: linux-kernel@vger.kernel.org
Subject: Re: sched /HT processor
Date: Mon, 04 Apr 2005 04:22:13 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 03 Apr 2005 22:52:13.0598 (UTC) FILETIME=[C6C98BE0:01C5389F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>From: Steven Rostedt <rostedt@goodmis.org>
>To: Jesper Juhl <juhl-lkml@dif.dk>
>CC: Arun Srinivas <getarunsri@hotmail.com>,        LKML 
><linux-kernel@vger.kernel.org>
>Subject: Re: sched /HT processor
>Date: Sun, 03 Apr 2005 11:31:03 -0400
>
>On Sun, 2005-04-03 at 13:17 +0200, Jesper Juhl wrote:
> >
> > A reschedule can happen once every ms, but also upon returning to
> > userspace and when returning from an interrupt handler, and also when
> > something in the kernel explicitly calls schedule() or sleeps (which in
> > turn results in a call to schedule()). And each CPU runs schedule()
> > independently.
> > At least that's my understanding of it - if I'm wrong I hope someone on
> > the list will correct me.
>
>You're correct, but I'll add some more details here.  The actual
>schedule happens when needed.  A schedule may not take place at every
>ms, if the task running is not done with its time slice and no events
>happened where another task should preempt it. If an RT task is running
>in a FIFO policy, then it will continue to run until it calls schedule
>itself or another process of higher priority preempts it.
>
>Now if you don't have PREEMPT turned on, than the schedule won't take
>place at all while a task is in the kernel, unless the task explicitly
>calls schedule.
>
>What happens on a timer interrupt where a task is done with its time
>slice or another event where a schedule should take place, is just the
>need_resched flag is set for the task.  On return from the interrupt the
>flag is checked, and if set a schedule is called.
>
>This is still a pretty basic description of what really happens, and if
>you want to learn more, just start searching the kernel code for
>schedule and need_resched. Don't forget to look in the asm code (ie
>entry.S, and dependent on your arch other *.S files).
>
>-- Steve
>
>

_________________________________________________________________
News, views and gossip. http://www.msn.co.in/Cinema/ Get it all at MSN 
Cinema!

