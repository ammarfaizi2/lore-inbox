Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264177AbTEGXCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264338AbTEGXCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:02:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48889 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264177AbTEGXB7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:01:59 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052349386555@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493861534@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1091, 2003/05/07 14:58:22-07:00, hannal@us.ibm.com

[PATCH] specialix tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/specialix.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)


diff -Nru a/drivers/char/specialix.c b/drivers/char/specialix.c
--- a/drivers/char/specialix.c	Wed May  7 16:01:49 2003
+++ b/drivers/char/specialix.c	Wed May  7 16:01:49 2003
@@ -833,9 +833,7 @@
 #ifdef SPECIALIX_DEBUG
 			printk ( "Sending HUP.\n");
 #endif
-			MOD_INC_USE_COUNT;
-			if (schedule_task(&port->tqueue_hangup) == 0)
-				MOD_DEC_USE_COUNT;
+			schedule_task(&port->tqueue_hangup);
 		} else {
 #ifdef SPECIALIX_DEBUG
 			printk ( "Don't need to send HUP.\n");
@@ -980,7 +978,6 @@
 	turn_ints_on (bp);
 	bp->flags |= SX_BOARD_ACTIVE;
 
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -1000,7 +997,6 @@
 
 	turn_ints_off (bp);
 
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -2150,7 +2146,6 @@
 	tty = port->tty;
 	if (tty)
 		tty_hangup(tty);	/* FIXME: module removal race here */
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -2233,6 +2228,7 @@
 	init_bh(SPECIALIX_BH, do_specialix_bh);
 	memset(&specialix_driver, 0, sizeof(specialix_driver));
 	specialix_driver.magic = TTY_DRIVER_MAGIC;
+	specialix_driver.owner = THIS_MODULE;
 	specialix_driver.name = "ttyW";
 	specialix_driver.major = SPECIALIX_NORMAL_MAJOR;
 	specialix_driver.num = SX_NBOARD * SX_NPORT;

