Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTIGGmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 02:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbTIGGmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 02:42:08 -0400
Received: from dukat.upl.cs.wisc.edu ([128.105.45.39]:61641 "EHLO
	dukat.upl.cs.wisc.edu") by vger.kernel.org with ESMTP
	id S262449AbTIGGmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 02:42:06 -0400
Date: Sun, 7 Sep 2003 01:42:04 -0500
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030907064204.GA31968@sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew - thanks for applying my last patch; thought you might be interested
in this trivial one too.  Patch is versus 2.6.0-test4-bk8, I expect it
will also apply against current -mm.

-Mitch

diff -urN -X dontdiff linux-2.6.0-test4bk8-VIRGIN/drivers/char/vt.c linux-2.6.0-test4bk8mnb1/drivers/char/vt.c
--- linux-2.6.0-test4bk8-VIRGIN/drivers/char/vt.c	2003-07-13 20:37:27.000000000 -0700
+++ linux-2.6.0-test4bk8mnb1/drivers/char/vt.c	2003-09-06 13:52:58.000000000 -0700
@@ -2179,7 +2179,7 @@
 	}
 	set_cursor(currcons);
 
-	if (!oops_in_progress)
+	if (likely(!oops_in_progress))
 		poke_blanked_console();
 
 quit:
diff -urN -X dontdiff linux-2.6.0-test4bk8-VIRGIN/drivers/parisc/led.c linux-2.6.0-test4bk8mnb1/drivers/parisc/led.c
--- linux-2.6.0-test4bk8-VIRGIN/drivers/parisc/led.c	2003-07-27 12:57:39.000000000 -0700
+++ linux-2.6.0-test4bk8mnb1/drivers/parisc/led.c	2003-09-06 13:53:18.000000000 -0700
@@ -488,7 +488,7 @@
 	}
 
 	/* blink all LEDs twice a second if we got an Oops (HPMC) */
-	if (oops_in_progress) {
+	if (unlikely(oops_in_progress)) {
 		currentleds = (count_HZ<=(HZ/2)) ? 0 : 0xff;
 	}
 	
diff -urN -X dontdiff linux-2.6.0-test4bk8-VIRGIN/kernel/printk.c linux-2.6.0-test4bk8mnb1/kernel/printk.c
--- linux-2.6.0-test4bk8-VIRGIN/kernel/printk.c	2003-07-13 20:39:24.000000000 -0700
+++ linux-2.6.0-test4bk8mnb1/kernel/printk.c	2003-09-06 13:53:50.000000000 -0700
@@ -400,7 +400,7 @@
 	static char printk_buf[1024];
 	static int log_level_unknown = 1;
 
-	if (oops_in_progress) {
+	if (unlikely(oops_in_progress)) {
 		/* If a crash is occurring, make sure we can't deadlock */
 		spin_lock_init(&logbuf_lock);
 		/* And make sure that we print immediately */
