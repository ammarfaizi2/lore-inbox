Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264736AbTF2VjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 17:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbTF2VjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 17:39:25 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:9861 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S264736AbTF2VjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 17:39:24 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [RFC] My research agenda for 2.7
Date: Sat, 28 Jun 2003 23:54:43 +0200
User-Agent: KMail/1.5.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306282306.59502.phillips@arcor.de> <Pine.LNX.4.53.0306292214160.11946@skynet>
In-Reply-To: <Pine.LNX.4.53.0306292214160.11946@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306282354.43153.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 June 2003 23:26, Mel Gorman wrote:
> On Sat, 28 Jun 2003, Daniel Phillips wrote:
> > > Because they are so common in comparison to other orders, I
> > > think that putting order0 in slabs of size 2^MAX_ORDER will make
> > > defragmentation *so* much easier, if not plain simple, because you can
> > > shuffle around order0 pages in the slabs to free up one slab which
> > > frees up one large 2^MAX_ORDER adjacent block of pages.
> >
> > But how will you shuffle those pages around?
>
> Thats where your defragger would need to kick in. The defragger would scan
> at most MAX_DEFRAG_SCAN slabs belonging to the order0 userspace cache
> where MAX_DEFRAG_SCAN is related to how urgent the request is. Select the
> slab with the least objects in them and either:
> a) Reclaim the pages by swapping them out or whatever
> b) Copy the pages to another slab and update the page tables via rmap
> Once the pages are copied from the selected slab, destroy it and you have
> a large block of free pages.

Yes, now we're on the same page, so to speak.  Personally, I don't have much 
interest in working on improving the allocator per se.  I'd love to see 
somebody else take a run at that, and I will occupy myself with the gritty 
details of how to move pages without making the system crater.

> The point which I am getting across, quite
> badly, is that by having order0 pages in slab, you are guarenteed to be
> able to quickly find a cluster of pages to move which will free up a
> contiguous block of 2^MAX_ORDER pages, or at least 2^MAX_GFP_ORDER with
> the current slab implementation.

I don't see that it's guaranteed, but I do see that organizing pages in 
slab-like chunks is a good thing to do - a close reading of my original 
response to you shows I was thinking about that.

I also don't see that the slab cache in its current incarnation is the right 
tool for the job.  It handles things that we just don't need to handle, such 
as objects of arbitary size and alignment.  I'm sure you could make it work, 
but why not just tweak alloc_pages to know about chunks instead?

Regards,

Daniel

