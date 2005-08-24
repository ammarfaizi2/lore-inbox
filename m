Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVHXQay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVHXQay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVHXQay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:30:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:5082 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751137AbVHXQax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:30:53 -0400
Date: Wed, 24 Aug 2005 11:29:59 -0500
To: John Rose <johnrose@austin.ibm.com>
Cc: paulus@samba.org, benh@kernel.crashing.org, akpm@osdl.org,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
Message-ID: <20050824162959.GC25174@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com> <1124898331.24668.33.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124898331.24668.33.camel@sinatra.austin.ibm.com>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 10:45:31AM -0500, John Rose was heard to remark:
> > +++ linux-2.6.13-rc6-git9/arch/ppc64/kernel/eeh_driver.c	2005-08-23 14:34:44.000000000 -0500
> > +/*
> > + * PCI Hot Plug Controller Driver for RPA-compliant PPC64 platform.
> 
> This probably isn't the right header description for this file :)

Yes, this file is a little ball of ugliness that resulted from moving
things out of the rpaphp directory; and, yes, it's rather
un-reconstructed. I released it under the "release early" program.

The meta-issue that I'd like to reach consensus on first is whether
there should be any hot-plug recovery attempted at all.  Removing
hot-plug-recovery support will make many of the issues you raise 
to be moot.

> > +++ linux-2.6.13-rc6-git9/include/asm-ppc64/prom.h	2005-08-23 13:31:52.000000000 -0500
> >  	int	busno;			/* for pci devices */
> >  	int	bussubno;		/* for pci devices */
> >  	int	devfn;			/* for pci devices */
> 
> How about a pointer to a struct of EEH fields?  Folks are touchy about
> adding anything PCI-specific to device nodes, especially since most DNs
> aren't PCI at all.

I attempted to remove all of the pci-related stuff from this struct,
and got a crash in very very early boot (before the transition from
real to virtual addressing). Not sure why, I was surprised.  It seems 
related to the flattening of the device ndode tree. I'll try again 
soon.

--linas
