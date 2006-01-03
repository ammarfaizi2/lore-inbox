Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWACUuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWACUuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWACUuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:50:21 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:60885 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750850AbWACUuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:50:20 -0500
Date: Tue, 3 Jan 2006 12:50:30 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix IXP4xx watchdog errata workaround
Message-ID: <20060103205030.GA17709@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IXP4xx driver bails out on all A0 CPUs, but it should only do
so on IXP42x as IXP46x has functioning HW.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

---


Index: linux-2.6-git/drivers/char/watchdog/ixp4xx_wdt.c
===================================================================
--- linux-2.6-git.orig/drivers/char/watchdog/ixp4xx_wdt.c
+++ linux-2.6-git/drivers/char/watchdog/ixp4xx_wdt.c
@@ -186,8 +186,8 @@ static int __init ixp4xx_wdt_init(void)
 	unsigned long processor_id;
 
 	asm("mrc p15, 0, %0, cr0, cr0, 0;" : "=r"(processor_id) :);
-	if (!(processor_id & 0xf)) {
-		printk("IXP4XXX Watchdog: Rev. A0 CPU detected - "
+	if (!(processor_id & 0xf) && !cpu_is_ixp46x()) {
+		printk("IXP4XXX Watchdog: Rev. A0 IXP42x CPU detected - "
 			"watchdog disabled\n");
 
 		return -ENODEV;
