Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSKXSMM>; Sun, 24 Nov 2002 13:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSKXSMM>; Sun, 24 Nov 2002 13:12:12 -0500
Received: from tomts9.bellnexxia.net ([209.226.175.53]:29899 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261544AbSKXSMJ>; Sun, 24 Nov 2002 13:12:09 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix some module format errors
Date: Sun, 24 Nov 2002 13:14:31 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211241314.31413.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds no_module_init to a few modules - those I need...
This lets the new module code load them.

Ed Tomlinson

--------------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.859   -> 1.860  
#	drivers/video/matrox/matroxfb_Ti3026.c	1.6     -> 1.7    
#	sound/oss/ac97_codec.c	1.11    -> 1.12   
#	   drivers/net/mii.c	1.14    -> 1.15   
#	drivers/video/matrox/matroxfb_DAC1064.c	1.14    -> 1.15   
#	drivers/video/matrox/matroxfb_accel.c	1.8     -> 1.9    
#	drivers/video/matrox/matroxfb_misc.c	1.9     -> 1.10   
#	drivers/video/matrox/g450_pll.c	1.2     -> 1.3    
#	drivers/video/matrox/matroxfb_g450.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/24	ed@oscar.et.ca	1.860
# add no_module_init for
# matrox fb, ac97_codex (cs46xx) and mii (via_rhine)
# --------------------------------------------
#
diff -Nru a/drivers/net/mii.c b/drivers/net/mii.c
--- a/drivers/net/mii.c	Sun Nov 24 13:05:08 2002
+++ b/drivers/net/mii.c	Sun Nov 24 13:05:08 2002
@@ -32,6 +32,7 @@
 #include <linux/netdevice.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
+#include <linux/init.h>
 
 int mii_ethtool_gset(struct mii_if_info *mii, struct ethtool_cmd *ecmd)
 {
@@ -335,6 +336,8 @@
 
 	return rc;
 }
+
+no_module_init;
 
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@pobox.com>");
 MODULE_DESCRIPTION ("MII hardware support library");
diff -Nru a/drivers/video/matrox/g450_pll.c b/drivers/video/matrox/g450_pll.c
--- a/drivers/video/matrox/g450_pll.c	Sun Nov 24 13:05:08 2002
+++ b/drivers/video/matrox/g450_pll.c	Sun Nov 24 13:05:08 2002
@@ -16,6 +16,7 @@
 
 #include "g450_pll.h"
 #include "matroxfb_DAC1064.h"
+#include "linux/init.h"
 
 static inline unsigned int g450_vco2f(unsigned char p, unsigned int fvco) {
 	return (p & 0x40) ? fvco : fvco >> ((p & 3) + 1);
@@ -468,6 +469,8 @@
 	}
 	return -ENOMEM;
 }
+
+no_module_init;
 
 EXPORT_SYMBOL(matroxfb_g450_setclk);
 EXPORT_SYMBOL(g450_mnp2f);
diff -Nru a/drivers/video/matrox/matroxfb_DAC1064.c b/drivers/video/matrox/matroxfb_DAC1064.c
--- a/drivers/video/matrox/matroxfb_DAC1064.c	Sun Nov 24 13:05:08 2002
+++ b/drivers/video/matrox/matroxfb_DAC1064.c	Sun Nov 24 13:05:08 2002
@@ -20,6 +20,7 @@
 #include "matroxfb_accel.h"
 #include "g450_pll.h"
 #include <linux/matroxfb.h>
+#include <linux/init.h>
 
 #ifdef NEED_DAC1064
 #define outDAC1064 matroxfb_DAC_out
@@ -1225,4 +1226,7 @@
 EXPORT_SYMBOL(DAC1064_global_init);
 EXPORT_SYMBOL(DAC1064_global_restore);
 #endif
+
+no_module_init;
+
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/matrox/matroxfb_Ti3026.c b/drivers/video/matrox/matroxfb_Ti3026.c
--- a/drivers/video/matrox/matroxfb_Ti3026.c	Sun Nov 24 13:05:08 2002
+++ b/drivers/video/matrox/matroxfb_Ti3026.c	Sun Nov 24 13:05:08 2002
@@ -85,6 +85,7 @@
 #include "matroxfb_misc.h"
 #include "matroxfb_accel.h"
 #include <linux/matroxfb.h>
+#include <linux/init.h>
 
 #ifdef CONFIG_FB_MATROX_MILLENIUM
 #define outTi3026 matroxfb_DAC_out
@@ -880,4 +881,7 @@
 };
 EXPORT_SYMBOL(matrox_millennium);
 #endif
+
+no_module_init;
+
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/matrox/matroxfb_accel.c b/drivers/video/matrox/matroxfb_accel.c
--- a/drivers/video/matrox/matroxfb_accel.c	Sun Nov 24 13:05:08 2002
+++ b/drivers/video/matrox/matroxfb_accel.c	Sun Nov 24 13:05:08 2002
@@ -80,6 +80,7 @@
 #include "matroxfb_DAC1064.h"
 #include "matroxfb_Ti3026.h"
 #include "matroxfb_misc.h"
+#include "linux/init.h"
 
 #define curr_ydstorg(x)	ACCESS_FBINFO2(x, curr.ydstorg.pixels)
 
@@ -1256,4 +1257,5 @@
 
 EXPORT_SYMBOL(matrox_init_putc);
 
+no_module_init;
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/matrox/matroxfb_g450.c b/drivers/video/matrox/matroxfb_g450.c
--- a/drivers/video/matrox/matroxfb_g450.c	Sun Nov 24 13:05:08 2002
+++ b/drivers/video/matrox/matroxfb_g450.c	Sun Nov 24 13:05:08 2002
@@ -17,6 +17,7 @@
 #include "matroxfb_DAC1064.h"
 #include "g450_pll.h"
 #include <linux/matroxfb.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 
@@ -410,6 +411,8 @@
 		up_write(&ACCESS_FBINFO(altout.lock));
 	}
 }
+
+no_module_init;
 
 EXPORT_SYMBOL(matroxfb_g450_connect);
 EXPORT_SYMBOL(matroxfb_g450_shutdown);
diff -Nru a/drivers/video/matrox/matroxfb_misc.c b/drivers/video/matrox/matroxfb_misc.c
--- a/drivers/video/matrox/matroxfb_misc.c	Sun Nov 24 13:05:08 2002
+++ b/drivers/video/matrox/matroxfb_misc.c	Sun Nov 24 13:05:08 2002
@@ -87,6 +87,7 @@
 #include "matroxfb_misc.h"
 #include <linux/interrupt.h>
 #include <linux/matroxfb.h>
+#include <linux/init.h>
 
 void matroxfb_createcursorshape(WPMINFO struct display* p, int vmode) {
 	unsigned int h;
@@ -996,6 +997,8 @@
 	pci_write_config_dword(pdev, PCI_OPTION_REG, opt);
 	matroxfb_set_limits(PMINFO &ACCESS_FBINFO(bios));
 }
+
+no_module_init;
 
 EXPORT_SYMBOL(matroxfb_DAC_in);
 EXPORT_SYMBOL(matroxfb_DAC_out);
diff -Nru a/sound/oss/ac97_codec.c b/sound/oss/ac97_codec.c
--- a/sound/oss/ac97_codec.c	Sun Nov 24 13:05:08 2002
+++ b/sound/oss/ac97_codec.c	Sun Nov 24 13:05:08 2002
@@ -1,4 +1,3 @@
-
 /*
  * ac97_codec.c: Generic AC97 mixer/modem module
  *
@@ -50,6 +49,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/ac97_codec.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>
 
 static int ac97_read_mixer(struct ac97_codec *codec, int oss_channel);
@@ -1106,6 +1106,8 @@
 	}
 	return 0;
 }
+
+no_module_init;
 
 EXPORT_SYMBOL(ac97_restore_state);
 
--------------

