Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbVKIXip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbVKIXip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbVKIXip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:38:45 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15834 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751597AbVKIXio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:38:44 -0500
Subject: [PATCH 2/4] Hugetlb: Rename find_lock_page to
	find_or_alloc_huge_page
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       David Gibson <david@gibson.dropbear.id.au>, wli@holomorphy.com,
       hugh@veritas.com, rohit.seth@intel.com, kenneth.w.chen@intel.com,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
In-Reply-To: <1131578925.28383.9.camel@localhost.localdomain>
References: <1131578925.28383.9.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Wed, 09 Nov 2005 17:37:52 -0600
Message-Id: <1131579472.28383.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugetlb: Rename find_lock_page to find_or_alloc_huge_page

On Wed, 2005-10-26 at 12:00 +1000, David Gibson wrote:
- find_lock_huge_page() isn't a great name, since it does extra things
  not analagous to find_lock_page().  Rename it
  find_or_alloc_huge_page() which is closer to the mark.

Original post by David Gibson <david@gibson.dropbear.id.au>

Version 2: Wed 9 Nov 2005
	Split into a separate patch

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 hugetlb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -339,8 +339,8 @@ void unmap_hugepage_range(struct vm_area
 	flush_tlb_range(vma, start, end);
 }
 
-static struct page *find_lock_huge_page(struct address_space *mapping,
-			unsigned long idx)
+static struct page *find_or_alloc_huge_page(struct address_space *mapping,
+						unsigned long idx)
 {
 	struct page *page;
 	int err;
@@ -392,7 +392,7 @@ int hugetlb_fault(struct mm_struct *mm, 
 	 * Use page lock to guard against racing truncation
 	 * before we get page_table_lock.
 	 */
-	page = find_lock_huge_page(mapping, idx);
+	page = find_or_alloc_huge_page(mapping, idx);
 	if (!page)
 		goto out;
 

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

