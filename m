Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272532AbTGZOlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272510AbTGZOfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:35:24 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:25151 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272508AbTGZOcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:36 -0400
Date: Sat, 26 Jul 2003 16:51:44 +0200
Message-Id: <200307261451.h6QEpi03002352@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Mac/m68k ADB HID
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ADB HID: Exclude PowerMac-specific things on classic Macs

--- linux-2.6.x/drivers/macintosh/adbhid.c	Tue May 27 19:02:52 2003
+++ linux-m68k-2.6.x/drivers/macintosh/adbhid.c	Sun Jun  8 11:10:58 2003
@@ -44,7 +44,9 @@
 #include <linux/pmu.h>
 
 #include <asm/machdep.h>
+#ifdef CONFIG_PPC_PMAC
 #include <asm/pmac_feature.h>
+#endif
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
@@ -160,6 +162,7 @@
 		return;
 	case 0x3f: /* ignore Powerbook Fn key */
 		return;
+#ifdef CONFIG_PPC_PMAC
 	case 0x7e: /* Power key on PBook 3400 needs remapping */
 		switch(pmac_call_feature(PMAC_FTR_GET_MB_INFO,
 			NULL, PMAC_MB_INFO_MODEL, 0)) {
@@ -169,6 +172,7 @@
 			keycode = 0x7f;
 		}
 		break;
+#endif /* CONFIG_PPC_PMAC */
 	}
 
 	if (adbhid[id]->keycode[keycode]) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
