Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269245AbUI3Mfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269245AbUI3Mfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 08:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269246AbUI3Mfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 08:35:32 -0400
Received: from p5089DE7B.dip.t-dialin.net ([80.137.222.123]:516 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S269245AbUI3MfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 08:35:25 -0400
Date: Thu, 30 Sep 2004 14:28:53 +0200
To: linux-kernel@vger.kernel.org
Cc: bbpetkov@yahoo.de
Subject: [PATCH] 2.6.9-rc3 fix warnings in sound/drivers/opl3/opl3_lib.c
Message-ID: <20040930122853.GA28332@none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Borislav Petkov <petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
   I get these warnings while compiling 2.6.9-rc3:
   sound/drivers/opl3/opl3_lib.c: In function `snd_opl3_cs4281_command':   
   sound/drivers/opl3/opl3_lib.c:101: warning: passing arg 2 of `writel'  makes pointer from integer without a cast   
   sound/drivers/opl3/opl3_lib.c:104: warning: passing arg 2 of `writel'  makes pointer from integer without a cast
   
   Hope this fix is correct.

   Regards,
   Boris.


--- sound/drivers/opl3/opl3_lib.c.orig	2004-09-30 14:22:08.000000000 +0200
+++ sound/drivers/opl3/opl3_lib.c	2004-09-30 14:23:50.000000000 +0200
@@ -98,10 +98,10 @@ void snd_opl3_cs4281_command(opl3_t * op
 
 	spin_lock_irqsave(&opl3->reg_lock, flags);
 
-	writel((unsigned int)cmd, port << 2);
+	writel((unsigned int)cmd, (void __iomem *)(port << 2));
 	udelay(10);
 
-	writel((unsigned int)val, (port + 1) << 2);
+	writel((unsigned int)val, (void __iomem *)((port + 1) << 2));
 	udelay(30);
 
 	spin_unlock_irqrestore(&opl3->reg_lock, flags);
