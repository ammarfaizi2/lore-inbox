Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVEaQdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVEaQdP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVEaQ0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:26:07 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:61830 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261953AbVEaQUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:20:05 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 31 May 2005 18:13:45 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will __pa(vmalloc()) ever work?
Message-ID: <20050531161345.GB24106@bytesex>
References: <4297746C.10900@ammasso.com> <873bs5yrxj.fsf@bytesex.org> <429C87FF.5070003@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C87FF.5070003@ammasso.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 10:51:27AM -0500, Timur Tabi wrote:
> Gerd Knorr wrote:
> 
> >You should use vmalloc_to_page() (this does the page-table walking
> >with correct locking), then the usual dma mapping interface
> >(pci_map_page() or pci_map_sg()) to get bus address(es) you can pass
> >to your device for DMA.
> 
> My problem is that I don't know where the memory came from.

Can you fix that?  If so, try that.  Would be the best.

> It could have been allocated via kmalloc, or vmalloc, or
> anywhere else.  Can I call vmalloc_to_page() on memory
> allocated via kmalloc()?

I think you can't.  What is "anywhere else"?  Does that include
userspace addresses?

> If the answer is no, then how can I tell whether the memory
> was allocated via vmalloc() or some other method?

Not sure how portable that is, but comparing the vaddr against
the vmalloc address space could work.  There are macros for
that, VMALLOC_START & VMALLOC_END IIRC.

> I need a reliable virtual-to-physical (or virtual-to-bus,
> which is the same thing on x86 architectures)

Well, on !x86 architectures it isn't ...

  Gerd

-- 
-mm seems unusually stable at present.
	-- akpm about 2.6.12-rc3-mm3
