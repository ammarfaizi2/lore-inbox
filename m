Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271752AbTGROLe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271796AbTGROJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:09:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24709
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271752AbTGROFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:05:23 -0400
Date: Fri, 18 Jul 2003 15:19:44 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181419.h6IEJisp017768@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: sym53c8xxx wasnt updated to new irq code etc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/scsi/sym53c8xx.c linux-2.6.0-test1-ac2/drivers/scsi/sym53c8xx.c
--- linux-2.6.0-test1/drivers/scsi/sym53c8xx.c	2003-07-10 21:12:16.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/scsi/sym53c8xx.c	2003-07-15 18:01:30.000000000 +0100
@@ -1327,7 +1327,7 @@
 #define SetScsiAbortResult(cmd) SetScsiResult(cmd, DID_ABORT, 0xff)
 #endif
 
-static void sym53c8xx_intr(int irq, void *dev_id, struct pt_regs * regs);
+static irqreturn_t sym53c8xx_intr(int irq, void *dev_id, struct pt_regs * regs);
 static void sym53c8xx_timeout(unsigned long np);
 
 #define initverbose (driver_setup.verbose)
@@ -7374,7 +7374,7 @@
 		}
 		if (cp->xerr_status & XE_BAD_PHASE) {
 			PRINT_ADDR(cmd);
-			printk ("illegal scsi phase (4/5).\n");
+			printk ("invalid scsi phase (4/5).\n");
 		}
 		if (cp->xerr_status & XE_SODL_UNRUN) {
 			PRINT_ADDR(cmd);
@@ -13660,7 +13660,7 @@
 **   routine for each host that uses this IRQ.
 */
 
-static void sym53c8xx_intr(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t sym53c8xx_intr(int irq, void *dev_id, struct pt_regs * regs)
 {
      unsigned long flags;
      ncb_p np = (ncb_p) dev_id;
@@ -13685,6 +13685,7 @@
           ncr_flush_done_cmds(done_list);
           NCR_UNLOCK_SCSI_DONE(done_list->device->host, flags);
      }
+     return IRQ_HANDLED;
 }
 
 /*
