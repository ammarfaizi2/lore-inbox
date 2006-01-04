Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWADAUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWADAUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWADAUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:20:49 -0500
Received: from palrel10.hp.com ([156.153.255.245]:12728 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S964893AbWADAUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:20:48 -0500
Date: Tue, 3 Jan 2006 16:20:47 -0800
From: Grant Grundler <iod00d@hp.com>
To: Mark Maule <maule@sgi.com>
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>, gregkh@suse.de
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
Message-ID: <20060104002047.GA14810@esmail.cup.hp.com>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222201657.2019.69251.48815@lnx-maule.americas.sgi.com> <20060103223918.GB13841@esmail.cup.hp.com> <20060103235024.GC16827@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103235024.GC16827@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 05:50:24PM -0600, Mark Maule wrote:
> > > +struct msi_ops msi_apic_ops = {
> > > +	.setup = msi_setup_apic,
> > > +	.teardown = msi_teardown_apic,
> > > +#ifdef CONFIG_SMP
> > > +	.target = msi_target_apic,
> > > +#endif
> > 
> > Mark,
> > msi_target_apic() initializes address_lo parameter.
> > Even on a UP machine, we need inialize this value.
> 
> Not sure what you mean here.  target is used to retarget an existing
> MSI vector to a different processor.

Right - I didn't realize the caller, set_msi_affinity(), was surrounded by
"#ifdef CONFIG_SMP".

But set_msi_affinity() appears to be dead code.
I couldn't find any calls to set_msi_affinity() in 2.6.14 or 2.6.15.
Greg, you want a patch to remove that?

thanks,
grant
