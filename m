Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264160AbTCXLop>; Mon, 24 Mar 2003 06:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264162AbTCXLop>; Mon, 24 Mar 2003 06:44:45 -0500
Received: from dp.samba.org ([66.70.73.150]:41636 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264160AbTCXLon>;
	Mon, 24 Mar 2003 06:44:43 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15998.61568.388276.241106@nanango.paulus.ozlabs.org>
Date: Mon, 24 Mar 2003 22:48:16 +1100 (EST)
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fixes for aty128fb
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a couple of problems in the aty128fb driver: an
include wasn't finding its file, and it needs to access the
pseudo_palette as 32-bit quantities.

Paul.

diff -urN linux-2.5/drivers/video/aty/aty128fb.c linuxppc-2.5/drivers/video/aty/aty128fb.c
--- linux-2.5/drivers/video/aty/aty128fb.c	2003-03-23 16:29:31.000000000 +1100
+++ linuxppc-2.5/drivers/video/aty/aty128fb.c	2003-03-23 21:42:33.000000000 +1100
@@ -62,7 +62,7 @@
 #ifdef CONFIG_ALL_PPC
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
-#include "macmodes.h"
+#include "../macmodes.h"
 #endif
 
 #ifdef CONFIG_ADB_PMU
@@ -1994,23 +1994,21 @@
 
 	if (regno < 16) {
 		int i;
+		u32 *pal = info->pseudo_palette;
+
 		switch (par->crtc.depth) {
 		case 15:
-			((u16 *) (info->pseudo_palette))[regno] =
-			    (regno << 10) | (regno << 5) | regno;
+			pal[regno] = (regno << 10) | (regno << 5) | regno;
 			break;
 		case 16:
-			((u16 *) (info->pseudo_palette))[regno] =
-			    (regno << 11) | (regno << 6) | regno;
+			pal[regno] = (regno << 11) | (regno << 6) | regno;
 			break;
 		case 24:
-			((u32 *) (info->pseudo_palette))[regno] =
-			    (regno << 16) | (regno << 8) | regno;
+			pal[regno] = (regno << 16) | (regno << 8) | regno;
 			break;
 		case 32:
 			i = (regno << 8) | regno;
-			((u32 *) (info->pseudo_palette))[regno] =
-			    (i << 16) | i;
+			pal[regno] = (i << 16) | i;
 			break;
 		}
 	}
