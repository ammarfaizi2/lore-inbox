Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVGSWLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVGSWLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 18:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVGSWLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 18:11:17 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:56082 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S262021AbVGSWIy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 18:08:54 -0400
Date: Wed, 20 Jul 2005 00:09:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (9/9)
Message-Id: <20050720000903.2f2cf8e3.khali@linux-fr.org>
In-Reply-To: <20050719233902.40282559.khali@linux-fr.org>
References: <20050719233902.40282559.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the definitions of i2c_is_isa_client and i2c_is_isa_adapter from
i2c.h to i2c-isa.h. Only hybrid drivers still need them.

 include/linux/i2c-isa.h |    7 +++++++
 include/linux/i2c.h     |    7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.13-rc3.orig/include/linux/i2c-isa.h	2005-07-16 18:46:37.000000000 +0200
+++ linux-2.6.13-rc3/include/linux/i2c-isa.h	2005-07-17 16:45:22.000000000 +0200
@@ -26,4 +26,11 @@
 extern int i2c_isa_add_driver(struct i2c_driver *driver);
 extern int i2c_isa_del_driver(struct i2c_driver *driver);
 
+/* Detect whether we are on the isa bus. This is only useful to hybrid
+   (i2c+isa) drivers. */
+#define i2c_is_isa_client(clientptr) \
+        ((clientptr)->adapter->algo->id == I2C_ALGO_ISA)
+#define i2c_is_isa_adapter(adapptr) \
+        ((adapptr)->algo->id == I2C_ALGO_ISA)
+
 #endif /* _LINUX_I2C_ISA_H */
--- linux-2.6.13-rc3.orig/include/linux/i2c.h	2005-07-17 15:26:30.000000000 +0200
+++ linux-2.6.13-rc3/include/linux/i2c.h	2005-07-17 16:44:40.000000000 +0200
@@ -575,11 +575,4 @@
 			.force =		force,			\
 		}
 
-/* Detect whether we are on the isa bus. If this returns true, all i2c
-   access will fail! */
-#define i2c_is_isa_client(clientptr) \
-        ((clientptr)->adapter->algo->id == I2C_ALGO_ISA)
-#define i2c_is_isa_adapter(adapptr) \
-        ((adapptr)->algo->id == I2C_ALGO_ISA)
-
 #endif /* _LINUX_I2C_H */


-- 
Jean Delvare
