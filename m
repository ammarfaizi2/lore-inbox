Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267833AbUG3Udu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267833AbUG3Udu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUG3Udu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:33:50 -0400
Received: from adsl-64-109-89-108.dsl.chcgil.ameritech.net ([64.109.89.108]:19859
	"EHLO redscar") by vger.kernel.org with ESMTP id S267833AbUG3U21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:28:27 -0400
Subject: Re: [PATCH] Improve pci_alloc_consistent wrapper on preemptive
	kernels
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040730132016.5906caa7.akpm@osdl.org>
References: <20040730190227.29913e23.ak@suse.de>
	<20040730130238.0f68f5e7.akpm@osdl.org> <1091218419.1968.46.camel@mulgrave>
	 <20040730132016.5906caa7.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Jul 2004 16:28:26 -0400
Message-Id: <1091219306.1727.49.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 16:20, Andrew Morton wrote:
> Sounds sane.  But the default version in asm-generic/dma-mapping.h needs to
> be fixed up:
> 
> static inline void *
> dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
> 		   int flag)
> {
> 	BUG_ON(dev->bus != &pci_bus_type);
> 
> 	return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
> }
> 
> If we stick with this model, we'll still need a new pci_alloc_consistent_gfp().

Theoretically, that was just to help architectures that didn't want to
implement the dma_ functions.  If we make dma_alloc_coherent() the
preferred implementation, we just remove this because now all arch's
will have to implement dma_alloc_coherent anyway.

James


