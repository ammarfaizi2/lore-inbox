Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317626AbSFIPkf>; Sun, 9 Jun 2002 11:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSFIPke>; Sun, 9 Jun 2002 11:40:34 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:56044 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S317626AbSFIPkd>; Sun, 9 Jun 2002 11:40:33 -0400
Date: Sun, 9 Jun 2002 11:45:31 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: r128.o unresolved symbol vmalloc_32
In-Reply-To: <E17H3pz-0006PB-00@baldrick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020609154029.HOGG24507.pop016.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> linux-2.5.21:
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b /usr/src/linux-2.5.21/debian/tmp-image -r 2.5.21; fi
> depmod: *** Unresolved symbols in /usr/src/linux-2.5.21/debian/tmp-image/lib/modules/2.5.21/kernel/drivers/char/drm/r128.o
> depmod:         vmalloc_32
> make[2]: *** [_modinst_post] Error 1

Here's an updated version of the patch I posted earlier.  This one
also exports vmalloc_32 and vmalloc_dma.


diff -ruN lin/mm/Makefile linux/mm/Makefile
--- lin/mm/Makefile	Sun Jun  9 05:53:08 2002
+++ linux/mm/Makefile	Sun Jun  9 05:52:17 2002
@@ -10,7 +10,7 @@
 O_TARGET := mm.o
 
 export-objs := shmem.o filemap.o mempool.o page_alloc.o \
-		page-writeback.o
+		page-writeback.o vmalloc.o
 
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
diff -ruN lin/mm/vmalloc.c linux/mm/vmalloc.c
--- lin/mm/vmalloc.c	Sun Jun  9 05:53:01 2002
+++ linux/mm/vmalloc.c	Sun Jun  9 11:40:01 2002
@@ -8,6 +8,7 @@
 
 #include <linux/config.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/spinlock.h>
 #include <linux/highmem.h>
@@ -354,3 +355,7 @@
 	read_unlock(&vmlist_lock);
 	return buf - buf_start;
 }
+
+EXPORT_SYMBOL(vmalloc);
+EXPORT_SYMBOL(vmalloc_dma);
+EXPORT_SYMBOL(vmalloc_32);


-- 
Skip
