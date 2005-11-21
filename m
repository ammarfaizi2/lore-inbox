Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVKUKMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVKUKMA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 05:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVKUKL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 05:11:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25874 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932253AbVKUKL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 05:11:58 -0500
Date: Mon, 21 Nov 2005 10:11:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: (no subject)
Message-ID: <20051121101144.GA12167@flint.arm.linux.org.uk>
Mail-Followup-To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
	Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
	bunk@stusta.de, linux-kernel@vger.kernel.org
References: <437DFBB3.mailLJC11TKEB@suse.de> <31100cb5abcb16617981e6923dd165d0@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31100cb5abcb16617981e6923dd165d0@cl.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 10:06:03AM +0000, Keir Fraser wrote:
> On 18 Nov 2005, at 16:05, Andi Kleen wrote:
> >I don't think you can do that. We still need these functions in low
> >level architecture code at least.
> >
> >Using __pa/__va doesn't cut it because it won't work on Xen guests
> >which have different views on bus vs physical addresses. The Xen
> >code is (hopefully) in the process of being merged, so intentionally
> >breaking them isn't a good idea.
> >
> >So if anything there would need to be replacement functions for it
> >first that do the same thing. But why not just keep the old ones?
> 
> We could make use of virt_to_machine/machine_to_virt instead, which 
> arguably better describe the intent of those functions. Currently we 
> only use virt_to_bus/bus_to_virt in our swiotlb implementation, and our 
> modified dma_map code. In those files I think the existing function 
> names make some sense, but we can easily change if that's preferred.

If you're thinking of replacing bus_to_virt/virt_to_bus, you might want
to think about virt_to_dma(dev, virt) and dma_to_virt(dev, dma) as a
replacement, where "dev" is the device actually performing the DMA
(which obviously may not be the device asking for the mapping to be set
up.)  ARM already has these for use in the architecture code.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
