Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUCUWvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUCUWvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:51:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57105 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261440AbUCUWv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:51:27 -0500
Date: Sun, 21 Mar 2004 22:51:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040321225117.F26708@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040320121345.2a80e6a0.akpm@osdl.org> <20040320205053.GJ2045@holomorphy.com> <20040320222639.K6726@flint.arm.linux.org.uk> <20040320224500.GP2045@holomorphy.com> <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <405E1859.5030906@pobox.com>; from jgarzik@pobox.com on Sun, Mar 21, 2004 at 05:34:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 05:34:01PM -0500, Jeff Garzik wrote:
> Russell King wrote:
> > What about the case where the buffer is scatter-gather in nature,
> > just like we're so fond of telling driver writers who want to grab
> > (eg) 1MB of contiguous kernel memory for video buffers and the like?
> > Do we really want to tell driver writers to walk over 1MB of pages,
> > page by page, inserting them into the processes page tables via
> > remap_area_pages()?
> 
> Tell driver writers to call a standard platform function with a 
> {dma|mmio|pio|vmalloc} handle+size+len for {dma|mmio|pio|vmalloc} mmap 
> setup, and {fault|nopage} handler.  ;-)  IMO they shouldn't have to care 
> about the details.

I don't think this addresses the scatter-gather case I mentioned above.
Or if we are, we've rewritten ALSA before hand to use Linux scatterlists
along side several dma_alloc_coherent mappings and have the ability to
mmap these as well.

Remember that we're fond of telling driver writers to use scatter gather
lists rather than grabbing one large contiguous memory chunk...  So
they did exactly as we told them.  Using pci_alloc_consistent and/or
dma_alloc_coherent and built their own scatter lists.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
