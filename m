Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVANAo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVANAo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVANAoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:44:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:4534 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261836AbVANAoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:44:05 -0500
Date: Thu, 13 Jan 2005 16:43:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Dave <dave.jiang@gmail.com>, linux-kernel@vger.kernel.org,
       smaurer@teja.com, linux@arm.linux.org.uk, dsaxena@plexity.net,
       drew.moseley@intel.com, mporter@kernel.crashing.org
Subject: Re: [PATCH 1/5] Convert resource to u64 from unsigned long
In-Reply-To: <20050113162309.2a125eb1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0501131641390.2310@ppc970.osdl.org>
References: <8746466a050113152636f49d18@mail.gmail.com>
 <20050113162309.2a125eb1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Andrew Morton wrote:
> 
> Also, the patches introduce tons of ifdefs such as:
> 
> +#if BITS_PER_LONG == 64			
> 	return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> +#else
> +	return (void __iomem *)(u32)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> +#endif

Ouch. Who does that, anyway? It's wrong to do that. It's not a pointer, 
not even an __iomem one. You'd need to do an ioremap() on it to turn it 
into a pointer.

		Linus
