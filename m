Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTEGXGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbTEGXFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:05:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:47086 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264328AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052349388865@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493882794@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1112, 2003/05/07 15:01:52-07:00, hannal@us.ibm.com

[PATCH] macintosh/macserial  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/macintosh/macserial.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)


diff -Nru a/drivers/macintosh/macserial.c b/drivers/macintosh/macserial.c
--- a/drivers/macintosh/macserial.c	Wed May  7 16:00:17 2003
+++ b/drivers/macintosh/macserial.c	Wed May  7 16:00:17 2003
@@ -1932,7 +1932,6 @@
 	spin_lock_irqsave(&info->lock, flags);
 
 	if (tty_hung_up_p(filp)) {
-		MOD_DEC_USE_COUNT;
 		spin_unlock_irqrestore(&info->lock, flags);
 		return;
 	}
@@ -1956,7 +1955,6 @@
 		info->count = 0;
 	}
 	if (info->count) {
-		MOD_DEC_USE_COUNT;
 		spin_unlock_irqrestore(&info->lock, flags);
 		return;
 	}
@@ -2026,7 +2024,6 @@
 	info->flags &= ~(ZILOG_NORMAL_ACTIVE|ZILOG_CALLOUT_ACTIVE|
 			 ZILOG_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -2233,17 +2230,14 @@
 	int 			retval, line;
 	unsigned long		page;
 
-	MOD_INC_USE_COUNT;
 	line = tty->index;
 	if ((line < 0) || (line >= zs_channels_found)) {
-		MOD_DEC_USE_COUNT;
 		return -ENODEV;
 	}
 	info = zs_soft + line;
 
 #ifdef CONFIG_KGDB
 	if (info->kgdb_channel) {
-		MOD_DEC_USE_COUNT;
 		return -ENODEV;
 	}
 #endif
@@ -2610,6 +2604,7 @@
 
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 	serial_driver.driver_name = "macserial";
 #ifdef CONFIG_DEVFS_FS
 	serial_driver.name = "tts/";

