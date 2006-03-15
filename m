Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752053AbWCOADU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbWCOADU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 19:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbWCOADT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 19:03:19 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:19145 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752053AbWCOADT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 19:03:19 -0500
Date: Tue, 14 Mar 2006 18:06:21 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Andi Kleen <ak@suse.de>, Muli Ben-Yehuda <MULI@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH 3/3] x86-64: Calgary IOMMU - hook it in
Message-ID: <20060315000621.GC7699@us.ibm.com>
References: <20060314082432.GE23631@granada.merseine.nu> <20060314082552.GF23631@granada.merseine.nu> <20060314082634.GG23631@granada.merseine.nu> <20060314230348.GC1579@elf.ucw.cz> <20060314232247.GB7699@us.ibm.com> <20060314232612.GC1785@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314232612.GC1785@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 12:26:12AM +0100, Pavel Machek wrote:
> On ?t 14-03-06 17:22:48, Jon Mason wrote:
> > On Wed, Mar 15, 2006 at 12:03:48AM +0100, Pavel Machek wrote:
> > > On ?t 14-03-06 10:26:34, Muli Ben-Yehuda wrote:
> > > > This patch hooks Calgary into the build and the x86-64 IOMMU
> > > > initialization paths.
> > > > 
> > > > Signed-Off-By: Muli Ben-Yehuda <mulix@mulix.org>
> > > > Signed-Off-By: Jon Mason <jdmason@us.ibm.com>
> > > > 
> > > > diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/arch/x86_64/Kconfig linux/arch/x86_64/Kconfig
> > > > --- iommu_detected/arch/x86_64/Kconfig	2006-03-14 08:58:23.000000000 +0200
> > > > +++ linux/arch/x86_64/Kconfig	2006-03-12 10:49:04.000000000 +0200
> > > > @@ -372,6 +372,16 @@ config GART_IOMMU
> > > >  	  and a software emulation used on other systems.
> > > >  	  If unsure, say Y.
> > > >  
> > > > +config CALGARY_IOMMU
> > > > +	bool "IBM x366 server IOMMU"
> > > > +	default y
> > > > +	depends on PCI && MPSC && EXPERIMENTAL
> > > > +	help
> > > > +	  Support for hardware IOMMUs in IBM's x366 server
> > > > +	  systems. The IOMMU can be turned off at runtime with the
> > > > +	  iommu=off parameter. Normally the kernel will make the right
> > > 
> > > Runtime? I think you meant boottime.
> > 
> > Yes, thanks for pointing it out.
> > 
> > > 
> > > > +	  choice by itself.  If unsure, say Y.
> > > 
> > > Eh? How common are those machines?
> > 
> > While this code is specific to IBM's xSeries systems, it will not hurt
> > to have it enabled on other systems.  The code is intelligent enough to 
> > detect the existence of Calgary chips and, if not there, will go down 
> > the standard path of no-iommu (providing that swiotlb has not been
> > specified at boottime).  If this isn't clear enough in the description,
> > I can remedy that.
> 
> No, it was pretty clear. But unless these machines are pretty common,
> I'd suggest users to say N. ... its like most drivers, it takes space
> but no other harm. Still we don't want to say "say Y" on all drivers.

Ah, I understand your point now.  I'll fixup the comment and default value.

> ...it is not required for boot on IBM x366 machines, is it?

No, it is not.

Thanks,
Jon

> 								Pavel
> 
> -- 
> 56:        MD5.TransformBlock( adNAME, 0, strName.IndexOf( '\0' ), adNAME, 0 );
