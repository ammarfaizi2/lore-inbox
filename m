Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbTBMCye>; Wed, 12 Feb 2003 21:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267765AbTBMCyW>; Wed, 12 Feb 2003 21:54:22 -0500
Received: from hera.cwi.nl ([192.16.191.8]:41421 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267744AbTBMCyJ>;
	Wed, 12 Feb 2003 21:54:09 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 13 Feb 2003 04:03:52 +0100 (MET)
Message-Id: <UTC200302130303.h1D33qj27852.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] remove the last trace of B_FREE
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
--- a/drivers/video/pm3fb.c	Tue Dec 10 18:42:38 2002
+++ b/drivers/video/pm3fb.c	Thu Feb 13 03:17:31 2003
@@ -1603,7 +1603,7 @@
 	disp[l_fb_info->board_num].scrollmode = 0;	/* SCROLL_YNOMOVE; *//* 0 means "let fbcon choose" */
 	l_fb_info->gen.parsize = sizeof(struct pm3fb_par);
 	l_fb_info->gen.info.changevar = NULL;
-	l_fb_info->gen.info.node = B_FREE;
+	l_fb_info->gen.info.node = NODEV;
 	l_fb_info->gen.info.fbops = &pm3fb_ops;
 	l_fb_info->gen.info.disp = &(disp[l_fb_info->board_num]);
 	if (fontn[l_fb_info->board_num][0])
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/video/pm3fb.h b/drivers/video/pm3fb.h
--- a/drivers/video/pm3fb.h	Fri Nov 22 22:40:58 2002
+++ b/drivers/video/pm3fb.h	Thu Feb 13 03:18:30 2003
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
 
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/kdev_t.h b/include/linux/kdev_t.h
--- a/include/linux/kdev_t.h	Fri Nov 22 22:40:57 2002
+++ b/include/linux/kdev_t.h	Thu Feb 13 03:19:02 2003
@@ -99,7 +99,6 @@
 
 #define HASHDEV(dev)	(kdev_val(dev))
 #define NODEV		(mk_kdev(0,0))
-#define B_FREE		(mk_kdev(0xff,0xff))
 
 extern const char * kdevname(kdev_t);	/* note: returns pointer to static data! */
 

Andries

