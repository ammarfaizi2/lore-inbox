Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUBJBOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 20:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbUBJBN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 20:13:59 -0500
Received: from palrel12.hp.com ([156.153.255.237]:61370 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265607AbUBJBNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 20:13:38 -0500
Date: Mon, 9 Feb 2004 17:13:36 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] via-ircc irq retval
Message-ID: <20040210011336.GH673@bougret.hpl.hp.com>
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

ir262_irq_retval_via.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] Better handling of shared IRQs in via-ircc driver.


diff -u -p linux/drivers/net/irda.d7/via-ircc.c linux/drivers/net/irda/via-ircc.c
--- linux/drivers/net/irda.d7/via-ircc.c	Wed Feb  4 11:55:57 2004
+++ linux/drivers/net/irda/via-ircc.c	Mon Feb  9 16:12:33 2004
@@ -1394,7 +1394,7 @@ static irqreturn_t via_ircc_interrupt(in
 
 	}			//Rx Event
 	spin_unlock(&self->lock);
-	return IRQ_HANDLED;
+	return IRQ_RETVAL(iHostIntType);
 }
 
 void hwreset(struct via_ircc_cb *self)
