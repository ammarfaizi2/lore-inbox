Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWJAOse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWJAOse (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 10:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWJAOse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 10:48:34 -0400
Received: from havoc.gtf.org ([69.61.125.42]:18410 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750752AbWJAOsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 10:48:33 -0400
Date: Sun, 1 Oct 2006 10:48:27 -0400
From: Jeff Garzik <jeff@garzik.org>
To: chas@cmf.nrl.navy.mil, netdev@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] atm/firestream: mark 32-bit only
Message-ID: <20061001144827.GA3322@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This driver does some dodgy stuff, reading a 32-bit value directly from
the hardware, calling bus_to_virt() on it, and then pretending that will
work just fine on 64-bit.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/atm/Kconfig b/drivers/atm/Kconfig
index cfa5af8..8903ecf 100644
--- a/drivers/atm/Kconfig
+++ b/drivers/atm/Kconfig
@@ -139,7 +139,7 @@ config ATM_ENI_BURST_RX_2W
 
 config ATM_FIRESTREAM
 	tristate "Fujitsu FireStream (FS50/FS155) "
-	depends on PCI && ATM
+	depends on PCI && ATM && 32BIT
 	help
 	  Driver for the Fujitsu FireStream 155 (MB86697) and
 	  FireStream 50 (MB86695) ATM PCI chips.
