Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131251AbQLJVmV>; Sun, 10 Dec 2000 16:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132977AbQLJVmG>; Sun, 10 Dec 2000 16:42:06 -0500
Received: from web.sajt.cz ([212.71.160.9]:6148 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S132684AbQLJVlx>;
	Sun, 10 Dec 2000 16:41:53 -0500
Date: Sun, 10 Dec 2000 22:09:01 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mdacon.c cleanup
Message-ID: <Pine.LNX.4.21.0012102205190.11977-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both MODULE_PARM and __init are removed by precompiler when not compiler
as module, so no need for ifdefs. 
2.4.0-test12pre8

Pavel Rabel

--- mdacon.c.old	Sun Dec 10 21:00:20 2000
+++ mdacon.c	Sun Dec 10 21:04:32 2000
@@ -77,10 +77,8 @@
 
 static struct vc_data	*mda_display_fg = NULL;
 
-#ifdef MODULE_PARM
 MODULE_PARM(mda_first_vc, "1-255i");
 MODULE_PARM(mda_last_vc,  "1-255i");
-#endif
 
 /* MDA register values
  */
@@ -200,11 +198,7 @@
 }
 #endif
 
-#ifdef MODULE
-static int mda_detect(void)
-#else
 static int __init mda_detect(void)
-#endif
 {
 	int count=0;
 	u16 *p, p_save;
@@ -287,11 +281,7 @@
 	return 1;
 }
 
-#ifdef MODULE
-static void mda_initialize(void)
-#else
 static void __init mda_initialize(void)
-#endif
 {
 	write_mda_b(97, 0x00);		/* horizontal total */
 	write_mda_b(80, 0x01);		/* horizontal displayed */
@@ -316,11 +306,7 @@
 	outb_p(0x00, mda_gfx_port);
 }
 
-#ifdef MODULE
-static const char *mdacon_startup(void)
-#else
 static const char __init *mdacon_startup(void)
-#endif
 {
 	mda_num_columns = 80;
 	mda_num_lines   = 25;
@@ -605,11 +591,7 @@
 	con_invert_region:	mdacon_invert_region,
 };
 
-#ifdef MODULE
-void mda_console_init(void)
-#else
 void __init mda_console_init(void)
-#endif
 {
 	if (mda_first_vc > mda_last_vc)
 		return;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
