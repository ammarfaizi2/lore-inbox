Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTEZNmo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 09:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTEZNmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 09:42:44 -0400
Received: from pointblue.com.pl ([62.89.73.6]:40712 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S264379AbTEZNml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 09:42:41 -0400
Subject: [PATCH] 2.5.69-bk19 drm_memory.h compilation error
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus <torvalds@transmeta.com>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1053956681.1852.7.camel@nalesnik.localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 14:44:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from drivers/char/drm/i810_drv.c:52:
drivers/char/drm/drm_memory.h: In function `drm_ioremapfree':
drivers/char/drm/drm_memory.h:170: error: `PKMAP_BASE' undeclared (first
use in this function)
drivers/char/drm/drm_memory.h:170: error: (Each undeclared identifier is
reported only once
drivers/char/drm/drm_memory.h:170: error: for each function it appears
in.)
make[3]: *** [drivers/char/drm/i810_drv.o] Error 1
make[2]: *** [drivers/char/drm] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2


looks like include/asm/highmem.h is not included.

patch below against 2.5.69-bk19
this helps

----------------------------------------------------------
diff -ur 1/drivers/char/drm/drm_memory.h 2/drivers/char/drm/drm_memory.h
--- 1/drivers/char/drm/drm_memory.h     2003-05-26 14:40:31.000000000
+0100
+++ 2/drivers/char/drm/drm_memory.h     2003-05-26 14:42:29.000000000
+0100
@@ -32,6 +32,14 @@
 #include <linux/config.h>
 #include "drmP.h"

+/*
+ * we need PKMAP_BASE definition
+*/
+
+#ifdef CONFIG_HIGHMEM
+#include <asm/highmem.h>
+#endif
+
 /* Cut down version of drm_memory_debug.h, which used to be called
  * drm_memory.h.  If you want the debug functionality, change 0 to 1
  * below.
------------------------------------------------------------------

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

