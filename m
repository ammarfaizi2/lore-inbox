Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTEGX0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTEGXEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:04:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:14824 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264325AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493872739@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493873716@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1101, 2003/05/07 15:00:03-07:00, hannal@us.ibm.com

[PATCH] pcxx tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/pcxx.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)


diff -Nru a/drivers/char/pcxx.c b/drivers/char/pcxx.c
--- a/drivers/char/pcxx.c	Wed May  7 16:01:05 2003
+++ b/drivers/char/pcxx.c	Wed May  7 16:01:05 2003
@@ -431,8 +431,6 @@
 		return(-ENODEV);
 	}
 
-	/* flag the kernel that there is somebody using this guy */
-	MOD_INC_USE_COUNT;
 	/*
 	 * If the device is in the middle of being closed, then block
 	 * until it's done, and then try again.
@@ -576,7 +574,6 @@
 
 		if(tty_hung_up_p(filp)) {
 			/* flag that somebody is done with this module */
-			MOD_DEC_USE_COUNT;
 			restore_flags(flags);
 			return;
 		}
@@ -594,7 +591,6 @@
 		}
 		if (info->count-- > 1) {
 			restore_flags(flags);
-			MOD_DEC_USE_COUNT;
 			return;
 		}
 		if (info->count < 0) {
@@ -651,7 +647,6 @@
 		info->asyncflags &= ~(ASYNC_NORMAL_ACTIVE|
 							  ASYNC_CALLOUT_ACTIVE|ASYNC_CLOSING);
 		wake_up_interruptible(&info->close_wait);
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 	}
 }
@@ -1228,6 +1223,7 @@
 
 	memset(&pcxe_driver, 0, sizeof(struct tty_driver));
 	pcxe_driver.magic = TTY_DRIVER_MAGIC;
+	pcxe_driver.owner = THIS_MODULE;
 	pcxe_driver.name = "ttyD";
 	pcxe_driver.major = DIGI_MAJOR; 
 	pcxe_driver.minor_start = 0;

