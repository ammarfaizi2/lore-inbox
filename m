Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTJGSJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbTJGSJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:09:18 -0400
Received: from zero.aec.at ([193.170.194.10]:48388 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262649AbTJGSJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:09:08 -0400
Date: Tue, 7 Oct 2003 20:09:05 +0200
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] Fix warning in sis frame buffer driver
Message-ID: <20031007180905.GA2318@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just fix a warning in the sis framebuffer driver and eliminate some
dead code. Trival.

diff -u linux-2.5-cleanup/drivers/video/sis/sis_main.c-o linux-2.5-cleanup/drivers/video/sis/sis_main.c
--- linux-2.5-cleanup/drivers/video/sis/sis_main.c-o	2003-06-05 02:29:10.000000000 +0200
+++ linux-2.5-cleanup/drivers/video/sis/sis_main.c	2003-12-02 17:19:05.151986072 +0100
@@ -619,18 +619,9 @@
 	double drate = 0, hrate = 0;
 	int found_mode = 0;
 	int old_mode;
-	unsigned char reg;
 
 	TWDEBUG("Inside do_set_var");
 	
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)	
-	inSISIDXREG(SISCR,0x34,reg);
-	if(reg & 0x80) {
-	   printk(KERN_INFO "sisfb: Cannot change display mode, X server is active\n");
-	   return -EBUSY;
-	}
-#endif	
-
 	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED) {
 		vtotal = var->upper_margin + var->yres + var->lower_margin +
 		         var->vsync_len;
