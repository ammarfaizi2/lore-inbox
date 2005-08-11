Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbVHKM6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbVHKM6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVHKM6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:58:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49369 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030295AbVHKM6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:58:14 -0400
Date: Thu, 11 Aug 2005 14:56:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: [patch] Make sharp zaurus sl-5500 use ucb1x00 generic infrastructure
Message-ID: <20050811125609.GA3685@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make collie use ucb1x00 core.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 4a7a0c6b2c3845ba652b7a27c6e65099aea53b27
tree 1e15e85e6fce3adaca5720f06544555fcb31f0f6
parent 5f1a0d9f2bef25e7620b37d02ad2c94875ea9908
author <pavel@amd.(none)> Thu, 11 Aug 2005 14:53:29 +0200
committer <pavel@amd.(none)> Thu, 11 Aug 2005 14:53:29 +0200

 arch/arm/mach-sa1100/collie.c     |    6 ++++++
 drivers/mfd/ucb1x00-core.c        |    1 +
 include/asm-arm/arch-sa1100/mcp.h |    2 ++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -40,6 +40,7 @@
 #include <asm/hardware/scoop.h>
 #include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/locomo.h>
+#include <asm/arch/mcp.h>
 
 #include "generic.h"
 
@@ -66,6 +67,10 @@ struct platform_device colliescoop_devic
 	.resource	= collie_scoop_resources,
 };
 
+static struct mcp_plat_data collie_mcp_data = {
+	.mccr0          = MCCR0_ADM,
+	.sclk_rate      = 11981000,
+};
 
 #ifdef CONFIG_SHARP_LOCOMO
 /*
@@ -238,6 +243,7 @@ static void __init collie_init(void)
 
 	sa11x0_set_flash_data(&collie_flash_data, collie_flash_resources,
 			      ARRAY_SIZE(collie_flash_resources));
+	sa11x0_set_mcp_data(&collie_mcp_data);
 
 	sharpsl_save_param();
 }

-- 
if you have sharp zaurus hardware you don't need... you know my address
