Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVGYBXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVGYBXu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 21:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVGYBXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 21:23:50 -0400
Received: from colo.lackof.org ([198.49.126.79]:27585 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261260AbVGYBXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 21:23:49 -0400
Date: Sun, 24 Jul 2005 19:28:40 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Grant Grundler <grundler@parisc-linux.org>, akpm@osdl.org, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcibios_bus_to_resource for parisc [Was: Re: [PATCH 8/8] pci and yenta: pcibios_bus_to_resource]
Message-ID: <20050725012840.GB18659@colo.lackof.org>
References: <20050711222138.GH30827@isilmar.linta.de> <20050718194216.GC11016@colo.lackof.org> <20050723195411.GC11065@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050723195411.GC11065@dominikbrodowski.de>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2005 at 09:54:11PM +0200, Dominik Brodowski wrote:
> Oh, yes, I seem to have missed it. Sorry. Does this patch look good?

Yes.

Acked-by: Grant Grundler <grundler@parisc-linux.org>

I'll commit this to the cvs.parisc-linux.org tree as well.
Willy can let me deal with the collision if it's not trivial
on his next merge.

thanks,
grant

> 
> 
> Add pcibios_bus_to_resource for parisc.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> Index: 2.6.13-rc3-git2/arch/parisc/kernel/pci.c
> ===================================================================
> --- 2.6.13-rc3-git2.orig/arch/parisc/kernel/pci.c
> +++ 2.6.13-rc3-git2/arch/parisc/kernel/pci.c
> @@ -255,8 +255,26 @@ void __devinit pcibios_resource_to_bus(s
>  	pcibios_link_hba_resources(&hba->lmmio_space, bus->resource[1]);
>  }
>  
> +void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
> +			      struct pci_bus_region *region)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	struct pci_hba_data *hba = HBA_DATA(bus->bridge->platform_data);
> +
> +	if (res->flags & IORESOURCE_MEM) {
> +		res->start = PCI_HOST_ADDR(hba, region->start);
> +		res->end = PCI_HOST_ADDR(hba, region->end);
> +	}
> +
> +	if (res->flags & IORESOURCE_IO) {
> +		res->start = region->start;
> +		res->end = region->end;
> +	}
> +}
> +
>  #ifdef CONFIG_HOTPLUG
>  EXPORT_SYMBOL(pcibios_resource_to_bus);
> +EXPORT_SYMBOL(pcibios_bus_to_resource);
>  #endif
>  
>  /*
