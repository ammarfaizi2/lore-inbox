Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSFFVYk>; Thu, 6 Jun 2002 17:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317195AbSFFVYj>; Thu, 6 Jun 2002 17:24:39 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:22962
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317194AbSFFVYa>; Thu, 6 Jun 2002 17:24:30 -0400
Date: Thu, 6 Jun 2002 14:24:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove numerous includes from <linux/mm.h>
Message-ID: <20020606212418.GJ14252@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 4 #includes from <linux/mm.h> and fix up implicit includes.

This remove linux/gfp.h, linux/string.h, linux/mmzone.h and
linux/rbtree.h from <linux/mm.h> and fixes the callers which relied on
<linux/mm.h> to provide <linux/gfp.h>

This relies on all of the previously sent patches to work.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== fs/isofs/namei.c 1.9 vs edited =====
--- 1.9/fs/isofs/namei.c	Thu May 23 06:18:50 2002
+++ edited/fs/isofs/namei.c	Thu Jun  6 12:33:14 2002
@@ -13,6 +13,7 @@
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
+#include <linux/gfp.h>
 #include <linux/errno.h>
 #include <linux/config.h>	/* Joliet? */
 #include <linux/smp_lock.h>
===== include/asm-i386/pgalloc.h 1.16 vs edited =====
--- 1.16/include/asm-i386/pgalloc.h	Thu Jun  6 11:35:04 2002
+++ edited/include/asm-i386/pgalloc.h	Thu Jun  6 12:15:09 2002
@@ -6,6 +6,7 @@
 #include <asm/fixmap.h>
 #include <linux/threads.h>
 #include <linux/mm.h>		/* for struct page */
+#include <linux/gfp.h>
 
 #define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
===== include/linux/mm.h 1.55 vs edited =====
--- 1.55/include/linux/mm.h	Sat May 25 16:25:47 2002
+++ edited/include/linux/mm.h	Thu Jun  6 12:15:09 2002
@@ -7,12 +7,8 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
-#include <linux/gfp.h>
-#include <linux/string.h>
 #include <linux/list.h>
-#include <linux/mmzone.h>
 #include <linux/swap.h>
-#include <linux/rbtree.h>
 #include <linux/fs.h>
 
 extern unsigned long max_mapnr;
===== mm/bootmem.c 1.9 vs edited =====
--- 1.9/mm/bootmem.c	Mon Jun  3 08:24:55 2002
+++ edited/mm/bootmem.c	Thu Jun  6 12:28:37 2002
@@ -10,6 +10,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/gfp.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
 #include <linux/swapctl.h>
===== mm/numa.c 1.5 vs edited =====
--- 1.5/mm/numa.c	Sat May 25 16:25:47 2002
+++ edited/mm/numa.c	Thu Jun  6 12:28:35 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
