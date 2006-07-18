Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWGRODX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWGRODX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 10:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWGRODX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 10:03:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34263 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932220AbWGRODW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 10:03:22 -0400
Date: Tue, 18 Jul 2006 07:03:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
In-Reply-To: <44BCE86A.4030602@mbligh.org>
Message-ID: <Pine.LNX.4.64.0607180659310.30887@schroedinger.engr.sgi.com>
References: <1153167857.31891.78.camel@lappy> 
 <Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com>
 <1153224998.2041.15.camel@lappy> <Pine.LNX.4.64.0607180557440.30245@schroedinger.engr.sgi.com>
 <44BCE86A.4030602@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006, Martin J. Bligh wrote:

> > Adding logic to determine the number of clean pages is not necessary. The
> > number of clean pages in the pagecache can be determined by:
> > 
> > global_page_state(NR_FILE_PAGES) - global_page_state(NR_FILE_DIRTY) 
> 
> It's not that simple. We also need to deal with other types of non-freeable
> pages, such as memlocked.

mlocked is an exceptional case. The problem is that the information if a 
page is mlocked is only available via the vma. One has to
scan the reverse list and check all the vmas for the flag.

Is mlock that important?

What other types of non freeable pages could exist?

Maybe slab allocations and direct kernel allocations? We have only
limited means to reclaim those pages.

