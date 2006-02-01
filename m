Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWBAL7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWBAL7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWBAL7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:59:04 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:3978 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932324AbWBAL7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:59:02 -0500
Date: Wed, 1 Feb 2006 12:58:32 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] s390: avoid usage of 'new' in header files.
Message-ID: <20060201115832.GB9361@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Don't use 'new' as name for variables, since some C++ sources may include
these header files.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/asm-s390/bitops.h   |   26 +++++++++++++-------------
 include/asm-s390/spinlock.h |    4 ++--
 2 files changed, 15 insertions(+), 15 deletions(-)

diff -urpN linux-2.6/include/asm-s390/bitops.h linux-2.6-patched/include/asm-s390/bitops.h
--- linux-2.6/include/asm-s390/bitops.h	2006-02-01 11:03:08.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/bitops.h	2006-02-01 11:04:07.000000000 +0100
@@ -119,7 +119,7 @@ extern const char _sb_findmap[];
  */
 static inline void set_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
-        unsigned long addr, old, new, mask;
+	unsigned long addr, old, tmp, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
@@ -131,7 +131,7 @@ static inline void set_bit_cs(unsigned l
 	/* make OR mask */
 	mask = 1UL << (nr & (__BITOPS_WORDSIZE - 1));
 	/* Do the atomic update. */
-	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_OR);
+	__BITOPS_LOOP(old, tmp, addr, mask, __BITOPS_OR);
 }
 
 /*
@@ -139,7 +139,7 @@ static inline void set_bit_cs(unsigned l
  */
 static inline void clear_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
-        unsigned long addr, old, new, mask;
+	unsigned long addr, old, tmp, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
@@ -151,7 +151,7 @@ static inline void clear_bit_cs(unsigned
 	/* make AND mask */
 	mask = ~(1UL << (nr & (__BITOPS_WORDSIZE - 1)));
 	/* Do the atomic update. */
-	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_AND);
+	__BITOPS_LOOP(old, tmp, addr, mask, __BITOPS_AND);
 }
 
 /*
@@ -159,7 +159,7 @@ static inline void clear_bit_cs(unsigned
  */
 static inline void change_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
-        unsigned long addr, old, new, mask;
+	unsigned long addr, old, tmp, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
@@ -171,7 +171,7 @@ static inline void change_bit_cs(unsigne
 	/* make XOR mask */
 	mask = 1UL << (nr & (__BITOPS_WORDSIZE - 1));
 	/* Do the atomic update. */
-	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_XOR);
+	__BITOPS_LOOP(old, tmp, addr, mask, __BITOPS_XOR);
 }
 
 /*
@@ -180,7 +180,7 @@ static inline void change_bit_cs(unsigne
 static inline int
 test_and_set_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
-        unsigned long addr, old, new, mask;
+	unsigned long addr, old, tmp, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
@@ -192,7 +192,7 @@ test_and_set_bit_cs(unsigned long nr, vo
 	/* make OR/test mask */
 	mask = 1UL << (nr & (__BITOPS_WORDSIZE - 1));
 	/* Do the atomic update. */
-	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_OR);
+	__BITOPS_LOOP(old, tmp, addr, mask, __BITOPS_OR);
 	__BITOPS_BARRIER();
 	return (old & mask) != 0;
 }
@@ -203,7 +203,7 @@ test_and_set_bit_cs(unsigned long nr, vo
 static inline int
 test_and_clear_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
-        unsigned long addr, old, new, mask;
+	unsigned long addr, old, new_val, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
@@ -215,9 +215,9 @@ test_and_clear_bit_cs(unsigned long nr, 
 	/* make AND/test mask */
 	mask = ~(1UL << (nr & (__BITOPS_WORDSIZE - 1)));
 	/* Do the atomic update. */
-	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_AND);
+	__BITOPS_LOOP(old, new_val, addr, mask, __BITOPS_AND);
 	__BITOPS_BARRIER();
-	return (old ^ new) != 0;
+	return (old ^ new_val) != 0;
 }
 
 /*
@@ -226,7 +226,7 @@ test_and_clear_bit_cs(unsigned long nr, 
 static inline int
 test_and_change_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
-        unsigned long addr, old, new, mask;
+	unsigned long addr, old, tmp, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
@@ -238,7 +238,7 @@ test_and_change_bit_cs(unsigned long nr,
 	/* make XOR/test mask */
 	mask = 1UL << (nr & (__BITOPS_WORDSIZE - 1));
 	/* Do the atomic update. */
-	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_XOR);
+	__BITOPS_LOOP(old, tmp, addr, mask, __BITOPS_XOR);
 	__BITOPS_BARRIER();
 	return (old & mask) != 0;
 }
diff -urpN linux-2.6/include/asm-s390/spinlock.h linux-2.6-patched/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/spinlock.h	2006-02-01 11:04:07.000000000 +0100
@@ -13,11 +13,11 @@
 
 static inline int
 _raw_compare_and_swap(volatile unsigned int *lock,
-		      unsigned int old, unsigned int new)
+		      unsigned int old, unsigned int new_val)
 {
 	asm volatile ("cs %0,%3,0(%4)"
 		      : "=d" (old), "=m" (*lock)
-		      : "0" (old), "d" (new), "a" (lock), "m" (*lock)
+		      : "0" (old), "d" (new_val), "a" (lock), "m" (*lock)
 		      : "cc", "memory" );
 	return old;
 }
