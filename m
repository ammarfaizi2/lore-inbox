Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVDDXOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVDDXOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVDDXNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:13:02 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:26295 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261481AbVDDXLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:11:07 -0400
Date: Tue, 5 Apr 2005 01:09:07 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
In-Reply-To: <Pine.LNX.4.61.0504041640490.31810@montezuma.fsmlabs.com>
Message-Id: <Pine.OSF.4.05.10504050106110.8387-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Zwane Mwaikambo wrote:

> On Mon, 4 Apr 2005, Steven Rostedt wrote:
> 
> > On Mon, 2005-04-04 at 22:47 +0200, Ingo Molnar wrote:
> > 
> > > > Currently my fix is in yield to lower the priority of the task calling 
> > > > yield and raise it after the schedule.  This is NOT a proper fix. It's 
> > > > just a hack so I can get by it and test other parts.
> > > 
> > > yeah, yield() is a quite RT-incompatible concept, which could livelock 
> > > an upstream kernel just as much - if the task in question is SCHED_FIFO.  
> > > Almost all yield() uses should be eliminated from the upstream kernel, 
> > > step by step.
> > 
> > Now the question is, who will fix it? Preferably the maintainers, but I
> > don't know how much of a priority this is to them. I don't have the time
> > now to look at this and understand enough about the code to be able to
> > make a proper fix, and I'm sure you have other things to do too.
> 
> I'm sure a lot of the yield() users could be converted to 
> schedule_timeout(), some of the users i saw were for low memory conditions 
> where we want other tasks to make progress and complete so that we a bit 
> more free memory.
> 

Easy, but damn ugly. Completions are the right answer. The memory system
needs a queue system where tasks can sleep (with a timeout) until the
right amount of memory is available instead of half busy-looping.

Esben


