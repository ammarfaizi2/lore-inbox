Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbTIKG0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 02:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbTIKG0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 02:26:31 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:32990 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266142AbTIKG01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 02:26:27 -0400
Date: Thu, 11 Sep 2003 08:26:21 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: linux-ide@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] dtc2278.c warning
Message-ID: <Pine.GSO.4.21.0309110824070.1879-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move dtc2278_release() to kill a warning in the non-modular case

--- linux-2.6.0-test5/drivers/ide/legacy/dtc2278.c.orig	Tue Sep  9 10:12:44 2003
+++ linux-2.6.0-test5/drivers/ide/legacy/dtc2278.c	Tue Sep  9 14:15:35 2003
@@ -134,6 +134,24 @@
 	probe_hwif_init(&ide_hwifs[1]);
 }
 
+#ifndef MODULE
+/*
+ * init_dtc2278:
+ *
+ * called by ide.c when parsing command line
+ */
+
+void __init init_dtc2278 (void)
+{
+	probe_dtc2278();
+}
+
+#else
+
+MODULE_AUTHOR("See Local File");
+MODULE_DESCRIPTION("support of DTC-2278 VLB IDE chipsets");
+MODULE_LICENSE("GPL");
+
 static void dtc2278_release (void)
 {
 	if (ide_hwifs[0].chipset != ide_dtc2278 &&
@@ -152,24 +170,6 @@
 	ide_hwifs[0].mate = NULL;
 	ide_hwifs[1].mate = NULL;
 }
-
-#ifndef MODULE
-/*
- * init_dtc2278:
- *
- * called by ide.c when parsing command line
- */
-
-void __init init_dtc2278 (void)
-{
-	probe_dtc2278();
-}
-
-#else
-
-MODULE_AUTHOR("See Local File");
-MODULE_DESCRIPTION("support of DTC-2278 VLB IDE chipsets");
-MODULE_LICENSE("GPL");
 
 static int __init dtc2278_mod_init(void)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

