Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278649AbRKFIdv>; Tue, 6 Nov 2001 03:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278695AbRKFIdo>; Tue, 6 Nov 2001 03:33:44 -0500
Received: from newton.math.uni-mannheim.de ([134.155.89.79]:40179 "EHLO
	newton.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S278649AbRKFId2>; Tue, 6 Nov 2001 03:33:28 -0500
Message-Id: <1639142.cGWNJJiE95@newssend.sf-tec.de>
From: Rolf Eike Beer <eike@euklid.math.uni-mannheim.de>
Subject: Re: 2.4.14 warnings and errors - M
To: linux-kernel@vger.kernel.org
Date: Tue, 06 Nov 2001 09:32:21 +0100
In-Reply-To: <18970.1005034082@ocs3.intra.ocs.com.au>
User-Agent: KNode/0.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1005043133.9i1g2EtIAg"
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1005043133.9i1g2EtIAg
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit

>From Keith Owens :

> drivers/video/fbcon.c: In function `fbcon_show_logo':
> drivers/video/fbcon.c:2129: warning: unused variable `y1'
> drivers/video/fbcon.c:2129: warning: unused variable `x1'
> drivers/video/fbcon.c:2128: warning: unused variable `src'
> drivers/video/fbcon.c:2128: warning: unused variable `dst'
> drivers/video/fbcon.c:2125: warning: unused variable `line'

I send a patch some weeks ago, here it is again.

Eike

--nextPart1005043133.9i1g2EtIAg
Content-Type: text/x-diff; name="patch_fbcon.c_reduce_noise"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="patch_fbcon.c_reduce_noise"

--- /usr/src/linux/drivers/video/fbcon.c.orig	Wed Oct 10 13:41:57 2001
+++ /usr/src/linux/drivers/video/fbcon.c	Wed Oct 10 14:05:20 2001
@@ -2125,12 +2125,16 @@
 {
     struct display *p = &fb_display[fg_console]; /* draw to vt in foreground */
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

--nextPart1005043133.9i1g2EtIAg--
