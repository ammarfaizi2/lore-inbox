Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSF2WtY>; Sat, 29 Jun 2002 18:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSF2WtX>; Sat, 29 Jun 2002 18:49:23 -0400
Received: from p015.as-l031.contactel.cz ([212.65.234.207]:40832 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S314381AbSF2WtW>;
	Sat, 29 Jun 2002 18:49:22 -0400
Date: Sun, 30 Jun 2002 02:34:10 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] 2.5.24 matroxfb off by one error
Message-ID: <20020630003410.GH25118@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
   please apply patch below.

   It fixes off by one error in getcolreg/setcolreg in matroxfb's 
secondary head driver.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
--- linux/drivers/video/matrox/matroxfb_crtc2.c	Fri Jun 21 00:53:48 2002
+++ linux/drivers/video/matrox/matroxfb_crtc2.c	Sat Jun 29 00:09:09 2002
@@ -29,7 +29,7 @@
 static int matroxfb_dh_getcolreg(unsigned regno, unsigned *red, unsigned *green,
 		unsigned *blue, unsigned *transp, struct fb_info* info) {
 #define m2info ((struct matroxfb_dh_fb_info*)info)
-	if (regno > 16)
+	if (regno >= 16)
 		return 1;
 	*red = m2info->palette[regno].red;
 	*blue = m2info->palette[regno].blue;
@@ -44,7 +44,7 @@
 #define m2info ((struct matroxfb_dh_fb_info*)info)
 	struct display* p;
 
-	if (regno > 16)
+	if (regno >= 16)
 		return 1;
 	m2info->palette[regno].red = red;
 	m2info->palette[regno].blue = blue;
