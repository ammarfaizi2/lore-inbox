Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbVJSOdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVJSOdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 10:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVJSOdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 10:33:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:5845 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751008AbVJSOdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 10:33:25 -0400
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
	2.6.14-rc4-git5
From: Adam Litke <agl@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rohit Seth <rohit.seth@intel.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20051018210721.4c80a292.akpm@osdl.org>
References: <20051018141512.A26194@unix-os.sc.intel.com>
	 <20051018143438.66d360c4.akpm@osdl.org>
	 <1129673824.19875.36.camel@akash.sc.intel.com>
	 <20051018172549.7f9f31da.akpm@osdl.org>
	 <1129692330.24309.44.camel@akash.sc.intel.com>
	 <20051018210721.4c80a292.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Wed, 19 Oct 2005 09:33:07 -0500
Message-Id: <1129732387.8702.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 21:07 -0700, Andrew Morton wrote:
> Rohit Seth <rohit.seth@intel.com> wrote:
> >
> > The prefetching problem is handled OK for regular pages because we can
> >  handle page faults corresponding to those pages.  That is currently not
> >  true for hugepages.  Currently the kernel assumes that PAGE_FAULT
> >  happening against a hugetlb page is caused by truncate and returns
> >  SIGBUS.
> 
> Doh.  No fault handler.  The penny finally drops.
> 
> Adam, I think this patch is temporary?

Yeah, looks like it can be dropped now since we handle this case (in
hugetlb_fault) as:

>         size = i_size_read(mapping->host) >> HPAGE_SHIFT;
>         if (idx >= size)
>                 goto backout;
> 
>         ret = VM_FAULT_MINOR;
>         if (!pte_none(*pte))
>                 goto backout;

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

