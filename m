Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVLCMYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVLCMYj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 07:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVLCMYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 07:24:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60420 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751240AbVLCMYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 07:24:38 -0500
Date: Sat, 3 Dec 2005 13:24:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: markus.lidel@shadowconnect.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] make i2o_iop_free() static inline
Message-ID: <20051203122439.GE31395@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's only a micro-optimizatin, but why not save a few bytes?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc3-mm1/drivers/message/i2o/core.h.old	2005-12-03 02:47:00.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/message/i2o/core.h	2005-12-03 02:49:05.000000000 +0100
@@ -38,7 +38,15 @@
 
 /* IOP */
 extern struct i2o_controller *i2o_iop_alloc(void);
-extern void i2o_iop_free(struct i2o_controller *);
+
+/**
+ *	i2o_iop_free - Free the i2o_controller struct
+ *	@c: I2O controller to free
+ */
+static inline void i2o_iop_free(struct i2o_controller *c)
+{
+	kfree(c);
+}
 
 extern int i2o_iop_add(struct i2o_controller *);
 extern void i2o_iop_remove(struct i2o_controller *);
--- linux-2.6.15-rc3-mm1/drivers/message/i2o/iop.c.old	2005-12-03 02:47:14.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/message/i2o/iop.c	2005-12-03 02:48:21.000000000 +0100
@@ -1051,15 +1051,6 @@
 }
 
 /**
- *	i2o_iop_free - Free the i2o_controller struct
- *	@c: I2O controller to free
- */
-void i2o_iop_free(struct i2o_controller *c)
-{
-	kfree(c);
-};
-
-/**
  *	i2o_iop_release - release the memory for a I2O controller
  *	@dev: I2O controller which should be released
  *

