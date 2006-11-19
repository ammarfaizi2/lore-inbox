Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933238AbWKSUgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933238AbWKSUgx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933244AbWKSUgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:36:53 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:17491 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933238AbWKSUgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:36:52 -0500
Date: Sun, 19 Nov 2006 12:36:48 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: markus.lidel@shadowconnect.com, akpm <akpm@osdl.org>
Subject: [PATCH] I2O: fix I2O_CONFIG without Adaptec extension
Message-Id: <20061119123648.747c9e78.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

With I2O_CONFIG=y and I2O_EXT_ADAPTEC=n, kernel build gets:

drivers/message/i2o/i2o_config.c:1115: error: 'i2o_cfg_compat_ioctl' undeclared here (not in a function)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/message/i2o/i2o_config.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2619-rc6g2.orig/drivers/message/i2o/i2o_config.c
+++ linux-2619-rc6g2/drivers/message/i2o/i2o_config.c
@@ -516,7 +516,6 @@ static int i2o_cfg_evt_get(unsigned long
 	return 0;
 }
 
-#ifdef CONFIG_I2O_EXT_ADAPTEC
 #ifdef CONFIG_COMPAT
 static int i2o_cfg_passthru32(struct file *file, unsigned cmnd,
 			      unsigned long arg)
@@ -759,6 +758,7 @@ static long i2o_cfg_compat_ioctl(struct 
 
 #endif
 
+#ifdef CONFIG_I2O_EXT_ADAPTEC
 static int i2o_cfg_passthru(unsigned long arg)
 {
 	struct i2o_cmd_passthru __user *cmd =


---
