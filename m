Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbUJZB7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbUJZB7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUJZB57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:57:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:9103 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261944AbUJZB1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:27:18 -0400
Date: Mon, 25 Oct 2004 18:26:42 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V2 [0/8]: Discussion and overview
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from V1:
- support huge pages in flush_dcache_page on various architectures
- revised simple numa allocation
- do not include update_mmu_cache in set_huge_pte. Require huge_update_mmu_cache

This is a revised edition of the hugetlb demand page patches by
Kenneth Chen which were discussed in the following thread in August 2004

http://marc.theaimsgroup.com/?t=109171285000004&r=1&w=2

The initial post by Ken was in April in

http://marc.theaimsgroup.com/?l=linux-ia64&m=108189860401704&w=2

Hugetlb demand paging has been part of SuSE SLES 9 for awhile now and this
patchset is intended to help hugetlb demand paging also get into the official
Linux kernel. Huge pages are referred to as "compound" pages in terms of "struct page"
in the Linux kernel. The term "compund page" may be used alternatively to
huge page.

Note that this is just the second patchset and is to be seen as discussion basis.
not as a final patchset. Please review these patches. Contributions welcome in
particular to sparc64, sh and sh64 architecture support since I do not have any of those
platforms available to me.

The patchset consists of 8 patches.

1/8 Demand Paging patch. Ken's original work plus a fix that was posted later.

2/8 Avoid-overcommit patch: Also mostly the original work by Ken plus a fix that he
	posted later.

3/8 Numa patch: Make the huge page allocator try to allocate local memory.

4/8 ia64 arch modifications

5/8 i386 arch modifications

6/8 sparc64 arch modifications (untested!)

7/8 sh64 arch modifications (untested!)

8/8 sh arch modifications (untested!)

Open issues:
- memory policy for numa alloc is only available in mempolicy.c and not in hugetlb.c
  If hugepage allocation needs to follow mempolicy then we need additional stuff
  in mempolicy.c exported (defer for now).

- Do other arch specific functions need to be aware of compound pages for
  this to work?

- Clearing hugetlb pages is time consuming using clear_highpage in alloc_huge_page.
  Make it possible to use hw assist via DMA or so there?

- sparc64 arch code needs to be tested

- sh64 code needs to be fixed up and tested

- sh code needs to be fixed up and tested
