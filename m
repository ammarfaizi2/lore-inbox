Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUJTAxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUJTAxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUJTAvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:51:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:2228 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266748AbUJTAT2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:28 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315043635@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:24 -0700
Message-Id: <10982315043501@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1867.7.4, 2004/09/14 10:52:06-07:00, khali@linux-fr.org

[PATCH] I2C: Update Documentation/i2c/writing-clients

This is a very small an update to Documentation/i2c/writing-clients. The
changes are about i2c client driver ID. It used to say that chip driver
writers should ask for a unique ID. It now explains that such an ID is
not required and they can go without it. Until we get plain rid of it...

The patch additionally features CodingStyle updates. We can't ask people
to respect it and at the same time ignore it in our own docs.

I have made a similar change to the i2c (the project) documentation, and
will propose an update to Marcelo for Linux 2.4 (not sure he will accept
it though).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/i2c/writing-clients |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)


diff -Nru a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
--- a/Documentation/i2c/writing-clients	2004-10-19 16:55:11 -07:00
+++ b/Documentation/i2c/writing-clients	2004-10-19 16:55:11 -07:00
@@ -24,22 +24,24 @@
 routines, a client structure specific information like the actual I2C
 address.
 
-  static struct i2c_driver foo_driver = {
-    .owner          = THIS_MODULE,
-    .name           = "Foo version 2.3 driver",
-    .id             = I2C_DRIVERID_FOO, /* usually from i2c-id.h */
-    .flags          = I2C_DF_NOTIFY,
-    .attach_adapter = &foo_attach_adapter,
-    .detach_client  = &foo_detach_client,
-    .command        = &foo_command /* may be NULL */
-  }
+static struct i2c_driver foo_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "Foo version 2.3 driver",
+	.id		= I2C_DRIVERID_FOO, /* from i2c-id.h, optional */
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= &foo_attach_adapter,
+	.detach_client	= &foo_detach_client,
+	.command	= &foo_command /* may be NULL */
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

