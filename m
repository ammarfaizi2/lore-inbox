Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbWADDwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbWADDwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 22:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWADDwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 22:52:38 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:65159 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965185AbWADDwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 22:52:37 -0500
Date: Tue, 3 Jan 2006 21:52:16 -0600
From: Mark Maule <maule@sgi.com>
To: Greg KH <gregkh@suse.de>
Cc: Grant Grundler <iod00d@hp.com>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
Message-ID: <20060104035216.GD16827@sgi.com>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222201657.2019.69251.48815@lnx-maule.americas.sgi.com> <20060103223918.GB13841@esmail.cup.hp.com> <20060103235024.GC16827@sgi.com> <20060104002047.GA14810@esmail.cup.hp.com> <20060104002737.GA18963@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104002737.GA18963@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 04:27:38PM -0800, Greg KH wrote:
> On Tue, Jan 03, 2006 at 04:20:47PM -0800, Grant Grundler wrote:
> > On Tue, Jan 03, 2006 at 05:50:24PM -0600, Mark Maule wrote:
> > > > > +struct msi_ops msi_apic_ops = {
> > > > > +	.setup = msi_setup_apic,
> > > > > +	.teardown = msi_teardown_apic,
> > > > > +#ifdef CONFIG_SMP
> > > > > +	.target = msi_target_apic,
> > > > > +#endif
> > > > 
> > > > Mark,
> > > > msi_target_apic() initializes address_lo parameter.
> > > > Even on a UP machine, we need inialize this value.
> > > 
> > > Not sure what you mean here.  target is used to retarget an existing
> > > MSI vector to a different processor.
> > 
> > Right - I didn't realize the caller, set_msi_affinity(), was surrounded by
> > "#ifdef CONFIG_SMP".
> > 
> > But set_msi_affinity() appears to be dead code.
> > I couldn't find any calls to set_msi_affinity() in 2.6.14 or 2.6.15.
> > Greg, you want a patch to remove that?
> 
> Yes please, that would be great to have.
> 
> thanks,
> 
> greg k-h

Is that really dead code?  From msi.h:

#ifdef CONFIG_SMP
#define set_msi_irq_affinity    set_msi_affinity
#else
#define set_msi_irq_affinity    NULL
#endif

Mark
