Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbTDTSVg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbTDTSVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:21:33 -0400
Received: from hera.cwi.nl ([192.16.191.8]:27066 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263663AbTDTSU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:20:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 20:32:55 +0200 (MEST)
Message-Id: <UTC200304201832.h3KIWtV18150.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] remove B_FREE
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the last traces of B_FREE.

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
--- a/drivers/video/pm3fb.c	Tue Mar 25 04:54:39 2003
+++ b/drivers/video/pm3fb.c	Sun Apr 20 19:28:37 2003
@@ -1602,7 +1602,7 @@
 	disp[l_fb_info->board_num].scrollmode = 0;	/* SCROLL_YNOMOVE; *//* 0 means "let fbcon choose" */
 	l_fb_info->gen.parsize = sizeof(struct pm3fb_par);
 	l_fb_info->gen.info.changevar = NULL;
-	l_fb_info->gen.info.node = B_FREE;
+	l_fb_info->gen.info.node = NODEV;
 	l_fb_info->gen.info.fbops = &pm3fb_ops;
 	l_fb_info->gen.info.disp = &(disp[l_fb_info->board_num]);
 	if (fontn[l_fb_info->board_num][0])
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/kdev_t.h b/include/linux/kdev_t.h
--- a/include/linux/kdev_t.h	Tue Apr  8 09:36:46 2003
+++ b/include/linux/kdev_t.h	Sun Apr 20 19:30:04 2003
@@ -99,7 +99,6 @@
 
 #define HASHDEV(dev)	(kdev_val(dev))
 #define NODEV		(mk_kdev(0,0))
-#define B_FREE		(mk_kdev(0xff,0xff))
 
 static inline int kdev_same(kdev_t dev1, kdev_t dev2)
 {
diff -u --recursive --new-file -X /linux/dontdiff a/include/video/pm3fb.h b/include/video/pm3fb.h
--- a/include/video/pm3fb.h	Tue Mar 25 04:54:46 2003
+++ b/include/video/pm3fb.h	Sun Apr 20 19:30:32 2003
@@ -1147,11 +1147,6 @@
 #define MUST_BYTESWAP
 #endif
 
-/* for compatibility between 2.5, 2.4 and 2.2 */
-#ifndef B_FREE
-#define B_FREE   -1
-#endif
-
 /* permedia3 -specific definitions */
 #define PM3_SCALE_TO_CLOCK(pr, fe, po) ((2 * PM3_REF_CLOCK * fe) / (pr * (1 << (po))))
 
