Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263016AbVCXDe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbVCXDe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbVCXDdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:33:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53265 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263005AbVCXDK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:10:26 -0500
Date: Thu, 24 Mar 2005 04:10:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] edid.h cleanups
Message-ID: <20050324031019.GU1948@stusta.de>
References: <20050320192915.GR4449@stusta.de> <200503210453.43894.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503210453.43894.adaplas@hotpop.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 04:53:43AM +0800, Antonino A. Daplas wrote:

> Not this one.  Code that grabs the EDID block using the video BIOS is in video.S.
> Currently, there's no driver that uses this but it's an acceptable backup for drivers
> that want the EDID block but has no i2c, or i2c probing fails.

OK, below are only the other parts of my patch.

> Tony

cu
Adrian



<--  snip  -->


This patch contains the following cleanups:
- remove unneeded #include <video/edid.h>'s
- include/video/edid.h: kill two stale function prototypes

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/boot/compressed/misc.c |    1 -
 drivers/video/fbmon.c            |    1 -
 drivers/video/vesafb.c           |    3 ---
 include/video/edid.h             |    9 ---------
 4 files changed, 14 deletions(-)

--- linux-2.6.11-mm4-full/drivers/video/fbmon.c.old	2005-03-20 20:03:56.000000000 +0100
+++ linux-2.6.11-mm4-full/drivers/video/fbmon.c	2005-03-20 20:04:27.000000000 +0100
@@ -34,7 +34,6 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #endif
-#include <video/edid.h>
 #include "edid.h"
 
 /* 
--- linux-2.6.11-mm4-full/drivers/video/vesafb.c.old	2005-03-20 20:04:12.000000000 +0100
+++ linux-2.6.11-mm4-full/drivers/video/vesafb.c	2005-03-20 20:04:18.000000000 +0100
@@ -19,9 +19,6 @@
 #include <linux/fb.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
-#ifdef __i386__
-#include <video/edid.h>
-#endif
 #include <asm/io.h>
 #include <asm/mtrr.h>
 
--- linux-2.6.11-mm4-full/arch/i386/boot/compressed/misc.c.old	2005-03-20 20:05:55.000000000 +0100
+++ linux-2.6.11-mm4-full/arch/i386/boot/compressed/misc.c	2005-03-20 20:05:58.000000000 +0100
@@ -12,7 +12,6 @@
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
-#include <video/edid.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
--- linux-2.6.12-rc1-mm1-full/include/video/edid.h.old	2005-03-24 01:37:07.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/include/video/edid.h	2005-03-24 01:37:27.000000000 +0100
@@ -4,9 +4,6 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
-#ifdef CONFIG_PPC_OF
-#include <linux/pci.h>
-#endif
 
 #ifdef CONFIG_X86
 struct edid_info {
@@ -14,14 +11,8 @@
 };
 
 extern struct edid_info edid_info;
-extern char *get_EDID_from_BIOS(void *);
-
 #endif /* CONFIG_X86 */
 
-#ifdef CONFIG_PPC_OF
-extern char *get_EDID_from_OF(struct pci_dev *pdev);
-#endif
-
 #endif /* __KERNEL__ */
 
 #endif /* __linux_video_edid_h__ */

