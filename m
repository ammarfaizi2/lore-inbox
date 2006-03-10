Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbWCJSEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWCJSEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 13:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWCJSEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 13:04:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44305 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751565AbWCJSEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 13:04:39 -0500
Date: Fri, 10 Mar 2006 19:04:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: wim@iguana.be
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/watchdog/pcwd_usb.c: fix a NULL pointer dereference
Message-ID: <20060310180438.GQ21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noted that this resulted in a NULL pointer 
reference if we were coming from

        if (usb_pcwd == NULL) {
                printk(KERN_ERR PFX "Out of memory\n");
                goto error;
        }


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/char/watchdog/pcwd_usb.c.old	2006-03-10 18:18:00.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/char/watchdog/pcwd_usb.c	2006-03-10 18:18:45.000000000 +0100
@@ -705,7 +705,8 @@ err_out_misc_deregister:
 err_out_unregister_reboot:
 	unregister_reboot_notifier(&usb_pcwd_notifier);
 error:
-	usb_pcwd_delete (usb_pcwd);
+	if (usb_pcwd)
+		usb_pcwd_delete(usb_pcwd);
 	usb_pcwd_device = NULL;
 	return retval;
 }

