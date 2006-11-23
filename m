Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757381AbWKWPAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381AbWKWPAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 10:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757385AbWKWPAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 10:00:19 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:3522 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1757381AbWKWPAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 10:00:18 -0500
Date: Thu, 23 Nov 2006 15:00:16 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <Pine.LNX.4.64.0611211821030.588@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0611231457070.23409@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211821030.588@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Christoph Lameter wrote:

> On Tue, 21 Nov 2006, Mel Gorman wrote:
>
>> On Tue, 21 Nov 2006, Christoph Lameter wrote:
>>
>>> Are GFP_HIGHUSER allocations always movable? It would reduce the size of
>>> the patch if this would be added to GFP_HIGHUSER.
>> No, they aren't. Page tables allocated with HIGHPTE are currently not movable
>> for example. A number of drivers (infiniband for example) also use
>> __GFP_HIGHMEM that are not movable.
>
> HIGHPTE with __GFP_USER set? This is a page table page right?
> pte_alloc_one does currently not set GFP_USER:
>

What is __GFP_USER? The difference between GFP_USER and GFP_KERNEL is only 
in the use of __GFP_HARDWALL. But HARDWALL on it's own is not enough to 
distinguish movable and non-movable.

> struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
> {
>        struct page *pte;
>
> #ifdef CONFIG_HIGHPTE
>        pte =
> alloc_pages(GFP_KERNEL|__GFP_HIGHMEM|__GFP_REPEAT|__GFP_ZERO, 0);
> #else
>        pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
> #endif
>        return pte;
> }
>
> How does infiniband insure that page migration does not move those pages?
>

I have not looked closely at infiniband and how it uses it's pages.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
