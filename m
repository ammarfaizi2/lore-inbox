Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbTJPBwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 21:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbTJPBwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 21:52:49 -0400
Received: from panda.sul.com.br ([200.219.150.4]:59666 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262617AbTJPBwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 21:52:47 -0400
Date: Wed, 15 Oct 2003 23:52:13 -0200
To: linux-kernel@vger.kernel.org
Cc: Brard Roudier <groudier@free.fr>
Subject: [patch][1/3] qlogic: use scsi_host_alloc instead scsi_register
Message-ID: <20031016015213.GA1765@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,
	these patches fixes qlogic_cs module loading and unloading. 

-- 
aris


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qlogic-alloc.patch"

--- linux/drivers/scsi/qlogicfas.c.orig	2003-10-15 23:41:52.000000000 -0200
+++ linux/drivers/scsi/qlogicfas.c	2003-10-15 23:41:28.000000000 -0200
@@ -671,7 +671,7 @@
 	if (qlirq >= 0 && !request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", NULL))
 		host->can_queue = 1;
 #endif
-	hreg = scsi_register(host, 0);	/* no host data */
+	hreg = scsi_host_alloc(host, 0);	/* no host data */
 	if (!hreg)
 		goto err_release_mem;
 	hreg->io_port = qbase;
@@ -679,6 +679,7 @@
 	hreg->dma_channel = -1;
 	if (qlirq != -1)
 		hreg->irq = qlirq;
+	INIT_LIST_HEAD(&hreg->sht_legacy_list);
 
 	sprintf(qinfo,
 		"Qlogicfas Driver version 0.46, chip %02X at %03X, IRQ %d, TPdma:%d",

--n8g4imXOkfNTN/H1--
