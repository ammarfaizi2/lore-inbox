Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVAPTt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVAPTt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVAPTt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:49:27 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:54283 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262598AbVAPTrb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:47:31 -0500
Date: Sun, 16 Jan 2005 20:49:58 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.6] I2C: Kill i2c_client.id (5/5)
Message-Id: <20050116204958.1bc0ed5f.khali@linux-fr.org>
In-Reply-To: <20050116194653.17c96499.khali@linux-fr.org>
References: <20050116194653.17c96499.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (5/5) Documentation update.

Finally, updates are required to the i2c/writing-client and
i2c/porting-client documents. Remove any reference to i2c_client id and
invite porters to discard that struct member.

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.11-rc1.orig/Documentation/i2c/porting-clients linux-2.6.11-rc1/Documentation/i2c/porting-clients
--- linux-2.6.11-rc1.orig/Documentation/i2c/porting-clients	2004-12-24 22:34:27.000000000 +0100
+++ linux-2.6.11-rc1/Documentation/i2c/porting-clients	2005-01-16 18:33:55.000000000 +0100
@@ -49,9 +49,8 @@
   static void lm75_update_client(struct i2c_client *client);
 
 * [Sysctl] All sysctl stuff is of course gone (defines, ctl_table
-  and functions). Instead, right after the static id definition
-  line, you have to define show and set functions for each sysfs
-  file. Only define set for writable values. Take a look at an
+  and functions). Instead, you have to define show and set functions for
+  each sysfs file. Only define set for writable values. Take a look at an
   existing 2.6 driver for details (lm78 for example). Don't forget
   to define the attributes for each file (this is that step that
   links callback functions). Use the file names specified in
@@ -86,6 +85,7 @@
   Replace the sysctl directory registration by calls to
   device_create_file. Move the driver initialization before any
   sysfs file creation.
+  Drop client->id.
 
 * [Init] Limits must not be set by the driver (can be done later in
   user-space). Chip should not be reset default (although a module
diff -ruN linux-2.6.11-rc1.orig/Documentation/i2c/writing-clients linux-2.6.11-rc1/Documentation/i2c/writing-clients
--- linux-2.6.11-rc1.orig/Documentation/i2c/writing-clients	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.11-rc1/Documentation/i2c/writing-clients	2005-01-16 12:50:29.000000000 +0100
@@ -344,9 +344,6 @@
 
 For now, you can ignore the `flags' parameter. It is there for future use.
 
-  /* Unique ID allocation */
-  static int foo_id = 0;
-
   int foo_detect_client(struct i2c_adapter *adapter, int address, 
                         unsigned short flags, int kind)
   {
@@ -482,7 +479,6 @@
     data->type = kind;
     /* SENSORS ONLY END */
 
-    new_client->id = foo_id++; /* Automatically unique */
     data->valid = 0; /* Only if you use this field */
     init_MUTEX(&data->update_lock); /* Only if you use this field */
 


-- 
Jean Delvare
http://khali.linux-fr.org/
