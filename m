Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVAOAgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVAOAgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVAOAgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:36:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37091 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262057AbVAOAgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:36:31 -0500
Date: Fri, 14 Jan 2005 19:42:18 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Avoiding fragmentation through different allocator
Message-ID: <20050114214218.GB3336@logos.cnet>
References: <Pine.LNX.4.58.0501122101420.13738@skynet> <20050113073146.GB1226@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113073146.GB1226@holomorphy.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 11:31:46PM -0800, William Lee Irwin III wrote:
> On Wed, Jan 12, 2005 at 09:09:24PM +0000, Mel Gorman wrote:
> > So... What the patch does. Allocations are divided up into three different
> > types of allocations;
> > UserReclaimable - These are userspace pages that are easily reclaimable. Right
> > 	now, I'm putting all allocations of GFP_USER and GFP_HIGHUSER as
> > 	well as disk-buffer pages into this category. These pages are trivially
> > 	reclaimed by writing the page out to swap or syncing with backing
> > 	storage
> > KernelReclaimable - These are pages allocated by the kernel that are easily
> > 	reclaimed. This is stuff like inode caches, dcache, buffer_heads etc.
> > 	These type of pages potentially could be reclaimed by dumping the
> > 	caches and reaping the slabs (drastic, but you get the idea). We could
> > 	also add pages into this category that are known to be only required
> > 	for a short time like buffers used with DMA
> > KernelNonReclaimable - These are pages that are allocated by the kernel that
> > 	are not trivially reclaimed. For example, the memory allocated for a
> > 	loaded module would be in this category. By default, allocations are
> > 	considered to be of this type
> 
> I'd expect to do better with kernel/user discrimination only, having
> address-ordering biases in opposite directions for each case.

What you mean with "address-ordering biases in opposite directions for each case" ? 

You mean to have each case allocate from the top and bottom of the free list, respectively,
and in opposite address direction ? What you gain from that?

And what that means during a long period of VM stress ?

