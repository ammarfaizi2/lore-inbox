Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbTK0HgS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 02:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTK0HgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 02:36:18 -0500
Received: from rth.ninka.net ([216.101.162.244]:31876 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264443AbTK0HgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 02:36:15 -0500
Date: Wed, 26 Nov 2003 23:36:07 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andreas Beckmann <sparclinux@abeckmann.de>
Cc: linux-kernel@vger.kernel.org, sparclinux@abeckmann.de
Subject: Re: 2.4.23-rc4 sparc64 compile problem: drivers/char/drm/ffb_drv.c
Message-Id: <20031126233607.7d781cc9.davem@redhat.com>
In-Reply-To: <3FC37A9E.6030002@abeckmann.de>
References: <3FC37A9E.6030002@abeckmann.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003 16:51:58 +0100
Andreas Beckmann <sparclinux@abeckmann.de> wrote:

> Compiling ffb_drv.c into the kernel (CONFIG_DRM_FFB=y) fails with
> ffb_drv.c:386: error: redefinition of `ffb_options'
> drm_drv.h:138: error: `ffb_options' previously defined here
> 
> Compiling it as a module (CONFIG_DRM_FFB=m) works fine.

Not hard to fix, I'll toss this to Marcelo when he starts
up 2.4.24-pre1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1195  -> 1.1196 
#	drivers/char/drm/ffb_drv.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/26	davem@nuts.ninka.net	1.1196
# [SPARC64]: Fix non-modular build of FFB drm driver.
# --------------------------------------------
#
diff -Nru a/drivers/char/drm/ffb_drv.c b/drivers/char/drm/ffb_drv.c
--- a/drivers/char/drm/ffb_drv.c	Wed Nov 26 23:32:08 2003
+++ b/drivers/char/drm/ffb_drv.c	Wed Nov 26 23:32:08 2003
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
-	DRM(parse_options)(str);
-	return 1;
-}
-
-__setup(DRIVER_NAME "=", ffb_options);
-#endif
-
 #include "drm_fops.h"
 #include "drm_init.h"
 #include "drm_ioctl.h"
