Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269696AbSIRXGU>; Wed, 18 Sep 2002 19:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269697AbSIRXGU>; Wed, 18 Sep 2002 19:06:20 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:56338
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S269696AbSIRXGS>; Wed, 18 Sep 2002 19:06:18 -0400
Subject: Re: [PATCH] In-kernel module loader 3/7
From: Robert Love <rml@tech9.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209190042370.8911-100000@serv>
References: <Pine.LNX.4.44.0209190042370.8911-100000@serv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 19:11:09 -0400
Message-Id: <1032390672.4592.1977.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 19:07, Roman Zippel wrote:

> On Wed, 18 Sep 2002, Rusty Russell wrote:
> 
> > +/* Stopping interrupts faster than atomics on many archs (and more
> > +   easily optimized if they're not) */
> > +static inline void bigref_inc(struct bigref *ref)
> > +{
> > +	unsigned long flags;
> > +	struct bigref_percpu *cpu;
> > +
> > +	local_irq_save(flags);
> > +	cpu = &ref->ref[smp_processor_id()];
> > +	if (likely(!cpu->slow_mode))
> > +		cpu->counter++;
> 
> Did you benchmark this? On most UP machines an inc/dec should be cheaper
> than irq enable/disable.

Yah.  I would think due to pipeline effects, disabling interrupts would
never be faster than an atomic inc/dec, assuming the architecture has
normal locking.

	Robert Love

