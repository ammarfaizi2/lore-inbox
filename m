Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWCaKGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWCaKGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCaKFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:05:23 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:12845 "EHLO
	linux") by vger.kernel.org with ESMTP id S932085AbWCaKEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:04:49 -0500
Message-Id: <20060331100424.680737000@towertech.it>
References: <20060331100423.175139000@towertech.it>
User-Agent: quilt/0.43-1
Date: Fri, 31 Mar 2006 12:04:31 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@osdl.org, Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH 08/10] RTC subsystem, SA1100 cleanup
Content-Disposition: inline; filename=rtc-subsys-sa1100-tidy.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - converted printks to dev_xxx
 - removed messages in excess

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Cc: Richard Purdie <rpurdie@rpsys.net>
---
 drivers/rtc/rtc-sa1100.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- linux-rtc.orig/drivers/rtc/rtc-sa1100.c	2006-03-29 03:15:58.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-sa1100.c	2006-03-29 03:15:58.000000000 +0200
@@ -160,19 +160,19 @@ static int sa1100_rtc_open(struct device
 	ret = request_irq(IRQ_RTC1Hz, sa1100_rtc_interrupt, SA_INTERRUPT,
 				"rtc 1Hz", dev);
 	if (ret) {
-		printk(KERN_ERR "rtc: IRQ%d already in use.\n", IRQ_RTC1Hz);
+		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTC1Hz);
 		goto fail_ui;
 	}
 	ret = request_irq(IRQ_RTCAlrm, sa1100_rtc_interrupt, SA_INTERRUPT,
 				"rtc Alrm", dev);
 	if (ret) {
-		printk(KERN_ERR "rtc: IRQ%d already in use.\n", IRQ_RTCAlrm);
+		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTCAlrm);
 		goto fail_ai;
 	}
 	ret = request_irq(IRQ_OST1, timer1_interrupt, SA_INTERRUPT,
 				"rtc timer", dev);
 	if (ret) {
-		printk(KERN_ERR "rtc: IRQ%d already in use.\n", IRQ_OST1);
+		dev_err(dev, "IRQ %d already in use.\n", IRQ_OST1);
 		goto fail_pi;
 	}
 	return 0;
@@ -332,7 +332,7 @@ static int sa1100_rtc_probe(struct platf
 	 */
 	if (RTTR == 0) {
 		RTTR = RTC_DEF_DIVIDER + (RTC_DEF_TRIM << 16);
-		printk(KERN_WARNING "rtc: warning: initializing default clock divider/trim value\n");
+		dev_warn(&pdev->dev, "warning: initializing default clock divider/trim value\n");
 		/* The current RTC value probably doesn't make sense either */
 		RCNR = 0;
 	}
@@ -340,14 +340,11 @@ static int sa1100_rtc_probe(struct platf
 	rtc = rtc_device_register(pdev->name, &pdev->dev, &sa1100_rtc_ops,
 				THIS_MODULE);
 
-	if (IS_ERR(rtc)) {
+	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
-	}
 
 	platform_set_drvdata(pdev, rtc);
 
-	dev_info(&pdev->dev, "SA11xx/PXA2xx RTC Registered\n");
-
 	return 0;
 }
 

--
