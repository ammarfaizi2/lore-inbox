Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317949AbSGLAZD>; Thu, 11 Jul 2002 20:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317951AbSGLAY7>; Thu, 11 Jul 2002 20:24:59 -0400
Received: from mail.gmx.de ([213.165.64.20]:36442 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317949AbSGLAYz>;
	Thu, 11 Jul 2002 20:24:55 -0400
From: Helge Deller <deller@gmx.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Jani Monoses <jani@iv.ro>
Subject: Re: Linux 2.4.19-rc1: [PATCH] tridentfb
Date: Fri, 12 Jul 2002 02:26:10 +0200
User-Agent: KMail/1.4.5
References: <Pine.LNX.4.44.0206241253120.9274-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44.0206241253120.9274-100000@freak.distro.conectiva>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200207120224.11593.deller@gmx.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iIiL9sDC87gjoCp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_iIiL9sDC87gjoCp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

The following patch automatically adds CONFIG_FBCON_CFB[8,16,32] 
if the tridentfb driver (CONFIG_FB_TRIDENT) was selected.
Without the patch I get:
	fbcon_setup: No support for fontwidth 8
	kernel: fbcon_setup: type 0 (aux 0, depth 8) not supported
and the screen stays black in case tridentfb was the only selected fb-driver.

The second part of the patch only inserts named initializers for some structs
in tridentfb.c.

Helge



--Boundary-00=_iIiL9sDC87gjoCp
Content-Type: text/plain;
  charset="iso-8859-1";
  name=" "
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="trident.patch"

--- ./drivers/video/Config.in.org	Fri Jul 12 02:01:22 2002
+++ ./drivers/video/Config.in	Fri Jul 12 02:02:59 2002
@@ -267,7 +267,7 @@
 	   "$CONFIG_FB_VALKYRIE" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
            "$CONFIG_FB_IGA" = "y" -o "$CONFIG_FB_MATROX" = "y" -o \
 	   "$CONFIG_FB_CT65550" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-           "$CONFIG_FB_PM3" = "y" -o \
+           "$CONFIG_FB_PM3" = "y" -o "$CONFIG_FB_TRIDENT" = "y" -o \
 	   "$CONFIG_FB_P9100" = "y" -o "$CONFIG_FB_ATY128" = "y" -o \
 	   "$CONFIG_FB_RIVA" = "y" -o "$CONFIG_FB_RADEON" = "y" -o \
 	   "$CONFIG_FB_SGIVW" = "y" -o "$CONFIG_FB_CYBER2000" = "y" -o \
@@ -288,7 +288,7 @@
 	      "$CONFIG_FB_VALKYRIE" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
               "$CONFIG_FB_IGA" = "m" -o "$CONFIG_FB_MATROX" = "m" -o \
 	      "$CONFIG_FB_CT65550" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-              "$CONFIG_FB_PM3" = "m" -o \
+              "$CONFIG_FB_PM3" = "m" -o "$CONFIG_FB_TRIDENT" = "y" -o \
 	      "$CONFIG_FB_P9100" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	      "$CONFIG_FB_RIVA" = "m" -o "$CONFIG_FB_3DFX" = "m" -o \
 	      "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_CYBER2000" = "m" -o \
@@ -308,7 +308,7 @@
 	   "$CONFIG_FB_VALKYRIE" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
 	   "$CONFIG_FB_CT65550" = "y" -o "$CONFIG_FB_MATROX" = "y" -o \
 	   "$CONFIG_FB_PM2" = "y" -o "$CONFIG_FB_SGIVW" = "y" -o \
-           "$CONFIG_FB_PM3" = "y" -o \
+           "$CONFIG_FB_PM3" = "y" -o "$CONFIG_FB_TRIDENT" = "y" -o \
 	   "$CONFIG_FB_RIVA" = "y" -o "$CONFIG_FB_ATY128" = "y" -o \
 	   "$CONFIG_FB_CYBER2000" = "y" -o "$CONFIG_FB_3DFX" = "y"  -o \
 	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_SA1100" = "y" -o \
@@ -325,7 +325,7 @@
 	      "$CONFIG_FB_VALKYRIE" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
 	      "$CONFIG_FB_CT65550" = "m" -o "$CONFIG_FB_MATROX" = "m" -o \
 	      "$CONFIG_FB_PM2" = "m" -o "$CONFIG_FB_SGIVW" = "m" -o \
-              "$CONFIG_FB_PM3" = "m" -o \
+              "$CONFIG_FB_PM3" = "m" -o "$CONFIG_FB_TRIDENT" = "y" -o \
 	      "$CONFIG_FB_RIVA" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	      "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
 	      "$CONFIG_FB_SA1100" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
@@ -356,7 +356,7 @@
 	   "$CONFIG_FB_CONTROL" = "y" -o "$CONFIG_FB_CLGEN" = "y" -o \
 	   "$CONFIG_FB_TGA" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
 	   "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-           "$CONFIG_FB_PM3" = "y" -o \
+           "$CONFIG_FB_PM3" = "y" -o "$CONFIG_FB_TRIDENT" = "y" -o \
 	   "$CONFIG_FB_RIVA" = "y" -o "$CONFIG_FB_ATY128" = "y" -o \
 	   "$CONFIG_FB_FM2" = "y" -o "$CONFIG_FB_SGIVW" = "y" -o \
 	   "$CONFIG_FB_RADEON" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
@@ -369,7 +369,7 @@
 	      "$CONFIG_FB_CONTROL" = "m" -o "$CONFIG_FB_CLGEN" = "m" -o \
 	      "$CONFIG_FB_TGA" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
 	      "$CONFIG_FB_MATROX" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-              "$CONFIG_FB_PM3" = "m" -o \
+              "$CONFIG_FB_PM3" = "m" -o "$CONFIG_FB_TRIDENT" = "y" -o \
 	      "$CONFIG_FB_RIVA" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	      "$CONFIG_FB_3DFX" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
--- ./drivers/video/tridentfb.c.org	Fri Jul 12 02:04:11 2002
+++ ./drivers/video/tridentfb.c	Fri Jul 12 02:06:14 2002
@@ -1248,17 +1248,16 @@
 }
 
 static struct fbgen_hwswitch trident_hwswitch = {
-	NULL, /* detect not needed */
-	trident_encode_fix,
-	trident_decode_var,
-	trident_encode_var,
-	trident_get_par,
-	trident_set_par,
-	trident_getcolreg,
-	trident_setcolreg,
-	trident_pan_display,
-	trident_blank,
-	trident_set_disp
+	encode_fix: trident_encode_fix,
+	decode_var: trident_decode_var,
+	encode_var: trident_encode_var,
+	get_par: trident_get_par,
+	set_par: trident_set_par,
+	getcolreg: trident_getcolreg,
+	setcolreg: trident_setcolreg,
+	pan_display: trident_pan_display,
+	blank: trident_blank,
+	set_disp: trident_set_disp
 };
 
 static int trident_iosize;
@@ -1487,6 +1486,7 @@
 }
 
 static struct fb_ops tridentfb_ops = {
+	owner:THIS_MODULE,
 	fb_get_fix:fbgen_get_fix,
 	fb_get_var:fbgen_get_var,
 	fb_set_var:fbgen_set_var,

--Boundary-00=_iIiL9sDC87gjoCp--

