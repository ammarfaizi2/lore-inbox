Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264572AbUEXWlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264572AbUEXWlv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUEXWlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:41:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:37280 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264572AbUEXWlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:41:49 -0400
Date: Mon, 24 May 2004 15:40:47 -0700
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       marcelo.tosatti@cyclades.com, dely.l.sy@intel.com,
       steven.carbonari@intel.com, sundarapandian.durairaj@intel.com
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
Message-ID: <20040524224047.GA7075@kroah.com>
References: <1ZuS0-1b4-15@gated-at.bofh.it> <1ZuS3-1b4-35@gated-at.bofh.it> <m3brkdcvp4.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3brkdcvp4.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll let the original authors of this patch answer the question as to
why they did not implement it in this manner.

Dely?

thanks,

greg k-h

On Tue, May 25, 2004 at 12:21:59AM +0200, Andi Kleen wrote:
> Greg KH <greg@kroah.com> writes:
> >  obj-y			+= pci-pc.o pci-irq.o
> > diff -Nru a/arch/x86_64/kernel/mmconfig.c b/arch/x86_64/kernel/mmconfig.c
> > --- /dev/null	Wed Dec 31 16:00:00 1969
> > +++ b/arch/x86_64/kernel/mmconfig.c	Mon May 24 13:52:10 2004
> 
> 
> > +static inline void pci_exp_set_dev_base(int bus, int devfn)
> > +{
> > +	u32 dev_base = pci_mmcfg_base_addr | (bus << 20) | (devfn << 12);
> > +	if (dev_base != mmcfg_last_accessed_device) {
> > +		mmcfg_last_accessed_device = dev_base;
> > +		set_fixmap(FIX_PCIE_MCFG, dev_base);
> > +	}
> 
> Please no dynamic fixmap crap on x86-64. Do it like 2.6 does  - ioremap()
> the complete mmconfig aperture once and just just reference it directly.
> 
> Then you can also get rid of the spinlocks in the actual access functions,
> since everything will be stateless.
> 
> -Andi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
