Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVD0S6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVD0S6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVD0S4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:56:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29714 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261958AbVD0Szr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:55:47 -0400
Date: Wed, 27 Apr 2005 19:55:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: returning non-ram via ->nopage, was Re: [patch] mspec driver for 2.6.12-rc2-mm3
Message-ID: <20050427195538.A964@flint.arm.linux.org.uk>
Mail-Followup-To: Jes Sorensen <jes@wildopensource.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <yq07jj8123j.fsf@jaguar.mkp.net> <20050413204335.GA17012@infradead.org> <yq08y3bys4e.fsf@jaguar.mkp.net> <20050424101615.GA22393@infradead.org> <yq03btftb9u.fsf@jaguar.mkp.net> <20050425144749.GA10093@infradead.org> <yq0ll75rxsl.fsf@jaguar.mkp.net> <426FB56B.5000006@pobox.com> <20050427155526.GA25921@infradead.org> <yq0hdhsrta1.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <yq0hdhsrta1.fsf@jaguar.mkp.net>; from jes@wildopensource.com on Wed, Apr 27, 2005 at 02:03:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 02:03:50PM -0400, Jes Sorensen wrote:
> >>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:
> 
> Christoph> On Wed, Apr 27, 2005 at 11:53:15AM -0400, Jeff Garzik
> Christoph> wrote:
> >> I don't see anything wrong with a ->nopage approach.
> >> 
> >> At Linus's suggestion, I used ->nopage in the implementation of
> >> sound/oss/via82cxxx_audio.c.
> 
> Christoph> The difference is that you return kernel memory (actually
> Christoph> pci_alloc_consistant memory that has it's own set of
> Christoph> problems), while this is memory not in mem_map, so he
> Christoph> allocates some regularly kernel memory too to have a struct
> Christoph> page and just leaks it
> 
> Are you suggesting then that we change do_no_page to handle this as a
> special return value then?

If you're looking to mmap dma memory, ARM already supports the API
which was discussed (although not properly imho) on linux-arch.
I previously posted a potential patch for x86, but it has the
problem that remap_pfn_range() will not work on such memory because
it isn't marked reserved.

In addition, if you're mmaping dma memory on x86 as is, you're
providing a potential security hole - the x86 DMA memory allocator
does not extend its zeroing to cover the entire last page of the
allocation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
