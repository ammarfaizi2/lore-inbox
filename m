Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266658AbUGQNHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266658AbUGQNHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 09:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUGQNHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 09:07:16 -0400
Received: from havoc.gtf.org ([216.162.42.101]:19851 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266658AbUGQNHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 09:07:14 -0400
Date: Sat, 17 Jul 2004 09:07:14 -0400
From: David Eger <eger@havoc.gtf.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] pmac_zilog: fix patch drain bramage
Message-ID: <20040717130714.GA27891@havoc.gtf.org>
References: <20040712075113.GB19875@havoc.gtf.org> <20040712082104.GA22366@havoc.gtf.org> <20040712220935.GA20049@havoc.gtf.org> <20040713003935.GA1050@havoc.gtf.org> <1089692194.1845.38.camel@gaston> <20040716185832.GA8750@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040716185832.GA8750@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How embarrassing.
One of the "if (!rc)"'s in that patch should be an "if (rc)".

-dte

Signed-off-by: David Eger <eger@havoc.gtf.org>

diff -Nru a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
--- a/drivers/serial/pmac_zilog.c	2004-07-17 09:04:47 -04:00
+++ b/drivers/serial/pmac_zilog.c	2004-07-17 09:04:47 -04:00
@@ -1801,7 +1801,7 @@
 	 * Register this driver with the serial core
 	 */
 	rc = uart_register_driver(&pmz_uart_reg);
-	if (rc != 0) 
+	if (rc)
 		return rc;
 
 	/*
@@ -1812,7 +1812,7 @@
 		/* NULL node may happen on wallstreet */
 		if (uport->node != NULL)
 			rc = uart_add_one_port(&pmz_uart_reg, &uport->port);
-		if (!rc)
+		if (rc)
 			goto err_out;
 	}
 
