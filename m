Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275546AbRJAUyk>; Mon, 1 Oct 2001 16:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275530AbRJAUyZ>; Mon, 1 Oct 2001 16:54:25 -0400
Received: from [194.213.32.141] ([194.213.32.141]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S275529AbRJAUxo>;
	Mon, 1 Oct 2001 16:53:44 -0400
Message-ID: <20011001164354.A21715@bug.ucw.cz>
Date: Mon, 1 Oct 2001 16:43:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Robert Love <rml@ufl.edu>, David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Allow net devices to contribute to /dev/random
In-Reply-To: <1001461026.9352.156.camel@phantasy> <9or70g$i59$1@abraham.cs.berkeley.edu> <1001465531.10701.61.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <1001465531.10701.61.camel@phantasy>; from Robert Love on Tue, Sep 25, 2001 at 08:52:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Here is my reasoning.  I'd like to quote drivers/char/random.c:
> >   * add_interrupt_randomness() uses the inter-interrupt timing as random
> >   * inputs to the entropy pool.  Note that not all interrupts are good
> >   * sources of randomness!  For example, the timer interrupts is not a
> >   * good choice, because the periodicity of the interrupts is too
> >   * regular, and hence predictable to an attacker.  Disk interrupts are
> >   * a better measure, since the timing of the disk interrupts are more
> >   * unpredictable.
> >   * 
> >   * All of these routines try to estimate how many bits of randomness a
> >   * particular randomness source.  They do this by keeping track of the
> >   * first and second order deltas of the event timings.
> 
> Obviously the timer interrupt would be the worst idea ever.  Its the
> same value (HZ) on almost all versions of Linux (Alpha being on example
> where it is not the same).

Actually, not quite. On 2.4.9 system, console kept interrupts disabled
for so long that timer interrupt was pretty good source of randomness.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
