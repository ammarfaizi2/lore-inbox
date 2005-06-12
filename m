Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVFLLPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVFLLPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVFLLPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:15:46 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:24781 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261934AbVFLLPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:15:38 -0400
Date: Sun, 12 Jun 2005 13:15:18 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <20050612065733.GA6997@elte.hu>
Message-Id: <Pine.OSF.4.05.10506121250310.2917-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005, Ingo Molnar wrote:

> 
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Sat, 2005-06-11 at 13:51 -0700, Daniel Walker wrote:
> > > On Sat, 11 Jun 2005, Ingo Molnar wrote:
> > 
> > > Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
> > > method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
> > > not sure if there is any function call overhead .. So the soft replacment 
> > > of cli/sti is 70% faster on a per instruction level .. So it's at least 
> > > not any slower .. Does everyone agree on that?
> > 
> > No, because x86 is not the whole universe
> 
> x86 is actually a 'worst-case', because it has one of the cheapest CPU 
> level cli/sti implementations. Usually it's the hard-local_irq_disable() 
> overhead on non-x86 platforms that is a problem. (ARM iirc) So in this 
> sense the soft-flag should be a win on most sane architectures.
> 
> 	Ingo

I am surprised that is should actually be faster, but I give in to the
experts. I will see if I can find time to perform a test or I should spend
it on something else.

That said, this long discussion have not been a complete waste of time: I
think this thread have learned us that we do have different goals and
clarifies stuff.

I am not happy about the soft-irq thing. Mostly due to naming.
local_irq_disable() is really just preempt_disable() with some extra stuff
to make it backward combatible. 
I still believe local_irq_disable() (also in the soft version) should be
completely forbidden when PREEMPT_RT is set. All places using it should be
replaced with a mutex or a ???_local_irq_disable() to mark that the code
have been reviewed for PREEMPT_RT. With your argument above 
???_local_irq_disable() should really be preempt_disable() as that is
faster.

Esben

