Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318070AbSFTAHB>; Wed, 19 Jun 2002 20:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318071AbSFTAHA>; Wed, 19 Jun 2002 20:07:00 -0400
Received: from [195.223.140.120] ([195.223.140.120]:39496 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318070AbSFTAHA>; Wed, 19 Jun 2002 20:07:00 -0400
Date: Thu, 20 Jun 2002 02:07:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
Message-ID: <20020620000751.GI22262@dualathlon.random>
References: <Pine.LNX.4.44.0206200123470.25434-100000@e2> <1024530423.917.21.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1024530423.917.21.camel@sinai>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 04:47:00PM -0700, Robert Love wrote:
> On Wed, 2002-06-19 at 16:35, Ingo Molnar wrote:
> 
> > the scheduler optimisation in 2.5.23-dj1, from James Bottomley, look fine
> > to me. I did some modifications:
> 
> Nice.
> 
> > +static inline unsigned int task_cpu(struct task_struct *p)
> > +static inline unsigned int set_task_cpu(struct task_struct *p, unsigned int cpu)
> 
> Technically, shouldn't we make these `unsigned long' ?

obviously not. Supporting 4G cpus is enough for this century, so the
other 32bit would be just wasted space. the 1 in the shiftleft needs the
UL anyways to be correct with >32 cpus (it's not strictly a bug right
now to forget the UL but if we get it right we'll be able to go 64-way
on 64bit systems with no change other than NR_TASKS). So the bitmasks
must be all unsigned longs, the cpu numbers are definitely fine as
unsigned ints.

Even after we break at some point the 64CPU limit growing the bitmask
ala sigset_t, still the cpu numbers will remain unsigned int for a very
long time (probably we'll never have a chance to see the need of
unsigned long cpu numbers in our lifes).

Andrea
