Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSDXI5h>; Wed, 24 Apr 2002 04:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310654AbSDXI5K>; Wed, 24 Apr 2002 04:57:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47377 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293680AbSDXIzQ>;
	Wed, 24 Apr 2002 04:55:16 -0400
Message-ID: <3CC6730F.86CB43C6@zip.com.au>
Date: Wed, 24 Apr 2002 01:55:43 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] remove PG_skip
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove PG_skip.  Nothing is using it (the change was acked by rmk a
while back)

=====================================

--- 2.5.9/include/linux/page-flags.h~cleanup-050-pg_skip	Wed Apr 24 01:06:14 2002
+++ 2.5.9-akpm/include/linux/page-flags.h	Wed Apr 24 01:06:14 2002
@@ -32,9 +32,6 @@
  * active, inactive_dirty and inactive_clean lists are protected by
  * the pagemap_lru_lock, and *NOT* by the usual PG_locked_dontuse bit!
  *
- * PG_skip is used on sparc/sparc64 architectures to "skip" certain
- * parts of the address space.
- *
  * PG_error is set to indicate that an I/O error occurred on this page.
  *
  * PG_arch_1 is an architecture specific page state bit.  The generic
@@ -62,14 +59,13 @@
 #define PG_active		 7
 
 #define PG_slab			 8	/* slab debug (Suparna wants this) */
-#define PG_skip			10	/* kill me now: obsolete */
-#define PG_highmem		11
-#define PG_checked		12	/* kill me in 2.5.<early>. */
+#define PG_highmem		 9
+#define PG_checked		10	/* kill me in 2.5.<early>. */
+#define PG_arch_1		11
 
-#define PG_arch_1		13
-#define PG_reserved		14
-#define PG_launder		15	/* written out by VM pressure.. */
-#define PG_private		16	/* Has something at ->private */
+#define PG_reserved		12
+#define PG_launder		13	/* written out by VM pressure.. */
+#define PG_private		14	/* Has something at ->private */
 
 /*
  * Per-CPU page acounting.  Inclusion of this file requires
--- 2.5.9/arch/arm/mm/init.c~cleanup-050-pg_skip	Wed Apr 24 01:06:14 2002
+++ 2.5.9-akpm/arch/arm/mm/init.c	Wed Apr 24 01:44:54 2002
@@ -64,18 +64,6 @@ static struct meminfo meminfo __initdata
  */
 struct page *empty_zero_page;
 
-/* This is currently broken
- * PG_skip is used on sparc/sparc64 architectures to "skip" certain
- * parts of the address space.
- *
- * #define PG_skip	10
- * #define PageSkip(page) (machine_is_riscpc() && test_bit(PG_skip, &(page)->flags))
- *			if (PageSkip(page)) {
- *				page = page->next_hash;
- *				if (page == NULL)
- *					break;
- *			}
- */
 void show_mem(void)
 {
 	int free = 0, total = 0, reserved = 0;
