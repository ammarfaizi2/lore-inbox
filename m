Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTEGXET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTEGXEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:04:02 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:42735 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264324AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493863583@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493861812@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1097, 2003/05/07 14:59:22-07:00, hannal@us.ibm.com

[PATCH] rocket tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/rocket.c |   10 +---------
 1 files changed, 1 insertion(+), 9 deletions(-)


diff -Nru a/drivers/char/rocket.c b/drivers/char/rocket.c
--- a/drivers/char/rocket.c	Wed May  7 16:01:23 2003
+++ b/drivers/char/rocket.c	Wed May  7 16:01:23 2003
@@ -874,9 +874,6 @@
 	}
 
 	if (info->count++ == 0) {
-#ifdef MODULE
-		MOD_INC_USE_COUNT;
-#endif
 		rp_num_ports_open++;
 #ifdef ROCKET_DEBUG_OPEN
 		printk("rocket mod++ = %d...", rp_num_ports_open);
@@ -1071,9 +1068,6 @@
 	tty->closing = 0;
 	wake_up_interruptible(&info->close_wait);
 	
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
 	rp_num_ports_open--;
 #ifdef ROCKET_DEBUG_OPEN
 	printk("rocket mod-- = %d...", rp_num_ports_open);
@@ -1504,9 +1498,6 @@
 		return;
 	}
 	if (info->count) {
-#ifdef MODULE
-		MOD_DEC_USE_COUNT;
-#endif
 		rp_num_ports_open--;
 	}
 	
@@ -2012,6 +2003,7 @@
 	 */
 	memset(&rocket_driver, 0, sizeof(struct tty_driver));
 	rocket_driver.magic = TTY_DRIVER_MAGIC;
+	rocket_driver.owner = THIS_MODULE;
 #ifdef CONFIG_DEVFS_FS
 	rocket_driver.name = "tts/R";
 #else

