Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbTCYBcK>; Mon, 24 Mar 2003 20:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbTCYBac>; Mon, 24 Mar 2003 20:30:32 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:26640 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261346AbTCYB2J>;
	Mon, 24 Mar 2003 20:28:09 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.66
In-reply-to: <10485563242021@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Mar 2003 17:38 -0800
Message-id: <10485563252071@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.985.1.4, 2003/03/24 15:16:12-08:00, greg@kroah.com

[PATCH] i2c: set up a "generic" i2c driver to prevent oopses when devices are registering.

This is needed as we are still not using the driver core model for
matching up devices to drivers, but doing it by hand.  Once that is
changed, this will not be needed.


 drivers/i2c/i2c-core.c |    9 +++++++++
 1 files changed, 9 insertions(+)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 24 17:26:51 2003
+++ b/drivers/i2c/i2c-core.c	Mon Mar 24 17:26:51 2003
@@ -65,6 +65,14 @@
 	return 0;
 }
 
+static struct device_driver i2c_generic_driver = {
+	.name =	"i2c",
+	.bus = &i2c_bus_type,
+	.probe = i2c_device_probe,
+	.remove = i2c_device_remove,
+};
+
+
 /* ---------------------------------------------------
  * registering functions 
  * --------------------------------------------------- 
@@ -106,6 +114,7 @@
 	if (adap->dev.parent == NULL)
 		adap->dev.parent = &legacy_bus;
 	sprintf(adap->dev.bus_id, "i2c-%d", i);
+	adap->dev.driver = &i2c_generic_driver;
 	device_register(&adap->dev);
 
 	/* inform drivers of new adapters */

