Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVJSU3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVJSU3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVJSU3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:29:10 -0400
Received: from gold.veritas.com ([143.127.12.110]:52484 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751303AbVJSU3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:29:09 -0400
Date: Wed, 19 Oct 2005 21:28:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: rohit.seth@intel.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       agl@us.ibm.com
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
 2.6.14-rc4-git5
In-Reply-To: <20051019131907.05ea7160.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0510192126100.11096@goblin.wat.veritas.com>
References: <20051018141512.A26194@unix-os.sc.intel.com>
 <20051018143438.66d360c4.akpm@osdl.org> <1129673824.19875.36.camel@akash.sc.intel.com>
 <20051018172549.7f9f31da.akpm@osdl.org> <1129692330.24309.44.camel@akash.sc.intel.com>
 <20051018210721.4c80a292.akpm@osdl.org> <Pine.LNX.4.61.0510191623220.7586@goblin.wat.veritas.com>
 <1129748733.339.90.camel@akash.sc.intel.com> <Pine.LNX.4.61.0510192049030.10794@goblin.wat.veritas.com>
 <20051019131907.05ea7160.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Oct 2005 20:29:09.0154 (UTC) FILETIME=[C2439820:01C5D4EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> > 
> >  I was forgetting that extending ftruncate wasn't supported in 2.6.14 and
> >  earlier, yes.  But I'm afraid the above scenario can still happen there:
> >  extending is done, not by ftruncate, but by (somewhere else) mmapping the
> >  larger size.   So your fix may still cause a tight infinite fault loop.
> 
> Will it?  Whenever we mmap a hugetlbfs file we prepopulate the entire vma
> with hugepages.  So I don't think there's ever any part of an address space
> which ia a) inside a hugepage vma and b) doesn't have a hugepage backing
> it.

The new vma, sure, will be fully populated.  But the old vma, in this
or some other process, which was created before the hugetlbfs file was
truncated down, will be left with a hole at the end.

Hugh
