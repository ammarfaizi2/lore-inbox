Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422995AbWCXDYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422995AbWCXDYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 22:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422996AbWCXDYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 22:24:16 -0500
Received: from mtaout1.012.net.il ([84.95.2.1]:45902 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S1422995AbWCXDYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 22:24:15 -0500
Date: Fri, 24 Mar 2006 05:23:39 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH 3/3] x86-64: Calgary IOMMU - hook it in
In-reply-to: <200603231736.44223.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Message-id: <20060324032339.GC2598@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060320084848.GA21729@granada.merseine.nu>
 <20060320085416.GB21729@granada.merseine.nu>
 <20060320085641.GC21729@granada.merseine.nu> <200603231736.44223.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 05:36:43PM +0100, Andi Kleen wrote:

> > +static int __init pci_iommu_init(void)
> > +{
> > +	int rc = 0;
> > +
> > +#ifdef CONFIG_GART_IOMMU
> > +	rc = gart_iommu_init();
> > +	if (!rc) /* success? */
> > +		return 0;
> > +#endif
> > +#ifdef CONFIG_CALGARY_IOMMU
> > +	rc = calgary_iommu_init();
> > +#endif
> 
> This is weird. Normally I would expect you to detect the calgary thing first
> and only then run the gart_iommu detection if not found. Why this
> order?

Seniority? :-) these are mutually exclusive, really, so we didn't
consider it important which runs "first".

> Fixing that would also not require adding the additional hacks to gart iommu
> you added.

We'll still need it at least to stop swiotlb from kicking in in
pci_swiotlb_init if we detected either gart or Calgary.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

