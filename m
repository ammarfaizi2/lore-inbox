Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264146AbSJWK0Q>; Wed, 23 Oct 2002 06:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264612AbSJWK0Q>; Wed, 23 Oct 2002 06:26:16 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:8580 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264146AbSJWK0Q>;
	Wed, 23 Oct 2002 06:26:16 -0400
Date: Wed, 23 Oct 2002 16:08:28 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: sparc64 read_barrier_depends
Message-ID: <20021023160828.B9933@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I missed sparc64 when I broke up read_barrier_depends in -mm
and sent to Linus. Please apply this to your tree until Linus is back
and I can fix it.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.



diff -urN linux-2.5.44-base/include/asm-sparc64/system.h linux-2.5.44-rbd/include/asm-sparc64/system.h
--- linux-2.5.44-base/include/asm-sparc64/system.h	Sat Oct 19 09:31:07 2002
+++ linux-2.5.44-rbd/include/asm-sparc64/system.h	Mon Oct 21 15:03:19 2002
@@ -84,6 +84,7 @@
 	membar("#LoadLoad | #LoadStore | #StoreStore | #StoreLoad");
 #define rmb()		membar("#LoadLoad")
 #define wmb()		membar("#StoreStore")
+#define read_barrier_depends()		do { } while(0)
 #define set_mb(__var, __value) \
 	do { __var = __value; membar("#StoreLoad | #StoreStore"); } while(0)
 #define set_wmb(__var, __value) \
@@ -93,10 +94,12 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #else
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
+#define smp_read_barrier_depends()	do { } while(0)
 #endif
 
 #define flushi(addr)	__asm__ __volatile__ ("flush %0" : : "r" (addr) : "memory")
