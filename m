Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbULOS75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbULOS75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbULOS74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:59:56 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:2493 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262448AbULOS7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:59:55 -0500
Date: Wed, 15 Dec 2004 11:59:44 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org,
       cwernham@airspan.com
Subject: [PATCH][PPC32] PPC4XX DMA polarity init fix
Message-ID: <20041215115944.B3696@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Clear bug fix, hopefully it can go in before 2.6.10]

This patch applies to the kernel 2.6.9 and fixes the initialisation of 
the DMA channel polarity in the function ppc4xx_init_dma_channel() for 
the PPC 4XX processor.

Signed-off-by: Colin P Wernham <cwernham@airspan.com>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/syslib/ppc4xx_dma.c 1.8 vs edited =====
--- 1.8/arch/ppc/syslib/ppc4xx_dma.c	2004-08-07 11:05:39 -07:00
+++ edited/arch/ppc/syslib/ppc4xx_dma.c	2004-12-15 11:58:16 -07:00
@@ -466,7 +466,7 @@
 
 	/* clear all polarity signals and then "or" in new signal levels */
 	polarity &= ~GET_DMA_POLARITY(dmanr);
-	polarity |= p_dma_ch->polarity;
+	polarity |= p_init->polarity;
 #if DCRN_POL > 0
 	mtdcr(DCRN_POL, polarity);
 #endif
