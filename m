Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbTCYB22>; Mon, 24 Mar 2003 20:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbTCYB22>; Mon, 24 Mar 2003 20:28:28 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:11280 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261321AbTCYB2B>;
	Mon, 24 Mar 2003 20:28:01 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.66
In-reply-to: <10485563141404@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Mar 2003 17:38 -0800
Message-id: <10485563161165@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.355.15, 2003/03/22 23:26:58-08:00, greg@kroah.com

i2c: fix up drivers/acorn/char/i2c.c due to previous i2c changes

I'm not going to touch the other driver in this directory, as it will
need more than just minor fixups to get correct.


 drivers/acorn/char/i2c.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/acorn/char/i2c.c b/drivers/acorn/char/i2c.c
--- a/drivers/acorn/char/i2c.c	Mon Mar 24 17:27:25 2003
+++ b/drivers/acorn/char/i2c.c	Mon Mar 24 17:27:25 2003
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

