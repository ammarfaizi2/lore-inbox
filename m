Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312841AbSC1H26>; Thu, 28 Mar 2002 02:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313093AbSC1H2t>; Thu, 28 Mar 2002 02:28:49 -0500
Received: from zero.tech9.net ([209.61.188.187]:24850 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312841AbSC1H2l>;
	Thu, 28 Mar 2002 02:28:41 -0500
Subject: Re: Scheduler priorities
From: Robert Love <rml@tech9.net>
To: Wessel Dankers <wsl@fruit.eu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020328070855.GB514@fruit.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 28 Mar 2002 02:29:34 -0500
Message-Id: <1017300610.17515.229.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-28 at 02:08, Wessel Dankers wrote:

> Well evidently it should be root-only, just like SCHED_RR and SCHED_FIFO.
> If the priority inversion issues are worked out this restriction could be
> removed. I remember discussing this problem with Rik van Riel.
> The kernel-preempt patch seems to be able to detect when a process holds a
> lock; perhaps the process scheduler can temporarily revert to SCHED_NORMAL
> when this is the case? Preferably with a large nice value.

The preempt-kernel patch does keep track of the lock count, but it does
not include semaphores and those are what we need to worry about.

I also don't think it is enough that SCHED_IDLE only be settable by
root.  Regardless of what permissions it takes to set the scheduling
class, a "SCHED_IDLE" task should never be capable of harming an RT
task.

One solution I have come across is checking whether the task is
returning to kernel or user mode and acting appropriately.  As needed,
the task can be scheduled as SCHED_NORMAL.  This situation could even be
special-cased like ptrace and not impact normal scheduling.  Perhaps
this is what Ingo had in mind ... I hope he is still interested and
presents some code.

I know all this because I tried to implement SCHED_IDLE about a year
ago.  There were arguments against every approach, and SCHED_IDLE will
never be accepted until they are all satisfied.  If we want it, it needs
to be done right.

	Robert Love

