Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270096AbTGSNXL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 09:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270130AbTGSNXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 09:23:11 -0400
Received: from dsl-082-082-136-038.arcor-ip.net ([82.82.136.38]:15364 "HELO
	obi.mine.nu") by vger.kernel.org with SMTP id S270096AbTGSNXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 09:23:09 -0400
Subject: [PATCH] 3/3 handle level triggered irqs on dbox2 (2.4.22-pre6)
From: Andreas Oberritter <obi@saftware.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1058620870.585.15.camel@localhost>
References: <1058620870.585.15.camel@localhost>
Content-Type: multipart/mixed; boundary="=-5qUtXoc2iPYWoas443PW"
Message-Id: <1058621788.585.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 19 Jul 2003 15:36:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5qUtXoc2iPYWoas443PW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This one is for components of the dbox2 which cannot be set up to do
edge triggered irqs because no documentation is available. #ifdef
CONFIG_DBOX2 is put around it because other boards don't seem to need
it. Is there a better way to handle level based interrupts?

--=-5qUtXoc2iPYWoas443PW
Content-Disposition: attachment; filename=linux-2.4.22-pre6-dbox2-irq.diff
Content-Type: text/x-patch; name=linux-2.4.22-pre6-dbox2-irq.diff; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.4.22-pre6/arch/ppc/kernel/irq.c linux-2.4.22-pre6-dbox2/arch/ppc/kernel/irq.c
--- linux-2.4.22-pre6/arch/ppc/kernel/irq.c	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4.22-pre6-dbox2/arch/ppc/kernel/irq.c	2003-07-15 09:16:34.000000000 +0200
@@ -507,6 +507,14 @@
 		else if (irq_desc[irq].handler->enable)
 			irq_desc[irq].handler->enable(irq);
 	}
+	
+#ifdef CONFIG_DBOX2
+	if (action) {
+	    if (action->flags & SA_ONESHOT)
+		disable_irq_nosync(irq);
+	}
+#endif
+
 	spin_unlock(&desc->lock);
 }
 

--=-5qUtXoc2iPYWoas443PW--

