Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWCEO4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWCEO4K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 09:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCEO4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 09:56:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11232 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750806AbWCEO4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 09:56:09 -0500
Date: Sun, 5 Mar 2006 14:53:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, linux@dominikbrodowski.net
Subject: [patch] collie: fix missing pcmcia bits
Message-ID: <20060305135351.GA16481@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds missing bits of collie (sharp sl-5500) PCMCIA support.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index f146e5e..8bd802e 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -76,6 +76,12 @@ static struct scoop_pcmcia_dev collie_pc
 },
 };
 
+static struct scoop_pcmcia_config collie_pcmcia_config = {
+	.devs         = &collie_pcmcia_scoop[0],
+	.num_devs     = 1,
+};
+
+
 static struct mcp_plat_data collie_mcp_data = {
 	.mccr0          = MCCR0_ADM,
 	.sclk_rate      = 11981000,
@@ -242,8 +249,7 @@ static void __init collie_init(void)
 	GPDR |= GPIO_32_768kHz;
 	TUCR  = TUCR_32_768kHz;
 
-	scoop_num = 1;
-	scoop_devs = &collie_pcmcia_scoop[0];
+	platform_scoop_config = &collie_pcmcia_config;
 
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret) {
diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
index fd36473..f1363b8 100644
--- a/drivers/pcmcia/pxa2xx_sharpsl.c
+++ b/drivers/pcmcia/pxa2xx_sharpsl.c
@@ -22,6 +22,15 @@
 #include <asm/hardware.h>
 #include <asm/irq.h>
 #include <asm/hardware/scoop.h>
+#include <asm/mach-types.h>
+#include <linux/delay.h>
+
+#ifdef CONFIG_SA1100_COLLIE
+#include <asm/arch-sa1100/collie.h>
+#else
+#include <asm/arch/spitz.h>
+#include <asm/arch-pxa/pxa-regs.h>
+#endif
 
 #include "soc_common.h"
 

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
