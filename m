Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSFAQkn>; Sat, 1 Jun 2002 12:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSFAQkm>; Sat, 1 Jun 2002 12:40:42 -0400
Received: from holomorphy.com ([66.224.33.161]:41118 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315923AbSFAQkl>;
	Sat, 1 Jun 2002 12:40:41 -0400
Date: Sat, 1 Jun 2002 09:40:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au, kernel-janitor-discuss@lists.sourceforge.net
Subject: forget_pte()
Message-ID: <20020601164002.GC10243@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
	kernel-janitor-discuss@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.656   -> 1.657  
#	         mm/memory.c	1.70    -> 1.71   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/01	wli@holomorphy.com	1.657
# memory.c:
#   Fix stale comment around forget_pte() and change to a #define in order to get accurate line numbers for BUG(), also using BUG_ON().
# --------------------------------------------
#
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Sat Jun  1 09:35:40 2002
+++ b/mm/memory.c	Sat Jun  1 09:35:40 2002
@@ -309,15 +309,12 @@
 }
 
 /*
- * Return indicates whether a page was freed so caller can adjust rss
+ * bug check to be sure pte's are unmapped when no longer used
  */
-static inline void forget_pte(pte_t page)
-{
-	if (!pte_none(page)) {
-		printk("forget_pte: old mapping existed!\n");
-		BUG();
-	}
-}
+#define forget_pte(pte)			\
+	do {				\
+		BUG_ON(!pte_none(pte));	\
+	} while (0)
 
 static void zap_pte_range(mmu_gather_t *tlb, pmd_t * pmd, unsigned long address, unsigned long size)
 {
