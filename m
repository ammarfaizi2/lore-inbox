Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVGVVnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVGVVnF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVGVVm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:42:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38922 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261281AbVGVVkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:40:55 -0400
Date: Fri, 22 Jul 2005 23:40:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cdrom/mcdx.c: fix -Wundef warnings
Message-ID: <20050722214048.GV3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warnings with -Wundef:

<--  snip  -->

...
  CC      drivers/cdrom/mcdx.o
drivers/cdrom/mcdx.c:54:5: warning: "RCS" is not defined
...
drivers/cdrom/mcdx.c:709:5: warning: "FALLBACK" is not defined
drivers/cdrom/mcdx.c:1219:5: warning: "WE_KNOW_WHY" is not defined
drivers/cdrom/mcdx.c:1297:5: warning: "FALLBACK" is not defined
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/cdrom/mcdx.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

--- linux-2.6.13-rc3-mm1-full/drivers/cdrom/mcdx.c.old	2005-07-22 18:14:36.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/cdrom/mcdx.c	2005-07-22 18:15:29.000000000 +0200
@@ -51,11 +51,6 @@
  */
 
 
-#if RCS
-static const char *mcdx_c_version
-    = "$Id: mcdx.c,v 1.21 1997/01/26 07:12:59 davem Exp $";
-#endif
-
 #include <linux/module.h>
 
 #include <linux/errno.h>
@@ -706,7 +701,7 @@
 		xtrace(OPENCLOSE, "open() init irq generation\n");
 		if (-1 == mcdx_config(stuffp, 1))
 			return -EIO;
-#if FALLBACK
+#ifdef FALLBACK
 		/* Set the read speed */
 		xwarn("AAA %x AAA\n", stuffp->readcmd);
 		if (stuffp->readerrs)
@@ -1216,7 +1211,7 @@
 	}
 
 
-#if WE_KNOW_WHY
+#ifdef WE_KNOW_WHY
 	/* irq 11 -> channel register */
 	outb(0x50, stuffp->wreg_chn);
 #endif
@@ -1294,7 +1289,7 @@
 
 	ans = mcdx_xfer(stuffp, p, sector, nr_sectors);
 	return ans;
-#if FALLBACK
+#ifdef FALLBACK
 	if (-1 == ans)
 		stuffp->readerrs++;
 	else

