Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268925AbUHMBaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268925AbUHMBaO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 21:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268928AbUHMBaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 21:30:14 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:60076 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268925AbUHMBaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 21:30:09 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Date: Thu, 12 Aug 2004 18:29:54 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <2sxuC-429-3@gated-at.bofh.it> <m3657nu9dl.fsf@averell.firstfloor.org>
In-Reply-To: <m3657nu9dl.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408121829.54830.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 12, 2004 6:14 pm, Andi Kleen wrote:
> Jesse Barnes <jbarnes@engr.sgi.com> writes:
> > On a NUMA machine, page cache pages should be spread out across the
> > system since they're generally global in nature and can eat up whole
> > nodes worth of memory otherwise.  This can end up hurting performance
> > since jobs will have to make off node references for much or all of their
> > non-file data.
> >
> > The patch works by adding an alloc_page_round_robin routine that simply
> > allocates on successive nodes each time its called, based on the value of
> > a per-cpu variable modulo the number of nodes.  The variable is per-cpu
> > to avoid cacheline contention when many cpus try to do page cache
> > allocations at
>
> I don't like this approach using a dynamic counter. I think it would
> be better to add a new function that takes the vma and uses the offset
> into the inode for static interleaving (anonymous memory would still
> use the vma offset). This way you would have a good guarantee that the
> interleaving stays interleaved even when the system swaps pages in and
> out and you're less likely to get anomalies in the page distribution.

Well, that's one reason I didn't add an alloc_pages routine, but just a single 
page distributor.  However, a multipage round robin routine would be useful 
in other cases, like for the slab allocator.

Jesse
