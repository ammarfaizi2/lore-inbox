Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWARPxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWARPxx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWARPxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:53:53 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:19072 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030362AbWARPxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:53:51 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Date: Wed, 18 Jan 2006 08:53:46 -0700
User-Agent: KMail/1.8.3
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-ia64@vger.kernel.org,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <200601171717.03192.bjorn.helgaas@hp.com> <200601180332.19692.ak@suse.de>
In-Reply-To: <200601180332.19692.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601180853.46290.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 19:32, Andi Kleen wrote:
> At least on x86-64/i386 the ioremap is actually cached unless a MTRR
> changes it, but it normally doesn't here. If one wants to force uncached
> access one has to use ioremap_uncached(). You're saying IA64 ioremap
> forces uncached access? That seems weird.

Right.  On ia64, ioremap() and ioremap_nocache() are the same.  You'd
have to ask David about the history behind this.

> > +	if (efi_enabled) {
> > +		if (efi_mem_attributes(base & EFI_MEMORY_WB)) {
> > +			iomem = 0;
> > +			buf = (u8 *) phys_to_virt(base);
> > +		} else if (efi_mem_attributes(base & EFI_MEMORY_UC))
> > +			buf = dmi_ioremap(base, len);
> > +		else
> > +			buf = NULL;
> 
> I would expect your ioremap to already do such a lookup. That is at least
> how MTRRs on i386/x86-64 work.  If it does not how about you fix
> ioremap()?

Yes, hiding this all inside ioremap() is probably a good idea.
It'll slow it down a lot, but I guess it's probably not used in
performance paths anyway.  Thanks for the advice.
