Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTJPBzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 21:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbTJPBzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 21:55:33 -0400
Received: from panda.sul.com.br ([200.219.150.4]:1797 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262671AbTJPBzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 21:55:25 -0400
Date: Wed, 15 Oct 2003 23:54:49 -0200
To: linux-kernel@vger.kernel.org
Cc: Brard Roudier <groudier@free.fr>
Subject: [patch][3/3] qlogic: set host name before using scsi_host_alloc()
Message-ID: <20031016015449.GC1765@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


-- 
aris


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qlogic-name.patch"

--- linux/drivers/scsi/qlogicfas.c.orig	2003-10-15 23:44:55.000000000 -0200
+++ linux/drivers/scsi/qlogicfas.c	2003-10-15 23:45:36.000000000 -0200
@@ -668,6 +668,11 @@
 	} else
 		printk(KERN_INFO "Ql: Using preset IRQ %d\n", qlirq);
 #endif
+	sprintf(qinfo,
+		"Qlogicfas Driver version 0.46, chip %02X at %03X, IRQ %d, TPdma:%d",
+		qltyp, qbase, qlirq, QL_TURBO_PDMA);
+	host->name = qinfo;
+
 	hreg = scsi_host_alloc(host, 0);	/* no host data */
 	if (!hreg)
 		goto err_release_mem;
@@ -678,10 +683,6 @@
 	hreg->can_queue = 1;
 	INIT_LIST_HEAD(&hreg->sht_legacy_list);
 
-	sprintf(qinfo,
-		"Qlogicfas Driver version 0.46, chip %02X at %03X, IRQ %d, TPdma:%d",
-		qltyp, qbase, qlirq, QL_TURBO_PDMA);
-	host->name = qinfo;
 #ifdef QL_USE_IRQ
 	if (qlirq < 0 || request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", hreg))
 		goto free_scsi_host;

--1ccMZA6j1vT5UqiK--
