Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275739AbRJJNfI>; Wed, 10 Oct 2001 09:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275734AbRJJNet>; Wed, 10 Oct 2001 09:34:49 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:5781 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S275739AbRJJNeh>; Wed, 10 Oct 2001 09:34:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rolf Eike Beer <eike@euklid.math.uni-mannheim.de>
Message-Id: <200110101446.10874@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fbcon.c
Date: Wed, 10 Oct 2001 15:36:36 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids some warnings during compile. The block where the vars are 
used is ifdefed out so here they are ifdefed out too. The patch is against 
2.4.11 but should apply to earlier 2.4 too, I remember this warnings from 
other 2.4.x.

Eike Beer

--- /usr/src/linux/drivers/video/fbcon.c.orig   Wed Oct 10 13:41:57 2001
+++ /usr/src/linux/drivers/video/fbcon.c        Wed Oct 10 14:05:20 2001
@@ -2125,12 +2125,16 @@
 {
     struct display *p = &fb_display[fg_console]; /* draw to vt in foreground 
*/
     int depth = p->var.bits_per_pixel;
-    int line = p->next_line;
     unsigned char *fb = p->screen_base;
     unsigned char *logo;
-    unsigned char *dst, *src;
-    int i, j, n, x1, y1, x;
+    int i, j, n, x;
     int logo_depth, done = 0;
+#if defined(CONFIG_FBCON_CFB16) || defined(CONFIG_FBCON_CFB24) || \
+    defined(CONFIG_FBCON_CFB32) || defined(CONFIG_FB_SBUS)
+    int line = p->next_line;
+    unsigned char *dst, *src;
+    int x1, y1;
+#endif

     /* Return if the frame buffer is not mapped */
     if (!fb)
