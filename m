Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753782AbWKFUnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbWKFUnA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789AbWKFUnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:43:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753752AbWKFUm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:42:59 -0500
Date: Mon, 6 Nov 2006 12:42:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061106124257.deffa31c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611061229080.29760@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	<20061103143145.85a9c63f.akpm@osdl.org>
	<Pine.LNX.4.64.0611031622540.16997@schroedinger.engr.sgi.com>
	<20061103165854.0f3e77ad.akpm@osdl.org>
	<Pine.LNX.4.64.0611060846070.25351@schroedinger.engr.sgi.com>
	<20061106115925.1dd41a77.akpm@osdl.org>
	<Pine.LNX.4.64.0611061207310.26685@schroedinger.engr.sgi.com>
	<20061106122446.8269f7bc.akpm@osdl.org>
	<Pine.LNX.4.64.0611061229080.29760@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006 12:31:36 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Mon, 6 Nov 2006, Andrew Morton wrote:
> 
> > I'm referring to the metadata rather than to the pages themselves: the zone
> > structure at least.  I bet there are a couple of cache misses in there.
> 
> Yes, in particular in large systems.
> 
> > > The number 
> > > of pages to take will vary depending on the size of the shared data. For 
> > > shared data areas that are just a couple of pages this wont work.
> > 
> > What is "shared data"?
> 
> Interleave is used for data accessed from many nodes otherwise one would 
> prefer to allocate from the current zone. The shared data may be very 
> frequently accessed from multiple nodes and one would like different NUMA 
> nodes to respond to these requests.

But what is "shared data"??  You're using a new but very general term
without defining it.

> > > > Umm, but that's exactly what the patch we're discussing will do.
> > > Not if we have a set of remaining nodes.
> > 
> > Yes it is.  You're proposing taking an arbitrarily large number of
> > successive pages from the same node rather than interleaving the allocations.
> > That will create "hotspots or imbalances" (whatever they are).
> 
> No I proposed to go round robin over the remaining nodes. The special case 
> of one node left could be dealt with.

OK, but if two nodes have a lot of free pages and the rest don't then
interleave will consume those free pages without performing any reclaim
from all the other nodes.  Hence hostpots or imbalances.

Whatever they are.  Why does it matter?
