Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTECOkk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 10:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTECOkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 10:40:40 -0400
Received: from [203.145.184.221] ([203.145.184.221]:15122 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263328AbTECOkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 10:40:40 -0400
Subject: [PATCH 2.{4,5}.x] mod_timer fix for synclink.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: davej@codemonkey.org.uk
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 20:27:51 +0530
Message-Id: <1051973871.2018.174.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

synclink.c: trivial {del,add}_timer to mod_timer conversion.

--- linux-2.5.68/drivers/char/synclink.c	2003-03-25 10:07:40.000000000 +0530
+++ linux-2.5.68-nvk/drivers/char/synclink.c	2003-05-03 15:43:24.000000000 +0530
@@ -4278,9 +4278,7 @@
 				info->get_tx_holding_index=0;
 
 			/* restart transmit timer */
-			del_timer(&info->tx_timer);
-			info->tx_timer.expires = jiffies + jiffies_from_ms(5000);
-			add_timer(&info->tx_timer);
+			mod_timer(&info->tx_timer, jiffies + jiffies_from_ms(5000));
 
 			ret = 1;
 		}



