Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUCUUpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 15:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbUCUUpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 15:45:31 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:64919 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261238AbUCUUp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 15:45:29 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: David Woodhouse <dwmw2@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: rmk@arm.linux.org.uk, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20040320224500.GP2045@holomorphy.com>
References: <20040320133025.GH9009@dualathlon.random>
	 <20040320144022.GC2045@holomorphy.com>
	 <20040320150621.GO9009@dualathlon.random>
	 <20040320121345.2a80e6a0.akpm@osdl.org>
	 <20040320205053.GJ2045@holomorphy.com>
	 <20040320222639.K6726@flint.arm.linux.org.uk>
	 <20040320224500.GP2045@holomorphy.com>
Content-Type: text/plain
Message-Id: <1079901914.17681.317.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sun, 21 Mar 2004 20:45:14 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-20 at 14:45 -0800, William Lee Irwin III wrote:
> This is the exact opposite of what I'd hoped come of this discussion.
> ISTR something about remap_area_pages() missing several pieces, but
> I pretty much need some kind of clarification to know what. Well, that,
> and I presumed your fixups for ALSA were headed toward mainline
> regardless after coping with whatever issue dwmw2 had (e.g. returning
> pfn's or something).

My request was that we shouldn't assume an architecture will have a
'struct page' corresponding to whatever it chooses to return from
dma_alloc_coherent(). 

There are machines where DMA to/from main memory _cannot_ be coherent
but we have some memory elsewhere, perhaps some SRAM which itself is
hanging off an I/O bus somewhere, which can be used. One of my toys is
currently running with dma_alloc_coherent() giving out memory from a PCI
video card, in fact.

Using a PFN should be OK.

-- 
dwmw2


