Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVHKVgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVHKVgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVHKVgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:36:16 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:10253 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932163AbVHKVgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:36:15 -0400
Date: Thu, 11 Aug 2005 23:36:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] (2/7) I2C: Kill i2c_algorithm.id
Message-Id: <20050811233649.472cfa05.khali@linux-fr.org>
In-Reply-To: <20050811231828.3e7f5837.khali@linux-fr.org>
References: <20050811231828.3e7f5837.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the adapter id rather than the algorithm id to detect the i2c-isa
pseudo-adapter. This saves one level of dereferencing, and the
algorithm ids will soon be gone anyway.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/busses/i2c-isa.c |    1 +
 include/linux/i2c-isa.h      |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.13-rc5.orig/drivers/i2c/busses/i2c-isa.c	2005-08-02 20:30:04.000000000 +0200
+++ linux-2.6.13-rc5/drivers/i2c/busses/i2c-isa.c	2005-08-02 20:30:24.000000000 +0200
@@ -50,6 +50,7 @@
 /* There can only be one... */
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
+	.id		= I2C_ALGO_ISA | I2C_HW_ISA,
 	.class          = I2C_CLASS_HWMON,
 	.algo		= &isa_algorithm,
 	.name		= "ISA main adapter",
--- linux-2.6.13-rc5.orig/include/linux/i2c-isa.h	2005-08-02 20:30:04.000000000 +0200
+++ linux-2.6.13-rc5/include/linux/i2c-isa.h	2005-08-02 20:30:24.000000000 +0200
@@ -28,9 +28,9 @@
 
 /* Detect whether we are on the isa bus. This is only useful to hybrid
    (i2c+isa) drivers. */
-#define i2c_is_isa_client(clientptr) \
-        ((clientptr)->adapter->algo->id == I2C_ALGO_ISA)
 #define i2c_is_isa_adapter(adapptr) \
-        ((adapptr)->algo->id == I2C_ALGO_ISA)
+        ((adapptr)->id == (I2C_ALGO_ISA | I2C_HW_ISA))
+#define i2c_is_isa_client(clientptr) \
+        i2c_is_isa_adapter((clientptr)->adapter)
 
 #endif /* _LINUX_I2C_ISA_H */

-- 
Jean Delvare
