Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVF3FBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVF3FBl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 01:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVF3FBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 01:01:41 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:19856 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262811AbVF3FBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 01:01:38 -0400
Date: Thu, 30 Jun 2005 00:01:28 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix pointer check for MPC8540 ADS device
Message-ID: <Pine.LNX.4.61.0506300000580.19735@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Editor snafu in which the call to ppc_sys_get_pdata got inside the if
check instead of before it.  Oops.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit e82df07a507588f1f0cc9da544934b4a737e2e84
tree 2e9642efcb34f846444bc288d3c4d7c384c00348
parent 6bd7d9f21de5992db4851f9be88c2e20b967f3d2
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 30 Jun 2005 01:35:53 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 30 Jun 2005 01:35:53 -0500

 arch/ppc/platforms/85xx/mpc8540_ads.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c
@@ -111,8 +111,8 @@ mpc8540ads_setup_arch(void)
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_FEC);
 	if (pdata) {
-		pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_FEC);
 		pdata->board_flags = 0;
 		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
 		pdata->phyid = 3;
