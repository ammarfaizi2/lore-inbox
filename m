Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWJDX0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWJDX0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWJDX0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:26:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:22657 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751231AbWJDX03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:26:29 -0400
Message-Id: <20061004232500.235077000@linux-m68k.org>
References: <20061004232414.730831000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 05 Oct 2006 01:24:18 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] m68k: small system.h cleanup
Content-Disposition: inline; filename=set_current
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

avoid unnecessary xchg() use in set_mb()

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---
 include/asm-m68k/system.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/include/asm-m68k/system.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/system.h
+++ linux-2.6/include/asm-m68k/system.h
@@ -78,13 +78,13 @@ static inline int irqs_disabled(void)
 #define mb()		barrier()
 #define rmb()		barrier()
 #define wmb()		barrier()
-#define read_barrier_depends()	do { } while(0)
-#define set_mb(var, value)    do { xchg(&var, value); } while (0)
+#define read_barrier_depends()	((void)0)
+#define set_mb(var, value)	({ (var) = (value); wmb(); })
 
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
-#define smp_read_barrier_depends()	do { } while(0)
+#define smp_read_barrier_depends()	((void)0)
 
 
 #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))

--

