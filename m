Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbULFPEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbULFPEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbULFPEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:04:54 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:39306 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261519AbULFPDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:03:45 -0500
Date: Mon, 6 Dec 2004 16:01:49 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
In-Reply-To: <20041206131458.GA20247@elte.hu>
Message-Id: <Pine.OSF.4.05.10412061520060.6546-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > On Fri, 3 Dec 2004, Ingo Molnar wrote:
> > 
> > > 
> > > [...] 
> > > on low RT load (the common case) 
> > 
> > In the system I deal with on my day job, 50% of the CPU load is from
> > RT tasks!
> 
> i'm not sure what point you are trying to make, but 'low RT load' in
> this context means up to a load of 1.0. (i.e. one or less tasks running
> on average)
>

The point I want to make is that RT tasks is not always of the type
which reacts to some interrupt, does a small job and then goes to
sleep. Sometimes you also want larger jobs done realtime. Forinstance an
application waking up every 10ms, running for 5ms before going to sleep
again. That ofcourse gives you a RT-load <= 1.0.

In more complicated systems you can have a task running every 5ms,
another at every 25ms and another at every 100ms. That gives you a
RT-load of up to 3! And it is a even common case because you try to
syncronize the tasks, i.e. you wake all 3 tasks up at the same time but
then you know that on your typical UP system they will be executed by
priority, i.e. first the 5ms one, then the 25ms one and last the 100ms.

So my point was: Low RT-load might not be the common case on specific
systems. It is on the desktop where you want to run some multimedia
multimedia task(s) and have fast CPU compared to the job you
need done in RT but in embedded devices you do not pick such a big CPU and
you often use a large part on it in you RT control-loops.
 
> also, this only applies to SMP systems.
> 
> thirdly, even if the new balancing code kicks in, the overhead is not
> that bad, and it's for a purpose: we rather want an RT task to run on a
> free CPU.
> 

Good to hear. I was going to ask if the overhead wasn't too big :-)

However, I do have a feeling that it is rather expensive to move tasks
around. If I was going to design a real-time application on a 2 CPU SMP
system, I think I would CPU lock my RT-tasks to make the system more
deterministic. I.e. I would probably "port" the above mentioned
application by putting the 5 ms task on one CPU, the 25ms on the 
other and the 100 ms on the whatever CPU has the less CPU load. Then the
other non-real-time tasks in the system can wander around as they please.

But that is ofcourse not something you can do unless you know the specific
hardware system you will run your application on.  That is not the case
when you make multimedia software for the PC. I.e. in that case moving
RT-tasks around makes perfect sense!


> 	Ingo
> 

Esben

