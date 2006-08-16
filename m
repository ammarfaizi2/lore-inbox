Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWHPJTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWHPJTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWHPJTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:19:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31688 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751047AbWHPJTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:19:32 -0400
Date: Wed, 16 Aug 2006 19:18:15 +1000
From: David Chinner <dgc@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: Christoph Lameter <clameter@sgi.com>, mpm@selenic.com,
       Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
Message-ID: <20060816091814.GM51703024@melbourne.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com> <20060816081208.GL51703024@melbourne.sgi.com> <20060816103259.f87c167a.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816103259.f87c167a.ak@muc.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 10:32:59AM +0200, Andi Kleen wrote:
> 
> > > 3. New slabs that are created can be merged into the kmalloc array
> > >    if it is detected that they match. This decreases the number of caches
> > >    and benefits cache use.
> > 
> > While this will be good for reducing fragmentation,
> 
> Will it? The theory behind a zone allocator like slab is that objects of the
> same type have similar livetimes.

True, but not all users of the slab caches are similar lifetime objects. e.g.
bufferheads, dentries, inodes, filps, radix tree nodes, etc all have effectively
random lifetimes. i'd say that most linux slab objects don't have that
property....

> Fragmentation mostly happens when objects
> have very different live times.

*nod*

Just look at how badly the inode and dentry slabs can fragment....

> If you mix objects of different types
> into the same slab then you might get more fragmentation.

Yes, but you don't tend to get the same worst case behaviour
that you get with single use slabs. With multiple use slabs, long
lifetime objects tend to accumulate on the same pages as different
objects come and go from the pages. IOWs, you waste less pages
in a fragmented multi-object cache that you do in N fragmented
single use caches.

> kmalloc already has that problem but it probably shouldn't be added 
> to other slabs too.

I've never seen the kmalloc slabs show anywhere near the levels of
fragmentation I've seen from the inode and dentry slabs.....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
