Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbVKIXho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbVKIXho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbVKIXho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:37:44 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:2184 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751594AbVKIXhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:37:43 -0500
Subject: [PATCH 1/4] Hugetlb: Remove duplicate i_size check
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
Date: Wed, 09 Nov 2005 17:36:49 -0600
Message-Id: <1131579410.28383.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugetlb: Remove duplicate i_size check

On Wed, 2005-10-26 at 12:00 +1000, David Gibson wrote:
> - The check against i_size was duplicated: once in
>   find_lock_huge_page() and again in hugetlb_fault() after taking the
>   page_table_lock.  We only really need the locked one, so remove the
>   other.

Original post by David Gibson <david@gibson.dropbear.id.au>

Version 2: Wed 9 Nov 2005
	Split this cleanup out into a standalone patch

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 hugetlb.c |    7 -------
 1 files changed, 7 deletions(-)
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -344,19 +344,12 @@ static struct page *find_lock_huge_page(
 {
 	struct page *page;
 	int err;
-	struct inode *inode = mapping->host;
-	unsigned long size;
 
 retry:
 	page = find_lock_page(mapping, idx);
 	if (page)
 		goto out;
 
-	/* Check to make sure the mapping hasn't been truncated */
-	size = i_size_read(inode) >> HPAGE_SHIFT;
-	if (idx >= size)
-		goto out;
-
 	if (hugetlb_get_quota(mapping))
 		goto out;
 	page = alloc_huge_page();

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

