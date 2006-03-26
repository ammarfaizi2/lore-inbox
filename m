Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWCZMY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWCZMY0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWCZMYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:24:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57604 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751293AbWCZMYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:24:23 -0500
Date: Sun, 26 Mar 2006 14:24:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: tim@cyberelk.net, linux-parport@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/paride/pd.c: fix an off-by-one error
Message-ID: <20060326122421.GH4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found this off-by-one error.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 11 Mar 2006

 drivers/block/paride/pd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc5-mm3-full/drivers/block/paride/pd.c.old	2006-03-11 02:07:21.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/block/paride/pd.c	2006-03-11 15:36:00.000000000 +0100
@@ -151,6 +151,7 @@ enum {D_PRT, D_PRO, D_UNI, D_MOD, D_GEO,
 #include <linux/cdrom.h>	/* for the eject ioctl */
 #include <linux/blkdev.h>
 #include <linux/blkpg.h>
+#include <linux/kernel.h>
 #include <asm/uaccess.h>
 #include <linux/sched.h>
 #include <linux/workqueue.h>
@@ -275,7 +276,7 @@ static void pd_print_error(struct pd_uni
 	int i;
 
 	printk("%s: %s: status = 0x%x =", disk->name, msg, status);
-	for (i = 0; i < 18; i++)
+	for (i = 0; i < ARRAY_SIZE(pd_errs); i++)
 		if (status & (1 << i))
 			printk(" %s", pd_errs[i]);
 	printk("\n");

