Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316591AbSE1OUv>; Tue, 28 May 2002 10:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316488AbSE1OUu>; Tue, 28 May 2002 10:20:50 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:42966 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S316309AbSE1OUt>;
	Tue, 28 May 2002 10:20:49 -0400
Date: Tue, 28 May 2002 17:20:49 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre8 compile fix
Message-ID: <Pine.GSO.4.43.0205281655270.4827-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19-pre8 from BK, x86 and sparc, all partition types enabled:

fs/fs.o: In function `riscix_partition':
fs/fs.o(.text+0x27eb4): undefined reference to `page_cache_release'
fs/fs.o: In function `linux_partition':
fs/fs.o(.text+0x28054): undefined reference to `page_cache_release'
fs/fs.o: In function `adfspart_check_ADFS':
fs/fs.o(.text+0x280e8): undefined reference to `page_cache_release'
fs/fs.o(.text+0x28138): undefined reference to `page_cache_release'
fs/fs.o: In function `adfspart_check_ICSLinux':
fs/fs.o(.text+0x28268): undefined reference to `page_cache_release'
fs/fs.o(.text+0x28440): more undefined references to `page_cache_release' follow

page_cache_release is used in check.c and check.h. check.h is included
in several other files (includeing check.c) and there the errors come.
The solution is to include linux/pagemap.h in check.h.

This is a resubmit by me, I'm not the original author of the patch but
the problem bites me since I compile in support for all partition types.

The patch:

--- fs/partitions/check.h.old	Fri May 24 18:59:10 2002
+++ fs/partitions/check.h	Fri May 24 18:59:36 2002
@@ -2,6 +2,9 @@
  * add_partition adds a partitions details to the devices partition
  * description.
  */
+
+#include <linux/pagemap.h>
+
 void add_gd_partition(struct gendisk *hd, int minor, int start, int size);

 typedef struct {struct page *v;} Sector;

-- 
Meelis Roos (mroos@linux.ee)

