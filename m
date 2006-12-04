Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937363AbWLDURg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937363AbWLDURg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937365AbWLDURg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:17:36 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39348 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937363AbWLDURf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:17:35 -0500
Date: Mon, 4 Dec 2006 12:17:26 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Mel Gorman <mel@skynet.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <20061204120611.4306024e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612041211390.32337@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
 <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org>
 <Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com>
 <20061204120611.4306024e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Andrew Morton wrote:

> > The multi zone approach does not work with NUMA. NUMA only supports a 
> > single zone for memory policy control etc.
> 
> Wot?  memory policies are a per-vma thing?

They only apply to "policy_zone" of a node. policy_zone can only take a 
single type of zone (has been like it forever). Multiple zones could 
become a nightmare with an exploding number of zones on zonelists. I.e. 
instead of 1k zones on a nodelist we now have 2k for two or even 4k if you 
want to have support for memory policies for 4 zones per node. We will 
then increase the search time through zonelists and have to manage all the 
memory in the different zones. Balancing is going to be difficult.

> I suspect you'll have to live with that.  I've yet to see a vaguely sane
> proposal to otherwise prevent unreclaimable, unmoveable kernel allocations
> from landing in a hot-unpluggable physical memory region.

Mel's approach already mananges memory in a chunks of MAX_ORDER. It is 
easy to just restrict the unmovable types of allocation to a section of 
the zone.

Then we should be doing some work to cut down the number of unmovable 
allocations.
