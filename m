Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266154AbUGTTpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266154AbUGTTpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbUGTToc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:44:32 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:796 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S266154AbUGTSjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:47 -0400
Date: Tue, 20 Jul 2004 20:39:45 +0200
Message-Id: <200407201839.i6KIdjo6015515@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ben Collins <bcollins@debian.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] depends on PCI DMA API: IEEE1394 core and SBP-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IEEE1394 core and SBP-2 unconditionally depend on the PCI DMA API, so mark them
broken if !PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/ieee1394/Kconfig	2004-04-21 10:34:58.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/ieee1394/Kconfig	2004-07-19 18:21:55.000000000 +0200
@@ -4,6 +4,7 @@
 
 config IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
+	depends on PCI || BROKEN
 	help
 	  IEEE 1394 describes a high performance serial bus, which is also
 	  known as FireWire(tm) or i.Link(tm) and is used for connecting all
@@ -113,7 +114,7 @@
 
 config IEEE1394_SBP2
 	tristate "SBP-2 support (Harddisks etc.)"
-	depends on IEEE1394 && SCSI
+	depends on IEEE1394 && SCSI && (PCI || BROKEN)
 	help
 	  This option enables you to use SBP-2 devices connected to your IEEE
 	  1394 bus.  SBP-2 devices include harddrives and DVD devices.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
