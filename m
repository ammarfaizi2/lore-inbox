Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267161AbSLEAkS>; Wed, 4 Dec 2002 19:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbSLEAkS>; Wed, 4 Dec 2002 19:40:18 -0500
Received: from dp.samba.org ([66.70.73.150]:58828 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267161AbSLEAkR>;
	Wed, 4 Dec 2002 19:40:17 -0500
Date: Thu, 5 Dec 2002 11:47:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205004744.GB2741@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org
References: <200212041747.gB4HlEF03005@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212041747.gB4HlEF03005@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 11:47:14AM -0600, James Bottomley wrote:
> Currently our only DMA API is highly PCI specific (making any non-pci bus with 
> a DMA controller create fake PCI devices to help it function).
> 
> Now that we have the generic device model, it should be equally possible to 
> rephrase the entire API for generic devices instead of pci_devs.
> 
> This patch does just that (for x86---although I also have working code for 
> parisc, that's where I actually tested the DMA capability).
> 
> The API is substantially the same as the PCI DMA one, with one important 
> exception with regard to consistent memory:
> 
> The PCI api has pci_alloc_consistent which allocates only consistent memory 
> and fails the allocation if none is available thus leading to driver writers 
> who might need to function with inconsistent memory to detect this and employ 
> a fallback strategy.
> 
> The new DMA API allows a driver to advertise its level of consistent memory 
> compliance to dma_alloc_consistent.  There are essentially two levels:
> 
> - I only work with consistent memory, fail if I cannot get it, or
> - I can work with inconsistent memory, try consistent first but return 
> inconsistent if it's not available.

Do you have an example of where the second option is useful?  Off hand
the only places I can think of where you'd use a consistent_alloc()
rather than map_single() and friends is in cases where the hardware's
behaviour means you absolutely positively have to have consistent
memory.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
