Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131290AbRAJAxu>; Tue, 9 Jan 2001 19:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132772AbRAJAxa>; Tue, 9 Jan 2001 19:53:30 -0500
Received: from linuxcare.com.au ([203.29.91.49]:39685 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131290AbRAJAxU>; Tue, 9 Jan 2001 19:53:20 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Wed, 10 Jan 2001 11:48:55 +1100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix raid5 on sparc
Message-ID: <20010110114855.X662@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On sparc the length of an xor block must be a multiple of 128 bytes.
Bad things happen otherwise.

Anton

Index: xor.c
===================================================================
RCS file: /cvs/linux/drivers/md/xor.c,v
retrieving revision 1.3
diff -u -r1.3 xor.c
--- xor.c	2000/12/06 13:30:36	1.3
+++ xor.c	2001/01/10 00:43:02
@@ -58,7 +58,11 @@
 static struct xor_block_template *template_list;
 
 /* The -6*32 shift factor colors the cache.  */
+#ifdef __sparc__
+#define BENCH_SIZE (PAGE_SIZE)
+#else
 #define BENCH_SIZE (PAGE_SIZE-6*32)
+#endif
 
 static void
 do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
