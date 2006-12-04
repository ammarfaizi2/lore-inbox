Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967352AbWLDVoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967352AbWLDVoc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967367AbWLDVoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:44:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41824 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S967352AbWLDVob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:44:31 -0500
Date: Mon, 4 Dec 2006 13:43:44 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Mel Gorman <mel@skynet.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <20061204131959.bdeeee41.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612041337520.851@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
 <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org>
 <Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com>
 <20061204120611.4306024e.akpm@osdl.org> <Pine.LNX.4.64.0612041211390.32337@schroedinger.engr.sgi.com>
 <20061204131959.bdeeee41.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Andrew Morton wrote:

> What happens when we need to run reclaim against just a section of a zone?
> Lumpy-reclaim could be used here; perhaps that's Mel's approach too?

Why would we run reclaim against a section of a zone?
 
> We'd need new infrastructure to perform the
> section-of-a-zone<->physical-memory-block mapping, and to track various
> states of the section-of-a-zone.  This will be complex, and buggy.  It will
> probably require the introduction of some sort of "sub-zone" structure.  At
> which stage people would be justified in asking "why didn't you just use
> zones - that's what they're for?"

Mel aready has that for anti-frag. The sections are per MAX_ORDER area 
and the only states are movable unmovable and reclaimable. There is 
nothing more to it. No other state information should be added. Why would 
we need sub zones? For what purpose?

> > Then we should be doing some work to cut down the number of unmovable 
> > allocations.
> 
> That's rather pointless.  A feature is either reliable or it is not.  We'll
> never be able to make all kernel allocations reclaimable/moveable so we'll
> never be reliable with this approach.  I don't see any alternative to the
> never-allocate-kernel-objects-in-removeable-memory approach.  

What feature are you talking about?

Why would all allocations need to be movable when we have a portion for 
unmovable allocations?
