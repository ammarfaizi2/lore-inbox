Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbULNWye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbULNWye (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbULNWx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:53:28 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:26053 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S261709AbULNWvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:51:53 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 14 Dec 2004 15:51:50 -0700
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk@arm.linux.org.uk>,
       Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: [PATCH 7/6] mv643xx_eth: Remove use of MV_SET_REG_BITS macro
Message-ID: <20041214225150.GA21869@xyzzy>
References: <20041213220949.GA19609@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213220949.GA19609@xyzzy>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I missed this in my first set of patches for the mv643xx_eth driver.

This patch removes the need for the MV_SET_REG_BITS macro in the mv643xx_eth
driver.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.5-marvell-submit.orig/drivers/net/mv643xx_eth.c	2004-12-14 15:07:49.537387217 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c	2004-12-14 15:07:53.721135861 -0700
@@ -1845,8 +1845,9 @@
 	MV_WRITE(MV64340_ETH_PORT_SERIAL_CONTROL_REG(eth_port_num),
 		 mp->port_serial_control);
 
-	MV_SET_REG_BITS(MV64340_ETH_PORT_SERIAL_CONTROL_REG(eth_port_num),
-			MV64340_ETH_SERIAL_PORT_ENABLE);
+	MV_WRITE(MV64340_ETH_PORT_SERIAL_CONTROL_REG(eth_port_num),
+		MV_READ(MV64340_ETH_PORT_SERIAL_CONTROL_REG(eth_port_num)) |
+						MV64340_ETH_SERIAL_PORT_ENABLE);
 
 	/* Assign port SDMA configuration */
 	MV_WRITE(MV64340_ETH_SDMA_CONFIG_REG(eth_port_num),
