Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267876AbUIPJUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267876AbUIPJUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUIPJUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:20:25 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:17118 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S267876AbUIPJUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:20:18 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 16 Sep 2004 11:08:40 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: msp3400 cleanup
Message-ID: <20040916090840.GA11471@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a minor cleanup for the msp3400.c module: use the new msleep()
function for delays.

please apply,

  Gerd

diff -up linux-2.6.9-rc2/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.9-rc2/drivers/media/video/msp3400.c	2004-09-14 10:36:32.000000000 +0200
+++ linux/drivers/media/video/msp3400.c	2004-09-16 10:06:32.000000000 +0200
@@ -191,8 +191,7 @@ msp3400c_read(struct i2c_client *client,
 		err++;
 		printk(KERN_WARNING "msp34xx: I/O error #%d (read 0x%02x/0x%02x)\n",
 		       err, dev, addr);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/10);
+		msleep(10);
 	}
 	if (3 == err) {
 		printk(KERN_WARNING "msp34xx: giving up, reseting chip. Sound will go off, sorry folks :-|\n");
@@ -220,8 +219,7 @@ msp3400c_write(struct i2c_client *client
 		err++;
 		printk(KERN_WARNING "msp34xx: I/O error #%d (write 0x%02x/0x%02x)\n",
 		       err, dev, addr);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/10);
+		msleep(10);
 	}
 	if (3 == err) {
 		printk(KERN_WARNING "msp34xx: giving up, reseting chip. Sound will go off, sorry folks :-|\n");
