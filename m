Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUDGRyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 13:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUDGRyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 13:54:12 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58497
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263875AbUDGRyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 13:54:10 -0400
Date: Wed, 7 Apr 2004 19:54:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: GFP_LEVEL_MASK for -mc2
Message-ID: <20040407175409.GK26888@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply this patch to -mc, against mc2:

diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.6.5-mc2-orig/include/linux/gfp.h 2.6.5-mc2/include/linux/gfp.h
--- 2.6.5-mc2-orig/include/linux/gfp.h	2004-04-07 19:50:58.800821480 +0200
+++ 2.6.5-mc2/include/linux/gfp.h	2004-04-07 19:50:30.895063800 +0200
@@ -37,6 +37,11 @@
 #define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
+/* if you forget to add the bitmask here kernel will crash, period */
+#define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
+			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
+			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP)
+
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
 #define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.6.5-mc2-orig/include/linux/slab.h 2.6.5-mc2/include/linux/slab.h
--- 2.6.5-mc2-orig/include/linux/slab.h	2004-02-20 17:26:53.000000000 +0100
+++ 2.6.5-mc2/include/linux/slab.h	2004-04-07 19:50:06.002847992 +0200
@@ -25,9 +25,7 @@ typedef struct kmem_cache_s kmem_cache_t
 #define	SLAB_KERNEL		GFP_KERNEL
 #define	SLAB_DMA		GFP_DMA
 
-#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS|\
-				__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT|\
-				__GFP_NOFAIL|__GFP_NORETRY)
+#define SLAB_LEVEL_MASK		GFP_LEVEL_MASK
 
 #define	SLAB_NO_GROW		__GFP_NO_GROW	/* don't grow a cache */
 

You can guess why I needed it...

thanks.
