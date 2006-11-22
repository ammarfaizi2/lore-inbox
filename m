Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161782AbWKVCZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161782AbWKVCZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 21:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161787AbWKVCZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 21:25:24 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:10925 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1161782AbWKVCZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 21:25:22 -0500
Date: Tue, 21 Nov 2006 18:25:12 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0611211821030.588@schroedinger.engr.sgi.com>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Mel Gorman wrote:

> On Tue, 21 Nov 2006, Christoph Lameter wrote:
> 
> > Are GFP_HIGHUSER allocations always movable? It would reduce the size of
> > the patch if this would be added to GFP_HIGHUSER.
> No, they aren't. Page tables allocated with HIGHPTE are currently not movable
> for example. A number of drivers (infiniband for example) also use
> __GFP_HIGHMEM that are not movable.

HIGHPTE with __GFP_USER set? This is a page table page right? 
pte_alloc_one does currently not set GFP_USER:

struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
{
        struct page *pte;

#ifdef CONFIG_HIGHPTE
        pte = 
alloc_pages(GFP_KERNEL|__GFP_HIGHMEM|__GFP_REPEAT|__GFP_ZERO, 0);
#else
        pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
#endif
        return pte;
}

How does infiniband insure that page migration does not move those pages?

