Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbULQMpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbULQMpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 07:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbULQMpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 07:45:00 -0500
Received: from mail.renesas.com ([202.234.163.13]:64482 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262795AbULQMo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 07:44:56 -0500
Date: Fri, 17 Dec 2004 21:44:43 +0900 (JST)
Message-Id: <20041217.214443.579663291.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Update include/asm-m32r/system.h
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates include/asm-m32r/system.h.
Please apply.

	* include/asm-m32r/system.h:
	- Use barrier() as mb().
	- Change __inline__ to inline.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/system.h |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)


diff -ruNp a/include/asm-m32r/system.h b/include/asm-m32r/system.h
--- a/include/asm-m32r/system.h	2004-10-19 06:53:07.000000000 +0900
+++ b/include/asm-m32r/system.h	2004-12-16 10:05:50.000000000 +0900
@@ -7,6 +7,7 @@
  * for more details.
  *
  * Copyright (C) 2001  by Hiroyuki Kondo, Hirokazu Takata, and Hitoshi Yamamoto
+ * Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
  */
 
 #include <linux/config.h>
@@ -73,7 +74,7 @@
 #define local_irq_disable() \
 	__asm__ __volatile__ ("clrpsw #0x40 -> nop": : :"memory")
 #else	/* CONFIG_CHIP_M32102 */
-static __inline__ void local_irq_enable(void)
+static inline void local_irq_enable(void)
 {
 	unsigned long tmpreg;
 	__asm__ __volatile__(
@@ -83,7 +84,7 @@ static __inline__ void local_irq_enable(
 	: "=&r" (tmpreg) : : "cbit", "memory");
 }
 
-static __inline__ void local_irq_disable(void)
+static inline void local_irq_disable(void)
 {
 	unsigned long tmpreg0, tmpreg1;
 	__asm__ __volatile__(
@@ -219,11 +220,7 @@ static __inline__ unsigned long __xchg(u
  * rmb() prevents loads being reordered across this point.
  * wmb() prevents stores being reordered across this point.
  */
-#if 0
-#define mb()   __asm__ __volatile__ ("push r0; \n\t pop r0;" : : : "memory")
-#else
-#define mb()   __asm__ __volatile__ ("" : : : "memory")
-#endif
+#define mb()   barrier()
 #define rmb()  mb()
 #define wmb()  mb()
 
@@ -298,4 +295,3 @@ static __inline__ unsigned long __xchg(u
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 #endif  /* _ASM_M32R_SYSTEM_H */
-

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

