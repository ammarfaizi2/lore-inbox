Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbVKNXZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVKNXZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVKNXZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:25:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41160 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751314AbVKNXZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:25:31 -0500
Date: Mon, 14 Nov 2005 15:25:00 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Adam Litke <agl@us.ibm.com>
cc: linux-mm@kvack.org, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com, wli@holomorphy.com
Subject: Re: [RFC] NUMA memory policy support for HUGE pages
In-Reply-To: <1132007410.13502.35.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0511141523100.4676@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511111051080.20589@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0511111225100.21071@schroedinger.engr.sgi.com> 
 <1131980814.13502.12.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0511141340160.4663@schroedinger.engr.sgi.com>
 <1132007410.13502.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2005, Adam Litke wrote:

> On Mon, 2005-11-14 at 13:46 -0800, Christoph Lameter wrote:
> > This is V2 of the patch.
> > 
> > Changes:
> > 
> > - Cleaned up by folding find_or_alloc() into hugetlb_no_page().
> 
> IMHO this is not really a cleanup.  When the demand fault patch stack
> was first accepted, we decided to separate out find_or_alloc_huge_page()
> because it has the page_cache retry loop with several exit conditions.
> no_page() has its own backout logic and mixing the two makes for a
> tangled mess.  Can we leave that hunk out please?

It seemed to me that find_or_alloc_huge_pages has a pretty simple backout 
logic that folds nicely into no_page(). Both functions share a lot of 
variables and putting them together not only increases the readability of 
the code but also makes the function smaller and execution more efficient.

