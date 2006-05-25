Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWEYB1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWEYB1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWEYB1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:27:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29838 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964817AbWEYB1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:27:02 -0400
Message-Id: <20060525003422.557653000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Thu, 25 May 2006 02:27:50 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] extra delay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The wd33c93 needs a small delay before a new command can be started.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 drivers/scsi/wd33c93.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6-mm/drivers/scsi/wd33c93.c
===================================================================
--- linux-2.6-mm.orig/drivers/scsi/wd33c93.c
+++ linux-2.6-mm/drivers/scsi/wd33c93.c
@@ -939,6 +939,7 @@ wd33c93_intr(struct Scsi_Host *instance)
 		DB(DB_INTR, printk("%02x", cmd->SCp.Status))
 		    if (hostdata->level2 >= L2_BASIC) {
 			sr = read_wd33c93(regs, WD_SCSI_STATUS);	/* clear interrupt */
+			udelay(7);
 			hostdata->state = S_RUNNING_LEVEL2;
 			write_wd33c93(regs, WD_COMMAND_PHASE, 0x50);
 			write_wd33c93_cmd(regs, WD_CMD_SEL_ATN_XFER);
@@ -955,6 +956,7 @@ wd33c93_intr(struct Scsi_Host *instance)
 
 		msg = read_1_byte(regs);
 		sr = read_wd33c93(regs, WD_SCSI_STATUS);	/* clear interrupt */
+		udelay(7);
 
 		hostdata->incoming_msg[hostdata->incoming_ptr] = msg;
 		if (hostdata->incoming_msg[0] == EXTENDED_MESSAGE)
@@ -1358,6 +1360,7 @@ wd33c93_intr(struct Scsi_Host *instance)
 			} else {
 				/* Verify this is a change to MSG_IN and read the message */
 				sr = read_wd33c93(regs, WD_SCSI_STATUS);
+				udelay(7);
 				if (sr == (CSR_ABORT | PHS_MESS_IN) ||
 				    sr == (CSR_UNEXP | PHS_MESS_IN) ||
 				    sr == (CSR_SRV_REQ | PHS_MESS_IN)) {
@@ -1374,6 +1377,7 @@ wd33c93_intr(struct Scsi_Host *instance)
 							     asr);
 					}
 					sr = read_wd33c93(regs, WD_SCSI_STATUS);
+					udelay(7);
 					if (sr != CSR_MSGIN)
 						printk
 						    ("wd33c93: Not paused with ACK on RESEL (%02x)\n",

--

