Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265832AbTL3WIt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265853AbTL3WHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:07:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:46785 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265280AbTL3WG2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:28 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219702169@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:10 -0800
Message-Id: <10728219704116@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.6.3, 2003/12/04 00:44:29-08:00, khali@linux-fr.org

[PATCH] I2C: i2c documentation (2 of 2)

This is a patch to writing-clients. The current version in Linux 2.6
still mentions the old module reference counting mechanism. The patch
brings it to the same version we have in i2c CVS, where that section has
been updated.


 Documentation/i2c/writing-clients |   57 ++++++--------------------------------
 1 files changed, 10 insertions(+), 47 deletions(-)


diff -Nru a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
--- a/Documentation/i2c/writing-clients	Tue Dec 30 12:32:43 2003
+++ b/Documentation/i2c/writing-clients	Tue Dec 30 12:32:43 2003
@@ -24,16 +24,14 @@
 routines, a client structure specific information like the actual I2C
 address.
 
-  struct i2c_driver foo_driver
-  {  
-    /* name           */  "Foo version 2.3 and later driver",
-    /* id             */  I2C_DRIVERID_FOO,
-    /* flags          */  I2C_DF_NOTIFY,
-    /* attach_adapter */  &foo_attach_adapter,
-    /* detach_client  */  &foo_detach_client,
-    /* command        */  &foo_command,   /* May be NULL */
-    /* inc_use        */  &foo_inc_use,   /* May be NULL */
-    /* dec_use        */  &foo_dec_use    /* May be NULL */
+  static struct i2c_driver foo_driver = {
+    .owner          = THIS_MODULE,
+    .name           = "Foo version 2.3 driver",
+    .id             = I2C_DRIVERID_FOO, /* usually from i2c-id.h */
+    .flags          = I2C_DF_NOTIFY,
+    .attach_adapter = &foo_attach_adapter,
+    .detach_client  = &foo_detach_client,
+    .command        = &foo_command /* may be NULL */
   }
  
 The name can be chosen freely, and may be upto 40 characters long. Please
@@ -50,43 +48,8 @@
 All other fields are for call-back functions which will be explained 
 below.
 
-
-Module usage count
-==================
-
-If your driver can also be compiled as a module, there are moments at 
-which the module can not be removed from memory. For example, when you
-are doing a lengthy transaction, or when you create a /proc directory,
-and some process has entered that directory (this last case is the
-main reason why these call-backs were introduced).
-
-To increase or decrease the module usage count, you can use the
-MOD_{INC,DEC}_USE_COUNT macros. They must be called from the module
-which needs to get its usage count changed; that is why each driver
-module has to implement its own callback.
-
-  void foo_inc_use (struct i2c_client *client)
-  {
-  #ifdef MODULE
-    MOD_INC_USE_COUNT;
-  #endif
-  }
-
-  void foo_dec_use (struct i2c_client *client)
-  {
-  #ifdef MODULE
-    MOD_DEC_USE_COUNT;
-  #endif
-  }
-
-Do not call these call-back functions directly; instead, use one of the
-following functions defined in i2c.h:
-  void i2c_inc_use_client(struct i2c_client *);
-  void i2c_dec_use_client(struct i2c_client *);
-
-You should *not* increase the module count just because a device is
-detected and a client created. This would make it impossible to remove
-an adapter driver! 
+There use to be two additional fields in this structure, inc_use et dec_use,
+for module usage count, but these fields were obsoleted and removed.
 
 
 Extra client data

