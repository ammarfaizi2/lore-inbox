Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRJ0P01>; Sat, 27 Oct 2001 11:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRJ0P0Q>; Sat, 27 Oct 2001 11:26:16 -0400
Received: from dobit2.rug.ac.be ([157.193.42.8]:59025 "EHLO dobit2.rug.ac.be")
	by vger.kernel.org with ESMTP id <S273588AbRJ0P0L>;
	Sat, 27 Oct 2001 11:26:11 -0400
Date: Sat, 27 Oct 2001 17:26:46 +0200 (MEST)
From: Frank Cornelis <Frank.Cornelis@rug.ac.be>
To: <linux-kernel@vger.kernel.org>
Subject: fixes: current_text_addr
Message-ID: <Pine.GSO.4.31.0110271724540.16025-100000@eduserv.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Next patch fixes the current_text_addr macro to work also with optimized
code.
There is also a documentation fix included.

Frank.

--- processor.h.orig	Fri Oct 26 16:37:51 2001
+++ processor.h	Fri Oct 26 16:39:15 2001
@@ -22,7 +22,8 @@
  * Default implementation of macro that returns current
  * instruction pointer ("program counter").
  */
-#define current_text_addr() ({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
+#define current_text_addr() \
+({ void *pc; __asm__ __volatile__("movl $1f,%0\n1:":"=g" (pc)); pc; })

 /*
  *  CPU type and hardware bug flags. Kept separately for each CPU.
--- threads.h.orig	Fri Oct 26 16:46:52 2001
+++ threads.h	Fri Oct 26 16:47:19 2001
@@ -5,7 +5,7 @@

 /*
  * The default limit for the nr of threads is now in
- * /proc/sys/kernel/max-threads.
+ * /proc/sys/kernel/threads-max.
  */

 #ifdef CONFIG_SMP

