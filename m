Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbTI1V5w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTI1V5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:57:52 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:42773 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262769AbTI1V5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:57:50 -0400
Date: Sun, 28 Sep 2003 14:55:21 +0200
Message-Id: <200309281255.h8SCtLvH005504@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 305] M68k bitops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k bitops: Make input parameters of *find*bit() routines const:
  - find_first_zero_bit()
  - find_next_zero_bit()
  - sched_find_first_bit()

--- linux-2.6.0-test6/include/asm-m68k/bitops.h	Sun Apr 20 12:28:58 2003
+++ linux-m68k-2.6.0-test6/include/asm-m68k/bitops.h	Wed Sep 10 21:27:51 2003
@@ -164,9 +164,10 @@
 	return ((1UL << (nr & 31)) & (((const volatile unsigned long *) vaddr)[nr >> 5])) != 0;
 }
 
-extern __inline__ int find_first_zero_bit(unsigned long * vaddr, unsigned size)
+extern __inline__ int find_first_zero_bit(const unsigned long *vaddr,
+					  unsigned size)
 {
-	unsigned long *p = vaddr, *addr = vaddr;
+	const unsigned long *p = vaddr, *addr = vaddr;
 	unsigned long allones = ~0UL;
 	int res;
 	unsigned long num;
@@ -187,11 +188,11 @@
 	return ((p - addr) << 5) + (res ^ 31);
 }
 
-extern __inline__ int find_next_zero_bit (unsigned long *vaddr, int size,
+extern __inline__ int find_next_zero_bit (const unsigned long *vaddr, int size,
 				      int offset)
 {
-	unsigned long *addr = vaddr;
-	unsigned long *p = addr + (offset >> 5);
+	const unsigned long *addr = vaddr;
+	const unsigned long *p = addr + (offset >> 5);
 	int set = 0, bit = offset & 31UL, res;
 
 	if (offset >= size)
@@ -263,7 +264,7 @@
  * unlikely to be set. It's guaranteed that at least one of the 140
  * bits is cleared.
  */
-static inline int sched_find_first_bit(unsigned long *b)
+static inline int sched_find_first_bit(const unsigned long *b)
 {
 	if (unlikely(b[0]))
 		return __ffs(b[0]);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
