Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUB0LzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 06:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUB0LzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 06:55:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:43194 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261726AbUB0LzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 06:55:15 -0500
Subject: [PATCH] radeonfb: small cleanup of common register init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077882383.22397.331.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 22:46:23 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch removes the unused common_regs_m6 and add one more
register to be cleared, according to latest XFree code from ATI.

Ben.


diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	Fri Feb 27 22:45:14 2004
+++ b/drivers/video/aty/radeon_base.c	Fri Feb 27 22:45:14 2004
@@ -222,16 +222,7 @@
 	{ I2C_CNTL_1, 0 },
 	{ GEN_INT_CNTL, 0 },
 	{ CAP0_TRIG_CNTL, 0 },
-};
-
-static reg_val common_regs_m6[] = {
-	{ OVR_CLR,      0 },
-	{ OVR_WID_LEFT_RIGHT,   0 },
-	{ OVR_WID_TOP_BOTTOM,   0 },
-	{ OV0_SCALE_CNTL,   0 },
-	{ SUBPIC_CNTL,      0 },
-	{ GEN_INT_CNTL,     0 },
-	{ CAP0_TRIG_CNTL,   0 } 
+	{ CAP1_TRIG_CNTL, 0 },
 };
 
 /*
@@ -1230,7 +1221,7 @@
 
 	radeon_screen_blank(rinfo, VESA_POWERDOWN);
 
-	for (i=0; i<9; i++)
+	for (i=0; i<10; i++)
 		OUTREG(common_regs[i].reg, common_regs[i].val);
 
 	/* Apply surface registers */
diff -Nru a/include/video/radeon.h b/include/video/radeon.h
--- a/include/video/radeon.h	Fri Feb 27 22:45:14 2004
+++ b/include/video/radeon.h	Fri Feb 27 22:45:14 2004
@@ -24,6 +24,7 @@
 #define AGP_CNTL                               0x0174
 #define BM_STATUS                              0x0160
 #define CAP0_TRIG_CNTL			       0x0950
+#define CAP1_TRIG_CNTL		               0x09c0
 #define VIPH_CONTROL			       0x0C40
 #define VENDOR_ID                              0x0F00  
 #define DEVICE_ID                              0x0F02  


