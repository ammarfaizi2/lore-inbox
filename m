Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWHVOqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWHVOqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWHVOqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:46:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17162 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932281AbWHVOqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:46:20 -0400
Date: Tue, 22 Aug 2006 16:46:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC: 2.6 patch] build sound/sound_firmware.c only for OSS
Message-ID: <20060822144620.GY11651@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All sound/sound_firmware.c contains is mod_firmware_load() that is a 
legacy API only used by some OSS drivers.

This patch builds it into an own sound_firmware module that is only 
built depending on CONFIG_SOUND_PRIME making the kernel slightly smaller 
for ALSA users.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/Makefile         |    3 ++-
 sound/sound_core.c     |    4 ----
 sound/sound_firmware.c |    3 +++
 3 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.18-rc4-mm2/sound/Makefile.old	2006-08-22 00:07:41.000000000 +0200
+++ linux-2.6.18-rc4-mm2/sound/Makefile	2006-08-22 00:10:41.000000000 +0200
@@ -2,6 +2,7 @@
 #
 
 obj-$(CONFIG_SOUND) += soundcore.o
+obj-$(CONFIG_SOUND_PRIME) += sound_firmware.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
 obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/
@@ -11,4 +12,4 @@
   obj-y += last.o
 endif
 
-soundcore-objs  := sound_core.o sound_firmware.o
+soundcore-objs  := sound_core.o
--- linux-2.6.18-rc4-mm2/sound/sound_core.c.old	2006-08-22 00:09:13.000000000 +0200
+++ linux-2.6.18-rc4-mm2/sound/sound_core.c	2006-08-22 00:12:10.000000000 +0200
@@ -517,10 +517,6 @@
 	return -ENODEV;
 }
 
-extern int mod_firmware_load(const char *, char **);
-EXPORT_SYMBOL(mod_firmware_load);
-
-
 MODULE_DESCRIPTION("Core sound module");
 MODULE_AUTHOR("Alan Cox");
 MODULE_LICENSE("GPL");
--- linux-2.6.18-rc4-mm2/sound/sound_firmware.c.old	2006-08-22 00:10:53.000000000 +0200
+++ linux-2.6.18-rc4-mm2/sound/sound_firmware.c	2006-08-22 00:26:03.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <asm/uaccess.h>
+#include "oss/sound_firmware.h"
 
 static int do_mod_firmware_load(const char *fn, char **fp)
 {
@@ -73,4 +74,6 @@
 	set_fs(fs);
 	return r;
 }
+EXPORT_SYMBOL(mod_firmware_load);
 
+MODULE_LICENSE("GPL");

