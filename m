Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUJETKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUJETKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUJETKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:10:52 -0400
Received: from palrel13.hp.com ([156.153.255.238]:57024 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261875AbUJETKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:10:41 -0400
Date: Tue, 5 Oct 2004 12:10:08 -0700
From: Grant Grundler <iod00d@hp.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Message-ID: <20041005191008.GG18567@cup.hp.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C647@scsmsx401.amr.corp.intel.com> <200410050843.44265.jbarnes@engr.sgi.com> <20041005162201.GC18567@cup.hp.com> <20041005174558.GZ16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005174558.GZ16153@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 06:45:58PM +0100, Matthew Wilcox wrote:
> On Tue, Oct 05, 2004 at 09:22:01AM -0700, Grant Grundler wrote:
> > pci_root_ops should be static. It's only intended for ACPI.
> 
> What I had intended when I wrote this code was that platforms that didn't
> want to use the generic SAL code (and why not?  It doesn't seem like it
> should be the hardest thing in the world to move your hacks into SAL)
> was that people should override
> 
>   struct pci_raw_ops *raw_pci_ops = &pci_sal_ops;

ah ok.

> by just assigning raw_pci_ops in their own code.  I haven't looked at
> the SGI code yet, but this is how arch/i386/pci/direct.c (for example)
> works.
> 
> > Maybe rename pci_root_ops to "acpi_pci_ops" would make that clearer.
> 
> No.  Don't rename it to anything ACPI specific.  It isn't.

I understand raw_pci_ops is not ACPI specific.
But pci_root_ops is only used by pci_acpi_scan_root().

grundler@gsyprf3:/usr/src/linux-2.6.8.1$ fgrep pci_acpi_scan_root include/*/*
include/acpi/acpi_drivers.h:struct pci_bus *pci_acpi_scan_root(struct acpi_device *device, int domain, int bus);

and

./drivers/acpi/pci_root.c:      root->bus = pci_acpi_scan_root(device, root->id.segment, root->id.bus);

The rename still seems appropriate to me.

thanks,
grant
