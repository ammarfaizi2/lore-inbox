Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVDDUyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVDDUyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVDDUwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:52:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40416 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261392AbVDDUsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:48:10 -0400
Date: Mon, 4 Apr 2005 22:47:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
Message-ID: <20050404204725.GA17818@elte.hu>
References: <200504011834.22600.gene.heskett@verizon.net> <20050402051254.GA23786@elte.hu> <1112470675.27149.14.camel@localhost.localdomain> <1112472372.27149.23.camel@localhost.localdomain> <20050402203550.GB16230@elte.hu> <1112474659.27149.39.camel@localhost.localdomain> <1112479772.27149.48.camel@localhost.localdomain> <1112486812.27149.76.camel@localhost.localdomain> <20050404200043.GA16736@elte.hu> <1112647253.5147.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112647253.5147.17.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > actually, what priorities do the yielding tasks have? sched_yield() does 
> > not guarantee that the CPU will be given up, of if a highest-prio 
> > SCHED_FIFO task is in a yield() loop it will livelock the system.
> 
> What scares me is the code in fs/inode.c with that 
> __wait_on_freeing_inode.  Look at the code in find_inode and 
> find_inode_fast.  Here you will see that they really are busy loops 
> with a yield in them, if the inode they are waiting on is I_FREEING or 
> I_CLEAR and the process doing this hasn't set I_LOCK.  I haven't 
> looked much at this, but my kernel has livelocked on it.

ok, makes sense.

> Currently my fix is in yield to lower the priority of the task calling 
> yield and raise it after the schedule.  This is NOT a proper fix. It's 
> just a hack so I can get by it and test other parts.

yeah, yield() is a quite RT-incompatible concept, which could livelock 
an upstream kernel just as much - if the task in question is SCHED_FIFO.  
Almost all yield() uses should be eliminated from the upstream kernel, 
step by step.

	Ingo
