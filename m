Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263548AbUJ2Uwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbUJ2Uwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbUJ2UvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:51:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50182 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263549AbUJ2Ug0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:36:26 -0400
Date: Fri, 29 Oct 2004 21:36:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 8390.c: Use mdelay(10) rather than udelay(10*1000)
Message-ID: <20041029213623.J31627@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ARM udelay can't cope with >2ms delays.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/net/8390.c linux/drivers/net/8390.c
--- orig/drivers/net/8390.c	Sat Oct 23 11:38:21 2004
+++ linux/drivers/net/8390.c	Sat Oct 23 11:36:34 2004
@@ -813,7 +813,7 @@ static void ei_rx_overrun(struct net_dev
 	 * We wait at least 10ms.
 	 */
 
-	udelay(10*1000);
+	mdelay(10);
 
 	/*
 	 * Reset RBCR[01] back to zero as per magic incantation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
