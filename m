Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbUKUXgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbUKUXgx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUKUXgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:36:52 -0500
Received: from mail.dif.dk ([193.138.115.101]:33752 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261848AbUKUXgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:36:21 -0500
Date: Mon, 22 Nov 2004 00:45:50 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Antonino Daplas <adaplas@pol.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove pointless <0 comparisons in drivers/video/fbmem.c
Message-ID: <Pine.LNX.4.61.0411220034040.3423@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The "console" and "framebuffer" members of struct fb_con2fbmap are both 
unsigned, so it makes no sense to compare them for being <0. Patch to 
remove the pointless comparisons below.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk6-orig/drivers/video/fbmem.c linux-2.6.10-rc2-bk6/drivers/video/fbmem.c
--- linux-2.6.10-rc2-bk6-orig/drivers/video/fbmem.c	2004-11-21 21:49:10.000000000 +0100
+++ linux-2.6.10-rc2-bk6/drivers/video/fbmem.c	2004-11-22 00:32:49.000000000 +0100
@@ -826,9 +826,9 @@ fb_ioctl(struct inode *inode, struct fil
 	case FBIOPUT_CON2FBMAP:
 		if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
 			return - EFAULT;
-		if (con2fb.console < 0 || con2fb.console > MAX_NR_CONSOLES)
+		if (con2fb.console > MAX_NR_CONSOLES)
 		    return -EINVAL;
-		if (con2fb.framebuffer < 0 || con2fb.framebuffer >= FB_MAX)
+		if (con2fb.framebuffer >= FB_MAX)
 		    return -EINVAL;
 #ifdef CONFIG_KMOD
 		if (!registered_fb[con2fb.framebuffer])



Please CC me on relies from linux-fbdev-devel

