Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbTEGXhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbTEGXC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:02:28 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:42478 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264185AbTEGXCA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493873768@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493873374@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1105, 2003/05/07 15:00:42-07:00, hannal@us.ibm.com

[PATCH] ip2main tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/ip2main.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)


diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Wed May  7 16:00:47 2003
+++ b/drivers/char/ip2main.c	Wed May  7 16:00:47 2003
@@ -793,6 +793,7 @@
 
 	/* Initialise the relevant fields. */
 	ip2_tty_driver.magic                = TTY_DRIVER_MAGIC;
+	ip2_tty_driver.owner		    = THIS_MODULE;
 	ip2_tty_driver.name                 = pcTty;
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,1,0)
 	ip2_tty_driver.driver_name          = pcDriver_name;
@@ -1577,7 +1578,6 @@
 	/* Setup pointer links in device and tty structures */
 	pCh->pTTY = tty;
 	tty->driver_data = pCh;
-	MOD_INC_USE_COUNT;
 
 #ifdef IP2DEBUG_OPEN
 	printk(KERN_DEBUG \
@@ -1777,14 +1777,12 @@
 #endif
 
 	if ( tty_hung_up_p ( pFile ) ) {
-		MOD_DEC_USE_COUNT;
 
 		ip2trace (CHANN, ITRC_CLOSE, 2, 1, 2 );
 
 		return;
 	}
 	if ( tty->count > 1 ) { /* not the last close */
-		MOD_DEC_USE_COUNT;
 
 		ip2trace (CHANN, ITRC_CLOSE, 2, 1, 3 );
 
@@ -1852,7 +1850,6 @@
 	DBG_CNT("ip2_close: after wakeups--");
 #endif
 
-	MOD_DEC_USE_COUNT;
 
 	ip2trace (CHANN, ITRC_CLOSE, ITRC_RETURN, 1, 1 );
 

