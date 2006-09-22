Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWIVVCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWIVVCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 17:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWIVVCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 17:02:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52102 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965038AbWIVVCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:02:12 -0400
Date: Fri, 22 Sep 2006 14:01:48 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Jesse Barnes <jesse.barnes@intel.com>
cc: Martin Bligh <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@google.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
In-Reply-To: <200609221341.44354.jesse.barnes@intel.com>
Message-ID: <Pine.LNX.4.64.0609221400230.9370@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com>
 <4514441E.70207@mbligh.org> <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com>
 <200609221341.44354.jesse.barnes@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Jesse Barnes wrote:

> > +	if (dev->coherent_dma_mask < 0xffffffff)
> > +		high = dev->coherent_dma_mask;
> 
> With your alloc_pages_range this check can go away.  I think only the dev 
> == NULL check is needed with this scheme since it looks like there's no 
> way (currently) for ISA devices to store their masks for later 
> consultation by arch code? 

This check is necessary to set up the correct high boundary for 
alloc_page_range.

> > +	if (high == -1L && low == 0L)
> > +		return alloc_pages(gfp_flags, order);
> 
> There's max_pfn, but on machines with large memory holes using it might not 
> help much.

I found node_start_pfn and node_spanned_pages in the node structure. That 
gives me the boundaries for a node and I think I can work with that.
 
