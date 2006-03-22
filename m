Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWCVSiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWCVSiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWCVSiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:38:12 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:61568 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750774AbWCVSiK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:38:10 -0500
Date: Wed, 22 Mar 2006 10:38:22 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 31/35] Add Xen grant table support
Message-ID: <20060322183822.GY15997@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063806.220039000@sorel.sous-sol.org> <1143017114.2955.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143017114.2955.27.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjan@infradead.org) wrote:
> 
> > + * This file may be distributed separately from the Linux kernel, or
> > + * incorporated into other software packages, subject to the following license:
> 
> please again fix the license

*nod*

> > +EXPORT_SYMBOL(gnttab_grant_foreign_access);
> > +EXPORT_SYMBOL(gnttab_end_foreign_access_ref);
> > +EXPORT_SYMBOL(gnttab_end_foreign_access);
> > +EXPORT_SYMBOL(gnttab_query_foreign_access);
> > +EXPORT_SYMBOL(gnttab_grant_foreign_transfer);
> > +EXPORT_SYMBOL(gnttab_end_foreign_transfer_ref);
> > +EXPORT_SYMBOL(gnttab_end_foreign_transfer);
> > +EXPORT_SYMBOL(gnttab_alloc_grant_references);
> > +EXPORT_SYMBOL(gnttab_free_grant_references);
> > +EXPORT_SYMBOL(gnttab_free_grant_reference);
> > +EXPORT_SYMBOL(gnttab_claim_grant_reference);
> > +EXPORT_SYMBOL(gnttab_release_grant_reference);
> > +EXPORT_SYMBOL(gnttab_request_free_callback);
> > +EXPORT_SYMBOL(gnttab_grant_foreign_access_ref);
> > +EXPORT_SYMBOL(gnttab_grant_foreign_transfer_ref);
> 
> and consider these as _GPL exports

Yes, I meant to note that as one of the known issues.  License clarity
and _GPL exports.

> > +#ifndef __ia64__
> > +static int map_pte_fn(pte_t *pte, struct page *pte_page,
> > +		      unsigned long addr, void *data)
> > +{
> > +	unsigned long **frames = (unsigned long **)data;
> > +
> > +	set_pte_at(&init_mm, addr, pte, pfn_pte((*frames)[0], PAGE_KERNEL));
> > +	(*frames)++;
> > +	return 0;
> > +}
> 
> looks to me the wrong ifdef for a file in arch/i386... please fix

Yes, the reuse of grant table amongst each Xen supported architecture
suggests it's in the wrong location.

thanks,
-chris
