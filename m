Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUCUXWa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUCUXW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:22:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65192 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261380AbUCUXW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:22:27 -0500
Message-ID: <405E23A5.7080903@pobox.com>
Date: Sun, 21 Mar 2004 18:22:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
References: <20040320121345.2a80e6a0.akpm@osdl.org> <20040320205053.GJ2045@holomorphy.com> <20040320222639.K6726@flint.arm.linux.org.uk> <20040320224500.GP2045@holomorphy.com> <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In fact, on a lot of architectures (well, at least x86, and likely
> anything else that doesn't use any IOTLB and just allocates a chunk of
> physical memory), I think the "map_dma_coherent()" thing should basically
> just become a "remap_page_range()". Ie something like
> 
> 	#define map_dma_coherent(vma, vaddr, len) \
> 		remap_page_range(vma, vma->vm_start, __pa(vaddr), len, vma->vm_page_prot)
> 
> for the simple case.


That would be nice, though the reason I avoided remap_page_range() in 
via82cxxx_audio is that it discourages S/G.  Because remap_page_range() 
is easier and more portable, several drivers allocate one-big-area and 
then create an S/G list describing individual portions of that area.

I want to avoid that.  Most decent h/w is s/g these days.

	Jeff



