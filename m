Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbTDIWTT (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTDIWRs (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:17:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:27323 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263875AbTDIWRk convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:17:40 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10499274991641@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.67
In-Reply-To: <10499274991425@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Apr 2003 15:31:39 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1133.1.2, 2003/04/08 02:48:29-07:00, kraxel@bytesex.org

[PATCH] i2c: add i2c_clientname()

This patch just adds a #define and a inline function to hide the
"i2c_client->name" => "i2c_client->dev.name" move introduced by
the recent i2c updates.  That makes it easier to build i2c drivers
on both 2.4 and 2.5 kernels.


 include/linux/i2c.h |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Wed Apr  9 15:16:15 2003
+++ b/include/linux/i2c.h	Wed Apr  9 15:16:15 2003
@@ -182,6 +182,13 @@
 	return dev_set_drvdata (&dev->dev, data);
 }
 
+#define I2C_DEVNAME(str)   .dev = { .name = str }
+
+static inline char *i2c_clientname(struct i2c_client *c)
+{
+	return c->dev.name;
+}
+
 /*
  * The following structs are for those who like to implement new bus drivers:
  * i2c_algorithm is the interface to a class of hardware solutions which can

