Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279783AbRJ0EXR>; Sat, 27 Oct 2001 00:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279781AbRJ0EXI>; Sat, 27 Oct 2001 00:23:08 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:18839 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S279780AbRJ0EXA>; Sat, 27 Oct 2001 00:23:00 -0400
Message-Id: <m15xL0K-007qbBC@smtp.web.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] random.c MIN cleanup
Date: Sat, 27 Oct 2001 06:39:56 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the MIN macro in random.c can be done away with. The patch below does
just that.

MIN was used two times, in both cases comparing two unsigned values.
The "builtin" min can be used instead.

René



--- linux-2.4.14-pre2/drivers/char/random.c	Fri Oct 26 23:07:16 2001
+++ linux-2.4.14-pre2-rs/drivers/char/random.c	Sat Oct 27 05:37:47 2001
@@ -406,10 +406,6 @@
  * 
  *****************************************************************/
 
-#ifndef MIN
-#define MIN(a,b) (((a) < (b)) ? (a) : (b))
-#endif
-
 /*
  * Unfortunately, while the GCC optimizer for the i386 understands how
  * to optimize a static rotate left of x bits, it doesn't know how to
@@ -1359,7 +1355,7 @@
 #endif
 		
 		/* Copy data to destination buffer */
-		i = MIN(nbytes, HASH_BUFFER_SIZE*sizeof(__u32)/2);
+		i = min(nbytes, HASH_BUFFER_SIZE*sizeof(__u32)/2);
 		if (flags & EXTRACT_ENTROPY_USER) {
 			i -= copy_to_user(buf, (__u8 const *)tmp, i);
 			if (!i) {
@@ -1586,7 +1582,7 @@
 	size_t		c = count;
 
 	while (c > 0) {
-		bytes = MIN(c, sizeof(buf));
+		bytes = min(c, sizeof(buf));
 
 		bytes -= copy_from_user(&buf, p, bytes);
 		if (!bytes) {
