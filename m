Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264811AbTCEHYb>; Wed, 5 Mar 2003 02:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTCEHYb>; Wed, 5 Mar 2003 02:24:31 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:11506 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264811AbTCEHXm>; Wed, 5 Mar 2003 02:23:42 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Get rid of bogus definitions of `smp_...' barrier macros on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030305073109.C18DF372A@mcspd15.ucom.lsi.nec.co.jp>
Date: Wed,  5 Mar 2003 16:31:09 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.64-moo.orig/include/asm-v850/system.h linux-2.5.64-moo/include/asm-v850/system.h
--- linux-2.5.64-moo.orig/include/asm-v850/system.h	2003-01-22 10:13:12.000000000 +0900
+++ linux-2.5.64-moo/include/asm-v850/system.h	2003-03-05 14:54:59.000000000 +0900
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
