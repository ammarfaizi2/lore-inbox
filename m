Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVD1K5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVD1K5j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 06:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVD1K5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 06:57:39 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:1503 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262010AbVD1K5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 06:57:37 -0400
Date: Thu, 28 Apr 2005 11:57:39 +0100 (IST)
From: Dave Airlie <airlied@skynet.ie>
X-X-Sender: airlied@skynet
To: stable@linux.com
Cc: linux-kernel@vger.kernel.org
Subject: patch: fix DRM on XFree86 4.3/Debian
Message-ID: <Pine.LNX.4.58.0504281153380.18588@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	This patch fixes an issue with XFree86 4.3 not starting properly
on Debian sarge with a 2.6.11 kernel and I think it should be in stable,
it has been in DRM CVS and in 2.6.12-rc2 for a while now...

Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Naru a/drivers/char/drm/drm_drv.c b/drivers/char/drm/drm_drv.c
--- a/drivers/char/drm/drm_drv.c	2005-04-28 03:56:32 -07:00
+++ b/drivers/char/drm/drm_drv.c	2005-04-28 03:56:32 -07:00
@@ -144,6 +144,12 @@
 	if (dev->driver->pretakedown)
 	  dev->driver->pretakedown(dev);

+	if (dev->unique) {
+		drm_free(dev->unique, strlen(dev->unique) + 1, DRM_MEM_DRIVER);
+		dev->unique = NULL;
+		dev->unique_len = 0;
+	}
+
 	if ( dev->irq_enabled ) drm_irq_uninstall( dev );

 	down( &dev->struct_sem );
