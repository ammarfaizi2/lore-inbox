Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757824AbWKXVFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757824AbWKXVFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934115AbWKXVFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:05:49 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:48330 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1757824AbWKXVFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:05:49 -0500
X-AuditID: d80ac21c-a2798bb000001069-16-45675eaccf2f 
Date: Fri, 24 Nov 2006 21:06:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Mel Gorman <mel@csn.ul.ie>
cc: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <Pine.LNX.4.64.0611242004520.3938@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0611242056260.20312@blonde.wat.veritas.com>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org> <20061123163613.GA25818@skynet.ie>
 <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org> <20061124104422.GA23426@skynet.ie>
 <Pine.LNX.4.64.0611241924110.17508@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0611242004520.3938@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Nov 2006 21:05:48.0187 (UTC) FILETIME=[50A326B0:01C7100C]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006, Mel Gorman wrote:
> 
> Good catch. In the page clustering patches I work on, I am doing this;
> 
> -       page = alloc_page_vma(gfp | __GFP_ZERO, &pvma, 0);
> +       page = alloc_page_vma(
> +                       set_migrateflags(gfp | __GFP_ZERO, __GFP_RECLAIMABLE),
> +                                                               &pvma, 0);
> 
> to get rid of the MOVABLE flag and replace it with __GFP_RECLAIMABLE. This
> clustered the allocations together with allocations like inode cache. In
> retrospect, this was not a good idea because it assumes that tmpfs and shmem
> pages are short-lived. That may not be the case at all.
>... 
> Thanks for that clarification. I suspected that something like this was the
> case when I removed the MOVABLE flag and used RECLAIMABLE but I wasn't 100%
> certain. In the tests I was running, tmpfs pages weren't a major problem so I
> didn't chase it down.

I'm fairly confused as to what MOVABLE versus RECLAIMABLE is supposed to
be meaning, and understand it's in flux, so haven't tried too hard.  Just
so long as you understand that tmpfs data pages go out to swap under memory
pressure, whereas ramfs pages do not, and tmpfs swap vector pages do not.

Hugh
