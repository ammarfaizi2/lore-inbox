Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263051AbTDBQ33>; Wed, 2 Apr 2003 11:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263055AbTDBQ33>; Wed, 2 Apr 2003 11:29:29 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:23269 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263051AbTDBQ31>; Wed, 2 Apr 2003 11:29:27 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 2 Apr 2003 18:51:16 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Frank Davis <fdavis@si.rr.com>
Subject: [patch] add i2c_clientname()
Message-ID: <20030402165116.GA24766@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch just adds a #define and a inline function to hide the
"i2c_client->name" => "i2c_client->dev.name" move introduced by
the recent i2c updates.  That makes it easier to build i2c drivers
on both 2.4 and 2.5 kernels.

  Gerd

diff -u linux-2.5.66/include/linux/i2c.h linux/include/linux/i2c.h
--- linux-2.5.66/include/linux/i2c.h	2003-04-02 11:42:19.455041606 +0200
+++ linux/include/linux/i2c.h	2003-04-02 11:49:36.479533709 +0200
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

-- 
Michael Moore for president!
