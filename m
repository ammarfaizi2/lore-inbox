Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVCHCRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVCHCRY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVCHCQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:16:59 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:60597 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261776AbVCHCOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:14:18 -0500
Date: Tue, 8 Mar 2005 03:14:17 +0100
From: Michal Januszewski <spock@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [announce 5/7] fbsplash - fbdev updates
Message-ID: <20050308021417.GF26249@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fbcmap.c updates.

Signed-off-by: Michael Januszewski <spock@gentoo.org>

---
diff -Nru a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
--- a/drivers/video/fbcmap.c	2005-03-07 16:50:34 +01:00
+++ b/drivers/video/fbcmap.c	2005-03-07 16:50:34 +01:00
@@ -16,6 +16,7 @@
 #include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/slab.h>
+#include "fbsplash.h"
 
 #include <asm/uaccess.h>
 
@@ -235,6 +236,10 @@
 					      info))
 			break;
 	}
+	fb_copy_cmap(cmap, &info->cmap);
+	if (fbsplash_active(info, vc_cons[fg_console].d) &&
+	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) 
+		fbsplash_fix_pseudo_pal(info, vc_cons[fg_console].d);
 	return 0;
 }
 
@@ -265,6 +270,9 @@
 		if (transp)
 			transp++;
 	}
+	if (fbsplash_active(info, vc_cons[fg_console].d) &&
+	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) 
+		fbsplash_fix_pseudo_pal(info, vc_cons[fg_console].d);
 	return 0;
 }




Live long and prosper.
-- 
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl

