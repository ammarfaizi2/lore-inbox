Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263968AbSKRTX4>; Mon, 18 Nov 2002 14:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSKRTX4>; Mon, 18 Nov 2002 14:23:56 -0500
Received: from 86.195.27.24.cfl.rr.com ([24.27.195.86]:8845 "EHLO
	www.compucrew.com") by vger.kernel.org with ESMTP
	id <S263968AbSKRTX4>; Mon, 18 Nov 2002 14:23:56 -0500
Message-ID: <1037649307.3dd9459b8997b@www2.compucrew.com>
Date: Mon, 18 Nov 2002 14:55:07 -0500
From: Lee Nash <lee@compucrew.com>
To: linux-kernel@vger.kernel.org
Subject: mk712 driver patch
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
  I think this is a typo in the mk712 device driver.  It would always
fail even though the region appears in /proc/ioports.  

After this patch, the device works correctly.

Thanks,
-lee

diff -ur linux-2.4.19.orig/drivers/char/mk712.c linux-
2.4.19/drivers/char/mk712.c
--- linux-2.4.19.orig/drivers/char/mk712.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.19/drivers/char/mk712.c	Mon Nov 18 13:09:59 2002
@@ -439,7 +439,7 @@
                 mk712_irq = irq;
 #endif
 
-	if(request_region(mk712_io, 8, "mk712_touchscreen"))
+	if(!request_region(mk712_io, 8, "mk712_touchscreen"))
 	{
 		printk("mk712: unable to get IO region\n");
 		return -ENODEV;
