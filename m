Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261351AbTCYBoa>; Mon, 24 Mar 2003 20:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261323AbTCYB2d>; Mon, 24 Mar 2003 20:28:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:12816 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261326AbTCYB2C>;
	Mon, 24 Mar 2003 20:28:02 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.66
In-reply-to: <10485563161329@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Mar 2003 17:38 -0800
Message-id: <10485563181803@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.357.1, 2003/03/21 12:29:44-08:00, vandrove@vc.cvut.cz

[PATCH] Fix kobject_get oopses triggered by i2c in 2.5.65-bk

i2c initialization must not use module_init now, when it was converted
to the kobject interface. There are dozens of users which need it working
much sooner. i2c is subsystem after all, isn't it?

Fixes kernel oopses in kobject_get during system init which were happening
to me.


 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 24 17:28:49 2003
+++ b/drivers/i2c/i2c-core.c	Mon Mar 24 17:28:49 2003
@@ -675,7 +675,7 @@
 	bus_unregister(&i2c_bus_type);
 }
 
-module_init(i2c_init);
+subsys_initcall(i2c_init);
 module_exit(i2c_exit);
 
 /* ----------------------------------------------------

