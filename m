Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVDDXLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVDDXLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVDDXLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:11:13 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:951 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S261486AbVDDXGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:06:47 -0400
Date: Tue, 5 Apr 2005 01:06:06 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
In-Reply-To: <1112649296.5147.21.camel@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10504050009080.8387-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Steven Rostedt wrote:

> On Mon, 2005-04-04 at 22:47 +0200, Ingo Molnar wrote:
> 
> > > Currently my fix is in yield to lower the priority of the task calling 
> > > yield and raise it after the schedule.  This is NOT a proper fix. It's 
> > > just a hack so I can get by it and test other parts.
> > 
> > yeah, yield() is a quite RT-incompatible concept, which could livelock 
> > an upstream kernel just as much - if the task in question is SCHED_FIFO.  
> > Almost all yield() uses should be eliminated from the upstream kernel, 
> > step by step.
> 
> Now the question is, who will fix it? Preferably the maintainers, but I
> don't know how much of a priority this is to them. I don't have the time
> now to look at this and understand enough about the code to be able to
> make a proper fix, and I'm sure you have other things to do too.

How about adding a
 if(rt_task(current)) {
        WARN_ON(1);
        mutex_setprio(current, MAX_PRIO-1)
 }
?

to find all calls to yields from rt-tasks. That will force the user (aka
the real-time developer) to either stop calling the subsystems still using
yield from his RT-tasks, or fix those subsystems.

Esben

> 
> -- Steve
> 


