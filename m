Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262960AbTCWIEK>; Sun, 23 Mar 2003 03:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262963AbTCWIEK>; Sun, 23 Mar 2003 03:04:10 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:60939 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262960AbTCWIDx>;
	Sun, 23 Mar 2003 03:03:53 -0500
Date: Sun, 23 Mar 2003 00:14:45 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH] Yet more i2c driver changes for 2.5.65
Message-ID: <20030323081445.GG26145@kroah.com>
References: <20030323080719.GD26145@kroah.com> <20030323081431.GF26145@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323081431.GF26145@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.354.15, 2003/03/22 23:26:58-08:00, greg@kroah.com

i2c: fix up drivers/acorn/char/i2c.c due to previous i2c changes

I'm not going to touch the other driver in this directory, as it will
need more than just minor fixups to get correct.


diff -Nru a/drivers/acorn/char/i2c.c b/drivers/acorn/char/i2c.c
--- a/drivers/acorn/char/i2c.c	Sun Mar 23 00:10:55 2003
+++ b/drivers/acorn/char/i2c.c	Sun Mar 23 00:10:55 2003
@@ -303,11 +303,13 @@
 }
 
 static struct i2c_adapter ioc_ops = {
-	.name			= "IOC/IOMD",
 	.id			= I2C_HW_B_IOC,
 	.algo_data		= &ioc_data,
 	.client_register	= ioc_client_reg,
 	.client_unregister	= ioc_client_unreg
+	.dev			= {
+		.name		= "IOC/IOMD",
+	},
 };
 
 static int __init i2c_ioc_init(void)
