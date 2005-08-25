Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVHYUKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVHYUKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 16:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVHYUKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 16:10:47 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:4350 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932531AbVHYUKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 16:10:46 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Sven-Thorsten Dietrich <sven@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       george anzinger <george@mvista.com>, dwalker@mvista.com,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20050825174732.GA23774@elte.hu>
References: <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124981238.5350.6.camel@localhost.localdomain>
	 <1124982413.5350.19.camel@localhost.localdomain>
	 <20050825174732.GA23774@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 25 Aug 2005 16:09:23 -0400
Message-Id: <1125000563.6264.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 19:47 +0200, Ingo Molnar wrote:

> your patch works great here, on 3 separate systems: a 1-way, a 2/4-way 
> and an 8-way.
> 
> the 1-way system performed so well running the SMP kernel that i first 
> thought i booted the UP kernel by accident :-)
> 
> on the 8-way box, "hackbench 10" got _3.7_ times faster (!!!).
> 
> i have booted the 8-way box without your patch once more because i didnt 
> believe the results initially and thought they were some benchmarking 
> fluke. But no, it wasnt a fluke. The kernel profiles are nicely flat 
> now.
> 
> i've released 2.6.13-rc7-rt2 with your patch included. This is certainly 
> a major milestone for PREEMPT_RT, it is now a first-class scalability 
> citizen on SMP too. Great work Steven!
> 
> 	Ingo

A word of caution (aka. disclaimer). This is still new.  I still expect
there are some cases in the code that was missed and can cause a dead
lock or other bad side effect.  Hopefully, we can iron these all out.
Also, I noticed that since the task takes it's own pi_lock for most of
the code, if something locks up and a NMI goes off, the down_trylock in
printk will also lock when it tries to take it's own pi_lock.

I stated earlier, that I converted printk to use early_printk (serial)
on a oops_in_progress, so I wouldn't need to worry about the unlocking
circus that needs to be done.  So, I'm sure if something goes wrong now,
you won't see anything, even with an NMI.

If someone else would like to fix that, I'm sure Ingo would be willing
to accept patches :-)

-- Steve


