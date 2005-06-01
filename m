Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVFAPTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVFAPTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVFAPS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:18:28 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:60352 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261416AbVFAPQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:16:32 -0400
Date: Wed, 1 Jun 2005 17:15:23 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <20050601150527.GL5413@g5.random>
Message-Id: <Pine.OSF.4.05.10506011709500.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Andrea Arcangeli wrote:

> On Wed, Jun 01, 2005 at 04:45:57PM +0200, Esben Nielsen wrote:
> > the implementation of the former spinlock, now a mutex, is using a
> > raw_spin_lock, which disables interrupts.
> 
> It's not _raw_spin_lock that disables irq. It's spin_lock_irq that does
> that and it has been redefinined into an operation that doesn't disable
> irq.
> 
> The patent text goes like this "providing a software emulator to disable
> and enable interrupts from the general purpose operating system; 
> 
> marking interrupts as "soft disabled" and not "soft enabled" in response
> to requests from the general purpose operating system to disable
> interrupts; ".
>

PREEMPT_RT doesn't do that. If you from Linux request to disable irqs or
preemption you just do it. Nothing in PREEMPT_RT prevents you. There is no
"software emulation" involved at all. Redefining spin_lock() to mean
lock_mutex() is clearly not the same as putting in a sub-kernel and
redifiing cli()/sti() in Linux, which is what the patent covers.
 
> I'm not a lawyer and I hope to be wrong, but I sure wouldn't bet the
> farm on it. You should ask a lawyer to make sure that non-GPL code is
> not infringing IMHO. This assuming that this could be a problem. It was
> a problem for RTAI users, people is used to the fact userland doesn't
> need to be GPL. Note that LGPL and BSD code will infringe too (i.e. no
> glibc etc..).

Neither am I. But I know if I start to interpret patens that way I would
have to stop writing software right now as every line of code would be
covered by some patent if you start to look at it your way.

Esben

