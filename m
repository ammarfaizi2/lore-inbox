Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263076AbUJ2Ds2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbUJ2Ds2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 23:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbUJ2Ds2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 23:48:28 -0400
Received: from holomorphy.com ([207.189.100.168]:42382 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263076AbUJ2DsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 23:48:23 -0400
Date: Thu, 28 Oct 2004 20:48:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       Adam Litke <agl@us.ibm.com>, Andy Whitworth <apw@shadowen.org>
Subject: Re: [RFC] Consolidate lots of hugepage code
Message-ID: <20041029034817.GY12934@holomorphy.com>
References: <20041029033708.GF12247@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029033708.GF12247@zax>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:37:08PM +1000, David Gibson wrote:
> wA lot of the code in arch/*/mm/hugetlbpage.c is quite similar.  This
> patch attempts to consolidate a lot of the code across the arch's,
> putting the combined version in mm/hugetlb.c.  There are a couple of
> uglyish hacks in order to cover all the hugepage archs, but the result
> is a very large reduction in the total amount of code.  It also means
> things like hugepage lazy allocation could be implemented in one
> place, instead of six.
> As yet this is entirely untested, except on ppc64.  Comments?
> Objections?  Testing acks?
> Notes:
> 	- this patch changes the meaning of set_huge_pte() to be more
> 	  analagous to set_pte()
> 	- does SH4 need special huge_ptep_get_and_clear()??

Further consolidation is premature given that outstanding hugetlb bugs
have the implication that architectures' needs are not being served by
the current arch/core split. I have at least two relatively major hugetlb
bugs outstanding, the lack of a flush_dcache_page() analogue first, and
another (soon to be a reported to affected distros) less well-understood.
Unless they're directly toward the end of restoring hugetlb to a sound
state, they're counterproductive to merge before patches doing so.

-- wli
