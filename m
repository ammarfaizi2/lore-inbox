Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbTD0MnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 08:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbTD0MnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 08:43:08 -0400
Received: from dp.samba.org ([66.70.73.150]:27073 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263962AbTD0MnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 08:43:07 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16043.53785.797962.890585@nanango.paulus.ozlabs.org>
Date: Sun, 27 Apr 2003 22:50:33 +1000 (EST)
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i2c-keywest.c irq handler type
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the interrupt handler routine in i2c-keywest.c to
return an irqreturn_t.

Paul.

diff -urN linux-2.5/drivers/i2c/i2c-keywest.c pmac-2.5/drivers/i2c/i2c-keywest.c
--- linux-2.5/drivers/i2c/i2c-keywest.c	2003-04-03 07:22:49.000000000 +1000
+++ pmac-2.5/drivers/i2c/i2c-keywest.c	2003-04-23 21:32:32.000000000 +1000
@@ -212,7 +212,7 @@
 #ifndef POLLED_MODE
 
 /* Interrupt handler */
-static void
+static irqreturn_t
 keywest_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct keywest_iface *iface = (struct keywest_iface *)dev_id;
@@ -225,6 +225,7 @@
 		add_timer(&iface->timeout_timer);
 	}
 	spin_unlock(&iface->lock);
+	return IRQ_HANDLED;
 }
 
 static void
