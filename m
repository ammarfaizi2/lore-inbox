Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317724AbSGRFXh>; Thu, 18 Jul 2002 01:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317856AbSGRFXh>; Thu, 18 Jul 2002 01:23:37 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:5830 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317724AbSGRFXf>;
	Thu, 18 Jul 2002 01:23:35 -0400
Date: Wed, 17 Jul 2002 22:23:42 -0700
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make tlb_remove_tlb_entry take ptep
Message-ID: <20020718052342.GE1204@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It seems only ppc32 and ppc64 use tlb_remove_tlb_entry. On ppc64 we need
a pointer to the pte so we can change some of the pte bits.

Paul has some nice patches to clean up tlb teardown, but the following
patch should allow ppc32 and ppc64 to work in the meantime.

Anton

===== include/asm-arm/tlb.h 1.2 vs edited =====
--- 1.2/include/asm-arm/tlb.h	Sat May 25 16:51:16 2002
+++ edited/include/asm-arm/tlb.h	Wed Jul 17 19:31:24 2002
@@ -11,7 +11,7 @@
 #define tlb_end_vma(tlb,vma)	\
 	flush_tlb_range(vma, vma->vm_start, vma->vm_end)
 
-#define tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
+#define tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 #include <asm-generic/tlb.h>
 
===== include/asm-i386/tlb.h 1.4 vs edited =====
--- 1.4/include/asm-i386/tlb.h	Fri May 24 11:22:21 2002
+++ edited/include/asm-i386/tlb.h	Wed Jul 17 19:31:17 2002
@@ -7,7 +7,7 @@
  */
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
+#define tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 /*
  * .. because we flush the whole mm when it
===== include/asm-ia64/tlb.h 1.2 vs edited =====
--- 1.2/include/asm-ia64/tlb.h	Fri May 24 23:45:09 2002
+++ edited/include/asm-ia64/tlb.h	Wed Jul 17 19:31:13 2002
@@ -1,7 +1,7 @@
 /* XXX fix me! */
 #define tlb_start_vma(tlb, vma)			do { } while (0)
 #define tlb_end_vma(tlb, vma)			do { } while (0)
-#define tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
+#define tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 #define tlb_flush(tlb)				flush_tlb_mm((tlb)->mm)
 
 #include <asm-generic/tlb.h>
===== include/asm-m68k/tlb.h 1.2 vs edited =====
--- 1.2/include/asm-m68k/tlb.h	Wed May 22 13:19:23 2002
+++ edited/include/asm-m68k/tlb.h	Wed Jul 17 19:31:09 2002
@@ -7,7 +7,7 @@
  */
 #define tlb_start_vma(tlb, vma)	do { } while (0)
 #define tlb_end_vma(tlb, vma)	do { } while (0)
-#define tlb_remove_tlb_entry(tlb, pte, address)	do { } while (0)
+#define tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
 
 /*
  * .. because we flush the whole mm when it
===== include/asm-s390/tlb.h 1.2 vs edited =====
--- 1.2/include/asm-s390/tlb.h	Thu Jun  6 14:31:19 2002
+++ edited/include/asm-s390/tlb.h	Wed Jul 17 19:31:05 2002
@@ -7,7 +7,7 @@
  */
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
+#define tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 /*
  * .. because we flush the whole mm when it
===== include/asm-s390x/tlb.h 1.2 vs edited =====
--- 1.2/include/asm-s390x/tlb.h	Thu Jun  6 14:31:19 2002
+++ edited/include/asm-s390x/tlb.h	Wed Jul 17 19:31:01 2002
@@ -7,7 +7,7 @@
  */
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
+#define tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 /*
  * .. because we flush the whole mm when it
===== include/asm-sparc64/tlb.h 1.4 vs edited =====
--- 1.4/include/asm-sparc64/tlb.h	Fri Jun  7 00:53:12 2002
+++ edited/include/asm-sparc64/tlb.h	Wed Jul 17 19:30:17 2002
@@ -16,7 +16,7 @@
 		flush_tlb_range(vma, vma->vm_start, vma->vm_end); \
 } while (0)
 
-#define tlb_remove_tlb_entry(tlb, pte, address) \
+#define tlb_remove_tlb_entry(tlb, ptep, address) \
 	do { } while (0)
 
 #include <asm-generic/tlb.h>
===== include/asm-x86_64/tlb.h 1.2 vs edited =====
--- 1.2/include/asm-x86_64/tlb.h	Thu May 30 13:12:17 2002
+++ edited/include/asm-x86_64/tlb.h	Wed Jul 17 19:30:04 2002
@@ -4,7 +4,7 @@
 
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
+#define tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 #define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
 
===== mm/memory.c 1.74 vs edited =====
--- 1.74/mm/memory.c	Thu Jul  4 09:17:35 2002
+++ edited/mm/memory.c	Wed Jul 17 19:27:58 2002
@@ -335,7 +335,7 @@
 			unsigned long pfn = pte_pfn(pte);
 
 			pte = ptep_get_and_clear(ptep);
-			tlb_remove_tlb_entry(tlb, pte, address+offset);
+			tlb_remove_tlb_entry(tlb, ptep, address+offset);
 			if (pfn_valid(pfn)) {
 				struct page *page = pfn_to_page(pfn);
 				if (!PageReserved(page)) {
