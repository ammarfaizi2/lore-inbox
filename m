Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbTIEPfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbTIEPfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:35:18 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:38488 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262786AbTIEPfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:35:10 -0400
Subject: [PATCH] 2.6.0-test4 synclinkmp.c
From: Paul Fulghum <paulkf@microgate.com>
To: "torvalds@osdl.org" <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1062776098.2675.4.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Sep 2003 10:34:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* replace previously remove NULL context check
  (causes oops when opening non existent device)

Please apply.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com

--- linux-2.6.0-test4/drivers/char/synclinkmp.c	2003-09-05 10:25:19.000000000 -0500
+++ linux-2.6.0-test4-mg/drivers/char/synclinkmp.c	2003-09-05 10:27:02.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.12 2003/06/18 15:29:33 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.14 2003/09/05 15:26:03 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -496,7 +496,7 @@
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.12 $";
+static char *driver_version = "$Revision: 4.14 $";
 
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
@@ -713,6 +713,9 @@
 		printk(badmagic, name, routine);
 		return 1;
 	}
+#else
+	if (!info)
+		return 1;
 #endif
 	return 0;
 }



