Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272570AbTG0XW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272475AbTG0Wzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 18:55:50 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272464AbTG0WzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:55:19 -0400
Subject: [PATCH] Remove what looks like a redundant ffb_options in ffb_drv.c
From: Tugrul Galatali <tugrul@galatali.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1059343449.720.12.camel@duality.galatali.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 27 Jul 2003 18:04:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Decided to try building stock 2.6.0-test2 on an Ultra 60 sitting here,
and ran into a redefinition of ffb_options between ffb_drv.c and
drm_drv.h. The one in ffb_drv.c looks redundant to me, and after
removing it I was able to successfully compile and boot the resulting
kernel.

	Tugrul Galatali


diff -u linux-2.6.0-test2/drivers/char/drm/ffb_drv.c.orig linux-2.6.0-test2/drivers/char/drm/ffb_drv.c
--- linux-2.6.0-test2/drivers/char/drm/ffb_drv.c.orig   2003-07-27 17:08:18.000000000 -0400
+++ linux-2.6.0-test2/drivers/char/drm/ffb_drv.c        2003-07-27 17:06:58.000000000 -0400
@@ -372,25 +372,6 @@
        return ret;
 }
 
-#ifndef MODULE
-/* DRM(options) is called by the kernel to parse command-line options
- * passed via the boot-loader (e.g., LILO).  It calls the insmod option
- * routine, drm_parse_drm.
- */
-
-/* JH- We have to hand expand the string ourselves because of the cpp.  If
- * anyone can think of a way that we can fit into the __setup macro without
- * changing it, then please send the solution my way.
- */
-static int __init ffb_options(char *str)
-{
-       DRM(parse_options)(str);
-       return 1;
-}
-
-__setup(DRIVER_NAME "=", ffb_options);
-#endif
-
 #include "drm_fops.h"
 #include "drm_init.h"
 #include "drm_ioctl.h"



