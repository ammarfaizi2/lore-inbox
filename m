Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268458AbTCFWpY>; Thu, 6 Mar 2003 17:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268471AbTCFWpY>; Thu, 6 Mar 2003 17:45:24 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:14084
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S268458AbTCFWpX>; Thu, 6 Mar 2003 17:45:23 -0500
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: Robert Love <rml@tech9.net>
To: Martin Waitz <tali@admingilde.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20030306223518.GB1326@admingilde.org>
References: <20030228202555.4391bf87.akpm@digeo.com>
	 <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
	 <20030306220307.GA1326@admingilde.org>
	 <1046988457.715.37.camel@phantasy.awol.org>
	 <20030306223518.GB1326@admingilde.org>
Content-Type: text/plain
Organization: 
Message-Id: <1046991366.715.52.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 06 Mar 2003 17:56:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 17:35, Martin Waitz wrote:

> processes tend to max out at one extreme or the other
> 
> processes that get stalled by a huge overall load of the machine
> are forced to sleep, too; yet they are not interactive.

Not running != Sleeping

> priority should be based on things the processes did, not on what
> they haven't done.

It _is_ based on something the process has done: sleeping in the kernel

> but for interactive tasks, latency is all-important
> if the task can't provide a result in a short timeslice it already
> failed to provide low latency and should not be considered interactive
> any more.

Ahh, but you are confusing timeslice with the time a process runs for.

This is what I pointed out in my initial email was your flaw :)

A process may have a 100ms timeslice, but only run for 1ms at a time
(100x before recalculating its quanta).  This is the intention of giving
large timeslices to interactive tasks: not that they need all 100ms at
_once_ but they may need some of it soon, and when they need it they
really NEED it, so make sure they have enough timeslice such that there
is plenty available when they wake up (since the latency is important,
as you said).

> but the time slice should not be large enough to stall other
> processes, which is extremely important for interactivity

Once a process stalls other processes (i.e. by running a long time i.e.
by being a CPU hog) then it loses its interactive bonus.

The heuristic works.  No one doubts that, modulo the corner cases we are
working on fixing.  I suggest you read the code.

	Robert Love

