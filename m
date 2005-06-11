Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVFKASJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVFKASJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 20:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVFKASJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 20:18:09 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:12933 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261483AbVFKASF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 20:18:05 -0400
Date: Fri, 10 Jun 2005 17:18:03 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
Subject: [PATCH][MM] ppc32: enable rapidio on mpc85xx ads boards
Message-ID: <20050610171802.B15999@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enables RIO on the MPC8540/8560 ADS ref boards.  RIO can be used
with a crossover cable between two of them.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
@@ -47,6 +47,8 @@
 
 #include <mm/mmu_decl.h>
 
+#include <syslib/ppc85xx_rio.h>
+
 #include <platforms/85xx/mpc85xx_ads_common.h>
 
 #ifndef CONFIG_PCI
@@ -223,3 +225,11 @@ mpc85xx_exclude_device(u_char bus, u_cha
 }
 
 #endif /* CONFIG_PCI */
+
+#ifdef CONFIG_RAPIDIO
+void platform_rio_init(void)
+{
+	/* 512MB RIO LAW at 0xc0000000 */
+	mpc85xx_rio_setup(0xc0000000, 0x20000000);
+}
+#endif /* CONFIG_RAPIDIO */
