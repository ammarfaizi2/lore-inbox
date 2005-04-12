Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVDLU1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVDLU1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVDLUZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:25:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:10952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262127AbVDLKbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:14 -0400
Message-Id: <200504121031.j3CAVBil005257@shell0.pdx.osdl.net>
Subject: [patch 034/198] ppc32: Allow adjust of pfn offset in pte
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, galak@freescale.com,
       kumar.gala@freescale.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Kumar Gala <galak@freescale.com>

Allow the pfn to be offset by more than just PAGE_SHIFT in the pte.  Today,
PAGE_SHIFT tends to allow us to have 12-bits of flags in the pte.  In the
future if we have a larger pte we can allocate more bits for flags by
offsetting the pfn even further.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-ppc/pgtable.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -puN include/asm-ppc/pgtable.h~ppc32-allow-adjust-of-pfn-offset-in-pte include/asm-ppc/pgtable.h
--- 25/include/asm-ppc/pgtable.h~ppc32-allow-adjust-of-pfn-offset-in-pte	2005-04-12 03:21:11.573377480 -0700
+++ 25-akpm/include/asm-ppc/pgtable.h	2005-04-12 03:21:11.576377024 -0700
@@ -431,10 +431,15 @@ extern unsigned long bad_call_to_PMD_PAG
  * Conversions between PTE values and page frame numbers.
  */
 
-#define pte_pfn(x)		(pte_val(x) >> PAGE_SHIFT)
+/* in some case we want to additionaly adjust where the pfn is in the pte to
+ * allow room for more flags */
+#define PFN_SHIFT_OFFSET	(PAGE_SHIFT)
+
+#define pte_pfn(x)		(pte_val(x) >> PFN_SHIFT_OFFSET)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
-#define pfn_pte(pfn, prot)	__pte(((pte_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pfn_pte(pfn, prot)	__pte(((pte_basic_t)(pfn) << PFN_SHIFT_OFFSET) |\
+					pgprot_val(prot))
 #define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
 
 /*
_
