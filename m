Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTE2MPA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 08:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTE2MPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 08:15:00 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:11235 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S262176AbTE2MO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 08:14:59 -0400
Date: Thu, 29 May 2003 14:28:16 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.70: add comment about console LCD backlight issues
Message-ID: <20030529122816.GB21147@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

a lot of people seem to be confused about (non-working) notebook display
blanking, so...

- add verbose explanation about the whole notebook screen blanking situation
  and a possible development direction to prominent place

I might actually be tempted to unify graphics hardware backlight handling
myself, since having a console that doesn't shut down the backlight properly
is mildly annoying...

Patch against vanilla 2.5.70.

Andreas Mohr

diff -urN linux-2.5.70.orig/drivers/video/console/vgacon.c linux-2.5.70/drivers/video/console/vgacon.c
--- linux-2.5.70.orig/drivers/video/console/vgacon.c	2003-05-28 17:57:07.000000000 +0200
+++ linux-2.5.70/drivers/video/console/vgacon.c	2003-05-29 03:13:53.000000000 +0200
@@ -661,6 +661,22 @@
 	}
 }
 
+/*
+ * vgacon_blank() is able to simply blank the screen, or to even switch
+ * the monitor off in case of "Green", "Energy Star" monitors
+ * (by switching off the sync signals using VESA mechanisms).
+ * However, it is NOT able to switch off the *backlight* of (most?) notebooks.
+ * For these cases, we usually make use of APM display blanking methods.
+ * However if you chose to use ACPI on your notebook instead of APM,
+ * then you're screwed for now, since ACPI expects the operating system itself
+ * to manage video device power state (there's no convenient APM call that
+ * does it for you). Since we don't have VGA adapter specific support for
+ * that (only XFree86 has it), you're only able to switch off your backlight
+ * in XFree86, and only if the driver supports that ('xset dpms force off').
+ * ppc already has config PMAC_BACKLIGHT for several graphics cards,
+ * so backlight handling should simply be generalized here instead,
+ * to also support i386 notebook backlight etc.
+ */
 static int vgacon_blank(struct vc_data *c, int blank)
 {
 	switch (blank) {
