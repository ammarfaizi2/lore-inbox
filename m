Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVG1OhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVG1OhI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVG1OTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:19:04 -0400
Received: from xenotime.net ([66.160.160.81]:49866 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S261492AbVG1OS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:18:56 -0400
Date: Thu, 28 Jul 2005 07:18:50 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
Cc: gregkh@suse.de, rolandd@cisco.com, mst@mellanox.co.il,
       linux-pci@atrey.karlin.mff.cuni.cz, openib-general@openib.org,
       linux-kernel@vger.kernel.org, mj@ucw.cz, ian.pratt@cl.cam.ac.uk
Subject: Re: [openib-general] Re: [PATCH] arch/xx/pci: remap_pfn_range ->
 io_remap_pfn_range
Message-Id: <20050728071850.6bed3966.rdunlap@xenotime.net>
In-Reply-To: <A95E2296287EAD4EB592B5DEEFCE0E9D282808@liverpoolst.ad.cl.cam.ac.uk>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D282808@liverpoolst.ad.cl.cam.ac.uk>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005 12:57:51 +0100 Ian Pratt wrote:

> > >     Greg> Hm, you do realize that io_remap_pfn_range() is the same
> > >     Greg> thing as remap_pfn_range() on i386, right?
> > > 
> > >     Greg> So, why would this patch change anything?
> > > 
> > > It's not the same thing under Xen.  I think this patch 
> > fixes userspace 
> > > access to PCI memory for XenLinux.
> > 
> > But Xen is a separate arch, and hence, will get different pci 
> > arch specific functions, right?
> > 
> > In short, what is this patch trying to fix?  What is the 
> > problem anyone is seeing with the existing code?
> 
> As I understand it, remap_pfn_range should be used for mapping pages
> that are backed by memory, and io_remap_pfn_range should be used for
> mapping MMIO regions.
> There's a distinciton between the two for architectures like Sparc and
> xen/x86. 
> 
> For example, drivers/char/mem.c uses io_remap_pfn_range for mmap'ing
> /dev/mem

That is my (limited) understanding also, but when I built
io_remap_pfn_range(), I didn't search all callers of
remap_pfn_range() to see which ones that I could fix (or break)
by changing them.  Mostly due to the possible breakage part.

---
~Randy
