Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVBJGvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVBJGvb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 01:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVBJGvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 01:51:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37067 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262029AbVBJGvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 01:51:21 -0500
Date: Thu, 10 Feb 2005 01:51:20 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: fix watchdog link order.
Message-ID: <20050210065120.GA12275@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comment says that softdog has to go last. Make it so.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.10/drivers/char/watchdog/Makefile~	2005-02-10 01:48:32.000000000 -0500
+++ linux-2.6.10/drivers/char/watchdog/Makefile	2005-02-10 01:49:39.000000000 -0500
@@ -2,11 +2,6 @@
 # Makefile for the WatchDog device drivers.
 #
 
-# Only one watchdog can succeed. We probe the hardware watchdog
-# drivers first, then the softdog driver.  This means if your hardware
-# watchdog dies or is 'borrowed' for some reason the software watchdog
-# still gives you some cover.
-
 obj-$(CONFIG_PCWATCHDOG) += pcwd.o
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
 obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
@@ -24,7 +19,6 @@ obj-$(CONFIG_SH_WDT) += shwdt.o
 obj-$(CONFIG_S3C2410_WATCHDOG) += s3c2410_wdt.o
 obj-$(CONFIG_SA1100_WATCHDOG) += sa1100_wdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
-obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
 obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
 obj-$(CONFIG_SC520_WDT) += sc520_wdt.o
@@ -39,3 +33,11 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+
+
+# Only one watchdog can succeed. We probe the hardware watchdog
+# drivers first, then the softdog driver.  This means if your hardware
+# watchdog dies or is 'borrowed' for some reason the software watchdog
+# still gives you some cover.
+obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
+
