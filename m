Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbWAXMwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWAXMwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 07:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWAXMwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 07:52:11 -0500
Received: from mail.gmx.de ([213.165.64.21]:49835 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030467AbWAXMwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 07:52:10 -0500
X-Authenticated: #31060655
Message-ID: <43D62256.2080207@gmx.net>
Date: Tue, 24 Jan 2006 13:49:26 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: [PATCH] sky2: fix ethtool ops
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes setting rx_coalesce_usecs_irq via ethtool in sky2.
The write was directed to the wrong register.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>

--- linux/drivers/net/sky2.c	2006-01-23 23:41:35.000000000 +0100
+++ linux/drivers/net/sky2.c	2006-01-24 12:52:11.000000000 +0100
@@ -2843,7 +2843,7 @@
 	if (ecmd->rx_coalesce_usecs_irq == 0)
 		sky2_write8(hw, STAT_ISR_TIMER_CTRL, TIM_STOP);
 	else {
-		sky2_write32(hw, STAT_TX_TIMER_INI,
+		sky2_write32(hw, STAT_ISR_TIMER_INI,
 			     sky2_us2clk(hw, ecmd->rx_coalesce_usecs_irq));
 		sky2_write8(hw, STAT_ISR_TIMER_CTRL, TIM_START);
 	}


