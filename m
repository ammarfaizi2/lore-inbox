Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbTEMWEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbTEMWEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:04:01 -0400
Received: from palrel10.hp.com ([156.153.255.245]:19406 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261339AbTEMWDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:03:54 -0400
Date: Tue, 13 May 2003 15:16:38 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200305132216.h4DMGcGo018057@napali.hpl.hp.com>
To: jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: radeonfb.c fixes
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought we had fixed this already, but now that I tried radeonfb
again, it didn't work (on ia64 linux).  Patch below fixes the problem
(OK, I don't really know if the fbdev output looks correct, as I'm
working remotely today, but at least it gets the machines booting
again and in the past, this was the only problem).

	--david

===== drivers/video/radeonfb.c 1.23 vs edited =====
--- 1.23/drivers/video/radeonfb.c	Sat May 10 02:48:52 2003
+++ edited/drivers/video/radeonfb.c	Tue May 13 14:56:34 2003
@@ -2840,8 +2840,7 @@
 	}
 
 	/* map the regions */
-	rinfo->mmio_base = (u32) ioremap (rinfo->mmio_base_phys,
-				    		    RADEON_REGSIZE);
+	rinfo->mmio_base = (unsigned long) ioremap (rinfo->mmio_base_phys, RADEON_REGSIZE);
 	if (!rinfo->mmio_base) {
 		printk ("radeonfb: cannot map MMIO\n");
 		release_mem_region (rinfo->mmio_base_phys,
@@ -2978,8 +2977,7 @@
 		}
 	}
 
-	rinfo->fb_base = (u32) ioremap (rinfo->fb_base_phys,
-				  		  rinfo->video_ram);
+	rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys, rinfo->video_ram);
 	if (!rinfo->fb_base) {
 		printk ("radeonfb: cannot map FB\n");
 		iounmap ((void*)rinfo->mmio_base);
