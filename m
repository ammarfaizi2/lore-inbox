Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUKIG5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUKIG5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 01:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUKIFys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:54:48 -0500
Received: from motgate8.mot.com ([129.188.136.8]:49904 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261409AbUKIFcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:32:11 -0500
Date: Mon, 8 Nov 2004 23:32:03 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Updated reporting of CPU rev & freq for e500 CPUs
Message-ID: <Pine.LNX.4.61.0411082327570.13565@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Fixes up the reporting of the e500 core revision.  Additionally, it 
changes the reporting of CPU frequency to match what other PPC systems do.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c	2004-11-08 22:18:31 -06:00
+++ b/arch/ppc/kernel/setup.c	2004-11-08 22:18:31 -06:00
@@ -226,6 +226,10 @@
  		maj = ((pvr >> 8) & 0xFF) - 1;
  		min = pvr & 0xFF;
  		break;
+	case 0x8020:	/* e500 */
+		maj = PVR_MAJ(pvr);
+		min = PVR_MIN(pvr);
+		break;
  	default:
  		maj = (pvr >> 8) & 0xFF;
  		min = pvr & 0xFF;
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2004-11-08 22:18:31 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2004-11-08 22:18:31 -06:00
@@ -142,8 +142,7 @@
  		seq_printf(m, "Machine\t\t: unknown\n");
  		break;
  	}
-	seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq / 1000000,
-		   freq % 1000000);
+	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
  	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
  	seq_printf(m, "SVR\t\t: 0x%x\n", svid);

diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2004-11-08 22:18:31 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2004-11-08 22:18:31 -06:00
@@ -172,8 +172,7 @@

          seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
  	seq_printf(m, "Machine\t\t: CDS (%x)\n", cadmus[CM_VER]);
-        seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq / 1000000,
-                   freq % 1000000);
+	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
          seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
          seq_printf(m, "SVR\t\t: 0x%x\n", svid);

diff -Nru a/arch/ppc/platforms/85xx/sbc85xx.c b/arch/ppc/platforms/85xx/sbc85xx.c
--- a/arch/ppc/platforms/85xx/sbc85xx.c	2004-11-08 22:18:31 -06:00
+++ b/arch/ppc/platforms/85xx/sbc85xx.c	2004-11-08 22:18:31 -06:00
@@ -142,8 +142,7 @@
  		seq_printf(m, "Machine\t\t: unknown\n");
  		break;
  	}
-	seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq / 1000000,
-		   freq % 1000000);
+	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
  	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
  	seq_printf(m, "SVR\t\t: 0x%x\n", svid);

