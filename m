Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269665AbUINUdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269665AbUINUdR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269494AbUINUaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:30:16 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:1031 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S269699AbUINUXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:23:35 -0400
Date: Tue, 14 Sep 2004 22:22:34 +0200
From: Jean Delvare <khali@linux-fr.org>
To: marcelo.tosatti@cyclades.com
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Update Documentation/i2c/writing-clients
Message-Id: <20040914222234.4263afaf.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

This is a quick update to the Documentation/i2c/writing-clients file. A
similar change was accepted by Greg KH in 2.6 and was also applied to
the i2c CVS repository.

The changes are about i2c client driver IDs. It used to say that chip
driver writers should ask for a unique ID. It now explains that such an
ID is not required and they can go without it. The patch additionally
features CodingStyle updates.

Fell free to apply it if you want,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.4.28-pre3/Documentation/i2c/writing-clients.orig	2004-09-14 21:46:41.000000000 +0200
+++ linux-2.4.28-pre3/Documentation/i2c/writing-clients	2004-09-14 22:15:14.000000000 +0200
@@ -24,24 +24,25 @@
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
-  }
+static struct i2c_driver foo_driver = {
+	.name		= "Foo version 2.3 driver",
+	.id		= I2C_DRIVERID_FOO, /* from i2c-id.h, optional */
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= &foo_attach_adapter,
+	.detach_client	= &foo_detach_client,
+	.command	= &foo_command, /* may be NULL */
+	.inc_use	= &foo_inc_use, /* May be NULL */
+	.dec_use	= &foo_dec_use, /* May be NULL */
+}
  
 The name can be chosen freely, and may be upto 40 characters long. Please
 use something descriptive here.
 
-The id should be a unique ID. The range 0xf000 to 0xffff is reserved for
-local use, and you can use one of those until you start distributing the
-driver. Before you do that, contact the i2c authors to get your own ID(s).
+If used, the id should be a unique ID. The range 0xf000 to 0xffff is
+reserved for local use, and you can use one of those until you start
+distributing the driver, at which time you should contact the i2c authors
+to get your own ID(s). Note that most of the time you don't need an ID
+at all so you can just omit it.
 
 Don't worry about the flags field; just put I2C_DF_NOTIFY into it. This
 means that your driver will be notified when new adapters are found.


-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
