Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVEXWyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVEXWyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEXWyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:54:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:13810 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262067AbVEXWyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:54:44 -0400
From: "Sven Dietrich" <sdietrich@mvista.com>
To: <karim@opersys.com>
Cc: "'Ingo Molnar'" <mingo@elte.hu>, "'Esben Nielsen'" <simlo@phys.au.dk>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Daniel Walker'" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>, "'Philippe Gerum'" <rpm@xenomai.org>
Subject: RE: RT patch acceptance
Date: Tue, 24 May 2005 15:54:36 -0700
Message-ID: <002201c560b3$904969f0$c800a8c0@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <4293AB4D.4030506@opersys.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Karim wrote:
> Sven Dietrich wrote:
> > Linux has been distributing and decoupling locking and
> > data structures since the first multi CPU kernel was booted.
> > 
> > All data integrity is just as consistent in RT, so HOW does
> > the behavior change? 
> 
> Here's quoting Arjan from another thread just today:
> > PREEMPT was (and is?) a stability risk and so you'll see RHEL4 not 
> > having it enabled.
> 
> ... and that's for simple preemption ...
> 

Any stability risk in PREEMPT is a stability risk in SMP.

I've been looking at some form of this RT code for over a year now. 

And 99 % of failures is buggy / dirty code that 
could fail under SMP as well, if not worse. 

We've pushed all that back to Ingo 
and elsewhere.

And the bugs keep on coming. This is the fast-track to exposing
concurrency problems all over the place, which makes better code
in Linux.

The RT stuff has the potential to enhance SMP scalability.

> Beyond that, I must admit that I'm probably missing the point 
> of your question: fact is that running interrupt handlers as 
> threads != dealing with interrupts in a linear fashion (as is 
> now.) That's behavior change right there, to mention just that.
> 

Linear is maybe not a good term to use. Do you mean the order in which
IRQs execute, or just that you execute IRQ code in process context.

A good generic IRQ handler that can run on multiple architectures,
doesn't care what the CPU flags are.

If it does have to be so down and dirty, it probably doesn't run 
as a thread, and its likely SA, as well.

If its about the order in which pending IRQs are processed, then lets take
a leap and ask why does that matter. The IRQs shouldn't care less what 
order they are processed in, if they are truly asynchronous / sporadic.

After all, how would the system know which IRQ arrived first to begin with,
when you happen to enable IRQs somewhere, and there happen to be 3 IRQs pending?

> 
> There is, in fact, nothing precluding rt-preemption from 
> co-existing with a nanokernel. </repeating-myself>
> 

Except complexity, as the performance differential between the
Linux kernel and the nanokernel vanishes.


