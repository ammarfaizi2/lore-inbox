Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbTDHAKJ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbTDGXYW (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:24:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63360
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263831AbTDGXIG (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:08:06 -0400
Date: Tue, 8 Apr 2003 01:26:58 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080026.h380QwGL009138@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix cosa verify_area
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/net/wan/cosa.c linux-2.5.67-ac1/drivers/net/wan/cosa.c
--- linux-2.5.67/drivers/net/wan/cosa.c	2003-03-26 19:59:52.000000000 +0000
+++ linux-2.5.67-ac1/drivers/net/wan/cosa.c	2003-03-26 20:06:13.000000000 +0000
@@ -1057,7 +1057,8 @@
 		return -EPERM;
 	}
 
-	if (get_user(addr, &(d->addr)) ||
+	if (verify_area(VERIFY_READ, d, sizeof(*d)) ||
+	    __get_user(addr, &(d->addr)) ||
 	    __get_user(len, &(d->len)) ||
 	    __get_user(code, &(d->code)))
 		return -EFAULT;
@@ -1098,7 +1099,8 @@
 		return -EPERM;
 	}
 
-	if (get_user(addr, &(d->addr)) ||
+	if (verify_area(VERIFY_READ, d, sizeof(*d)) ||
+	    __get_user(addr, &(d->addr)) ||
 	    __get_user(len, &(d->len)) ||
 	    __get_user(code, &(d->code)))
 		return -EFAULT;
@@ -1106,7 +1108,7 @@
 	/* If something fails, force the user to reset the card */
 	cosa->firmware_status &= ~COSA_FW_RESET;
 
-	if ((i=readmem(cosa, d->code, len, addr)) < 0) {
+	if ((i=readmem(cosa, code, len, addr)) < 0) {
 		printk(KERN_NOTICE "cosa%d: reading memory failed: %d\n",
 			cosa->num, i);
 		return -EIO;
