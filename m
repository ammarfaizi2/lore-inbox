Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWBVC0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWBVC0c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWBVC0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:26:32 -0500
Received: from ozlabs.org ([203.10.76.45]:26830 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750862AbWBVC0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:26:31 -0500
Date: Wed, 22 Feb 2006 13:15:10 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IA64 non-contiguous memory space bugs
Message-ID: <20060222021510.GC23574@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060222001359.GA23574@localhost.localdomain> <200602220132.k1M1Vxg09552@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602220132.k1M1Vxg09552@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 05:31:59PM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Tuesday, February 21, 2006 4:14 PM
> > Second problem is in the hugepage logic in free_pgtables()
> > (mm/memory.c).  As far as I can tell it's complete crap, and only
> > works by accident, for different accidental reasons on ppc64 and ia64,
> > the only archs that have a non-trivial is_hugepage_only_range().
> > Except that I'm not sure it does entirely work by accident on ia64:
> > suppose a process has a hugepage mapping that begins some way after
> > the beginning of the hugepage address range.  Before
> > hugetlb_free_pgd_range() gets called on that area, it will be called
> > on the next normal page VMA down - but with an end address at the
> > beginning of the hugepage VMA and so extending into the hugepage
> > address range.  I don't really understand the ia64 pagetable mapping
> > stuff well enough to tell if that's dangerous or not.
> 
> I don't see any problem in the ia64 code.  The start and end address is
> what the vma specified.  Floor and ceiling is just a hint for free_pgtables()
> to free any left over page tables between vma holes (to prev and next).
> As far as I can tell, the code looks fine.

Ah, yes, I see now.  free_pgd_range() only iterates through to end,
not ceiling so it should be fine.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
