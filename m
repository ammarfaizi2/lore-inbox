Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVKJAtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVKJAtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVKJAtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:49:20 -0500
Received: from ozlabs.org ([203.10.76.45]:13798 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751141AbVKJAtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:49:19 -0500
Date: Thu, 10 Nov 2005 11:49:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Adam Litke <agl@us.ibm.com>, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hugh@veritas.com, rohit.seth@intel.com,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH 4/4] Hugetlb: Copy on Write support
Message-ID: <20051110004907.GA17840@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	William Lee Irwin III <wli@holomorphy.com>,
	Adam Litke <agl@us.ibm.com>, akpm@osdl.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hugh@veritas.com,
	rohit.seth@intel.com, kenneth.w.chen@intel.com
References: <1131578925.28383.9.camel@localhost.localdomain> <1131579596.28383.25.camel@localhost.localdomain> <20051110001534.GN29402@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110001534.GN29402@holomorphy.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 04:15:34PM -0800, William Lee Irwin wrote:
> On Wed, Nov 09, 2005 at 05:39:55PM -0600, Adam Litke wrote:
> > Hugetlb: Copy on Write support
> > Implement copy-on-write support for hugetlb mappings so MAP_PRIVATE can be
> > supported.  This helps us to safely use hugetlb pages in many more
> > applications.  The patch makes the following changes.  If needed, I also have
> > it broken out according to the following paragraphs.
> > 1. Add a pair of functions to set/clear write access on huge ptes.  The
> > writable check in make_huge_pte is moved out to the caller for use by COW
> > later.
> > 2. Hugetlb copy-on-write requires special case handling in the following
> > situations:
> >  - copy_hugetlb_page_range() - Copied pages must be write protected so a COW
> >     fault will be triggered (if necessary) if those pages are written to.
> >  - find_or_alloc_huge_page() - Only MAP_SHARED pages are added to the page
> >     cache.  MAP_PRIVATE pages still need to be locked however.
> > 3. Provide hugetlb_cow() and calls from hugetlb_fault() and hugetlb_no_page()
> > which handles the COW fault by making the actual copy.
> > 4. Remove the check in hugetlbfs_file_map() so that MAP_PRIVATE mmaps will be
> > allowed.  Make MAP_HUGETLB exempt from the depricated VM_RESERVED mapping
> > check.
> 
> Did you do the audit of pte protection bits I asked about? If not, I'll
> dredge them up and check to make sure.

I still don't know what you're talking about here - you never
responded to my mail asking for clarification.  The hugepage code
already relies on pte_mkwrite() and pte_wrprotect() working correctly,
I don't see that COW makes any difference.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
