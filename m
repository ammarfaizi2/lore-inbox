Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUI0SGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUI0SGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUI0SGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:06:33 -0400
Received: from fmr04.intel.com ([143.183.121.6]:41879 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266884AbUI0SEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:04:09 -0400
Date: Mon, 27 Sep 2004 11:03:51 -0700
From: Suresh Siddha <suresh.b.siddha@intel.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, asit.k.mallick@intel.com,
       Andi Kleen <ak@suse.de>
Subject: Re: [Patch 0/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525
Message-ID: <20040927110350.C18131@unix-os.sc.intel.com>
References: <20040923233410.A19555@unix-os.sc.intel.com> <Pine.LNX.4.53.0409241805020.2791@musoma.fsmlabs.com> <4154828F.6090205@pobox.com> <20040924152026.A25742@unix-os.sc.intel.com> <Pine.LNX.4.53.0409251206120.2914@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0409251206120.2914@musoma.fsmlabs.com>; from zwane@linuxpower.ca on Sat, Sep 25, 2004 at 12:15:27PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane,

As far as irq_affinity is concerned, workaround fits nicely in quirks.c
infrastructure.

x86 irqbalance is the one which is causing the pain. Workaround will be more
cleaner if we can move balanced_irq_init() to late_initcall.

If there is no objection, I can post a new patch with that change.

thanks,
suresh

On Sat, Sep 25, 2004 at 12:15:27PM +0300, Zwane Mwaikambo wrote:
> On Fri, 24 Sep 2004, Suresh Siddha wrote:
> > +#ifdef CONFIG_X86_IO_APIC
> > +#include <asm/hw_irq.h>
> > +#ifdef CONFIG_IRQBALANCE
> > +extern int irqbalance_disable(char *str);
> > +#endif
> > +extern int no_irq_affinity;
> > +extern int noirqdebug_setup(char *str);
> 
> Ok this is sort of ugly, but it's not your fault, i understand that the
> PCI quirks code is too late after IOAPIC setup, x86_64 has some early PCI
> bridge detection code which helps in doing IOAPIC quirks.
> 
> > +void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
> 
> This may as well be moved elsewhere since it's not actually going to be 
> used in PCI quirks. I think you should just do the chipset detection in 
> io_apic.c and then do the disable from there, it's racy and strange 
> (although it may seem natural) to do it in quirks.c
