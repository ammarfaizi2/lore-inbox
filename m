Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTEGXbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbTEGXDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:03:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49145 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264311AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052349387433@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <1052349387810@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1107, 2003/05/07 15:01:02-07:00, hannal@us.ibm.com

[PATCH] esp  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/esp.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)


diff -Nru a/drivers/char/esp.c b/drivers/char/esp.c
--- a/drivers/char/esp.c	Wed May  7 16:00:39 2003
+++ b/drivers/char/esp.c	Wed May  7 16:00:39 2003
@@ -643,9 +643,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 			printk("scheduling hangup...");
 #endif
-			MOD_INC_USE_COUNT;
-			if (schedule_task(&info->tqueue_hangup) == 0)
-				MOD_DEC_USE_COUNT;
+			schedule_task(&info->tqueue_hangup);
 		}
 	}
 }
@@ -811,7 +809,6 @@
 	tty = info->tty;
 	if (tty)
 		tty_hangup(tty);
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -2132,7 +2129,7 @@
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE|
 			 ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-out:	MOD_DEC_USE_COUNT;
+out:
 	restore_flags(flags);
 }
 
@@ -2375,7 +2372,6 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("esp_open %s, count = %d\n", tty->name, info->count);
 #endif
-	MOD_INC_USE_COUNT;
 	info->count++;
 	tty->driver_data = info;
 	info->tty = tty;
@@ -2551,6 +2547,7 @@
 	
 	memset(&esp_driver, 0, sizeof(struct tty_driver));
 	esp_driver.magic = TTY_DRIVER_MAGIC;
+	esp_driver.owner = THIS_MODULE;
 	esp_driver.name = "ttyP";
 	esp_driver.major = ESP_IN_MAJOR;
 	esp_driver.minor_start = 0;

