Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVDMAyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVDMAyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbVDLUPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:15:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:26568 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262107AbVDLKbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:31 -0400
Message-Id: <200504121031.j3CAVMic005300@shell0.pdx.osdl.net>
Subject: [patch 044/198] ppc32: MV643XX ethernet is an option for Pegasos
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benh@kernel.crashing.org,
       fabbione@ubuntu.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch allows Kconfig to build the MV643xx ethernet driver on Pegasos
(CONFIG_PPC_MULTIPLATFORM) and adds what I think is a missing fix from
Dale's batch, that is remove SA_INTERRUPT and add SA_SHIRQ in there as the
interrupt is shared if I understand things correctly.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/net/Kconfig       |    2 +-
 25-akpm/drivers/net/mv643xx_eth.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/net/Kconfig~ppc32-mv643xx-ethernet-is-an-option-for-pegasos drivers/net/Kconfig
--- 25/drivers/net/Kconfig~ppc32-mv643xx-ethernet-is-an-option-for-pegasos	2005-04-12 03:21:13.762044752 -0700
+++ 25-akpm/drivers/net/Kconfig	2005-04-12 03:21:13.769043688 -0700
@@ -2044,7 +2044,7 @@ config GFAR_NAPI
 
 config MV643XX_ETH
 	tristate "MV-643XX Ethernet support"
-	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || MOMENCO_OCELOT_3
+	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || MOMENCO_OCELOT_3 || PPC_MULTIPLATFORM
 	help
 	  This driver supports the gigabit Ethernet on the Marvell MV643XX
 	  chipset which is used in the Momenco Ocelot C and Jaguar ATX and
diff -puN drivers/net/mv643xx_eth.c~ppc32-mv643xx-ethernet-is-an-option-for-pegasos drivers/net/mv643xx_eth.c
--- 25/drivers/net/mv643xx_eth.c~ppc32-mv643xx-ethernet-is-an-option-for-pegasos	2005-04-12 03:21:13.764044448 -0700
+++ 25-akpm/drivers/net/mv643xx_eth.c	2005-04-12 03:21:13.771043384 -0700
@@ -668,7 +668,7 @@ static int mv643xx_eth_open(struct net_d
 	spin_lock_irq(&mp->lock);
 
 	err = request_irq(dev->irq, mv643xx_eth_int_handler,
-			SA_INTERRUPT | SA_SAMPLE_RANDOM, dev->name, dev);
+			SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
 
 	if (err) {
 		printk(KERN_ERR "Can not assign IRQ number to MV643XX_eth%d\n",
_
