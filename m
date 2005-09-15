Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030495AbVIOPTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbVIOPTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbVIOPTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:19:54 -0400
Received: from tim.rpsys.net ([194.106.48.114]:35235 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1030493AbVIOPTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:19:53 -0400
Subject: [patch] Fix up some pm_message_t types
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 16:19:43 +0100
Message-Id: <1126797583.11244.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up some pm_message_t types

Signed-Off-By: Richard Purdie <rpurdie@rpsys.net>

Index: git/drivers/video/imxfb.c
===================================================================
--- git.orig/drivers/video/imxfb.c	2005-09-14 10:08:28.000000000 +0100
+++ git/drivers/video/imxfb.c	2005-09-15 16:07:14.000000000 +0100
@@ -425,7 +425,7 @@
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int imxfb_suspend(struct device *dev, u32 state, u32 level)
+static int imxfb_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct imxfb_info *fbi = dev_get_drvdata(dev);
 	pr_debug("%s\n",__FUNCTION__);
Index: git/arch/ppc/syslib/open_pic2.c
===================================================================
--- git.orig/arch/ppc/syslib/open_pic2.c	2005-09-14 10:08:21.000000000 +0100
+++ git/arch/ppc/syslib/open_pic2.c	2005-09-15 16:03:23.000000000 +0100
@@ -575,7 +575,7 @@
  * we need something better to deal with that... Maybe switch to S1 for
  * cpufreq changes
  */
-int openpic2_suspend(struct sys_device *sysdev, u32 state)
+int openpic2_suspend(struct sys_device *sysdev, pm_message_t state)
 {
 	int	i;
 	unsigned long flags;
Index: git/sound/arm/aaci.c
===================================================================
--- git.orig/sound/arm/aaci.c	2005-09-14 10:08:32.000000000 +0100
+++ git/sound/arm/aaci.c	2005-09-15 16:08:24.000000000 +0100
@@ -650,7 +650,7 @@
 	return 0;
 }
 
-static int aaci_suspend(struct amba_device *dev, u32 state)
+static int aaci_suspend(struct amba_device *dev, pm_message_t state)
 {
 	snd_card_t *card = amba_get_drvdata(dev);
 	return card ? aaci_do_suspend(card) : 0;
Index: git/arch/arm/common/locomo.c
===================================================================
--- git.orig/arch/arm/common/locomo.c	2005-09-14 10:08:18.000000000 +0100
+++ git/arch/arm/common/locomo.c	2005-09-15 16:02:38.000000000 +0100
@@ -551,7 +551,7 @@
 	u16	LCM_SPIMD;
 };
 
-static int locomo_suspend(struct device *dev, u32 pm_message_t, u32 level)
+static int locomo_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct locomo *lchip = dev_get_drvdata(dev);
 	struct locomo_save_data *save;
Index: git/drivers/serial/mpc52xx_uart.c
===================================================================
--- git.orig/drivers/serial/mpc52xx_uart.c	2005-09-14 10:08:27.000000000 +0100
+++ git/drivers/serial/mpc52xx_uart.c	2005-09-15 16:06:19.000000000 +0100
@@ -781,7 +781,7 @@
 
 #ifdef CONFIG_PM
 static int
-mpc52xx_uart_suspend(struct device *dev, u32 state, u32 level)
+mpc52xx_uart_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct uart_port *port = (struct uart_port *) dev_get_drvdata(dev);

