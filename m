Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTEGAUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbTEGAUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:20:18 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:62710 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262161AbTEGATL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:19:11 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522676152488@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.69
In-Reply-To: <1052267615977@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 17:33:35 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1042.48.3, 2003/04/29 10:12:19-07:00, paulus@samba.org

[PATCH] i2c: i2c-keywest.c irq handler type

This patch changes the interrupt handler routine in i2c-keywest.c to
return an irqreturn_t.


 drivers/i2c/i2c-keywest.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-keywest.c b/drivers/i2c/i2c-keywest.c
--- a/drivers/i2c/i2c-keywest.c	Tue May  6 17:24:55 2003
+++ b/drivers/i2c/i2c-keywest.c	Tue May  6 17:24:55 2003
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

