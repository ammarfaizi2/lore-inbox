Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTLQHSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 02:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTLQHSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 02:18:35 -0500
Received: from smarty.dreamhost.com ([66.33.216.24]:32417 "EHLO
	smarty.dreamhost.com") by vger.kernel.org with ESMTP
	id S263697AbTLQHSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 02:18:33 -0500
Date: Wed, 17 Dec 2003 02:18:29 -0500
From: "Daniel Richard G." <skunk@iskunk.org>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br, torvalds@osdl.org
Subject: [PATCH] include/asm-i386/byteorder.h: ANSI mode fixes
Message-ID: <20031217071829.GA30851@midnight>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This header file uses `inline' where it should use `__inline__', `asm'
where it should use `__asm__'. GCC with -ansi barfs if it sees these
keywords without the double underscores. Headaches for the KDE folks:

	http://bugs.kde.org/show_bug.cgi?id=67269
	http://bugs.kde.org/show_bug.cgi?id=70100

(Note that the header already uses __inline__ and __asm__ for the most
part---this patch addresses the three remaining exceptions.)

Patch applies equally against latest 2.4.23(bk12) and 2.6.0-test11(bk12)
revs; the header file is identical in both.

Please Cc: me on any replies.


--------BEGIN PATCH--------
--- include/asm-i386/byteorder.h.orig	2003-12-17 01:19:49.000000000 -0500
+++ include/asm-i386/byteorder.h	2003-12-17 01:20:37.000000000 -0500
@@ -35,7 +35,7 @@
 }
 
 
-static inline __u64 ___arch__swab64(__u64 val) 
+static __inline__ __u64 ___arch__swab64(__u64 val) 
 { 
 	union { 
 		struct { __u32 a,b; } s;
@@ -43,13 +43,13 @@
 	} v;
 	v.u = val;
 #ifdef CONFIG_X86_BSWAP
-	asm("bswapl %0 ; bswapl %1 ; xchgl %0,%1" 
-	    : "=r" (v.s.a), "=r" (v.s.b) 
-	    : "0" (v.s.a), "1" (v.s.b)); 
+	__asm__("bswapl %0 ; bswapl %1 ; xchgl %0,%1" 
+	        : "=r" (v.s.a), "=r" (v.s.b) 
+	        : "0" (v.s.a), "1" (v.s.b)); 
 #else
-   v.s.a = ___arch__swab32(v.s.a); 
+	v.s.a = ___arch__swab32(v.s.a); 
 	v.s.b = ___arch__swab32(v.s.b); 
-	asm("xchgl %0,%1" : "=r" (v.s.a), "=r" (v.s.b) : "0" (v.s.a), "1" (v.s.b));
+	__asm__("xchgl %0,%1" : "=r" (v.s.a), "=r" (v.s.b) : "0" (v.s.a), "1" (v.s.b));
 #endif
 	return v.u;	
 } 
--------END PATCH--------


--Danny


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
