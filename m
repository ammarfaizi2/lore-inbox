Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSFIJvj>; Sun, 9 Jun 2002 05:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317586AbSFIJvi>; Sun, 9 Jun 2002 05:51:38 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:31202 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S317580AbSFIJvi>; Sun, 9 Jun 2002 05:51:38 -0400
Date: Sun, 9 Jun 2002 05:56:30 -0400
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Unresolved symbol - vmalloc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020609095134.HNIV24507.pop016.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several modules reference vmalloc and it's no longer an inline,
so I think it needs to be exported.  Please tell me if I'm wrong.


diff -ruN linux/mm/Makefile lin/mm/Makefile
--- linux/mm/Makefile	Sun Jun  9 05:53:08 2002
+++ lin/mm/Makefile	Sun Jun  9 05:52:17 2002
@@ -10,7 +10,7 @@
 O_TARGET := mm.o
 
 export-objs := shmem.o filemap.o mempool.o page_alloc.o \
-		page-writeback.o
+		page-writeback.o vmalloc.o
 
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
diff -ruN linux/mm/vmalloc.c lin/mm/vmalloc.c
--- linux/mm/vmalloc.c	Sun Jun  9 05:53:01 2002
+++ lin/mm/vmalloc.c	Sun Jun  9 05:52:17 2002
@@ -8,6 +8,7 @@
 
 #include <linux/config.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/spinlock.h>
 #include <linux/highmem.h>
@@ -354,3 +355,5 @@
 	read_unlock(&vmlist_lock);
 	return buf - buf_start;
 }
+
+EXPORT_SYMBOL(vmalloc);

-- 
Skip
