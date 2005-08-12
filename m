Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVHLPHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVHLPHv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 11:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVHLPHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 11:07:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:23249 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750731AbVHLPHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 11:07:50 -0400
Date: Fri, 12 Aug 2005 17:07:48 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       johnpol@2ka.mipt.ru
Subject: [PATCH] kernel spams syslog every 10 sec with w1 debug
Message-ID: <20050812150748.GA6774@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bug 104020 - kernel spams syslog every 10 sec with: w1_driver w1_bus_master1: No devices present on the wire.

After installing 10.0 B1, I found this in my syslog: 
Aug 10 23:40:06 linux kernel: w1_driver w1_bus_master1: No devices present on the wire. 
Aug 10 23:40:16 linux kernel: w1_driver w1_bus_master1: No devices present on the wire. 

Signed-off-by: Olaf Hering <olh@suse.de>

 drivers/w1/w1.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc6-aes/drivers/w1/w1.c
===================================================================
--- linux-2.6.13-rc6-aes.orig/drivers/w1/w1.c
+++ linux-2.6.13-rc6-aes/drivers/w1/w1.c
@@ -593,7 +593,8 @@ void w1_search(struct w1_master *dev, w1
 		 * Return 0 - device(s) present, 1 - no devices present.
 		 */
 		if (w1_reset_bus(dev)) {
-			dev_info(&dev->dev, "No devices present on the wire.\n");
+			if (printk_ratelimit())
+				dev_debug(&dev->dev, "No devices present on the wire.\n");
 			break;
 		}
 
