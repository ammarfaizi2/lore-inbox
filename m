Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbULKSE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbULKSE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 13:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbULKSE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 13:04:26 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:30397 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261984AbULKSEV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 13:04:21 -0500
Date: Sat, 11 Dec 2004 18:59:54 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>, Ingo Molnar <mingo@elte.hu>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
In-Reply-To: <1102722147.3300.7.camel@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10412111844360.6963-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Dec 2004, Steven Rostedt wrote:

> On Thu, 2004-12-09 at 12:10 -0600, Mark_H_Johnson@raytheon.com wrote:
> > >but you never want your real application be delayed by things like IDE
> > >processing or networking workloads, correct?
> > For the most part, that I/O workload IS because I have the RT application
> > running. That was one of my points. I cannot reliably starve any of
> > those activities. The disk reads in my real application simulate a disk
> > read from a real world device. That data is needed for RT processing
> > in the simulated system. Some of the network traffic is also RT since
> > we generate a data stream that is interpreted in real time by other
> > systems.
> 
> [RFC]  Has there been previously any thought of adding priority
> inheriting wait queues. With the IRQs that run as threads, have hooks in
> the code that allows a driver or socket layer to attach a thread to a
> wait queue, and when a RT priority task waits on the queue, a function
> is call to increase (if needed) the priority of the attached thread. I
> know that this would take some work, and would make the normal kernel
> and RT diverge more, but it would really help to solve the problem of a
> high priority process waiting for an interrupt that can be starved by
> other high priority processes.
> 
> Just a thought.
>
I am not sure I understand you correctly.

If it is a general method of making priority sorting on  wait-queues: Yes,
certainly! The highest priority task nearly always ought to be woken
first.

But in a lot of cases you send messages from high to low and visa verse
without wanting to move their priorities by doing so. If forinstance you
want a IRQ-thread to be increased in priority when a RT task listens to
packets from that device I think it is a bad idea. The developer should
himself set the priorities right. The device might use a lot of CPU in
some cases. By increasing it's priority you might destroy the RT
properties of all the tasks in between. In general you don't know.
 
> -- Steve
> 
Esben

