Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265466AbUBJBRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 20:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265643AbUBJBPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 20:15:41 -0500
Received: from palrel10.hp.com ([156.153.255.245]:15517 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265639AbUBJBOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 20:14:14 -0500
Date: Mon, 9 Feb 2004 17:14:09 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] w83977af_ir irq retval
Message-ID: <20040210011409.GI673@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir262_irq_retval_w83977af.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] Better handling of shared IRQs in w83977af_ir driver.


diff -u -p linux/drivers/net/irda.d7/w83977af_ir.c linux/drivers/net/irda/w83977af_ir.c
--- linux/drivers/net/irda.d7/w83977af_ir.c	Wed Feb  4 11:55:57 2004
+++ linux/drivers/net/irda/w83977af_ir.c	Mon Feb  9 16:12:28 2004
@@ -1143,7 +1143,7 @@ static irqreturn_t w83977af_interrupt(in
 
 	outb(icr, iobase+ICR);    /* Restore (new) interrupts */
 	outb(set, iobase+SSR);    /* Restore bank register */
-	return IRQ_HANDLED;
+	return IRQ_RETVAL(isr);
 }
 
 /*
