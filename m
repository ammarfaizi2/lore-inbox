Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWJKCrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWJKCrW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 22:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWJKCrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 22:47:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:15014 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S932421AbWJKCrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 22:47:21 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,292,1157353200"; 
   d="scan'208"; a="144478544:sNHT36677088"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: "'Hugh Dickins'" <hugh@veritas.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Hugepage regression
Date: Tue, 10 Oct 2006 19:47:04 -0700
Message-ID: <000401c6ecdf$8ea49250$cb34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Acbs0zkaghv6w2zmSsuvFizjPadYRAAC6Owg
In-Reply-To: <20061011011816.GA21235@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Tuesday, October 10, 2006 6:18 PM
> Can I suggest that you put a big comment on the linked list
> declaration itself saying that you're relying on serialization here.
> Otherwise I'm worried someone will try to de-serialize it again, and
> break it without realizing.  Given the number of people who failed to
> spot the problem with the patch the first time around..


I'm not very good at writing comments, how about the following?

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- linus-2.6/mm/hugetlb.c.orig	2006-10-10 19:32:36.000000000 -0700
+++ linus-2.6/mm/hugetlb.c	2006-10-10 19:41:18.000000000 -0700
@@ -365,6 +365,11 @@ void __unmap_hugepage_range(struct vm_ar
 	pte_t pte;
 	struct page *page;
 	struct page *tmp;
+	/*
+	 * A page gathering list, protected by per file i_mmap_lock. The
+	 * lock is used to avoid list corruption from multiple unmapping
+	 * of the same page since we are using page->lru.
+	 */
 	LIST_HEAD(page_list);
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
