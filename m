Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVFAISq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVFAISq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 04:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVFAISq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 04:18:46 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:64233 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261227AbVFAISZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 04:18:25 -0400
Date: Wed, 1 Jun 2005 10:17:22 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: James Bruce <bruce@andrew.cmu.edu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <17053.180.604190.389481@wombat.chubb.wattle.id.au>
Message-Id: <Pine.OSF.4.05.10506010950430.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Peter Chubb wrote:

> >>>>> "Esben" == Esben Nielsen <simlo@phys.au.dk> writes:
> 
> Esben> On Tue, 31 May 2005, James Bruce wrote:
> >> 
> >> It is only better in that if you need provable hard-RT *right now*,
> >> then you have to use a nanokernel.
> 
> Esben> What do you mean by "provable"? Security critical? Forget about
> Esben> nanokernels then. The WHOLE system has to be validated. 
> 
> The whole point of a nanokernel is it's *small*.  The whole thing can
> be formally verified.  And its semantics will provide isolation
> between the real-time processes and anything else that's running.
>

By the "whole thing" I meant everything running in kernel mode. That is
the nanokernel, Linux and any linux module you load runtime. A simple
memory violation: crash. It doesn't help you verify that the nano-kernel
runs realtime when you haven't verifies that Linux kernel is without
bugs which can trash a nano-kernel like Adeos/RTAI (it seems not to be the
case of Iguana, which does use memory protection against Linux.)

> We're currently working on a system called Iguana, which will have
> provable WCET for real-time scheduled tasks, and a Linux envionrment
> (called `wombat') that provides compatibility for 
> 
> Esben> I can't see it would be easier prove that a nano-kernel with
> Esben> various needed mutex and queuing mechanism works correct than
> Esben> it is to prove that the Linux scheduler with mutex and queueing
> Esben> mechanisms works correctly.  
> 
> Except that the nano-kernel is less than one percent of the size.
> 
> Both systems does the same thing
> Esben> and is most likely based on the same principles!  If a module
> Esben> in Linux disables interrupts for a non-deterministic amount of
> Esben> time, it destroys the RT in both scenarious. With the
> Esben> nanokernel, the Linux kernel is patched not to disable
> Esben> interrupts, but if someone didn't use the official
> Esben> local_irq_disable() macro the patch didn't work anyway...  The
> Esben> only way you can be absolutely sure Linux doesn't hurt RT is to
> Esben> run it in a full blown virtuel machine where it doesn't have
> Esben> access to disable interrupts and otherwise interfere with the
> Esben> nano-kernel.
> 
> This is precisely the approach we (and others) are taking.   A
> virtualised Linux to provide interactive and soft realtime (think java
> games on your mobile phone), and a nanokernel for your hard realtime
> tasks (think the radio controller on your mobile phone).  
> See http://www.disy.cse.unsw.edu.au/Software/Iguana/ for our work.

Iguana seems to do it safe and make real
virtuallisation/compartmentisation. I have seen similar systems presented
before: Seperate your machine protection domains - both wrt. timing and
memory. Then you don't have to worry so much about what is going on in
there as long as you don't need the output for anything critical.

The nanokernels (most Adeos/RTAI) we were discussing up until now, isn't
doing that.

> 
> In addition to our work, there's the Adeos system
> (http://www.hyades-itea.org/) uses a very similar approach.

Similar, but not so: No memory protection is involved in Adeos.

Iguana can be formally verified. Adeos/RTAI can't because it needs
verification of the whole Linux kernel, which is very unrealistic.

Linux preempt and Adeos/RTAI can get to/is at the level where it is
"designed deterministically". I.e. it is deterministic under the
assumption there is no bugs, but neither can be formally verified.

I suggest we call Adeos/RTAI a nanokernel and Iguana a microkernel (the
above link you provided says so :-) to avoid confusion.

This thread is really interresting but is also getting very messy due to a
lot of incompatible termonology :-(

Esben

