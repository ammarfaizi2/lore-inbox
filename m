Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263681AbTCUSFj>; Fri, 21 Mar 2003 13:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263683AbTCUSFj>; Fri, 21 Mar 2003 13:05:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32131
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263681AbTCUSFg>; Fri, 21 Mar 2003 13:05:36 -0500
Date: Fri, 21 Mar 2003 19:20:51 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211920.h2LJKpoF025699@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: __NO_VERSION__ and remove a bogomacro from drm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/i830_dma.c linux-2.5.65-ac2/drivers/char/drm/i830_dma.c
--- linux-2.5.65/drivers/char/drm/i830_dma.c	2003-02-10 18:37:58.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/i830_dma.c	2003-03-14 00:52:15.000000000 +0000
@@ -31,7 +31,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include "i830.h"
 #include "drmP.h"
 #include "drm.h"
@@ -40,12 +39,6 @@
 #include <linux/interrupt.h>	/* For task queue support */
 #include <linux/delay.h>
 
-#ifdef DO_MUNMAP_4_ARGS
-#define DO_MUNMAP(m, a, l)	do_munmap(m, a, l, 1)
-#else
-#define DO_MUNMAP(m, a, l)	do_munmap(m, a, l)
-#endif
-
 #define I830_BUF_FREE		2
 #define I830_BUF_CLIENT		1
 #define I830_BUF_HARDWARE      	0
@@ -230,7 +223,7 @@
 		return -EINVAL;
 
 	down_write(&current->mm->mmap_sem);
-	retcode = DO_MUNMAP(current->mm,
+	retcode = do_munmap(current->mm,
 			    (unsigned long)buf_priv->virtual,
 			    (size_t) buf->total);
 	up_write(&current->mm->mmap_sem);
