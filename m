Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266659AbUBFHzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 02:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUBFHzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 02:55:00 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:16526 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266659AbUBFHyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 02:54:53 -0500
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Make v850 __delay function handle a loop count of zero
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040206075447.B796645A@mcspd15>
Date: Fri,  6 Feb 2004 16:54:47 +0900 (JST)
From: miles@mcspd15.ucom.lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[In practice, this only seems to occur in odd debugging
situations, but it's quite annoying then.]

diff -ruN -X../cludes linux-2.6.2-uc0/include/asm-v850/delay.h linux-2.6.2-uc0-v850-20040206/include/asm-v850/delay.h
--- linux-2.6.2-uc0/include/asm-v850/delay.h	2002-11-05 11:25:31.000000000 +0900
+++ linux-2.6.2-uc0-v850-20040206/include/asm-v850/delay.h	2004-02-06 14:02:30.000000000 +0900
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
