Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264334AbUDUCKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbUDUCKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 22:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbUDUCKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 22:10:09 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56551
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264334AbUDUCKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 22:10:03 -0400
Date: Wed, 21 Apr 2004 04:10:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: updated-fbmem-patch.patch
Message-ID: <20040421021008.GM29954@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm4/broken-out/updated-fbmem-patch.patch

this uses get_user for the set_cmap operation too.

--- 2.6.5-aa3/drivers/video/fbmem.c.~1~	2004-04-04 08:09:23.000000000 +0200
+++ 2.6.5-aa3/drivers/video/fbmem.c	2004-04-21 03:11:05.878951424 +0200
@@ -1034,11 +1034,11 @@ fb_ioctl(struct inode *inode, struct fil
 	case FBIOPUTCMAP:
 		if (copy_from_user(&cmap, (void *) arg, sizeof(cmap)))
 			return -EFAULT;
-		return (fb_set_cmap(&cmap, 0, info));
+		return (fb_set_cmap(&cmap, 1, info));
 	case FBIOGETCMAP:
 		if (copy_from_user(&cmap, (void *) arg, sizeof(cmap)))
 			return -EFAULT;
-		return (fb_copy_cmap(&info->cmap, &cmap, 0));
+		return (fb_copy_cmap(&info->cmap, &cmap, 2));
 	case FBIOPAN_DISPLAY:
 		if (copy_from_user(&var, (void *) arg, sizeof(var)))
 			return -EFAULT;

this is the port to 2.4:

--- 2.4.23aa2/drivers/video/fbmem.c.~1~	2003-08-26 00:13:02.000000000 +0200
+++ 2.4.23aa2/drivers/video/fbmem.c	2004-04-21 03:13:34.545350696 +0200
@@ -511,11 +511,11 @@ fb_ioctl(struct inode *inode, struct fil
 	case FBIOPUTCMAP:
 		if (copy_from_user(&cmap, (void *) arg, sizeof(cmap)))
 			return -EFAULT;
-		return (fb->fb_set_cmap(&cmap, 0, PROC_CONSOLE(info), info));
+		return (fb->fb_set_cmap(&cmap, 1, PROC_CONSOLE(info), info));
 	case FBIOGETCMAP:
 		if (copy_from_user(&cmap, (void *) arg, sizeof(cmap)))
 			return -EFAULT;
-		return (fb->fb_get_cmap(&cmap, 0, PROC_CONSOLE(info), info));
+		return (fb->fb_get_cmap(&cmap, 1, PROC_CONSOLE(info), info));
 	case FBIOPAN_DISPLAY:
 		if (copy_from_user(&var, (void *) arg, sizeof(var)))
 			return -EFAULT;


(1 not a typo)

Let me know if you see something wrong, it's untested.
