Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVDDW4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVDDW4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVDDWzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:55:37 -0400
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:60813 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261460AbVDDWto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:49:44 -0400
Date: Mon, 4 Apr 2005 16:51:12 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@elte.hu>, Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
In-Reply-To: <1112649296.5147.21.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0504041640490.31810@montezuma.fsmlabs.com>
References: <200504011834.22600.gene.heskett@verizon.net>  <20050402051254.GA23786@elte.hu>
  <1112470675.27149.14.camel@localhost.localdomain> 
 <1112472372.27149.23.camel@localhost.localdomain>  <20050402203550.GB16230@elte.hu>
  <1112474659.27149.39.camel@localhost.localdomain> 
 <1112479772.27149.48.camel@localhost.localdomain> 
 <1112486812.27149.76.camel@localhost.localdomain>  <20050404200043.GA16736@elte.hu>
  <1112647253.5147.17.camel@localhost.localdomain>  <20050404204725.GA17818@elte.hu>
 <1112649296.5147.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

I'm sure a lot of the yield() users could be converted to 
schedule_timeout(), some of the users i saw were for low memory conditions 
where we want other tasks to make progress and complete so that we a bit 
more free memory.

