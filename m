Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbULGPAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbULGPAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbULGPAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:00:15 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:40429 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261821AbULGPAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:00:10 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 7 Dec 2004 15:36:06 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] fbdev: sysfs fix
Message-ID: <20041207143606.GA23570@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the fbdev sysfs class is registered before all drivers,
otherwise some symlinks are missing.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/video/fbmem.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2004-11-23/drivers/video/fbmem.c
===================================================================
--- linux-2004-11-23.orig/drivers/video/fbmem.c	2004-11-26 16:31:37.110665860 +0100
+++ linux-2004-11-23/drivers/video/fbmem.c	2004-11-26 17:41:14.112220692 +0100
@@ -1165,7 +1165,7 @@ fbmem_init(void)
 	}
 	return 0;
 }
-module_init(fbmem_init);
+subsys_initcall(fbmem_init);
 
 static char *video_options[FB_MAX];
 static int ofonly;

-- 
#define printk(args...) fprintf(stderr, ## args)
