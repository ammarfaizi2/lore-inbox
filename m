Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLJVUp>; Sun, 10 Dec 2000 16:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132310AbQLJVUg>; Sun, 10 Dec 2000 16:20:36 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:17398
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S129524AbQLJVUR>; Sun, 10 Dec 2000 16:20:17 -0500
Date: Sun, 10 Dec 2000 13:48:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Cc: linux-fbdev@vuser.vu.union.edu
Subject: [PATCH] aty128fb & >8bit
Message-ID: <20001210134847.F4810@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.  I just noticed that in 2.2.18pre27 you can only use the aty128fb
driver at 8 bit, because of some missing bits to drivers/video/Config.in.
w/o this you can't use console at > 8 bit nor X.  I would consider this to
be a good thing to squash for 2.2.18 final because 2.2.18 is the 1st release
in a while that works well on PPC, and lots of PPCs have a rage128.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="128fix.patch"

===== drivers/video/Config.in 1.10 vs edited =====
--- 1.10/drivers/video/Config.in	Fri Oct 20 22:20:29 2000
+++ edited/drivers/video/Config.in	Sun Dec 10 13:33:45 2000
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
@@ -233,14 +235,14 @@
     fi
     if [ "$CONFIG_FB_ATY" = "y" -o "$CONFIG_FB_VIRTUAL" = "y" -o \
 	 "$CONFIG_FB_CLGEN" = "y" -o "$CONFIG_FB_VESA" = "y" -o \
-	  "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-	 "$CONFIG_FB_CYBER2000" = "y" ]; then
+	 "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
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

--VywGB/WGlW4DM4P8--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
