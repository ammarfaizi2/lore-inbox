Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTE0J7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTE0J7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:59:47 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:26043 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263176AbTE0J7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:59:46 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  const-qualify memory arg in v850's __test_bit
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030527101248.BCA923701@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 27 May 2003 19:12:48 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This silences at least one compile-time warning... :-)

diff -ruN -X../cludes linux-2.5.70/include/asm-v850/bitops.h linux-2.5.70-v850-20030527/include/asm-v850/bitops.h
--- linux-2.5.70/include/asm-v850/bitops.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.5.70-v850-20030527/include/asm-v850/bitops.h	2003-05-27 18:53:02.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/bitops.h -- Bit operations
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *  Copyright (C) 1992  Linus Torvalds.
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -133,7 +133,7 @@
                 "m" (*((const char *)(addr) + ((nr) >> 3))));		\
      __test_bit_res;							\
   })
-extern __inline__ int __test_bit (int nr, void *addr)
+extern __inline__ int __test_bit (int nr, const void *addr)
 {
 	int res;
 	__asm__ ("tst1 %1, [%2]; setf nz, %0"
