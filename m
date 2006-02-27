Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWB0A2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWB0A2U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 19:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWB0A2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 19:28:19 -0500
Received: from ozlabs.org ([203.10.76.45]:13270 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751440AbWB0A2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 19:28:19 -0500
Date: Mon, 27 Feb 2006 11:27:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Hugh Dickins <hugh@veritas.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix ia64 hugetlb_free_pgd_range
Message-ID: <20060227002742.GC24422@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	Hugh Dickins <hugh@veritas.com>, "Luck, Tony" <tony.luck@intel.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <B05667366EE6204181EABE9C1B1C0EB509C43438@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB509C43438@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 10:30:39PM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Thursday, February 23, 2006 8:06 PM
> > But I don't see how not transforming them sometimes can be correct.
> > Suppose 'floor' is only a little way below 'addr' - addr will be
> > shifted down, but floor won't, so floor may now be above addr, which
> > will cause weird results.
> > 
> > Afaict the *only* thing floor and ceiling are used for is bounds
> > checking the address range we're examining.  How can that ever be
> > right if one address has been scaled down, but the other hasn't.
> 
> The scale down isn't exactly on every address bits.  Top 3 bits of
> virtual address are preserved.

Ah.. yes.

> #define htlbpage_to_page(x)    (((unsigned long) REGION_NUMBER(x) << 61)
>                                  | (REGION_OFFSET(x) >>
> (HPAGE_SHIFT-PAGE_SHIFT)))
> 
> So scaled address for a hugetlb address will never be below unscaled
> normal page address.  That is adjusted addr will never below unchanged
> floor.

Ok.  So in fact it wouldn't matter whether or not addresses outside
the region are scaled, but conceptually they probably should be.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
