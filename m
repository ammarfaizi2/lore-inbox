Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUJVUqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUJVUqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUJVUqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:46:15 -0400
Received: from holomorphy.com ([207.189.100.168]:57797 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267737AbUJVUpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:45:13 -0400
Date: Fri, 22 Oct 2004 13:45:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [2/4]: set_huge_pte() arch updates
Message-ID: <20041022204506.GD17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410212156300.3524@schroedinger.engr.sgi.com> <20041022103708.GK17038@holomorphy.com> <Pine.LNX.4.58.0410220829200.7868@schroedinger.engr.sgi.com> <20041022154219.GY17038@holomorphy.com> <Pine.LNX.4.58.0410221318370.9833@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410221318370.9833@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, William Lee Irwin III wrote:
>> What is in fact far more pressing is flush_dcache_page(), without a
>> correct implementation of which for hugetlb, user-visible data
>> corruption follows.

On Fri, Oct 22, 2004 at 01:29:24PM -0700, Christoph Lameter wrote:
> When is flush_dcache_page used on a huge page?
> It seems that the i386 simply does nothing for flush_dcache_page. IA64
> defers to update_mmu_cache by setting PG_arch_1. So these two are ok as
> is.
> The other archs are likely much more involved than this. I tried to find
> an simple way to identify a page as a huge page via struct page but
> that is not that easy and its likely not good to follow
> pointers to pointers in such a critical function. Maybe we need to add a
> new page flag?

It's not done at all for hugepages now, and needs to be. Fault handling
on hugetlb vmas will likely expose the cahing of stale data more readily.


-- wli
