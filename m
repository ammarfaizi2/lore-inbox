Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbULOS1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbULOS1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbULOS1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:27:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39809 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262436AbULOSYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:24:20 -0500
Date: Wed, 15 Dec 2004 12:24:10 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
In-Reply-To: <20041215071734.GO27225@wotan.suse.de>
Message-ID: <Pine.SGI.4.61.0412151051270.24052@kzerza.americas.sgi.com>
References: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com>
 <9250000.1103050790@flay> <20041214191348.GA27225@wotan.suse.de>
 <19030000.1103054924@flay> <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com>
 <20041215040854.GC27225@wotan.suse.de> <686170000.1103094885@[10.10.2.4]>
 <20041215071734.GO27225@wotan.suse.de>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004, Andi Kleen wrote:

> On Tue, Dec 14, 2004 at 11:14:46PM -0800, Martin J. Bligh wrote:
> > Well hold on a sec. We don't need to use the hugepages pool for this,
> > do we? This is the same as using huge page mappings for the whole of
> > kernel space on ia32. As long as it's a kernel mapping, and 16MB aligned
> > and contig, we get it for free, surely?
> 
> The whole point of the patch is to not use the direct mapping, but
> use a different interleaved mapping on NUMA machines to spread
> the memory out over multiple nodes.

There is a middle ground, in theory.  At least on a NUMA machine you
can divide up the allocation roughly as requested_size/number_nodes.
Round the result up to the next available page size, and allocate
interleaved on the nodes until you've satisfied the requested size.
This minimizes the number of TLB entries required to interleave the
allocation.

However, as noted, the kernel barely handles two page sizes, much
less multiple page sizes.  If more flexible page-size handling
comes along someday this and many other sections of code could
stand to benefit from some rewriting.

> > > Using other page sizes would be probably tricky because the 
> > > linux VM can currently barely deal with two page sizes.
> > > I suspect handling more would need some VM infrastructure effort
> > > at least in the changed port. 
> > 
> > For the general case I'd agree. But this is a setup-time only tweak
> > of the static kernel mapping, isn't it?
> 
> It's probably not impossible, just lots of ugly special cases.
> e.g. how about supporting it for /proc/kcore etc? 

Just to bring a bit of closure regarding the patches I posted yesterday,
I'm reading the overall discussion as "The patches look good enough for
current kernels, and this would benefit from multiple page size support,
if we ever get it."  Fair read?

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
