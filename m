Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWFGDrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWFGDrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWFGDrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:47:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:47491 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750798AbWFGDrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:47:18 -0400
Subject: Re: genirq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060606144242.GB29798@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <20060606144242.GB29798@elte.hu>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 13:46:32 +1000
Message-Id: <1149651993.27572.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  Still stabilising.  It's looking more like 2.6.19 material.  Needs 
> >  more review from arch maintainers too.
> 
> there hasnt been any real problem since the MSI one. The core bits are 
> rather stable. The patch-queue had positive input from the maintainers 
> of the two architectures with the most complex IRQ hardware (arm and 
> ppc*), and that's reassuring. But in any case, other architectures are 
> not affected at all (sans brow paperbag build bugs and typos), their 
> __do_IRQ() handling remains unchanged. So i'd like to see this in 
> 2.6.18. (there a good deal of stuff we have ontop of genirq)
> 
> (the irqpoll discussions are unrelated to genirq - they are fixes for an 
> irqpoll problem that the lock validator uncovered, and naturally those 
> patches were ontop of genirq.)


I vote for genirq inclusion in 2.6.18 too. I'm almost finishing porting
powerpc over to it and so far it looks good. In addition, I'm pretty
confident the patches have a very low impact (if at all) on archs that
haven't been ported over (the old mecanism is still there mostly
untouched). 

In addition, I'm doing some fairly heavy rework of some of the powerpc
irq management that is based on top of the genirq port and I'd really
want it in 2.6.18...

Finally, we are doing some crash-work on MSI (trying to get some basic
support for powerpc separate from the current unuseable
drivers/pci/msi.c) so we can at least get something working in 2.6.18
and that too will be based on my work mentioned above.

So as far as I'm concerned, genirq is pretty important to have in right
at the beginning.

Cheers,
Ben.


