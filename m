Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUHNXtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUHNXtm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 19:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUHNXtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 19:49:42 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:32015 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S265773AbUHNXta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 19:49:30 -0400
From: Sebastian =?iso-8859-1?q?K=FCgler?= <sebas@vizZzion.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Compile fixes for various fb drivers
Date: Sun, 15 Aug 2004 01:49:13 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5TqHBtzMhPTcSnZ"
Message-Id: <200408150149.14663.sebas@vizZzion.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_5TqHBtzMhPTcSnZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

fb_copy_cmap has changed in 2.6.8.1, but the change is not reflected in all=
=20
drivers, this updates the respective framebuffer drivers.

The patch is against vanilla 2.6.8.1.

Signed-off-by: Sebastian K=FCgler <sebas@vizZzion.org>

kind regards,
=2D-=20
sebas
=2D - - - - - - - - - -
http://vizZzion.org
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mathematician, n.: Some one who believes imaginary things appear right befo=
re=20
your i's.


--Boundary-00=_5TqHBtzMhPTcSnZ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fb-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fb-patch.diff"

diff -uprN -X dontdiff linux-2.6.8.1/drivers/video/atafb.c linux-2.6.8.1-fb/drivers/video/atafb.c
--- linux-2.6.8.1/drivers/video/atafb.c	2004-08-14 12:54:50.000000000 +0200
+++ linux-2.6.8.1-fb/drivers/video/atafb.c	2004-08-15 01:24:33.000000000 +0200
@@ -2539,7 +2539,7 @@ atafb_get_cmap(struct fb_cmap *cmap, int
 		return fb_get_cmap(cmap, kspc, fbhw->getcolreg, info);
 	else
 		if (fb_display[con].cmap.len) /* non default colormap ? */
-			fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
+			fb_copy_cmap(&fb_display[con].cmap, cmap);
 		else
 			fb_copy_cmap(fb_default_cmap(1<<fb_display[con].var.bits_per_pixel),
 				     cmap, kspc ? 0 : 2);
diff -uprN -X dontdiff linux-2.6.8.1/drivers/video/cyberfb.c linux-2.6.8.1-fb/drivers/video/cyberfb.c
--- linux-2.6.8.1/drivers/video/cyberfb.c	2004-08-14 12:54:48.000000000 +0200
+++ linux-2.6.8.1-fb/drivers/video/cyberfb.c	2004-08-15 01:23:52.000000000 +0200
@@ -937,7 +937,7 @@ static int cyberfb_get_cmap(struct fb_cm
 		return(fb_get_cmap(cmap, kspc, Cyber_getcolreg, info));
 	} else if (fb_display[con].cmap.len) { /* non default colormap? */
 		DPRINTK("Use console cmap\n");
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
+		fb_copy_cmap(&fb_display[con].cmap, cmap);
 	} else {
 		DPRINTK("Use default cmap\n");
 		fb_copy_cmap(fb_default_cmap(1<<fb_display[con].var.bits_per_pixel),
diff -uprN -X dontdiff linux-2.6.8.1/drivers/video/retz3fb.c linux-2.6.8.1-fb/drivers/video/retz3fb.c
--- linux-2.6.8.1/drivers/video/retz3fb.c	2004-08-14 12:56:01.000000000 +0200
+++ linux-2.6.8.1-fb/drivers/video/retz3fb.c	2004-08-15 01:25:15.000000000 +0200
@@ -1277,7 +1277,7 @@ static int retz3fb_get_cmap(struct fb_cm
 	if (con == info->currcon) /* current console? */
 		return(fb_get_cmap(cmap, kspc, retz3_getcolreg, info));
 	else if (fb_display[con].cmap.len) /* non default colormap? */
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
+		fb_copy_cmap(&fb_display[con].cmap, cmap);
 	else
 		fb_copy_cmap(fb_default_cmap(1<<fb_display[con].var.bits_per_pixel),
 			     cmap, kspc ? 0 : 2);
diff -uprN -X dontdiff linux-2.6.8.1/drivers/video/S3triofb.c linux-2.6.8.1-fb/drivers/video/S3triofb.c
--- linux-2.6.8.1/drivers/video/S3triofb.c	2004-08-14 12:56:23.000000000 +0200
+++ linux-2.6.8.1-fb/drivers/video/S3triofb.c	2004-08-15 01:23:11.000000000 +0200
@@ -220,7 +220,7 @@ static int s3trio_get_cmap(struct fb_cma
     if (con == info->currcon) /* current console? */
 	return fb_get_cmap(cmap, kspc, s3trio_getcolreg, info);
     else if (fb_display[con].cmap.len) /* non default colormap? */
-	fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
+	fb_copy_cmap(&fb_display[con].cmap, cmap);
     else
 	fb_copy_cmap(fb_default_cmap(1 << fb_display[con].var.bits_per_pixel),
 		     cmap, kspc ? 0 : 2);
diff -uprN -X dontdiff linux-2.6.8.1/drivers/video/sis/sis_main.c linux-2.6.8.1-fb/drivers/video/sis/sis_main.c
--- linux-2.6.8.1/drivers/video/sis/sis_main.c	2004-08-14 12:55:47.000000000 +0200
+++ linux-2.6.8.1-fb/drivers/video/sis/sis_main.c	2004-08-15 01:20:32.000000000 +0200
@@ -1641,12 +1641,12 @@ sisfb_get_cmap(struct fb_cmap *cmap, int
 
 	} else if(display->cmap.len) {
 
-		fb_copy_cmap(&display->cmap, cmap, kspc ? 0 : 2);
+		fb_copy_cmap(&display->cmap, cmap);
 
 	} else {
 
 		int size = sisfb_get_cmap_len(&display->var);
-		fb_copy_cmap(fb_default_cmap(size), cmap, kspc ? 0 : 2);
+		fb_copy_cmap(fb_default_cmap(size), cmap);
 
 	}
 
@@ -1671,7 +1671,7 @@ sisfb_set_cmap(struct fb_cmap *cmap, int
 	if(con == ivideo->currcon) {
 		return fb_set_cmap(cmap, kspc, sisfb_setcolreg, info);
 	} else {
-		fb_copy_cmap(cmap, &display->cmap, kspc ? 0 : 1);
+		fb_copy_cmap(cmap, &display->cmap);
 	}
 
 	return 0;
diff -uprN -X dontdiff linux-2.6.8.1/drivers/video/sun3fb.c linux-2.6.8.1-fb/drivers/video/sun3fb.c
--- linux-2.6.8.1/drivers/video/sun3fb.c	2004-08-14 12:54:51.000000000 +0200
+++ linux-2.6.8.1-fb/drivers/video/sun3fb.c	2004-08-15 01:24:51.000000000 +0200
@@ -306,7 +306,7 @@ static int sun3fb_get_cmap(struct fb_cma
 	if (con == info->currcon) /* current console? */
 		return fb_get_cmap(cmap, kspc, sun3fb_getcolreg, info);
 	else if (fb_display[con].cmap.len) /* non default colormap? */
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
+		fb_copy_cmap(&fb_display[con].cmap, cmap);
 	else
 		fb_copy_cmap(fb_default_cmap(1<<fb_display[con].var.bits_per_pixel), cmap, kspc ? 0 : 2);
 	return 0;
diff -uprN -X dontdiff linux-2.6.8.1/drivers/video/virgefb.c linux-2.6.8.1-fb/drivers/video/virgefb.c
--- linux-2.6.8.1/drivers/video/virgefb.c	2004-08-14 12:55:09.000000000 +0200
+++ linux-2.6.8.1-fb/drivers/video/virgefb.c	2004-08-15 01:22:38.000000000 +0200
@@ -1615,7 +1615,7 @@ static int virgefb_get_cmap(struct fb_cm
 		return(fb_get_cmap(cmap, kspc, fbhw->getcolreg, info));
 	} else if (fb_display[con].cmap.len) { /* non default colormap? */
 		DPRINTK("Use console cmap\n");
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
+		fb_copy_cmap(&fb_display[con].cmap, cmap);
 	} else {
 		DPRINTK("Use default cmap\n");
 		fb_copy_cmap(fb_default_cmap(fb_display[con].var.bits_per_pixel==8 ? 256 : 16),

--Boundary-00=_5TqHBtzMhPTcSnZ--
