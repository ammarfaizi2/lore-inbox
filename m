Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVANBlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVANBlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVANBhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:37:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52673 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261778AbVANBf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:35:28 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] Convert resource to u64 from unsigned long
Date: Thu, 13 Jan 2005 17:35:04 -0800
User-Agent: KMail/1.7.1
Cc: Dave <dave.jiang@gmail.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, smaurer@teja.com, linux@arm.linux.org.uk,
       dsaxena@plexity.net, drew.moseley@intel.com,
       mporter@kernel.crashing.org
References: <8746466a050113152636f49d18@mail.gmail.com> <20050113162309.2a125eb1.akpm@osdl.org>
In-Reply-To: <20050113162309.2a125eb1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131735.04592.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 13, 2005 4:23 pm, Andrew Morton wrote:
> +#if BITS_PER_LONG == 64
>  return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> +#else
> + return (void __iomem *)(u32)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> +#endif

I just noticed that the PCI rom code also appears to be mixing other types, 
e.g. it delcares start as loff_t and stuffs a pci_resource_start into it, 
then uses it as the first argument to ioremap.

Jesse
