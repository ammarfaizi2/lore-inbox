Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbUKHJcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUKHJcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbUKHJcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:32:02 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:22238 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261809AbUKHJEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:04:08 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:54:20 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: msp3400 fix
Message-ID: <20041108085420.GA19347@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for the msp3400 module: make the initial carrier scan
(after loading the driver) work.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/msp3400.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -u linux-2.6.10/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.10/drivers/media/video/msp3400.c	2004-11-07 12:23:12.256678404 +0100
+++ linux/drivers/media/video/msp3400.c	2004-11-07 16:08:43.247733306 +0100
@@ -1426,6 +1426,8 @@
 static int msp_suspend(struct device * dev, u32 state, u32 level);
 static int msp_resume(struct device * dev, u32 level);
 
+static void msp_wake_thread(struct i2c_client *client);
+
 static struct i2c_driver driver = {
 	.owner          = THIS_MODULE,
 	.name           = "i2c msp3400 driver",
@@ -1550,7 +1552,7 @@
 		msp->kthread = kthread_run(thread_func, c, "msp34xx");
 		if (NULL == msp->kthread)
 			printk(KERN_WARNING "msp34xx: kernel_thread() failed\n");
-		wake_up_interruptible(&msp->wq);
+		msp_wake_thread(c);
 	}
 
 	/* done */

-- 
#define printk(args...) fprintf(stderr, ## args)
