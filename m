Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTEGXEU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTEGXDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:03:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:6101 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264309AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493863606@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493864071@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1095, 2003/05/07 14:59:02-07:00, hannal@us.ibm.com

[PATCH] ser_a2232 tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/ser_a2232.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)


diff -Nru a/drivers/char/ser_a2232.c b/drivers/char/ser_a2232.c
--- a/drivers/char/ser_a2232.c	Wed May  7 16:01:31 2003
+++ b/drivers/char/ser_a2232.c	Wed May  7 16:01:31 2003
@@ -272,7 +272,6 @@
 		not in "a2232_close()". See the comment in "sx.c", too.
 		If you run into problems, compile this driver into the
 		kernel instead of compiling it as a module. */
-	MOD_DEC_USE_COUNT;
 }
 
 static int  a2232_set_real_termios(void *ptr)
@@ -414,7 +413,6 @@
 	a2232_disable_tx_interrupts(ptr);
 	a2232_disable_rx_interrupts(ptr);
 	/* see the comment in a2232_shutdown_port above. */
-	/* MOD_DEC_USE_COUNT; */
 }
 
 static void a2232_hungup(void *ptr)
@@ -468,13 +466,9 @@
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
@@ -711,6 +705,7 @@
 
 	memset(&a2232_driver, 0, sizeof(a2232_driver));
 	a2232_driver.magic = TTY_DRIVER_MAGIC;
+	a2232_driver.owner = THIS_MODULE;
 	a2232_driver.driver_name = "commodore_a2232";
 	a2232_driver.name = "ttyY";
 	a2232_driver.major = A2232_NORMAL_MAJOR;

