Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264792AbTF2VyC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 17:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264802AbTF2VyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 17:54:02 -0400
Received: from holomorphy.com ([66.224.33.161]:34209 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264792AbTF2VyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 17:54:00 -0400
Date: Sun, 29 Jun 2003 15:07:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Mel Gorman <mel@csn.ul.ie>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
Message-ID: <20030629220756.GB26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@arcor.de>, Mel Gorman <mel@csn.ul.ie>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306282306.59502.phillips@arcor.de> <Pine.LNX.4.53.0306292214160.11946@skynet> <200306282354.43153.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306282354.43153.phillips@arcor.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 June 2003 23:26, Mel Gorman wrote:
>> Thats where your defragger would need to kick in. The defragger would scan
>> at most MAX_DEFRAG_SCAN slabs belonging to the order0 userspace cache
>> where MAX_DEFRAG_SCAN is related to how urgent the request is. Select the
>> slab with the least objects in them and either:
>> a) Reclaim the pages by swapping them out or whatever
>> b) Copy the pages to another slab and update the page tables via rmap
>> Once the pages are copied from the selected slab, destroy it and you have
>> a large block of free pages.

On Sat, Jun 28, 2003 at 11:54:43PM +0200, Daniel Phillips wrote:
> Yes, now we're on the same page, so to speak.  Personally, I don't have much 
> interest in working on improving the allocator per se.  I'd love to see 
> somebody else take a run at that, and I will occupy myself with the gritty 
> details of how to move pages without making the system crater.

This sounds like it's behind dependent on physically scanning slabs,
since one must choose slab pages for replacement on the basis of their
potential to restore contiguity, not merely "dump whatever's replaceable
and check how much got freed".


On Sunday 29 June 2003 23:26, Mel Gorman wrote:
>> The point which I am getting across, quite
>> badly, is that by having order0 pages in slab, you are guarenteed to be
>> able to quickly find a cluster of pages to move which will free up a
>> contiguous block of 2^MAX_ORDER pages, or at least 2^MAX_GFP_ORDER with
>> the current slab implementation.

On Sat, Jun 28, 2003 at 11:54:43PM +0200, Daniel Phillips wrote:
> I don't see that it's guaranteed, but I do see that organizing pages in 
> slab-like chunks is a good thing to do - a close reading of my original 
> response to you shows I was thinking about that.
> I also don't see that the slab cache in its current incarnation is the right 
> tool for the job.  It handles things that we just don't need to handle, such 
> as objects of arbitary size and alignment.  I'm sure you could make it work, 
> but why not just tweak alloc_pages to know about chunks instead?

A larger question in my mind is what slabs have to do with this at all.
Slabs are for fixed-size allocations. These techniques are explicitly
oriented toward making user allocations more variable, not less.


-- wli
