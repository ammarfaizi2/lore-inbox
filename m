Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVANBJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVANBJF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVANBIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:08:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11789 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261754AbVANAxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:53:02 -0500
Date: Fri, 14 Jan 2005 00:52:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave <dave.jiang@gmail.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, smaurer@teja.com, linux@arm.linux.org.uk,
       dsaxena@plexity.net, drew.moseley@intel.com,
       mporter@kernel.crashing.org
Subject: Re: [PATCH 1/5] Convert resource to u64 from unsigned long
Message-ID: <20050114005253.A22530@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Dave <dave.jiang@gmail.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, smaurer@teja.com,
	linux@arm.linux.org.uk, dsaxena@plexity.net, drew.moseley@intel.com,
	mporter@kernel.crashing.org
References: <8746466a050113152636f49d18@mail.gmail.com> <20050113162309.2a125eb1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050113162309.2a125eb1.akpm@osdl.org>; from akpm@osdl.org on Thu, Jan 13, 2005 at 04:23:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 04:23:09PM -0800, Andrew Morton wrote:
> Also, the patches introduce tons of ifdefs such as:
> 
> +#if BITS_PER_LONG == 64			
> 	return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> +#else
> +	return (void __iomem *)(u32)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> +#endif

That looks rather illegal to me.  What says that ROM resources are
in a different memory space to MMIO resources?  PCI internally treats
them the same as MMIO, and as such they certainly require ioremapping
on ARM.

Just because x86 has a broken architecture with respect to having
holes in its memory map does not mean that's suitable for the rest
of the world.

ISTR x86 ioremap knows about this, so maybe the solution to the above
is to do it the Right Way(tm) and use ioremap() ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
