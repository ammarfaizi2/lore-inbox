Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267796AbUH2Mpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267796AbUH2Mpa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 08:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267795AbUH2Mpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 08:45:30 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:17030 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267796AbUH2MpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 08:45:15 -0400
Date: Sun, 29 Aug 2004 13:45:14 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: ffb drm dead code removal..
Message-ID: <Pine.LNX.4.58.0408291342170.3682@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave,
	I want to apply the following to the ffb DRM it is dead code as
the DRM doesn't use the macro anymore... if you have no issues I'll send
it on to Linus..

I've no way to build the ffb driver at all at the moment, if anyone builds
sparc kernels with ffb regularly I don't suppose you could checkout DRM
cvs and build it against the kernel to see if it still builds...

Dave.

diff -Nru a/drivers/char/drm/ffb_drv.c b/drivers/char/drm/ffb_drv.c
--- a/drivers/char/drm/ffb_drv.c	Sun Aug 29 22:39:49 2004
+++ b/drivers/char/drm/ffb_drv.c	Sun Aug 29 22:39:49 2004
@@ -40,7 +40,6 @@
 	.get_unmapped_area	= ffb_get_unmapped_area,		\
 }

-#define DRIVER_COUNT_CARDS()	ffb_count_card_instances()
 /* Allocate private structure and fill it */
 #define DRIVER_PRESETUP()	do {		\
 	int _ret;				\
@@ -220,34 +219,6 @@
 }

 static int ffb_presetup(drm_device_t *);
-
-static int __init ffb_count_card_instances(void)
-{
-	int root, total, instance;
-
-	total = ffb_count_siblings(prom_root_node);
-	root = prom_getchild(prom_root_node);
-	for (root = prom_searchsiblings(root, "upa"); root;
-	     root = prom_searchsiblings(prom_getsibling(root), "upa"))
-		total += ffb_count_siblings(root);
-
-	ffb_position = kmalloc(sizeof(ffb_position_t) * total, GFP_KERNEL);
-
-	/* Actual failure will be caught during ffb_presetup b/c we can't catch
-	 * it easily here.
-	 */
-	if (!ffb_position)
-		return -ENOMEM;
-
-	instance = ffb_scan_siblings(prom_root_node, 0);
-
-	root = prom_getchild(prom_root_node);
-	for (root = prom_searchsiblings(root, "upa"); root;
-	     root = prom_searchsiblings(prom_getsibling(root), "upa"))
-		instance = ffb_scan_siblings(root, instance);
-
-	return total;
-}

 static drm_map_t *ffb_find_map(struct file *filp, unsigned long off)
 {
