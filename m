Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263220AbTDCAHl>; Wed, 2 Apr 2003 19:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263237AbTDCAHk>; Wed, 2 Apr 2003 19:07:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:46334 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263220AbTDCACN> convert rfc822-to-8bit; Wed, 2 Apr 2003 19:02:13 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10493289583383@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <10493289572106@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:58 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.977.29.4, 2003/04/01 11:48:21-08:00, greg@kroah.com

[PATCH] i2c: change the way i2c creates the bus ids to actually be unique now.

It also is much like the old naming scheme, to keep things consistent.


 drivers/i2c/i2c-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Wed Apr  2 16:01:44 2003
+++ b/drivers/i2c/i2c-core.c	Wed Apr  2 16:01:44 2003
@@ -392,7 +392,8 @@
 	client->dev.driver = &client->driver->driver;
 	client->dev.bus = &i2c_bus_type;
 	
-	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id), "i2c_dev_%d", i);
+	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id),
+		"%d-%04x", i2c_adapter_id(adapter), client->addr);
 	printk("registering %s\n", client->dev.bus_id);
 	device_register(&client->dev);
 	

