Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWHSTRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWHSTRl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 15:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWHSTRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 15:17:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46559 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751774AbWHSTRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 15:17:40 -0400
Date: Sat, 19 Aug 2006 12:17:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andi Kleen <ak@muc.de>, mpm@selenic.com,
       Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
In-Reply-To: <44E75E56.60905@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0608191209370.4890@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
 <20060816094358.e7006276.ak@muc.de> <Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com>
 <44E3FC4F.2090506@colorfullife.com> <Pine.LNX.4.64.0608170922030.24204@schroedinger.engr.sgi.com>
 <44E6B8EA.2010100@colorfullife.com> <Pine.LNX.4.64.0608190941490.4872@schroedinger.engr.sgi.com>
 <44E75E56.60905@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006, Manfred Spraul wrote:

> > And as we have just seen virt to page is mostly an address calculation in
> > many configurations. I doubt that there would be a great advantage. Todays
> > processors biggest cause for latencies are cacheline misses..
> > 
> It involves table walking on discontigmem archs. "slabp=addr &
> (~(PAGE_SIZE-1));" means no pointer chasing, and the access touches the same
> page, i.e. definitively no TLB miss.

There is no table walking for discontigmem on ia64. Ia64 only creates page 
table if it needs to satify the Linux kernels demands for such a thing. 
And this is a kernel mapping. No page table involved.

The current sparsemem approach also does not need table walking. It needs
to do lookups in a table.

UP and SMP currently work cleanly.

> > Power of 2 cache sizes make the object align neatly to cacheline boundaries
> > and make them fit tightly into a page.
> >  
> IMHO not really an issue. 2kb-cache_line_size() also aligns perfectly.

That would work and also be in line with the existing overhead of the 
slabs.




