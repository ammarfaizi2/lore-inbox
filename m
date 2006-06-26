Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWFZVrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWFZVrm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWFZVrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:47:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27150 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751089AbWFZVrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:47:42 -0400
Date: Mon, 26 Jun 2006 23:47:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: markus.lidel@shadowconnect.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] proper prototype for drivers/message/i2o/device.c:i2o_parm_issue()
Message-ID: <20060626214739.GG23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a proper protorype for i2o_parm_issue() in core.h.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/message/i2o/core.h       |    3 +++
 drivers/message/i2o/i2o_config.c |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm2-full/drivers/message/i2o/core.h.old	2006-06-26 23:16:01.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/message/i2o/core.h	2006-06-26 23:16:39.000000000 +0200
@@ -38,6 +38,9 @@
 extern void i2o_device_remove(struct i2o_device *);
 extern int i2o_device_parse_lct(struct i2o_controller *);
 
+int i2o_parm_issue(struct i2o_device *i2o_dev, int cmd, void *oplist,
+		   int oplen, void *reslist, int reslen);
+
 /* IOP */
 extern struct i2o_controller *i2o_iop_alloc(void);
 
--- linux-2.6.17-mm2-full/drivers/message/i2o/i2o_config.c.old	2006-06-26 23:16:54.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/message/i2o/i2o_config.c	2006-06-26 23:23:25.000000000 +0200
@@ -36,9 +36,9 @@
 
 #include <asm/uaccess.h>
 
-#define SG_TABLESIZE		30
+#include "core.h"
 
-extern int i2o_parm_issue(struct i2o_device *, int, void *, int, void *, int);
+#define SG_TABLESIZE		30
 
 static int i2o_cfg_ioctl(struct inode *, struct file *, unsigned int,
 			 unsigned long);

