Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135614AbRD1ThS>; Sat, 28 Apr 2001 15:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135615AbRD1ThI>; Sat, 28 Apr 2001 15:37:08 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:40089 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135614AbRD1Tg7>; Sat, 28 Apr 2001 15:36:59 -0400
Date: Sat, 28 Apr 2001 12:36:51 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: PATCH: linux-2.4.4/drivers/video/Config.in offered drivers that would not compile on your architecture
Message-ID: <20010428123651.A1406@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	linux-2.4.4/drivers/video/Config.in allowed the user to select
some Atari and SuperH architecture video drivers that would not compile
on other architectures.  This patch causes those drivers to be offered
only on architectures on which they will compile.

	By the way, this patch is much simpler than it looks.  It just
adds two "if" statements.  The rest of the chanages is just the
corresponding reindentation.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="video.diff"

--- linux-2.4.4/drivers/video/Config.in	Fri Apr 13 20:31:32 2001
+++ linux/drivers/video/Config.in	Fri Apr 27 23:20:51 2001
@@ -98,10 +98,13 @@
          bool '    CGsix (GX,TurboGX) support' CONFIG_FB_CGSIX
       fi
    fi
-   bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
-   if [ "$CONFIG_FB_E1355" = "y" ]; then
-      hex '    Register Base Address' CONFIG_E1355_REG_BASE a8000000
-      hex '    Framebuffer Base Address' CONFIG_E1355_FB_BASE a8200000
+
+   if [ "$CONFIG_SUPERH" = "y" ]; then
+      bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
+      if [ "$CONFIG_FB_E1355" = "y" ]; then
+         hex '    Register Base Address' CONFIG_E1355_REG_BASE a8000000
+         hex '    Framebuffer Base Address' CONFIG_E1355_FB_BASE a8200000
+      fi
    fi
    if [ "$CONFIG_SH_DREAMCAST" = "y" ]; then
       tristate '  Dreamcast Frame Buffer support' CONFIG_FB_DC
@@ -179,10 +182,12 @@
       tristate '    32 bpp packed pixels support' CONFIG_FBCON_CFB32
       tristate '    Amiga bitplanes support' CONFIG_FBCON_AFB
       tristate '    Amiga interleaved bitplanes support' CONFIG_FBCON_ILBM
-      tristate '    Atari interleaved bitplanes (2 planes) support' CONFIG_FBCON_IPLAN2P2
-      tristate '    Atari interleaved bitplanes (4 planes) support' CONFIG_FBCON_IPLAN2P4
-      tristate '    Atari interleaved bitplanes (8 planes) support' CONFIG_FBCON_IPLAN2P8
-#      tristate '    Atari interleaved bitplanes (16 planes) support' CONFIG_FBCON_IPLAN2P16
+      if [ "$CONFIG_ATARI" = "y" ]; then
+        tristate '    Atari interleaved bitplanes (2 planes) support' CONFIG_FBCON_IPLAN2P2
+        tristate '    Atari interleaved bitplanes (4 planes) support' CONFIG_FBCON_IPLAN2P4
+        tristate '    Atari interleaved bitplanes (8 planes) support' CONFIG_FBCON_IPLAN2P8
+#       tristate '    Atari interleaved bitplanes (16 planes) support' CONFIG_FBCON_IPLAN2P16
+      fi	
       tristate '    Mac variable bpp packed pixels support' CONFIG_FBCON_MAC
       tristate '    VGA 16-color planar support' CONFIG_FBCON_VGA_PLANES
       tristate '    VGA characters/attributes support' CONFIG_FBCON_VGA

--cWoXeonUoKmBZSoM--
