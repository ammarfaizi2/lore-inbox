Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933070AbWKXUEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933070AbWKXUEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933072AbWKXUEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:04:53 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:8382 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S933070AbWKXUEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:04:52 -0500
Date: Fri, 24 Nov 2006 20:04:49 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Christoph Lameter <clameter@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Mel Gorman <mel@skynet.ie>,
       linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <Pine.LNX.4.64.0611240955170.24649@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0611241956420.3938@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org> <20061123163613.GA25818@skynet.ie>
 <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org>
 <Pine.LNX.4.64.0611240955170.24649@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006, Christoph Lameter wrote:

> On Thu, 23 Nov 2006, Linus Torvalds wrote:
>
>> And the assumption would be that if it's MOVABLE, then it's obviously a
>> USER allocation (it it can fail much more eagerly - that's really what the
>> whole USER bit ends up meaning internally).
>
> We can probably make several types of kernel allocations movable if there
> would be some benefit from it.
>

Page tables are the major type of allocation that comes to mind. From what 
I've seen, they are the most common long-lived unmovable and unreclaimable 
allocation.

> Mel already has a problem with mlocked user pages in the movable section.
> If this is fixed by using page migration to move the mlocked pages

That is the long-term plan.

> then we
> can likely make addititional classes kernel pages also movable and reduce
> the amount of memory that is unmovable. If we have more movable pages then
> the defrag can work more efficiently.

Indeed, although some sort of placement is still needed to keep these 
movable allocations together.

> Having most pages movable will also
> help to make memory unplug a reality.
>
> So please do not require movable pages to be user allocations.
>

That is not the intention. It just happens that allocations that are 
directly accessible by userspace are also the ones that are currently 
movable.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
