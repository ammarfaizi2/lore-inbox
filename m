Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVAZAUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVAZAUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVAZATq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:19:46 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:37110 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262262AbVAZASF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:18:05 -0500
Date: Tue, 25 Jan 2005 18:17:48 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org,
       afleming@freescale.com
Subject: [PATCH] netdrv gianfar: Fix usage of gfar_read in debug code   
Message-ID: <Pine.LNX.4.61.0501251814480.26772@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes instances where gfar_read() was invoked in debug codewith a value, 
rather than a pointer.

Signed-of-by: Andy Fleming <afleming@freescale.com>
Signed-of-by: Kumar Gala <afleming@freescale.com>

---

diff -Nru a/drivers/net/gianfar.c b/drivers/net/gianfar.c
--- a/drivers/net/gianfar.c	2005-01-25 18:14:13 -06:00
+++ b/drivers/net/gianfar.c	2005-01-25 18:14:13 -06:00
@@ -1190,8 +1190,8 @@
 	} else {
 #ifdef VERBOSE_GFAR_ERRORS
 		printk(KERN_DEBUG "%s: receive called twice (%x)[%x]\n",
-		       dev->name, gfar_read(priv->regs->ievent),
-		       gfar_read(priv->regs->imask));
+		       dev->name, gfar_read(&priv->regs->ievent),
+		       gfar_read(&priv->regs->imask));
 #endif
 	}
 #else
@@ -1415,7 +1415,7 @@
 
 #ifdef VERBOSE_GFAR_ERRORS
 		printk(KERN_DEBUG "%s: busy error (rhalt: %x)\n", dev->name,
-		       gfar_read(priv->regs->rstat));
+		       gfar_read(&priv->regs->rstat));
 #endif
 	}
 	if (events & IEVENT_BABR) {
@@ -1793,7 +1793,7 @@
 
 #ifdef VERBOSE_GFAR_ERRORS
 		printk(KERN_DEBUG "%s: busy error (rhalt: %x)\n", dev->name,
-		       gfar_read(priv->regs->rstat));
+		       gfar_read(&priv->regs->rstat));
 #endif
 	}
 	if (events & IEVENT_BABR) {
