Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWIZEum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWIZEum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 00:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWIZEum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 00:50:42 -0400
Received: from xenotime.net ([66.160.160.81]:61414 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750767AbWIZEul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 00:50:41 -0400
Date: Mon, 25 Sep 2006 21:51:47 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: v4l-dvb-maintainer@linuxtv.org, lkml <linux-kernel@vger.kernel.org>
Cc: isely@pobox.com, akpm <akpm@osdl.org>, alannisota@gmail.com,
       jelle@foks.8m.com, kraxel@bytesex.org
Subject: [PATCH] drivers/media: use NULL instead of 0 for ptrs
Message-Id: <20060925215147.1a9f6a42.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Use NULL instead of 0 for pointer value, eliminate sparse warnings.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/media/dvb/dvb-usb/gp8psk.c                   |    2 +-
 drivers/media/video/cx88/cx88-blackbird.c            |    2 +-
 drivers/media/video/pvrusb2/pvrusb2-i2c-chips-v4l2.c |    4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

--- linux-2618-g4.orig/drivers/media/dvb/dvb-usb/gp8psk.c
+++ linux-2618-g4/drivers/media/dvb/dvb-usb/gp8psk.c
@@ -217,7 +217,7 @@ static struct dvb_usb_properties gp8psk_
 		  .cold_ids = { &gp8psk_usb_table[0], NULL },
 		  .warm_ids = { &gp8psk_usb_table[1], NULL },
 		},
-		{ 0 },
+		{ NULL },
 	}
 };
 
--- linux-2618-g4.orig/drivers/media/video/cx88/cx88-blackbird.c
+++ linux-2618-g4/drivers/media/video/cx88/cx88-blackbird.c
@@ -896,7 +896,7 @@ static int mpeg_do_ioctl(struct inode *i
 		snprintf(name, sizeof(name), "%s/2", core->name);
 		printk("%s/2: ============  START LOG STATUS  ============\n",
 		       core->name);
-		cx88_call_i2c_clients(core, VIDIOC_LOG_STATUS, 0);
+		cx88_call_i2c_clients(core, VIDIOC_LOG_STATUS, NULL);
 		cx2341x_log_status(&dev->params, name);
 		printk("%s/2: =============  END LOG STATUS  =============\n",
 		       core->name);
--- linux-2618-g4.orig/drivers/media/video/pvrusb2/pvrusb2-i2c-chips-v4l2.c
+++ linux-2618-g4/drivers/media/video/pvrusb2/pvrusb2-i2c-chips-v4l2.c
@@ -19,6 +19,7 @@
  *
  */
 
+#include <linux/kernel.h>
 #include "pvrusb2-i2c-core.h"
 #include "pvrusb2-hdw-internal.h"
 #include "pvrusb2-debug.h"
@@ -93,7 +94,8 @@ void pvr2_i2c_probe(struct pvr2_hdw *hdw
 
 const struct pvr2_i2c_op *pvr2_i2c_get_op(unsigned int idx)
 {
-	if (idx >= sizeof(ops)/sizeof(ops[0])) return 0;
+	if (idx >= ARRAY_SIZE(ops))
+		return NULL;
 	return ops[idx];
 }
 


---
