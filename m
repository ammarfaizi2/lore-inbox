Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWEQOy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWEQOy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 10:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWEQOy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 10:54:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38067 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750831AbWEQOy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 10:54:57 -0400
Date: Wed, 17 May 2006 07:52:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Paul Mackerras <paulus@samba.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
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
       linux390@de.ibm.com, davem@davemloft.net, arnd@arndb.de,
       kenneth.w.chen@intel.com, sam@ravnborg.org, kiran@scalex86.org
Subject: Re: [RFC PATCH 00/09] robust VM per_cpu variables
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0605170744360.13021@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006, Steven Rostedt wrote:

> My first attempt to fix this introduced another dereference, to allow
> for modules to allocate their own memory.  This was quickly shot down,
> and for good reason, because dereferences kill performance, and don't
> play nice with large SMP systems that depend on per_cpu being fast.

> I now place the per_cpu variables into VM, such that the pages are
> only allocated when needed. All the architecture needs to do is
> supply a VM address range, size for each CPU to use (note this
> implementation expects all the VM CPU areas to be together), and
> three functions to allow for allocating page tables at bootup.

So now instead of an explicit indirection we use an implicit one 
through the page tables for this. This happens during early boot which 
requires additional page table functions? And it requires the use of an 
additional TLB entry? I guess that the additional TLB pressure alone will 
result in a performance drop of 3%?

See http://www.gelato.unsw.edu.au/archives/linux-ia64/0602/17311.html



