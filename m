Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbVHDXxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVHDXxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVHDXw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:52:58 -0400
Received: from tim.rpsys.net ([194.106.48.114]:62085 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262772AbVHDXw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:52:27 -0400
Subject: [patch] Corgi: Add MMC/SD write protection switch handling
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 00:52:11 +0100
Message-Id: <1123199531.8987.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MMC/SD write protection switch handling for the Corgi platform
(extending the MMC/SD patches in -mm).

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/arch/arm/mach-pxa/corgi.c
===================================================================
--- linux-2.6.12.orig/arch/arm/mach-pxa/corgi.c	2005-08-05 00:29:17.000000000 +0100
+++ linux-2.6.12/arch/arm/mach-pxa/corgi.c	2005-08-05 00:29:45.000000000 +0100
@@ -160,6 +160,11 @@
 	}
 }
 
+static int corgi_mci_get_ro(struct device *dev)
+{
+	return GPLR(CORGI_GPIO_nSD_WP) & GPIO_bit(CORGI_GPIO_nSD_WP);
+}
+
 static void corgi_mci_exit(struct device *dev, void *data)
 {
 	free_irq(CORGI_IRQ_GPIO_nSD_DETECT, data);
@@ -169,6 +174,7 @@
 static struct pxamci_platform_data corgi_mci_platform_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.init 		= corgi_mci_init,
+	.get_ro		= corgi_mci_get_ro,
 	.setpower 	= corgi_mci_setpower,
 	.exit		= corgi_mci_exit,
 };

