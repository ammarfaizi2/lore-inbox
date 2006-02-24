Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWBXCr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWBXCr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWBXCr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:47:28 -0500
Received: from ozlabs.org ([203.10.76.45]:39813 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751819AbWBXCrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:47:25 -0500
Date: Fri, 24 Feb 2006 13:44:31 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Hugh Dickins'" <hugh@veritas.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix ia64 hugetlb_free_pgd_range
Message-ID: <20060224024431.GC28368@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Hugh Dickins' <hugh@veritas.com>,
	"Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200602240145.k1O1jEg05475@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602240145.k1O1jEg05475@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 05:45:14PM -0800, Chen, Kenneth W wrote:
> I've looked at hugetlb_free_pgd_range() right side up, right side
> down, up side up, up side down.  And it just doesn't look correct
> to me at all.
> 
> In that function, we do address transformation before calling
> free_pgd_range, so the generic function can traverse to right set
> of page table page.  There is no need to do any range check.

I think you're right - the range check is bogus.  Probably someone
just used it because the range check gave the right answer - but only
by accident in a sense.

However... I suspect in fact that the transformations should be
unconditional.  The whole address scaling thing that ia64 does for
hugepages is extremely confusing, but since floor and ceiling are just
used for bounds checking on the inner functions, shouldn't they be
transformed to the same scale as addr and end, even if that's not
actually a true address (hugepage or otherwise).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
