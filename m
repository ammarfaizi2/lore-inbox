Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUCUXKO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUCUXKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:10:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44200 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261357AbUCUXKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:10:02 -0500
Message-ID: <405E20BC.9000702@pobox.com>
Date: Sun, 21 Mar 2004 18:09:48 -0500
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
References: <20040320121345.2a80e6a0.akpm@osdl.org> <20040320205053.GJ2045@holomorphy.com> <20040320222639.K6726@flint.arm.linux.org.uk> <20040320224500.GP2045@holomorphy.com> <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk>
In-Reply-To: <20040321225117.F26708@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> I don't think this addresses the scatter-gather case I mentioned above.
> Or if we are, we've rewritten ALSA before hand to use Linux scatterlists
> along side several dma_alloc_coherent mappings and have the ability to
> mmap these as well.
> 
> Remember that we're fond of telling driver writers to use scatter gather
> lists rather than grabbing one large contiguous memory chunk...  So
> they did exactly as we told them.  Using pci_alloc_consistent and/or
> dma_alloc_coherent and built their own scatter lists.

Agreed...  though IMO that can handled by considering DMA S/G as just 
one more set of helper functions that the driver writer should not have 
to implement ;)  dma_sg_setup_mmap() could function as a peer alongside 
dma_setup_mmap(), mmio_setup_mmap(), etc.  Providing such to driver 
writers gives them incentive to use S/G lists as well as incentive not 
to invent their own mmap(2) setup and handling code.

	Jeff



