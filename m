Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWDOUR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWDOUR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 16:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWDOUR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 16:17:29 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:24704 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751426AbWDOUR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 16:17:28 -0400
Date: Sat, 15 Apr 2006 16:17:01 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux390@de.ibm.com, davem@davemloft.net
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <4440855A.7040203@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
 <4440855A.7040203@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Apr 2006, Nick Piggin wrote:

> Steven Rostedt wrote:
>
> >  would now create a variable called per_cpu_offset__myint in
> > the .data.percpu_offset section.  This variable will point to the (if
> > defined in the kernel) __per_cpu_offset[] array.  If this was a module
> > variable, it would point to the module per_cpu_offset[] array which is
> > created when the modules is loaded.
>
> If I'm following you correctly, this adds another dependent load
> to a per-CPU data access, and from memory that isn't node-affine.
>
> If so, I think people with SMP and NUMA kernels would care more
> about performance and scalability than the few k of memory this
> saves.

It's not just about saving memory, but also to make it more robust. But
that's another story.

Since both the offset array, and the variables are mainly read only (only
written on boot up), added the fact that the added variables are in their
own section.  Couldn't something be done to help pre load this in a local
cache, or something similar?

I understand SMP issues pretty well, but NUMA is still somewhat foreign to
me.

-- Steve

