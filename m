Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUJNMx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUJNMx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 08:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUJNMx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 08:53:56 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:51205 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264113AbUJNMxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 08:53:52 -0400
Date: Thu, 14 Oct 2004 13:53:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Introduce PCI <-> CPU address conversion [1/2]
Message-ID: <20041014125348.GA9633@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org
References: <20041014124737.GM16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014124737.GM16153@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define IS_MEMORY(l)	(((l) & PCI_BASE_ADDRESS_SPACE) == \
> +				PCI_BASE_ADDRESS_SPACE_MEMORY)
> +#define IS_64BIT(l)	(((l) & PCI_BASE_ADDRESS_MEM_TYPE_64) != 0)

Should got to pci.h with more descriptive names

>  /*
> + * Convert between the CPU's view of addresses on a PCI card and the PCI
> + * device's view of the same location.  The default implementation is a no-op
> + * as most architectures have the same addresses on the CPU and PCI busses.
> + */
> +
> +#ifndef pci_phys_to_bus
> +#define pci_phys_to_bus(busdev, addr, flags) (addr)
> +#define pci_bus_to_phys(busdev, addr, flags) (addr)
> +#endif

I'd rather have this declared in every architectures asm/ header, so it's
more explicit that it's an per-arch thing.  Also make it a static inline
so we get typechecking.

