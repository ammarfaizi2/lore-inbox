Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbTEGXSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTEGXEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:04:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:49799 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264327AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493881375@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493882505@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1110, 2003/05/07 15:01:32-07:00, hannal@us.ibm.com

[PATCH] cyclades tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/cyclades.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)


diff -Nru a/drivers/char/cyclades.c b/drivers/char/cyclades.c
--- a/drivers/char/cyclades.c	Wed May  7 16:00:25 2003
+++ b/drivers/char/cyclades.c	Wed May  7 16:00:25 2003
@@ -2579,15 +2579,12 @@
   int retval, line;
   unsigned long page;
 
-    MOD_INC_USE_COUNT;
     line = tty->index;
     if ((line < 0) || (NR_PORTS <= line)){
-	MOD_DEC_USE_COUNT;
         return -ENODEV;
     }
     info = &cy_port[line];
     if (info->line < 0){
-	MOD_DEC_USE_COUNT;
         return -ENODEV;
     }
     
@@ -2607,7 +2604,6 @@
 	    } else {
 		printk("cyc:Cyclades-Z firmware not yet loaded\n");
 	    }
-	    MOD_DEC_USE_COUNT;
 	    return -ENODEV;
 	}
 #ifdef CONFIG_CYZ_INTR
@@ -2803,7 +2799,6 @@
     CY_LOCK(info, flags);
     /* If the TTY is being hung up, nothing to do */
     if (tty_hung_up_p(filp)) {
-	MOD_DEC_USE_COUNT;
 	CY_UNLOCK(info, flags);
         return;
     }
@@ -2834,7 +2829,6 @@
         info->count = 0;
     }
     if (info->count) {
-	MOD_DEC_USE_COUNT;
 	CY_UNLOCK(info, flags);
         return;
     }
@@ -2931,7 +2925,6 @@
     printk(" cyc:cy_close done\n");
 #endif
 
-    MOD_DEC_USE_COUNT;
     CY_UNLOCK(info, flags);
     return;
 } /* cy_close */
@@ -5494,6 +5487,7 @@
     
     memset(&cy_serial_driver, 0, sizeof(struct tty_driver));
     cy_serial_driver.magic = TTY_DRIVER_MAGIC;
+    cy_serial_driver.owner = THIS_MODULE;
     cy_serial_driver.driver_name = "cyclades";
     cy_serial_driver.name = "ttyC";
     cy_serial_driver.major = CYCLADES_MAJOR;

