Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUCUWeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUCUWeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:34:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33959 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261405AbUCUWeP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:34:15 -0500
Message-ID: <405E1859.5030906@pobox.com>
Date: Sun, 21 Mar 2004 17:34:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
References: <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320121345.2a80e6a0.akpm@osdl.org> <20040320205053.GJ2045@holomorphy.com> <20040320222639.K6726@flint.arm.linux.org.uk> <20040320224500.GP2045@holomorphy.com> <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk>
In-Reply-To: <20040321222327.D26708@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> What about the case where the buffer is scatter-gather in nature,
> just like we're so fond of telling driver writers who want to grab
> (eg) 1MB of contiguous kernel memory for video buffers and the like?
> Do we really want to tell driver writers to walk over 1MB of pages,
> page by page, inserting them into the processes page tables via
> remap_area_pages()?

Tell driver writers to call a standard platform function with a 
{dma|mmio|pio|vmalloc} handle+size+len for {dma|mmio|pio|vmalloc} mmap 
setup, and {fault|nopage} handler.  ;-)  IMO they shouldn't have to care 
about the details.

	Jeff



