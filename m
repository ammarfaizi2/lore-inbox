Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSLBOzR>; Mon, 2 Dec 2002 09:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSLBOzR>; Mon, 2 Dec 2002 09:55:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41231 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262667AbSLBOzQ>;
	Mon, 2 Dec 2002 09:55:16 -0500
Date: Mon, 2 Dec 2002 15:02:44 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Neaten up mm/Makefile
Message-ID: <20021202150244.B27991@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the include of (the now empty) Rules.make, gets rid of
the ifndef clause and fixes the indentation.

===== mm/Makefile 1.20 vs edited =====
--- 1.20/mm/Makefile	Tue Nov 26 08:33:23 2002
+++ edited/mm/Makefile	Mon Dec  2 06:01:36 2002
@@ -4,18 +4,13 @@
 
 export-objs := shmem.o filemap.o mempool.o page_alloc.o page-writeback.o
 
-obj-y	    := bootmem.o filemap.o mempool.o oom_kill.o page_alloc.o \
-	       page-writeback.o pdflush.o readahead.o slab.o swap.o \
-	       truncate.o vcache.o vmscan.o
+mmu-y			:= nommu.o
+mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
+			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
+			   shmem.o vmalloc.o
 
-obj-$(CONFIG_MMU)	+= fremap.o highmem.o madvise.o memory.o \
-			   mincore.o mlock.o mmap.o mprotect.o mremap.o \
-			   msync.o rmap.o shmem.o vmalloc.o
+obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o \
+			   page_alloc.o page-writeback.o pdflush.o readahead.o \
+			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
-
-ifneq ($(CONFIG_MMU),y)
-obj-y			+= nommu.o
-endif
-
-include $(TOPDIR)/Rules.make

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
