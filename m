Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbTECOOO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 10:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTECOOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 10:14:14 -0400
Received: from [203.145.184.221] ([203.145.184.221]:4626 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263317AbTECOON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 10:14:13 -0400
Subject: [PATCH 2.{4,5}.x] trivial mod_timer fixes for sdla_chdlc.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: dm@sangoma.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 20:01:06 +0530
Message-Id: <1051972267.2018.144.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sdla_chdlc.c: trivial {del,add}_timer to mod_timer conversion.

--- linux-2.5.68/drivers/net/wan/sdla_chdlc.c	2003-04-21 10:14:28.000000000 +0530
+++ linux-2.5.68-nvk/drivers/net/wan/sdla_chdlc.c	2003-05-03 15:59:23.000000000 +0530
@@ -998,13 +998,11 @@
 	
 	set_bit(0,&chdlc_priv_area->config_chdlc);
 	chdlc_priv_area->config_chdlc_timeout=jiffies;
-	del_timer(&chdlc_priv_area->poll_delay_timer);
 
 	/* Start the CHDLC configuration after 1sec delay.
 	 * This will give the interface initilization time
 	 * to finish its configuration */
-	chdlc_priv_area->poll_delay_timer.expires=jiffies+HZ;
-	add_timer(&chdlc_priv_area->poll_delay_timer);
+	mod_timer(&chdlc_priv_area->poll_delay_timer, jiffies + HZ);
 	return err;
 }
 



