Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbULQEND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbULQEND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 23:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbULQEJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 23:09:45 -0500
Received: from mail.renesas.com ([202.234.163.13]:911 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262741AbULQEGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 23:06:49 -0500
Date: Fri, 17 Dec 2004 13:06:36 +0900 (JST)
Message-Id: <20041217.130636.52185712.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Clean up
 include/asm-m32r/pgtable-2level.h (3/3)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041217.130507.241920387.takata.hirokazu@renesas.com>
References: <20041217.130507.241920387.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.10-rc3-mm1] m32r: Clean up include/asm-m32r/pgtable-2level.h (3/3)
- Add #ifdef __KERNEL__
- Change __inline__ to inline for __KERNEL__ portion.
- Remove RCS ID string.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/pgtable-2level.h |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)


diff -ruNp a/include/asm-m32r/pgtable-2level.h b/include/asm-m32r/pgtable-2level.h
--- a/include/asm-m32r/pgtable-2level.h	2004-12-16 16:13:05.000000000 +0900
+++ b/include/asm-m32r/pgtable-2level.h	2004-12-16 16:13:28.000000000 +0900
@@ -1,7 +1,7 @@
 #ifndef _ASM_M32R_PGTABLE_2LEVEL_H
 #define _ASM_M32R_PGTABLE_2LEVEL_H
 
-/* $Id$ */
+#ifdef __KERNEL__
 
 #include <linux/config.h>
 
@@ -33,9 +33,9 @@
  * setup: the pgd is never bad, and a pmd always exists (as it's folded
  * into the pgd entry)
  */
-static __inline__ int pgd_none(pgd_t pgd)	{ return 0; }
-static __inline__ int pgd_bad(pgd_t pgd)	{ return 0; }
-static __inline__ int pgd_present(pgd_t pgd)	{ return 1; }
+static inline int pgd_none(pgd_t pgd)	{ return 0; }
+static inline int pgd_bad(pgd_t pgd)	{ return 0; }
+static inline int pgd_present(pgd_t pgd)	{ return 1; }
 #define pgd_clear(xp)				do { } while (0)
 
 /*
@@ -55,7 +55,7 @@ static __inline__ int pgd_present(pgd_t 
 #define pgd_page(pgd) \
 ((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
 
-static __inline__ pmd_t *pmd_offset(pgd_t * dir, unsigned long address)
+static inline pmd_t *pmd_offset(pgd_t * dir, unsigned long address)
 {
 	return (pmd_t *) dir;
 }
@@ -72,4 +72,6 @@ static __inline__ pmd_t *pmd_offset(pgd_
 #define pte_to_pgoff(pte)	(((pte_val(pte) >> 2) & 0xef) | (((pte_val(pte) >> 10)) << 7))
 #define pgoff_to_pte(off)	((pte_t) { (((off) & 0xef) << 2) | (((off) >> 7) << 10) | _PAGE_FILE })
 
+#endif /* __KERNEL__ */
+
 #endif /* _ASM_M32R_PGTABLE_2LEVEL_H */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

