Return-Path: <linux-kernel-owner+w=401wt.eu-S1753238AbWL2EN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbWL2EN6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 23:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbWL2EN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 23:13:58 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:34993 "EHLO
	ausmtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbWL2EN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 23:13:57 -0500
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Balbir Singh <balbir@in.ibm.com>
Date: Fri, 29 Dec 2006 09:43:10 +0530
Message-Id: <20061229041310.1217.32072.sendpatchset@balbir.in.ibm.com>
Subject: [PATCH 2.6.20-rc2] Fix set_pte_at arguments in page_mkclean_one
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

page_mkclean_one() passes vma instead of the expected mm as argument1 to
set_pte_at. Below is a simple fix (tested by compiling the kernel on
powerpc). Please ignore the patch, if a fix has already been applied.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 mm/rmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN mm/rmap.c~fix-set-pte-in-page_mkclean_one mm/rmap.c
--- linux-2.6.20-rc2/mm/rmap.c~fix-set-pte-in-page_mkclean_one	2006-12-29 09:18:26.000000000 +0530
+++ linux-2.6.20-rc2-balbir/mm/rmap.c	2006-12-29 09:25:28.000000000 +0530
@@ -461,7 +461,7 @@ static int page_mkclean_one(struct page 
 		entry = ptep_clear_flush(vma, address, pte);
 		entry = pte_wrprotect(entry);
 		entry = pte_mkclean(entry);
-		set_pte_at(vma, address, pte, entry);
+		set_pte_at(mm, address, pte, entry);
 		lazy_mmu_prot_update(entry);
 		ret = 1;
 	}
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
