Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTJJJXx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 05:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTJJJW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 05:22:57 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:9970 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262760AbTJJJWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 05:22:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Make v850 __delay function handle a loop count of zero
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20031010092201.1384537E7@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 10 Oct 2003 18:22:01 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

[In practice, this only seems to occur in odd debugging
situations, but it's quite annoying then.]

diff -ruN -X../cludes linux-2.6.0-test7-moo/include/asm-v850/delay.h linux-2.6.0-test7-moo-v850-20031010/include/asm-v850/delay.h
--- linux-2.6.0-test7-moo/include/asm-v850/delay.h	2002-11-05 11:25:31.000000000 +0900
+++ linux-2.6.0-test7-moo-v850-20031010/include/asm-v850/delay.h	2003-10-10 16:48:23.000000000 +0900
@@ -2,8 +2,8 @@
  * include/asm-v850/delay.h -- Delay routines, using a pre-computed
  * 	"loops_per_second" value
  *
- *  Copyright (C) 2001  NEC Corporation
- *  Copyright (C) 2001  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,03  NEC Corporation
+ *  Copyright (C) 2001,03  Miles Bader <miles@gnu.org>
  *  Copyright (C) 1994 Hamish Macdonald
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -18,8 +18,9 @@
 
 extern __inline__ void __delay(unsigned long loops)
 {
-	__asm__ __volatile__ ("1: add -1, %0; bnz 1b"
-			      : "=r" (loops) : "0" (loops));
+	if (loops)
+		__asm__ __volatile__ ("1: add -1, %0; bnz 1b"
+				      : "=r" (loops) : "0" (loops));
 }
 
 /*
