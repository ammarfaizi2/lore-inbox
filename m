Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWCCFSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWCCFSE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 00:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWCCFSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 00:18:04 -0500
Received: from silver.veritas.com ([143.127.12.111]:15960 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750867AbWCCFSD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 00:18:03 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,162,1139212800"; 
   d="scan'208"; a="35326279:sNHT22596724"
Date: Fri, 3 Mar 2006 05:18:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "'David Gibson'" <david@gibson.dropbear.id.au>
cc: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       William Irwin <wli@holomorphy.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: hugepage: Fix hugepage logic in free_pgtables() harder
In-Reply-To: <20060303010408.GG23766@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0603030508470.5446@goblin.wat.veritas.com>
References: <20060303010408.GG23766@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Mar 2006 05:18:02.0455 (UTC) FILETIME=[D8238E70:01C63E81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2006, 'David Gibson' wrote:

> Sigh.  Turns out the hugepage logic in free_pgtables() was doubly
> broken.  The loop coalescing multiple normal page VMAs into one call
> to free_pgd_range() had an off by one error, which could mean it would
> coalesce one hugepage VMA into the same bundle (checking 'vma' not
> 'next' in the loop).  I transferred this bug into the new
> is_vm_hugetlb_page() based version.  Here's the fix.
> 
> This one didn't bite on powerpc previously for the same reason the
> is_hugepage_only_range() problem didn't: powerpc's
> hugetlb_free_pgd_range() is identical to free_pgd_range().  It didn't
> bite on ia64 because the hugepage region is distant enough from any
> other region that the separated PMD_SIZE distance test would always
> prevent coalescing the two together.

I agree with your patch, but not with your comment: it's just a fix
to your earlier patch, there's no such off-by-one in the mainline
free_pgtables.  Probably you were misled by my use of "vma->vm_mm"
rather than  "next->vm_mm", equal but admittedly confusing, when
looking at the "next" vma.

Hugh
