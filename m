Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbUJZU7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUJZU7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbUJZU7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:59:52 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:11722 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261467AbUJZU7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:59:00 -0400
Date: Tue, 26 Oct 2004 13:58:47 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: ebs@ebshome.net, linuxppc-embedded@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Disable broken L2 cache on all 440GX revs
Message-ID: <20041026135847.A16409@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Always disable L2 cache on PPC440GX. All revs/speeds of silicon
have parity error problems despite errata claims to the contrary.                                                                                 
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/platforms/4xx/ocotea.c 1.8 vs edited =====
--- 1.8/arch/ppc/platforms/4xx/ocotea.c	2004-10-18 22:26:41 -07:00
+++ edited/arch/ppc/platforms/4xx/ocotea.c	2004-10-26 13:40:44 -07:00
@@ -350,8 +350,12 @@
 	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
 	ocp_sys_info.opb_bus_freq = clocks.opb;
 
-	/* Disable L2-Cache on broken hardware, enable it otherwise */
-	ibm440gx_l2c_setup(&clocks);
+	/*
+	 * Always disable L2 cache. All revs/speeds of silicon
+	 * have parity error problems despite errata claims to
+	 * the contrary.
+	 */
+	ibm440gx_l2c_disable();
 
 	ibm44x_platform_init();
 
