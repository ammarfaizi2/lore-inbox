Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLNSpt>; Thu, 14 Dec 2000 13:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbQLNSpi>; Thu, 14 Dec 2000 13:45:38 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:16903 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129345AbQLNSpe>;
	Thu, 14 Dec 2000 13:45:34 -0500
Date: Thu, 14 Dec 2000 19:14:43 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0-test13-pre1 Makefile fixes
Message-ID: <20001214191443.A3079@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
  test13 pre1 contains
(1) lowercase agp :-(
(2) even if matroxfb is compiled into kernel, you can have some
    parts of it compiled as modules (i2c support, g400 second head)
BTW, why both-m rule is not in Rules.make? I copied this one
from drivers/Makefile...
				Thanks,
					Petr Vandrovec
					vandrove@vc.cvut.cz

diff -urdN linux/drivers/char/Makefile linux/drivers/char/Makefile
--- linux/drivers/char/Makefile	Thu Dec 14 17:43:18 2000
+++ linux/drivers/char/Makefile	Thu Dec 14 17:53:14 2000
@@ -155,7 +155,7 @@
 subdir-$(CONFIG_FTAPE) += ftape
 subdir-$(CONFIG_DRM) += drm
 subdir-$(CONFIG_PCMCIA) += pcmcia
-subdir-$(CONFIG_agp) += agp
+subdir-$(CONFIG_AGP) += agp
 
 ifeq ($(CONFIG_FTAPE),y)
 obj-y       += ftape/ftape.o
diff -urdN linux/drivers/video/Makefile linux/drivers/video/Makefile
--- linux/drivers/video/Makefile	Thu Dec 14 17:43:18 2000
+++ linux/drivers/video/Makefile	Thu Dec 14 18:05:03 2000
@@ -6,6 +6,8 @@
 O_OBJS   :=
 M_OBJS   :=
 
+mod-subdirs	:= matrox
+
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
@@ -119,6 +121,8 @@
 obj-$(CONFIG_FBCON_MFB)           += fbcon-mfb.o
 obj-$(CONFIG_FBCON_VGA)           += fbcon-vga.o
 obj-$(CONFIG_FBCON_HGA)           += fbcon-hga.o
+
+both-m	:= $(filter $(mod-subdirs), $(subdir-y))
 
 include $(TOPDIR)/Rules.make
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
