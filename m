Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131935AbQLVSyc>; Fri, 22 Dec 2000 13:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131934AbQLVSyM>; Fri, 22 Dec 2000 13:54:12 -0500
Received: from shoe.tuxtops.com ([208.184.141.200]:49928 "EHLO
	shoe.tuxtops.com") by vger.kernel.org with ESMTP id <S130425AbQLVSyE>;
	Fri, 22 Dec 2000 13:54:04 -0500
Date: Fri, 22 Dec 2000 09:54:44 -0800 (PST)
From: Brad Douglas <brad@tuxtops.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2.19pre3
Message-ID: <Pine.LNX.4.10.10012220952290.26628-100000@shoe.tuxtops.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

Here's a patch that fixes the Makefile and Config.in for drivers/video in
regard to the ATI Rage128.  This will allow it to properly be compiled as
a module with proper defaults.

No idea what happened to this...  Looks like it's been broke for some
time.

Brad Douglas
brad@tuxtops.com
brad@neruo.com


diff -urN linux-2.2.19pre3/drivers/video/Config.in linux/drivers/video/Config.in
--- linux-2.2.19pre3/drivers/video/Config.in	Sun Dec 10 16:49:44 2000
+++ linux/drivers/video/Config.in	Fri Dec 22 09:56:35 2000
@@ -188,7 +188,8 @@
 	 "$CONFIG_FB_VALKYRIE" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
          "$CONFIG_FB_IGA" = "y" -o "$CONFIG_FB_MATROX" = "y" -o \
 	 "$CONFIG_FB_CT65550" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-	 "$CONFIG_FB_SGIVW" = "y" -o "$CONFIG_FB_CYBER2000" = "y" ]; then
+	 "$CONFIG_FB_SGIVW" = "y" -o "$CONFIG_FB_CYBER2000" = "y" -o \
+	 "$CONFIG_FB_ATY128" = "y" ]; then
       define_bool CONFIG_FBCON_CFB8 y
     else
       if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_ATARI" = "m" -o \
@@ -202,14 +203,15 @@
 	   "$CONFIG_FB_VALKYRIE" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
            "$CONFIG_FB_IGA" = "m" -o "$CONFIG_FB_MATROX" = "m" -o \
 	   "$CONFIG_FB_CT65550" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-	   "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_CYBER2000" = "m" ]; then
+	   "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_CYBER2000" = "m" -o \
+	   "$CONFIG_FB_ATY128" = "m" ]; then
 	define_bool CONFIG_FBCON_CFB8 m
       fi
     fi
     if [ "$CONFIG_FB_ATARI" = "y" -o "$CONFIG_FB_ATY" = "y" -o \
 	 "$CONFIG_FB_MAC" = "y" -o "$CONFIG_FB_VESA" = "y" -o \
 	 "$CONFIG_FB_VIRTUAL" = "y" -o "$CONFIG_FB_TBOX" = "y" -o \
-	 "$CONFIG_FB_Q40" = "y" -o \
+	 "$CONFIG_FB_Q40" = "y" -o "$CONFIG_FB_ATY128" = "y" -o \
 	 "$CONFIG_FB_CONTROL" = "y" -o "$CONFIG_FB_CLGEN" = "y" -o \
 	 "$CONFIG_FB_VIRGE" = "y" -o "$CONFIG_FB_CYBER" = "y" -o \
 	 "$CONFIG_FB_VALKYRIE" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
@@ -221,7 +223,7 @@
       if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
 	   "$CONFIG_FB_MAC" = "m" -o "$CONFIG_FB_VESA" = "m" -o \
 	   "$CONFIG_FB_VIRTUAL" = "m" -o "$CONFIG_FB_TBOX" = "m" -o \
-	 "$CONFIG_FB_Q40" = "m" -o \
+	   "$CONFIG_FB_Q40" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	   "$CONFIG_FB_CONTROL" = "m" -o "$CONFIG_FB_CLGEN" = "m" -o \
 	   "$CONFIG_FB_VIRGE" = "m" -o "$CONFIG_FB_CYBER" = "m" -o \
  	   "$CONFIG_FB_VALKYRIE" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
@@ -234,13 +236,13 @@
     if [ "$CONFIG_FB_ATY" = "y" -o "$CONFIG_FB_VIRTUAL" = "y" -o \
 	 "$CONFIG_FB_CLGEN" = "y" -o "$CONFIG_FB_VESA" = "y" -o \
 	  "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-	 "$CONFIG_FB_CYBER2000" = "y" ]; then
+	 "$CONFIG_FB_CYBER2000" = "y" -o "$CONFIG_FB_ATY128" = "y" ]; then
       define_bool CONFIG_FBCON_CFB24 y
     else
       if [ "$CONFIG_FB_ATY" = "m" -o "$CONFIG_FB_VIRTUAL" = "m" -o \
 	   "$CONFIG_FB_CLGEN" = "m" -o "$CONFIG_FB_VESA" = "m" -o \
 	   "$CONFIG_FB_MATROX" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-	   "$CONFIG_FB_CYBER2000" = "m" ]; then
+	   "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_ATY128" = "m" ]; then
 	define_bool CONFIG_FBCON_CFB24 m
       fi
     fi
@@ -249,7 +251,8 @@
 	 "$CONFIG_FB_CONTROL" = "y" -o "$CONFIG_FB_CLGEN" = "y" -o \
 	 "$CONFIG_FB_TGA" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
 	 "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-	 "$CONFIG_FB_FM2" = "y" -o "$CONFIG_FB_SGIVW" = "y" ]; then
+	 "$CONFIG_FB_FM2" = "y" -o "$CONFIG_FB_SGIVW" = "y" -o \
+	 "$CONFIG_FB_ATY128" = "y" ]; then
       define_bool CONFIG_FBCON_CFB32 y
     else
       if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
@@ -257,7 +260,7 @@
 	   "$CONFIG_FB_CONTROL" = "m" -o "$CONFIG_FB_CLGEN" = "m" -o \
 	   "$CONFIG_FB_TGA" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
 	   "$CONFIG_FB_MATROX" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-           "$CONFIG_FB_SGIVW" = "m" ]; then
+           "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_ATY128" = "m" ]; then
 	define_bool CONFIG_FBCON_CFB32 m
       fi
     fi
diff -urN linux-2.2.19pre3/drivers/video/Makefile linux/drivers/video/Makefile
--- linux-2.2.19pre3/drivers/video/Makefile	Sun Dec 10 16:49:44 2000
+++ linux/drivers/video/Makefile	Fri Dec 22 09:53:00 2000
@@ -106,6 +106,10 @@
 
 ifeq ($(CONFIG_FB_ATY128),y)
   L_OBJS += aty128fb.o
+else
+  ifeq ($(CONFIG_FB_ATY128),m)
+  M_OBJS += aty128fb.o
+  endif
 endif
 
 ifeq ($(CONFIG_FB_IGA),y)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
