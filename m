Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTIEPih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbTIEPg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:36:59 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:60504 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262843AbTIEPgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:36:53 -0400
Subject: [PATCH] 2.6.0-test4 synclink_cs.c
From: Paul Fulghum <paulkf@microgate.com>
To: "torvalds@osdl.org" <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1062776201.2675.7.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Sep 2003 10:36:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* replace previously removed NULL context check
  (causes oops when opening non existent device)

Please apply.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


--- linux-2.6.0-test4/drivers/char/pcmcia/synclink_cs.c	2003-09-05 10:25:25.000000000 -0500
+++ linux-2.6.0-test4-mg/drivers/char/pcmcia/synclink_cs.c	2003-09-05 10:27:04.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/pcmcia/synclink_cs.c
  *
- * $Id: synclink_cs.c,v 4.13 2003/06/18 15:29:32 paulkf Exp $
+ * $Id: synclink_cs.c,v 4.15 2003/09/05 15:26:02 paulkf Exp $
  *
  * Device driver for Microgate SyncLink PC Card
  * multiprotocol serial adapter.
@@ -491,7 +491,7 @@
 MODULE_LICENSE("GPL");
 
 static char *driver_name = "SyncLink PC Card driver";
-static char *driver_version = "$Revision: 4.13 $";
+static char *driver_version = "$Revision: 4.15 $";
 
 static struct tty_driver *serial_driver;
 
@@ -838,6 +838,9 @@
 		printk(badmagic, name, routine);
 		return 1;
 	}
+#else
+	if (!info)
+		return 1;
 #endif
 	return 0;
 }



