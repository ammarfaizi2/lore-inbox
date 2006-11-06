Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753746AbWKFUbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbWKFUbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbWKFUbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:31:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:2253 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1753747AbWKFUbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:31:41 -0500
Date: Mon, 6 Nov 2006 12:31:36 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
In-Reply-To: <20061106122446.8269f7bc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611061229080.29760@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
 <20061103134633.a815c7b3.akpm@osdl.org> <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
 <20061103143145.85a9c63f.akpm@osdl.org> <Pine.LNX.4.64.0611031622540.16997@schroedinger.engr.sgi.com>
 <20061103165854.0f3e77ad.akpm@osdl.org> <Pine.LNX.4.64.0611060846070.25351@schroedinger.engr.sgi.com>
 <20061106115925.1dd41a77.akpm@osdl.org> <Pine.LNX.4.64.0611061207310.26685@schroedinger.engr.sgi.com>
 <20061106122446.8269f7bc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006, Andrew Morton wrote:

> I'm referring to the metadata rather than to the pages themselves: the zone
> structure at least.  I bet there are a couple of cache misses in there.

Yes, in particular in large systems.

> > The number 
> > of pages to take will vary depending on the size of the shared data. For 
> > shared data areas that are just a couple of pages this wont work.
> 
> What is "shared data"?

Interleave is used for data accessed from many nodes otherwise one would 
prefer to allocate from the current zone. The shared data may be very 
frequently accessed from multiple nodes and one would like different NUMA 
nodes to respond to these requests.

> > > Umm, but that's exactly what the patch we're discussing will do.
> > Not if we have a set of remaining nodes.
> 
> Yes it is.  You're proposing taking an arbitrarily large number of
> successive pages from the same node rather than interleaving the allocations.
> That will create "hotspots or imbalances" (whatever they are).

No I proposed to go round robin over the remaining nodes. The special case 
of one node left could be dealt with.
