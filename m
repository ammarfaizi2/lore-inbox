Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUCVAaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUCVAaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:30:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60074 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261554AbUCVAaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:30:15 -0500
Message-ID: <405E3387.1050505@pobox.com>
Date: Sun, 21 Mar 2004 19:29:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: rmk@arm.linux.org.uk, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
References: <20040320224500.GP2045@holomorphy.com> <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <20040321234515.G26708@flint.arm.linux.org.uk> <20040322002349.GZ2045@holomorphy.com>
In-Reply-To: <20040322002349.GZ2045@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> int dma_mmap_coherent_sg(struct dma_scatterlist *sglist,
>                         int nr_sglist_elements,     /* length of sglist */
>                         struct vm_area_struct *vma, /* for address space */
>                         unsigned long address,      /* user virtual address */
>                         unsigned long offset,       /* offset (in pages) */
>                         unsigned long nr_pages);    /* length (in pages) */
> 
> int dma_munmap_coherent_sg(struct dma_scatterlist *sglist,
>                         int nr_sglist_elements,     /* length of sglist */
>                         struct vm_area_struct *vma, /* for address space */
>                         unsigned long address,      /* user virtual address */
>                         unsigned long offset,       /* offset (in pages) */
>                         unsigned long nr_pages);    /* length (in pages) */
> 
> int dma_alloc_coherent_sg(struct dma_scatterlist **sglist,
>                         unsigned long length);      /* length in pages */
> 
> int dma_free_coherent_sg(struct dma_scatterlist **sglist,
>                         unsigned long length);      /* length in pages */

No comment on struct dma_scatterlist, but the above is the most natural 
API for audio drivers at least.

Audio drivers allocate buffers at ->probe() or open(2), and the only 
entity that actually cares about the contents of the buffers are (a) the 
hardware and (b) userland.  via82cxxx_audio only uses 
pci_alloc_consistent because there's not a more appropriate DMA 
allocator for the use to which that memory is put.

Audio drivers only need to read/write the buffers inside the kernel when 
implementing read(2) and write(2) via copy_{to,from}_user().

	Jeff



