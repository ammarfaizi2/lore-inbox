Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVFAR4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVFAR4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVFARyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:54:32 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:54665 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261482AbVFARvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:51:50 -0400
Date: Wed, 1 Jun 2005 10:51:45 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org, kumar.gala@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] cpm_uart: Route SCC2 pins for the STx GP3 board
Message-ID: <20050601105145.B15351@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds SCC2 pin routing specific to the GP3 board.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

Index: drivers/serial/cpm_uart/cpm_uart_cpm2.c
===================================================================
--- b4bedd69e60ae8cc7d89f3c97c617a444eb43292/drivers/serial/cpm_uart/cpm_uart_cpm2.c  (mode:100644)
+++ uncommitted/drivers/serial/cpm_uart/cpm_uart_cpm2.c  (mode:100644)
@@ -134,12 +134,21 @@
 
 void scc2_lineif(struct uart_cpm_port *pinfo)
 {
+	/*
+	 * STx GP3 uses the SCC2 secondary option pin assignment
+	 * which this driver doesn't account for in the static
+	 * pin assignments. This kind of board specific info
+	 * really has to get out of the driver so boards can
+	 * be supported in a sane fashion.
+	 */
+#ifndef CONFIG_STX_GP3
 	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
 	io->iop_pparb |= 0x008b0000;
 	io->iop_pdirb |= 0x00880000;
 	io->iop_psorb |= 0x00880000;
 	io->iop_pdirb &= ~0x00030000;
 	io->iop_psorb &= ~0x00030000;
+#endif
 	cpm2_immr->im_cpmux.cmx_scr &= 0xff00ffff;
 	cpm2_immr->im_cpmux.cmx_scr |= 0x00090000;
 	pinfo->brg = 2;
