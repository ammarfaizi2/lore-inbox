Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbTEGXbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTEGXDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:03:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:10984 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264322AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493881130@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493881777@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1114, 2003/05/07 15:02:12-07:00, hannal@us.ibm.com

[PATCH] vme_scc tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/vme_scc.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)


diff -Nru a/drivers/char/vme_scc.c b/drivers/char/vme_scc.c
--- a/drivers/char/vme_scc.c	Wed May  7 16:00:08 2003
+++ b/drivers/char/vme_scc.c	Wed May  7 16:00:08 2003
@@ -129,6 +129,7 @@
 
 	memset(&scc_driver, 0, sizeof(scc_driver));
 	scc_driver.magic = TTY_DRIVER_MAGIC;
+	scc_driver.owner = THIS_MODULE;
 	scc_driver.driver_name = "scc";
 #ifdef CONFIG_DEVFS_FS
 	scc_driver.name = "tts/";
@@ -795,7 +796,6 @@
 {
 	scc_disable_tx_interrupts(ptr);
 	scc_disable_rx_interrupts(ptr);
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -803,7 +803,6 @@
 {
 	scc_disable_tx_interrupts(ptr);
 	scc_disable_rx_interrupts(ptr);
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -938,13 +937,9 @@
 		return retval;
 	}
 	port->gs.flags |= GS_ACTIVE;
-	if (port->gs.count == 1) {
-		MOD_INC_USE_COUNT;
-	}
 	retval = gs_block_til_ready(port, filp);
 
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		port->gs.count--;
 		return retval;
 	}

