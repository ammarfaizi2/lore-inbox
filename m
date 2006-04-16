Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWDPGfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWDPGfT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 02:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWDPGfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 02:35:18 -0400
Received: from ozlabs.org ([203.10.76.45]:32183 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751224AbWDPGfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 02:35:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17473.58781.901412.135671@cargo.ozlabs.ibm.com>
Date: Sun, 16 Apr 2006 16:35:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       linux-mips@linux-mips.org, David Mosberger-Tang <davidm@hpl.hp.com>,
       linux-ia64@vger.kernel.org, Martin Mares <mj@atrey.karlin.mff.cuni.cz>,
       spyro@f2s.com, Joe Taylor <joe@tensilica.com>, linuxppc-dev@ozlabs.org,
       benedict.gaster@superh.com, bjornw@axis.com,
       Ingo Molnar <mingo@elte.hu>, grundler@parisc-linux.org,
       starvik@axis.com, Linus Torvalds <torvalds@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net, chris@zankel.net,
       tony.luck@intel.com, Andi Kleen <ak@suse.de>, ralf@linux-mips.org,
       Marc Gauthier <marc@tensilica.com>, lethal@linux-sh.org,
       schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
       parisc-linux@parisc-linux.org
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt writes:

> The data in .data.percpu_offset holds is referenced by the per_cpu
> variable name which points to the __per_cpu_offset array.  For modules,
> it will point to the per_cpu_offset array of the module.
> 
> Example:
> 
>  DEFINE_PER_CPU(int, myint);
> 
>  would now create a variable called per_cpu_offset__myint in
> the .data.percpu_offset section.  This variable will point to the (if
> defined in the kernel) __per_cpu_offset[] array.  If this was a module
> variable, it would point to the module per_cpu_offset[] array which is
> created when the modules is loaded.

This sounds like you have an extra memory reference each time a
per-cpu variable is accessed.  Have you tried to measure the
performance impact of that?  If so, how much performance does it lose?

Paul.
