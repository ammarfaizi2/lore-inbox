Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTJTXZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTJTXZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:25:44 -0400
Received: from panda.sul.com.br ([200.219.150.4]:39435 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S263051AbTJTXZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:25:37 -0400
Date: Mon, 20 Oct 2003 21:24:26 -0200
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <mikenc@us.ibm.com>
Subject: [patch] qlogic: kill QL_USE_IRQ
Message-ID: <20031020232425.GC473@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


-- 
aris


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qlogic-kill_qluseirq.patch"

--- linux-2.5/drivers/scsi/qlogicfas.c	2003-10-15 17:16:15.000000000 -0200
+++ build-2.5/drivers/scsi/qlogicfas.c	2003-10-17 16:44:41.000000000 -0200
@@ -48,11 +48,6 @@
 
 #define QL_INT_ACTIVE_HIGH 2
 
-/* Set the following to 1 to enable the use of interrupts.  Note that 0 tends
-   to be more stable, but slower (or ties up the system more) */
-
-#define QL_USE_IRQ 1
-
 /* Set the following to max out the speed of the PIO PseudoDMA transfers,
    again, 0 tends to be slower, but more stable.  */
 
@@ -500,8 +495,6 @@
 	return (result << 16) | (message << 8) | (status & STATUS_MASK);
 }
 
-#if QL_USE_IRQ
-
 /*
  *	Interrupt handler 
  */
@@ -541,10 +534,6 @@
 	return IRQ_HANDLED;
 }
 
-#endif
-
-#if QL_USE_IRQ
-
 /*
  *	Queued command
  */
@@ -566,12 +555,6 @@
 	ql_icmd(cmd);
 	return 0;
 }
-#else
-int qlogicfas_queuecommand(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
-{
-	return 1;
-}
-#endif
 
 #ifdef PCMCIA
 
@@ -641,7 +624,6 @@
 	REG0;
 #endif
 
-#if QL_USE_IRQ
 	/*
 	 *	IRQ probe - toggle pin and check request pending 
 	 */
@@ -670,7 +652,7 @@
 
 	if (qlirq >= 0 && !request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", NULL))
 		host->can_queue = 1;
-#endif
+
 	hreg = scsi_register(host, 0);	/* no host data */
 	if (!hreg)
 		goto err_release_mem;

--69pVuxX8awAiJ7fD--
