Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbVCPXUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbVCPXUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVCPXTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:19:38 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:23713 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262877AbVCPXRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:17:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FuU5Ij04UcmfZbYYgF1NRjA2hmSEIswb6wrrBt0hxA22na5yzTmZhKeZq9HDRtxDhCbtwGUO3FtABFb0f9l8Z/Erji4+Pi5IHruR3k4cPCTodrunCEGLo/O/UBcKC/6rqnYIIZ4iLRQUXUDG6jTxLpRZvEu+GEu9q6mwTvHUjaI=
Message-ID: <9e4733910503161517735bc631@mail.gmail.com>
Date: Wed, 16 Mar 2005 18:17:21 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: jschopp@austin.ibm.com
Subject: Re: [PATCH] matroxfb compile error
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42371945.1030606@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <42371945.1030606@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is already fixed the patch just hasn't made it in yet.

--
Jon Smirl
jonsmirl@gmail.com

Fix link error for PPC-based drivers that also use functions in macmodes.c.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Kconfig    |   16 ++++++++++++++++
Makefile   |    9 +++++----
macmodes.c |    9 ++++++---
3 files changed, 27 insertions(+), 7 deletions(-)

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig     2005-03-05 07:56:36 +08:00
+++ b/drivers/video/Kconfig     2005-03-14 06:50:28 +08:00
@@ -74,6 +74,11 @@
        This is used by drivers that don't provide their own (accelerated)
        version.

+config FB_MACMODES
+       tristate
+       depends on FB
+       default n
+
config FB_MODE_HELPERS
       bool "Enable Video Mode Handling Helpers"
       depends on FB
@@ -323,6 +328,7 @@
      select FB_CFB_COPYAREA
      select FB_CFB_IMAGEBLIT
      select FB_SOFT_CURSOR
+       select FB_MACMODES
      help
        Say Y if you want support with Open Firmware for your graphics
        board.
@@ -334,6 +340,7 @@
      select FB_CFB_COPYAREA
      select FB_CFB_IMAGEBLIT
      select FB_SOFT_CURSOR
+       select FB_MACMODES
      help
        This driver supports a frame buffer for the graphics adapter in the
        Power Macintosh 7300 and others.
@@ -345,6 +352,7 @@
      select FB_CFB_COPYAREA
      select FB_CFB_IMAGEBLIT
      select FB_SOFT_CURSOR
+       select FB_MACMODES
      help
        This driver supports a frame buffer for the "platinum" graphics
        adapter in some Power Macintoshes.
@@ -356,6 +364,7 @@
      select FB_CFB_COPYAREA
      select FB_CFB_IMAGEBLIT
      select FB_SOFT_CURSOR
+       select FB_MACMODES
      help
        This driver supports a frame buffer for the "valkyrie" graphics
        adapter in some Power Macintoshes.
@@ -384,6 +393,7 @@
      depends on (FB = y) && PCI
      select FB_CFB_IMAGEBLIT
      select FB_SOFT_CURSOR
+       select FB_MACMODES if PPC
      help
        The IMS Twin Turbo is a PCI-based frame buffer card bundled with
        many Macintosh and compatible computers.
@@ -436,6 +446,7 @@
      select FB_CFB_COPYAREA
      select FB_CFB_IMAGEBLIT
      select FB_SOFT_CURSOR
+       select FB_MACMODES

#      bool '  Apple DAFB display support' CONFIG_FB_DAFB
config FB_HP300
@@ -753,6 +764,7 @@
      select FB_CFB_IMAGEBLIT
      select FB_SOFT_CURSOR
      select FB_TILEBLITTING
+       select FB_MACMODES if PPC_PMAC
      ---help---
        Say Y here if you have a Matrox Millennium, Matrox Millennium II,
        Matrox Mystique, Matrox Mystique 220, Matrox Productiva G100, Matrox
@@ -892,6 +904,7 @@
      select FB_CFB_COPYAREA
      select FB_CFB_IMAGEBLIT
      select FB_SOFT_CURSOR
+       select FB_MACMODES if PPC
      help
        Choose this option if you want to use an ATI Radeon graphics card as
        a framebuffer device.  There are both PCI and AGP versions.  You
@@ -909,6 +922,7 @@
      select FB_CFB_COPYAREA
      select FB_CFB_IMAGEBLIT
      select FB_SOFT_CURSOR
+       select FB_MACMODES if PPC_OF
      help
        Choose this option if you want to use an ATI Radeon graphics card as
        a framebuffer device.  There are both PCI and AGP versions.  You
@@ -947,6 +961,7 @@
      select FB_CFB_COPYAREA
      select FB_CFB_IMAGEBLIT
      select FB_SOFT_CURSOR
+       select FB_MACMODES if PPC_PMAC
      help
        This driver supports graphics boards with the ATI Rage128 chips.
        Say Y if you have such a graphics board and read
@@ -962,6 +977,7 @@
      select FB_CFB_COPYAREA
      select FB_CFB_IMAGEBLIT
      select FB_SOFT_CURSOR
+       select FB_MACMODES if PPC
      help
        This driver supports graphics boards with the ATI Mach64 chips.
        Say Y if you have such a graphics board.
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile    2005-03-12 23:22:36 +08:00
+++ b/drivers/video/Makefile    2005-03-14 06:55:07 +08:00
@@ -16,6 +16,7 @@
obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
obj-$(CONFIG_FB_CFB_IMAGEBLIT) += cfbimgblt.o
obj-$(CONFIG_FB_SOFT_CURSOR)   += softcursor.o
+obj-$(CONFIG_FB_MACMODES)      += macmodes.o

# Hardware specific drivers go first
obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
@@ -41,9 +42,9 @@
obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o vgastate.o
obj-$(CONFIG_FB_VIRGE)            += virgefb.o
obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
-obj-$(CONFIG_FB_CONTROL)          += controlfb.o macmodes.o
-obj-$(CONFIG_FB_PLATINUM)         += platinumfb.o macmodes.o
-obj-$(CONFIG_FB_VALKYRIE)         += valkyriefb.o macmodes.o
+obj-$(CONFIG_FB_CONTROL)          += controlfb.o
+obj-$(CONFIG_FB_PLATINUM)         += platinumfb.o
+obj-$(CONFIG_FB_VALKYRIE)         += valkyriefb.o
obj-$(CONFIG_FB_CT65550)          += chipsfb.o
obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
obj-$(CONFIG_FB_S3TRIO)           += S3triofb.o
@@ -61,7 +62,7 @@
obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o
obj-$(CONFIG_FB_ACORN)            += acornfb.o
obj-$(CONFIG_FB_ATARI)            += atafb.o
-obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o
+obj-$(CONFIG_FB_MAC)              += macfb.o
obj-$(CONFIG_FB_HGA)              += hgafb.o
obj-$(CONFIG_FB_IGA)              += igafb.o
obj-$(CONFIG_FB_APOLLO)           += dnfb.o
diff -Nru a/drivers/video/macmodes.c b/drivers/video/macmodes.c
--- a/drivers/video/macmodes.c  2005-03-12 23:23:12 +08:00
+++ b/drivers/video/macmodes.c  2005-03-14 06:50:30 +08:00
@@ -19,6 +19,7 @@
#include <linux/errno.h>
#include <linux/fb.h>
#include <linux/string.h>
+#include <linux/module.h>

#include "macmodes.h"

@@ -281,7 +282,7 @@
   var->vmode = mode->vmode;
   return 0;
}
-
+EXPORT_SYMBOL(mac_vmode_to_var);

/**
*     mac_var_to_vmode - convert var structure to MacOS vmode/cmode pair
@@ -326,7 +327,7 @@
   }
   return -EINVAL;
}
-
+EXPORT_SYMBOL(mac_var_to_vmode);

/**
*     mac_map_monitor_sense - Convert monitor sense to vmode
@@ -348,7 +349,7 @@
          break;
   return map->vmode;
}
-
+EXPORT_SYMBOL(mac_map_monitor_sense);

/**
*     mac_find_mode - find a video mode
@@ -384,3 +385,5 @@
   return fb_find_mode(var, info, mode_option, db, dbsize,
                      &mac_modedb[DEFAULT_MODEDB_INDEX], default_bpp);
}
+EXPORT_SYMBOL(mac_find_mode);
+
