Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261741AbSIXRZW>; Tue, 24 Sep 2002 13:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbSIXRXW>; Tue, 24 Sep 2002 13:23:22 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:53404 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261721AbSIXRWm> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:42 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 08_bitops.
Date: Tue, 24 Sep 2002 19:19:28 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241919.28480.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix broken bitops for unaligned atomic operations on s390.

diff -urN linux-2.5.38/include/asm-s390/bitops.h linux-2.5.38-s390/include/asm-s390/bitops.h
--- linux-2.5.38/include/asm-s390/bitops.h	Sun Sep 22 06:24:59 2002
+++ linux-2.5.38-s390/include/asm-s390/bitops.h	Tue Sep 24 17:42:22 2002
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
diff -urN linux-2.5.38/include/asm-s390x/bitops.h linux-2.5.38-s390/include/asm-s390x/bitops.h
--- linux-2.5.38/include/asm-s390x/bitops.h	Tue Sep 24 17:41:38 2002
+++ linux-2.5.38-s390/include/asm-s390x/bitops.h	Tue Sep 24 17:42:22 2002
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

