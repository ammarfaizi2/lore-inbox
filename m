Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbULUVpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbULUVpC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 16:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbULUVpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 16:45:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:16824 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261863AbULUVo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 16:44:58 -0500
Date: Tue, 21 Dec 2004 13:44:42 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, willy@debian.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] add legacy resources to sysfs
Message-ID: <20041221214442.GA10362@kroah.com>
References: <200412211247.44883.jbarnes@engr.sgi.com> <20041221212839.GF31261@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221212839.GF31261@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 09:28:39PM +0000, Matthew Wilcox wrote:
> > ===== arch/ia64/sn/pci/pci_dma.c 1.2 vs edited =====
> > +int sn_pci_get_legacy_mem(struct pci_bus *bus, unsigned long *addr)
> > +{
> > +	if (!SN_PCIBUS_BUSSOFT(bus))
> > +		return -ENODEV;
> > +
> > +	*addr = SN_PCIBUS_BUSSOFT(bus)->bs_legacy_mem | __IA64_UNCACHED_OFFSET;
> > +
> > +	return 0;
> > +}
> 
> int sn_pci_get_legacy_mem(struct pci_bus *bus)
> {
> 	if (!SN_PCIBUS_BUSSOFT(bus))
> 		return ERR_PTR(-ENODEV);

Huh?  A pointer doesn't fit into an int on all arches.  I think the
original was correct.

thanks,

greg k-h
