Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbTCYCt3>; Mon, 24 Mar 2003 21:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbTCYCrY>; Mon, 24 Mar 2003 21:47:24 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:11691 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261374AbTCYCql>; Mon, 24 Mar 2003 21:46:41 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Get rid of bogus definitions of `smp_...' barrier macros on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030325025658.E214037C9@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 25 Mar 2003 11:56:58 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.66-moo.orig/include/asm-v850/system.h linux-2.5.66-moo/include/asm-v850/system.h
--- linux-2.5.66-moo.orig/include/asm-v850/system.h	2003-01-22 10:13:12.000000000 +0900
+++ linux-2.5.66-moo/include/asm-v850/system.h	2003-03-25 10:37:52.000000000 +0900
@@ -72,17 +72,10 @@
 #define set_mb(var, value)	set_rmb (var, value)
 #define set_wmb(var, value)	do { var = value; wmb (); } while (0)
 
-#ifdef CONFIG_SMP
 #define smp_mb()	mb ()
 #define smp_rmb()	rmb ()
 #define smp_wmb()	wmb ()
 #define smp_read_barrier_depends()	read_barrier_depends()
-#else
-#define smp_mb()	barrier ()
-#define smp_rmb()	barrier ()
-#define smp_wmb()	barrier ()
-#define smp_read_barrier_depends()	((void)0)
-#endif
 
 #define xchg(ptr, with) \
   ((__typeof__ (*(ptr)))__xchg ((unsigned long)(with), (ptr), sizeof (*(ptr))))
