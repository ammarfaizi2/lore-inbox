Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbTDVSOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTDVSOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:14:16 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:22792 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S263323AbTDVSON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:14:13 -0400
Date: Tue, 22 Apr 2003 11:09:53 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove __const__ due to GCC warning
Message-ID: <20030422160953.GF7260@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

These two patches remove a warning GCC produces about using __const__
where it doesn't matter. I've built numerous kernels with these patches
and things seem to work fine, so I thought I'd send them out. Maybe GCC
is right, or maybe it isn't ...

BTW, the warning appears if '-W' is added to the compile commands.

Art Haas

===== include/asm-i386/byteorder.h 1.2 vs edited =====
--- 1.2/include/asm-i386/byteorder.h	Fri Oct 11 12:15:35 2002
+++ edited/include/asm-i386/byteorder.h	Tue Feb 11 09:39:35 2003
@@ -10,7 +10,7 @@
 #include <linux/config.h>
 #endif
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __u32 ___arch__swab32(__u32 x)
 {
 #ifdef CONFIG_X86_BSWAP
 	__asm__("bswap %0" : "=r" (x) : "0" (x));
@@ -26,7 +26,7 @@
 
 /* gcc should generate this for open coded C now too. May be worth switching to 
    it because inline assembly cannot be scheduled. -AK */
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("xchgb %b0,%h0"		/* swap bytes		*/
 		: "=q" (x)
===== include/linux/byteorder/swab.h 1.2 vs edited =====
--- 1.2/include/linux/byteorder/swab.h	Tue Feb  5 01:43:00 2002
+++ edited/include/linux/byteorder/swab.h	Tue Feb 11 09:39:15 2003
@@ -128,7 +128,7 @@
 #endif /* OPTIMIZE */
 
 
-static __inline__ __const__ __u16 __fswab16(__u16 x)
+static __inline__  __u16 __fswab16(__u16 x)
 {
 	return __arch__swab16(x);
 }
@@ -141,7 +141,7 @@
 	__arch__swab16s(addr);
 }
 
-static __inline__ __const__ __u32 __fswab32(__u32 x)
+static __inline__ __u32 __fswab32(__u32 x)
 {
 	return __arch__swab32(x);
 }
@@ -155,7 +155,7 @@
 }
 
 #ifdef __BYTEORDER_HAS_U64__
-static __inline__ __const__ __u64 __fswab64(__u64 x)
+static __inline__ __u64 __fswab64(__u64 x)
 {
 #  ifdef __SWAB_64_THRU_32__
 	__u32 h = x >> 32;
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
