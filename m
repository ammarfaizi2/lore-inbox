Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVFMHCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVFMHCz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 03:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVFMHCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 03:02:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52468 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261401AbVFMHCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 03:02:51 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.05.10506121250310.2917-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506121250310.2917-100000@da410.phys.au.dk>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 00:01:35 -0700
Message-Id: <1118646095.5729.57.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-12 at 13:15 +0200, Esben Nielsen wrote:
> On Sun, 12 Jun 2005, Ingo Molnar wrote:
> I am surprised that is should actually be faster, but I give in to the
> experts. I will see if I can find time to perform a test or I should spend
> it on something else.
> 
> That said, this long discussion have not been a complete waste of time: I
> think this thread have learned us that we do have different goals and
> clarifies stuff.
> 
> I am not happy about the soft-irq thing. Mostly due to naming.
> local_irq_disable() is really just preempt_disable() with some extra stuff
> to make it backward combatible. 
> I still believe local_irq_disable() (also in the soft version) should be
> completely forbidden when PREEMPT_RT is set. All places using it should be
> replaced with a mutex or a ???_local_irq_disable() to mark that the code
> have been reviewed for PREEMPT_RT. With your argument above 
> ???_local_irq_disable() should really be preempt_disable() as that is
> faster.
> 

Hi Esben,

I just wondered if you are talking about the scenario where an interrupt
is executing on one processor, and gets preempted. Then some code runs
on the same CPU, which does local_irq_disable (now preempt_disable), to
keep that IRQ from running, but the IRQ thread is already started?

In the community kernel, this could never happen, because IRQs can't be
preempted. But in RT, its possible an IRQ could be preempted, and under
some circumstance, this sequence could occur.

Is that is what you are talking about? If not, it might be over my head,
and I am sorry. If so, I think that scenario is covered under SMP.

Sven


