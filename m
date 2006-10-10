Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWJJXSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWJJXSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWJJXSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:18:43 -0400
Received: from havoc.gtf.org ([69.61.125.42]:32683 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030330AbWJJXSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:18:42 -0400
Date: Tue, 10 Oct 2006 19:18:41 -0400
From: Jeff Garzik <jeff@garzik.org>
To: a.zummo@towertech.it, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtc: fix printk of 64-bit res on 32-bit platform
Message-ID: <20061010231841.GA18801@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With 64-bit resources on 32-bit platforms, the resource address might be
larger than a void*.  Fix printk to work regardless of resource size.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/rtc/rtc-v3020.c       |    4 ++--

diff --git a/drivers/rtc/rtc-v3020.c b/drivers/rtc/rtc-v3020.c
index 09b714f..6c6d13d 100644
--- a/drivers/rtc/rtc-v3020.c
+++ b/drivers/rtc/rtc-v3020.c
@@ -195,9 +195,9 @@ static int rtc_probe(struct platform_dev
 	 * are all disabled */
 	v3020_set_reg(chip, V3020_STATUS_0, 0x0);
 
-	dev_info(&pdev->dev, "Chip available at physical address 0x%p,"
+	dev_info(&pdev->dev, "Chip available at physical address 0x%llx,"
 		"data connected to D%d\n",
-		(void*)pdev->resource[0].start,
+		(unsigned long long) pdev->resource[0].start,
 		chip->leftshift);
 
 	platform_set_drvdata(pdev, chip);
