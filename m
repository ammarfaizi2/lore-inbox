Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVFMFXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVFMFXu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 01:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVFMFXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 01:23:50 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:48104 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261361AbVFMFX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 01:23:27 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <1118530780.5593.154.camel@sdietrich-xp.vilm.net>
References: <Pine.OSF.4.05.10506112214240.2917-100000@da410.phys.au.dk>
	 <1118530780.5593.154.camel@sdietrich-xp.vilm.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 13 Jun 2005 01:22:53 -0400
Message-Id: <1118640173.29495.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 15:59 -0700, Sven-Thorsten Dietrich wrote:
> On Sat, 2005-06-11 at 22:23 +0200, Esben Nielsen wrote:
> > > 
> > No because it correctly leaves irqs on but not preemption on. 
> > 
> 
> I see your worries now. See below.
> 
I'm still slightly confused :-)

> > No. If you leave preemption off but irqs on, which is what is done here,
> > you get good, deterministic IRQ latencies but nothing for task-latencies -
> > actually slightly (unmeassureable I agree) worse due to the extra step
> > you have to go from the physical interrupt to the task-switch is
> > completed.

So is this just to allow for waking up of the IRQ threads?  I can see an
improvement on SMP since it would allow for the IRQ thread to run on
another CPU while the current CPU has local_irq_disable.  Or is this
just to improve the SA_NODELAY?

> PI is already in there. I think you are missing some basic concepts here, 
> for example that IRQs can happen ANYTIME, not just when we happen to enable 
> interrupts where they have previously been disabled.

I don't understand this paragraph at all :-?    Where is the PI with the
local_irq_disable?   So what if the IRQs can happen anytime?  Maybe it's
just because it's late and I've spent the last three hours catching up
on this and other threads (I still need to read the "Attempted
summary ..." thread. Wow that's big!), but this paragraph just totally
lost me.

> 
> I am going to stop responding to this thread until you back up your concerns 
> with real data, or throw some code out there, that you can back up with real data.

I hope you at least respond to me ;-) but I might try to implement that
per CPU BKL for local_irq_... just to see how it looks. But then again
you have to check all the code that uses it to see if it's not just
protection some local CPU data. Since there's not too many reasons to
use local_irq_.. in an SMP environment.  So when they are used, it
probably would be for a reason that a global mutex wouldn't work for. Oh
well, I guess I don't need to implement that after all. 

Cheers,

-- Steve


