Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318260AbSGXHwj>; Wed, 24 Jul 2002 03:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318262AbSGXHwj>; Wed, 24 Jul 2002 03:52:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7897 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318260AbSGXHwi>;
	Wed, 24 Jul 2002 03:52:38 -0400
Date: Wed, 24 Jul 2002 09:54:47 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Robert Love <rml@tech9.net>, george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruptionin2.5.27?]
In-Reply-To: <3D3E5E80.EA769517@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207240953130.7415-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Andrew Morton wrote:

> > Code that relies on
> > cli/sti for atomicity should be pretty rare and limited, there's 1 known
> > case so far where it leads to bugs.
> 
> Are you implying that all code which does spin_unlock() inside
> local_irq_disable() needs to be converted to use _raw_spin_unlock()? If
> so then, umm, ugh.  I hope that the debug check is working for
> CONFIG_PREEMPT=n.

yes, it works for CONFIG_PREEMT=n as well.

> BTW, what is the situation with spin_unlock_irq[restore]()?  Seems that
> these will schedule inside local_irq_disable() quite a lot?

i changed the order in my patch - and there's another valid reason for it:  
to slightly reduce the amount of time spent with irqs disabled.

	Ingo

