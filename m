Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWFBQt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWFBQt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 12:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWFBQt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 12:49:56 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:31702 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932505AbWFBQtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 12:49:55 -0400
Subject: Re: [PATCH] hugetlb: powerpc: Actively close unused htlb regions
	on vma close
From: Adam Litke <agl@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
       David Gibson <david@gibson.dropbear.id.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606021737310.26864@blonde.wat.veritas.com>
References: <1149257287.9693.6.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606021737310.26864@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 02 Jun 2006 11:49:28 -0500
Message-Id: <1149266969.9693.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 17:43 +0100, Hugh Dickins wrote:
> On Fri, 2 Jun 2006, Adam Litke wrote:
> > 
> > On powerpc, each segment can contain pages of only one size.  When a
> > hugetlb mapping is requested, a segment is located and marked for use
> > with huge pages.  This is a uni-directional operation -- hugetlb
> > segments are never marked for use again with normal pages.  For long
> > running processes which make use of a combination of normal and hugetlb
> > mappings, this behavior can unduly constrain the virtual address space.
> > 
> > The following patch introduces a architecture-specific vm_ops.close()
> > hook.  For all architectures besides powerpc, this is a no-op.  On
> > powerpc, the low and high segments are scanned to locate empty hugetlb
> > segments which can be made available for normal mappings.  Comments?
> 
> Wouldn't hugetlb_free_pgd_range be a better place to do that kind of
> thing, all within arch/powerpc, no need for arch_hugetlb_close_vma etc?

Hmm.  Interesting idea.  I'll take a look.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

