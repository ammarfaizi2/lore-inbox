Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVAMHcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVAMHcg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 02:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVAMHcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 02:32:35 -0500
Received: from holomorphy.com ([207.189.100.168]:14306 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261190AbVAMHbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 02:31:55 -0500
Date: Wed, 12 Jan 2005 23:31:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Avoiding fragmentation through different allocator
Message-ID: <20050113073146.GB1226@holomorphy.com>
References: <Pine.LNX.4.58.0501122101420.13738@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501122101420.13738@skynet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 09:09:24PM +0000, Mel Gorman wrote:
> So... What the patch does. Allocations are divided up into three different
> types of allocations;
> UserReclaimable - These are userspace pages that are easily reclaimable. Right
> 	now, I'm putting all allocations of GFP_USER and GFP_HIGHUSER as
> 	well as disk-buffer pages into this category. These pages are trivially
> 	reclaimed by writing the page out to swap or syncing with backing
> 	storage
> KernelReclaimable - These are pages allocated by the kernel that are easily
> 	reclaimed. This is stuff like inode caches, dcache, buffer_heads etc.
> 	These type of pages potentially could be reclaimed by dumping the
> 	caches and reaping the slabs (drastic, but you get the idea). We could
> 	also add pages into this category that are known to be only required
> 	for a short time like buffers used with DMA
> KernelNonReclaimable - These are pages that are allocated by the kernel that
> 	are not trivially reclaimed. For example, the memory allocated for a
> 	loaded module would be in this category. By default, allocations are
> 	considered to be of this type

I'd expect to do better with kernel/user discrimination only, having
address-ordering biases in opposite directions for each case.

-- wli
