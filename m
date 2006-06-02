Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWFBQnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWFBQnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 12:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWFBQnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 12:43:22 -0400
Received: from gold.veritas.com ([143.127.12.110]:40377 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750783AbWFBQnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 12:43:21 -0400
X-IronPort-AV: i="4.05,204,1146466800"; 
   d="scan'208"; a="60150909:sNHT29980692"
Date: Fri, 2 Jun 2006 17:43:13 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Adam Litke <agl@us.ibm.com>
cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
       David Gibson <david@gibson.dropbear.id.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: powerpc: Actively close unused htlb regions on
 vma close
In-Reply-To: <1149257287.9693.6.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606021737310.26864@blonde.wat.veritas.com>
References: <1149257287.9693.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Jun 2006 16:43:21.0599 (UTC) FILETIME=[A8A640F0:01C68663]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006, Adam Litke wrote:
> 
> On powerpc, each segment can contain pages of only one size.  When a
> hugetlb mapping is requested, a segment is located and marked for use
> with huge pages.  This is a uni-directional operation -- hugetlb
> segments are never marked for use again with normal pages.  For long
> running processes which make use of a combination of normal and hugetlb
> mappings, this behavior can unduly constrain the virtual address space.
> 
> The following patch introduces a architecture-specific vm_ops.close()
> hook.  For all architectures besides powerpc, this is a no-op.  On
> powerpc, the low and high segments are scanned to locate empty hugetlb
> segments which can be made available for normal mappings.  Comments?

Wouldn't hugetlb_free_pgd_range be a better place to do that kind of
thing, all within arch/powerpc, no need for arch_hugetlb_close_vma etc?

Hugh
