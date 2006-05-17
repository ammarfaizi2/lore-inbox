Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWEQKq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWEQKq2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 06:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWEQKq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 06:46:28 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:42478 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751091AbWEQKq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 06:46:27 -0400
Date: Wed, 17 May 2006 06:46:01 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andi Kleen <ak@suse.de>
cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Paul Mackerras <paulus@samba.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>, rth@twiddle.net, spyro@f2s.com,
       starvik@axis.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       ralf@linux-mips.org, linux-mips@linux-mips.org,
       grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       linuxppc-dev@ozlabs.org, linux390@de.ibm.com, davem@davemloft.net,
       arnd@arndb.de, kenneth.w.chen@intel.com, sam@ravnborg.org,
       clameter@sgi.com, kiran@scalex86.org
Subject: Re: [RFC PATCH 01/09] robust VM per_cpu core
In-Reply-To: <200605171117.06060.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0605170640280.8408@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605170555190.8408@gandalf.stny.rr.com> <200605171117.06060.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 May 2006, Andi Kleen wrote:

>
> > As well as the following three functions:
> >
> > pud_t *pud_boot_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long addr,
> >                      int cpu);
> > pmd_t *pmd_boot_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
> >                      int cpu);
> > pte_t *pte_boot_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
> >                      int cpu);
>
> I'm not sure you can just put them like this into generic code. Some
> architectures are doing strange things with them.

Hmm, like what?

>
> And we already have boot_ioremap on some architectures. Why is that not
> enough?

I thought about using boot_ioremap, but it seems to be an abuse.  Since
I'm not mapping io, but actual memory pages.  So the solution to that
seemed more of a hack.  I then would need to worry about grabbing pages
that were node specific and getting the physical addresses.  It just
looked like a cleaner solution to have an API that was for exactly what it
was meant for.

-- Steve

