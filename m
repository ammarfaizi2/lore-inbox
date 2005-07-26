Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVGZWdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVGZWdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVGZWdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:33:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:52460 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262306AbVGZWcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:32:52 -0400
Subject: patch i2c-hwmon-split-09.patch added to gregkh-2.6 tree
To: khali@linux-fr.org, greg@kroah.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
From: <gregkh@suse.de>
Date: Tue, 26 Jul 2005 15:33:18 -0700
In-Reply-To: <20050720000903.2f2cf8e3.khali@linux-fr.org>
Message-ID: <1DxXzD-0g7-00@press.kroah.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C: Separate non-i2c hwmon drivers from i2c-core (9/9)

to my gregkh-2.6 tree.  Its filename is

     i2c-hwmon-split-09.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from khali@linux-fr.org are

i2c/i2c-max6875-documentation-update.patch
i2c/i2c-max6875-simplify.patch
i2c/i2c-hwmon-class-01.patch
i2c/i2c-hwmon-class-02.patch
i2c/i2c-hwmon-class-03.patch
i2c/i2c-missing-space.patch
i2c/i2c-nforce2-cleanup.patch
i2c/i2c-hwmon-split-01.patch
i2c/i2c-hwmon-split-02.patch
i2c/i2c-hwmon-split-03.patch
i2c/i2c-hwmon-split-04.patch
i2c/i2c-hwmon-split-05.patch
i2c/i2c-hwmon-split-06.patch
i2c/i2c-hwmon-split-07.patch
i2c/i2c-hwmon-split-08.patch
i2c/i2c-hwmon-split-09.patch


>From khali@linux-fr.org Tue Jul 19 18:12:04 2005
Date: Wed, 20 Jul 2005 00:09:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>, LM Sensors
 <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: I2C: Separate non-i2c hwmon drivers from i2c-core (9/9)
Message-Id: <20050720000903.2f2cf8e3.khali@linux-fr.org>

Move the definitions of i2c_is_isa_client and i2c_is_isa_adapter from
i2c.h to i2c-isa.h. Only hybrid drivers still need them.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/i2c-isa.h |    7 +++++++
 include/linux/i2c.h     |    7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

--- gregkh-2.6.orig/include/linux/i2c-isa.h	2005-07-26 15:14:08.000000000 -0700
+++ gregkh-2.6/include/linux/i2c-isa.h	2005-07-26 15:16:51.000000000 -0700
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
--- gregkh-2.6.orig/include/linux/i2c.h	2005-07-26 15:16:45.000000000 -0700
+++ gregkh-2.6/include/linux/i2c.h	2005-07-26 15:16:51.000000000 -0700
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
