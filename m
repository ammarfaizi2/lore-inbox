Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262099AbSI3Npi>; Mon, 30 Sep 2002 09:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262069AbSI3NpU>; Mon, 30 Sep 2002 09:45:20 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:26859 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S262070AbSI3Nno> convert rfc822-to-8bit; Mon, 30 Sep 2002 09:43:44 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.39 s390 (10/26): bitops bug.
Date: Mon, 30 Sep 2002 14:54:57 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301454.57116.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix broken bitops for unaligned atomic operations on s390.

diff -urN linux-2.5.39/include/asm-s390/bitops.h linux-2.5.39-s390/include/asm-s390/bitops.h
--- linux-2.5.39/include/asm-s390/bitops.h	Fri Sep 27 23:48:38 2002
+++ linux-2.5.39-s390/include/asm-s390/bitops.h	Mon Sep 30 13:32:13 2002
@@ -59,8 +59,8 @@
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 3;		/* align address to 4 */
 	nr += (addr & 3) << 3;		/* add alignment to bit number */
+	addr ^= addr & 3;		/* align address to 4 */
 #endif
 	addr += (nr ^ (nr & 31)) >> 3;	/* calculate address for CS */
 	mask = 1UL << (nr & 31);	/* make OR mask */
@@ -84,8 +84,8 @@
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 3;		/* align address to 4 */
 	nr += (addr & 3) << 3;		/* add alignment to bit number */
+	addr ^= addr & 3;		/* align address to 4 */
 #endif
 	addr += (nr ^ (nr & 31)) >> 3;	/* calculate address for CS */
 	mask = ~(1UL << (nr & 31));	/* make AND mask */
@@ -109,8 +109,8 @@
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 3;		/* align address to 4 */
 	nr += (addr & 3) << 3;		/* add alignment to bit number */
+	addr ^= addr & 3;		/* align address to 4 */
 #endif
 	addr += (nr ^ (nr & 31)) >> 3;	/* calculate address for CS */
 	mask = 1UL << (nr & 31);	/* make XOR mask */
@@ -160,8 +160,8 @@
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 3;		/* align address to 4 */
 	nr += (addr & 3) << 3;		/* add alignment to bit number */
+	addr ^= addr & 3;		/* align address to 4 */
 #endif
 	addr += (nr ^ (nr & 31)) >> 3;	/* calculate address for CS */
 	mask = ~(1UL << (nr & 31));	/* make AND mask */
@@ -186,8 +186,8 @@
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 3;		/* align address to 4 */
 	nr += (addr & 3) << 3;		/* add alignment to bit number */
+	addr ^= addr & 3;		/* align address to 4 */
 #endif
 	addr += (nr ^ (nr & 31)) >> 3;	/* calculate address for CS */
 	mask = 1UL << (nr & 31);	/* make XOR mask */
diff -urN linux-2.5.39/include/asm-s390x/bitops.h linux-2.5.39-s390/include/asm-s390x/bitops.h
--- linux-2.5.39/include/asm-s390x/bitops.h	Mon Sep 30 13:25:21 2002
+++ linux-2.5.39-s390/include/asm-s390x/bitops.h	Mon Sep 30 13:32:13 2002
@@ -63,8 +63,8 @@
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 7;		/* align address to 8 */
 	nr += (addr & 7) << 3;		/* add alignment to bit number */
+	addr ^= addr & 7;		/* align address to 8 */
 #endif
 	addr += (nr ^ (nr & 63)) >> 3;	/* calculate address for CS */
 	mask = 1UL << (nr & 63);	/* make OR mask */
@@ -88,8 +88,8 @@
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 7;		/* align address to 8 */
 	nr += (addr & 7) << 3;		/* add alignment to bit number */
+	addr ^= addr & 7;		/* align address to 8 */
 #endif
 	addr += (nr ^ (nr & 63)) >> 3;	/* calculate address for CS */
 	mask = ~(1UL << (nr & 63));	/* make AND mask */
@@ -113,8 +113,8 @@
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 7;		/* align address to 8 */
 	nr += (addr & 7) << 3;		/* add alignment to bit number */
+	addr ^= addr & 7;		/* align address to 8 */
 #endif
 	addr += (nr ^ (nr & 63)) >> 3;	/* calculate address for CS */
 	mask = 1UL << (nr & 63);	/* make XOR mask */
@@ -139,8 +139,8 @@
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 7;		/* align address to 8 */
 	nr += (addr & 7) << 3;		/* add alignment to bit number */
+	addr ^= addr & 7;		/* align address to 8 */
 #endif
 	addr += (nr ^ (nr & 63)) >> 3;	/* calculate address for CS */
 	mask = 1UL << (nr & 63);	/* make OR/test mask */
@@ -166,8 +166,8 @@
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 7;		/* align address to 8 */
 	nr += (addr & 7) << 3;		/* add alignment to bit number */
+	addr ^= addr & 7;		/* align address to 8 */
 #endif
 	addr += (nr ^ (nr & 63)) >> 3;	/* calculate address for CS */
 	mask = ~(1UL << (nr & 63));	/* make AND mask */
@@ -193,8 +193,8 @@
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 7;		/* align address to 8 */
 	nr += (addr & 7) << 3;		/* add alignment to bit number */
+	addr ^= addr & 7;		/* align address to 8 */
 #endif
 	addr += (nr ^ (nr & 63)) >> 3;	/* calculate address for CS */
 	mask = 1UL << (nr & 63);	/* make XOR mask */

