Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTEGXhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbTEGXCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:02:24 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:19620 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264186AbTEGXCA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493882794@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493881375@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1111, 2003/05/07 15:01:42-07:00, hannal@us.ibm.com

[PATCH] amiserial tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/amiserial.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)


diff -Nru a/drivers/char/amiserial.c b/drivers/char/amiserial.c
--- a/drivers/char/amiserial.c	Wed May  7 16:00:21 2003
+++ b/drivers/char/amiserial.c	Wed May  7 16:00:21 2003
@@ -1528,7 +1528,6 @@
 
 	if (tty_hung_up_p(filp)) {
 		DBG_CNT("before DEC-hung");
-		MOD_DEC_USE_COUNT;
 		local_irq_restore(flags);
 		return;
 	}
@@ -1555,7 +1554,6 @@
 	}
 	if (state->count) {
 		DBG_CNT("before DEC-2");
-		MOD_DEC_USE_COUNT;
 		local_irq_restore(flags);
 		return;
 	}
@@ -1615,7 +1613,6 @@
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE|
 			 ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-	MOD_DEC_USE_COUNT;
 	local_irq_restore(flags);
 }
 
@@ -1894,15 +1891,12 @@
 	int 			retval, line;
 	unsigned long		page;
 
-	MOD_INC_USE_COUNT;
 	line = tty->index;
 	if ((line < 0) || (line >= NR_PORTS)) {
-		MOD_DEC_USE_COUNT;
 		return -ENODEV;
 	}
 	retval = get_async_struct(line, &info);
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		return retval;
 	}
 	tty->driver_data = info;
@@ -2116,6 +2110,7 @@
 
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 	serial_driver.driver_name = "amiserial";
 	serial_driver.name = "ttyS";
 	serial_driver.major = TTY_MAJOR;

