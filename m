Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317877AbSHHTZz>; Thu, 8 Aug 2002 15:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSHHTZz>; Thu, 8 Aug 2002 15:25:55 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:25481 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S317877AbSHHTZy>;
	Thu, 8 Aug 2002 15:25:54 -0400
Date: Thu, 8 Aug 2002 14:29:33 -0500
From: Robin Holt <holt@sgi.com>
X-X-Sender: <holt@fsgi123.americas.sgi.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: What about adding L1_CACHE_MASK and L1_CACHE_ALIGNED?
Message-ID: <Pine.SGI.4.33.0208081416080.100441-100000@fsgi123.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While doing some work with a hardware specific driver, I kept running
across cases where the following mod to <linux/cache.h> would be helpful.
What is the general opinion towards getting this accepted into 2.5?  How
about 2.4.20?

Thanks,
Robin Holt

---------------------------  Diff follows  ---------------------------
--- linux-2.4.19/include/linux/cache.h  Fri Dec 21 11:42:03 2001
+++ linux-2.4.19-modified/include/linux/cache.h Thu Aug  8 14:26:32 2002
@@ -4,8 +4,16 @@
 #include <linux/config.h>
 #include <asm/cache.h>

+#ifndef L1_CACHE_MASK
+#define L1_CACHE_MASK  L1_CACHE_BYTES - 1
+#endif
+
 #ifndef L1_CACHE_ALIGN
-#define L1_CACHE_ALIGN(x) (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
+#define L1_CACHE_ALIGN(x) (((x)+(L1_CACHE_MASK))&~(L1_CACHE_MASK))
+#endif
+
+#ifndef L1_CACHE_ALIGNED
+#define L1_CACHE_ALIGNED(_p)    (((u64)(_p) & L1_CACHE_MASK) == 0)
 #endif

 #ifndef SMP_CACHE_BYTES


