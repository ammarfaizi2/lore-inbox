Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbSLIAxY>; Sun, 8 Dec 2002 19:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbSLIAxY>; Sun, 8 Dec 2002 19:53:24 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28678
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262631AbSLIAxX>; Sun, 8 Dec 2002 19:53:23 -0500
Subject: [PATCH] remove stale add_blkdev_randomness() uses
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain
Organization: 
Message-Id: <1039395678.1943.7157.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 08 Dec 2002 20:01:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add_blkdev_randomness() is long gone, so remove stale comments and a
lone remaining reference.

Patch is against current BK.  Linus, please apply.

	Robert Love


 drivers/char/random.c         |    3 ---
 drivers/s390/char/tapeblock.c |    6 +-----
 2 files changed, 1 insertion(+), 8 deletions(-)


diff -urN linux-2.5.50/drivers/char/random.c linux/drivers/char/random.c
--- linux-2.5.50/drivers/char/random.c	2002-11-27 17:35:49.000000000 -0500
+++ linux/drivers/char/random.c	2002-12-08 17:15:06.000000000 -0500
@@ -128,7 +128,6 @@
  * 	void add_keyboard_randomness(unsigned char scancode);
  * 	void add_mouse_randomness(__u32 mouse_data);
  * 	void add_interrupt_randomness(int irq);
- * 	void add_blkdev_randomness(int irq);
  * 
  * add_keyboard_randomness() uses the inter-keypress timing, as well as the
  * scancode as random inputs into the "entropy pool".
@@ -144,8 +143,6 @@
  * a better measure, since the timing of the disk interrupts are more
  * unpredictable.
  * 
- * add_blkdev_randomness() times the finishing time of block requests.
- * 
  * All of these routines try to estimate how many bits of randomness a
  * particular randomness source.  They do this by keeping track of the
  * first and second order deltas of the event timings.
diff -urN linux-2.5.50/drivers/s390/char/tapeblock.c linux/drivers/s390/char/tapeblock.c
--- linux-2.5.50/drivers/s390/char/tapeblock.c	2002-11-27 17:36:21.000000000 -0500
+++ linux/drivers/s390/char/tapeblock.c	2002-12-08 19:59:18.000000000 -0500
@@ -253,12 +253,8 @@
 	bh->b_reqnext = NULL;
 	bh->b_end_io (bh, uptodate);
     }
-    if (!end_that_request_first (td->blk_data.current_request, uptodate, "tBLK")) {
-#ifndef DEVICE_NO_RANDOM
-	add_blkdev_randomness (MAJOR (td->blk_data.current_request->rq_dev));
-#endif
+    if (!end_that_request_first (td->blk_data.current_request, uptodate, "tBLK"))
 	end_that_request_last (td->blk_data.current_request);
-    }
     if (treq!=NULL) {
 	    tape_remove_ccw_req(td,treq);
 	    td->discipline->free_bread(treq);



