Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbULVLwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbULVLwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 06:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbULVLvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 06:51:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61969 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261969AbULVLuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 06:50:12 -0500
Date: Wed, 22 Dec 2004 12:50:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/lp.c: make some code static (fwd)
Message-ID: <20041222115010.GP5217@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 5 Dec 2004 18:01:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/lp.c: make some code static

The patch below makes a struct and a function that both were needlessly 
global static.


diffstat output:
 drivers/char/lp.c  |    4 ++--
 include/linux/lp.h |    6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/include/linux/lp.h.old	2004-11-07 00:22:38.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/linux/lp.h	2004-11-07 00:22:51.000000000 +0100
@@ -186,12 +186,6 @@
  */
 #define LP_DELAY 	50
 
-/*
- * function prototypes
- */
-
-extern int lp_init(void);
-
 #endif
 
 #endif
--- linux-2.6.10-rc1-mm3-full/drivers/char/lp.c.old	2004-11-07 00:23:01.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/lp.c	2004-11-07 00:27:41.000000000 +0100
@@ -142,7 +142,7 @@
 /* ROUND_UP macro from fs/select.c */
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
 
-struct lp_struct lp_table[LP_NO];
+static struct lp_struct lp_table[LP_NO];
 
 static unsigned int lp_count = 0;
 static struct class_simple *lp_class;
@@ -867,7 +867,7 @@
 	.detach = lp_detach,
 };
 
-int __init lp_init (void)
+static int __init lp_init (void)
 {
 	int i, err = 0;
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

