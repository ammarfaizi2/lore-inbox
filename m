Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTILSKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTILSKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:10:41 -0400
Received: from ns.suse.de ([195.135.220.2]:28037 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261763AbTILSKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:10:35 -0400
Date: Fri, 12 Sep 2003 20:09:33 +0200
From: Andi Kleen <ak@suse.de>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-Id: <20030912200933.4e483bf8.ak@suse.de>
In-Reply-To: <20030912180429.GA876@sgi.com>
References: <20030911192550.7dfaf08c.ak@suse.de.suse.lists.linux.kernel>
	<1063308053.4430.37.camel@huykhoi.suse.lists.linux.kernel>
	<20030912162713.GA4852@sgi.com.suse.lists.linux.kernel>
	<20030912174807.GA629@sgi.com.suse.lists.linux.kernel>
	<p73y8wtlwf0.fsf@oldwotan.suse.de>
	<20030912180429.GA876@sgi.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003 11:04:29 -0700
jbarnes@sgi.com (Jesse Barnes) wrote:

> On Fri, Sep 12, 2003 at 08:00:03PM +0200, Andi Kleen wrote:
> > jbarnes@sgi.com (Jesse Barnes) writes:
> > 
> > > Ok, Andi asked for benchmarks, so I ran some.  Let this should be a
> > > lesson on why you shouldn't use port I/O :)  I ran these on an SGI Altix
> > > w/900 MHz McKinley processors.
> > > 
> > > Just straight calls to the routines (all of these are based on the
> > > average of 100 iterations):
> > >   writeq(val, reg) time: 64 cycles
> > >   outl(val, reg) time: 2126 cycles
> >                          ^^^^^
> > > 
> > > A simple branch:
> > >   if (use_mmio)
> > > 	writeq(val, reg) time: 132 cycles
> > >   else
> > > 	outl(val, reg) time: 1990 cycles
> >                              ^^^^^
> > Something seems to be wrong in your numbers.
> > 
> > Surely the outl in the if () cannot be faster than the pure outl() ?
> 
> Well, they're approximate at best...  For outl the branch doesn't seem
> to matter since it takes forever regardless.

True. Ok for PIO it doesn't matter. I'm surprised the hit is that big
for MMIO. What code does the IA64 compiler generate for this?
If it was a branch it should have been predicted.

I guess we could use dynamic patching like the alternative() code on
i386 does for prefetches etc., but that may be a bit of overkill...
Or fix the makefiles that they can easily compile two versions of 
the driver.

-Andi
