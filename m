Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUBNBD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 20:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUBNBD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 20:03:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:45978 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267237AbUBNBDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 20:03:34 -0500
Subject: [PATCH] Fix incorrect kfree in radeonfb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Message-Id: <1076720526.900.146.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 14 Feb 2004 12:02:06 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I missed a kfree -> framebuffer_release() in the new radeonfb, here's
the patch, please apply (and thanks to Luca for noticing it).

Ben.

===== drivers/video/aty/radeon_base.c 1.2 vs edited =====
--- 1.2/drivers/video/aty/radeon_base.c	Fri Feb 13 03:10:47 2004
+++ edited/drivers/video/aty/radeon_base.c	Sat Feb 14 12:00:22 2004
@@ -2291,7 +2291,7 @@
 #ifdef CONFIG_FB_RADEON_I2C
 	radeon_delete_i2c_busses(rinfo);
 #endif        
-        kfree (rinfo);
+        framebuffer_release(info);
 }
 
 


