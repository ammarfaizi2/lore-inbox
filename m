Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbTBXVom>; Mon, 24 Feb 2003 16:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267608AbTBXVom>; Mon, 24 Feb 2003 16:44:42 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18824 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267602AbTBXVol>;
	Mon, 24 Feb 2003 16:44:41 -0500
Subject: [PATCH] pte_alloc_kernel needs additional check
From: Paul Larson <plars@linuxtestproject.org>
To: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 24 Feb 2003 15:54:39 -0600
Message-Id: <1046123680.13919.67.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This applies against 2.5.63.
pte_alloc_kernel needs a check for pmd_present(*pmd) at the end.

Thanks,
Paul Larson

--- linux-2.5.63/mm/memory.c	Mon Feb 24 13:05:31 2003
+++ linux-2.5.63-fix/mm/memory.c	Mon Feb 24 15:45:05 2003
@@ -186,7 +186,9 @@
 		pmd_populate_kernel(mm, pmd, new);
 	}
 out:
-	return pte_offset_kernel(pmd, address);
+	if (pmd_present(*pmd))
+		return pte_offset_kernel(pmd, address);
+	return NULL;
 }
 #define PTE_TABLE_MASK	((PTRS_PER_PTE-1) * sizeof(pte_t))
 #define PMD_TABLE_MASK	((PTRS_PER_PMD-1) * sizeof(pmd_t))


