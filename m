Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVANBFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVANBFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVANAwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:52:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50048 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261752AbVANAwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:52:30 -0500
Date: Fri, 14 Jan 2005 00:52:17 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave <dave.jiang@gmail.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, smaurer@teja.com, linux@arm.linux.org.uk,
       dsaxena@plexity.net, drew.moseley@intel.com,
       mporter@kernel.crashing.org
Subject: Re: [PATCH 1/5] Convert resource to u64 from unsigned long
Message-ID: <20050114005216.GM26051@parcelfarce.linux.theplanet.co.uk>
References: <8746466a050113152636f49d18@mail.gmail.com> <20050113162309.2a125eb1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113162309.2a125eb1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 04:23:09PM -0800, Andrew Morton wrote:
> +#if BITS_PER_LONG == 64			
> 	return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> +#else
> +	return (void __iomem *)(u32)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> +#endif
> 
> We really should find a way of avoiding this.  Even if it is
> 
> #if BITS_PER_LONG == 64
> #define resource_to_ptr(r) ((void *)(r))
> #else
> #define resource_to_ptr(r) ((void *)((u32)r))
> #endif
> 
> in a header file somewhere.  Open-coding the decision all over the place is
> unsightly.

This is wrong anyway - ioremap() on these will give you __iomem pointers,
but cast like that looks very bogus.
