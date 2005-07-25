Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVGYJgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVGYJgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 05:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVGYJgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 05:36:15 -0400
Received: from tim.rpsys.net ([194.106.48.114]:8336 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261163AbVGYJgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 05:36:14 -0400
Subject: [patch] Stop the nand functions triggering false softlockup reports
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: dirk@opfer-online.de, linux-kernel@vger.kernel.org
In-Reply-To: <20050724234238.2141e828.akpm@osdl.org>
References: <20050715013653.36006990.akpm@osdl.org>
	 <1122222021.7585.64.camel@localhost.localdomain>
	 <20050724234238.2141e828.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 10:35:43 +0100
Message-Id: <1122284143.7942.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stop the nand functions triggering false softlockup reports.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/drivers/mtd/nand/nand_base.c
===================================================================
--- linux-2.6.12.orig/drivers/mtd/nand/nand_base.c	2005-07-24 18:49:35.000000000 +0100
+++ linux-2.6.12/drivers/mtd/nand/nand_base.c	2005-07-25 09:31:51.000000000 +0100
@@ -526,6 +526,7 @@
 	do {
 		if (this->dev_ready(mtd))
 			return;
+		touch_softlockup_watchdog();
 	} while (time_before(jiffies, timeo));	
 }
 


