Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTF0PBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTF0O6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:58:35 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:18097 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S264461AbTF0Ozk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:55:40 -0400
Date: Fri, 27 Jun 2003 17:08:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (5/7): set module owner.
Message-ID: <20030627150831.GF3591@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pass correct argument to SET_MODULE_OWNER.

diffstat:
 drivers/s390/net/ctcmain.c |    8 ++++----
 drivers/s390/net/ctctty.c  |    2 +-
 drivers/s390/net/lcs.c     |    6 +++---
 drivers/s390/net/netiucv.c |    8 ++++----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff -urN linux-2.5/drivers/s390/net/ctcmain.c linux-2.5-s390/drivers/s390/net/ctcmain.c
--- linux-2.5/drivers/s390/net/ctcmain.c	Sun Jun 22 20:32:41 2003
+++ linux-2.5-s390/drivers/s390/net/ctcmain.c	Fri Jun 27 16:04:39 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.42 2003/05/23 17:45:57 felfert Exp $
+ * $Id: ctcmain.c,v 1.43 2003/05/27 11:34:23 mschwide Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.42 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.43 $
  *
  */
 
@@ -272,7 +272,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.42 $";
+	char vbuf[] = "$Revision: 1.43 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -2752,7 +2752,7 @@
 	dev->type = ARPHRD_SLIP;
 	dev->tx_queue_len = 100;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
-	SET_MODULE_OWNER(&tun->dev);
+	SET_MODULE_OWNER(dev);
 	return dev;
 }
 
diff -urN linux-2.5/drivers/s390/net/ctctty.c linux-2.5-s390/drivers/s390/net/ctctty.c
--- linux-2.5/drivers/s390/net/ctctty.c	Sun Jun 22 20:32:55 2003
+++ linux-2.5-s390/drivers/s390/net/ctctty.c	Fri Jun 27 16:04:39 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctctty.c,v 1.11 2003/05/06 09:40:55 mschwide Exp $
+ * $Id: ctctty.c,v 1.12 2003/06/17 11:36:44 mschwide Exp $
  *
  * CTC / ESCON network driver, tty interface.
  *
diff -urN linux-2.5/drivers/s390/net/lcs.c linux-2.5-s390/drivers/s390/net/lcs.c
--- linux-2.5/drivers/s390/net/lcs.c	Sun Jun 22 20:32:33 2003
+++ linux-2.5-s390/drivers/s390/net/lcs.c	Fri Jun 27 16:04:39 2003
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.51 $	 $Date: 2003/03/28 08:54:40 $
+ *    $Revision: 1.53 $	 $Date: 2003/06/17 11:36:45 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,7 +58,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.51 $"
+#define VERSION_LCS_C  "$Revision: 1.53 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 
@@ -1785,7 +1785,7 @@
 		dev->set_multicast_list = lcs_set_multicast_list;
 #endif
 	dev->get_stats = lcs_getstats;
-	SET_MODULE_OWNER(&tun->dev);
+	SET_MODULE_OWNER(dev);
 	if (register_netdev(dev) != 0)
 		goto out;
 	netif_stop_queue(dev);
diff -urN linux-2.5/drivers/s390/net/netiucv.c linux-2.5-s390/drivers/s390/net/netiucv.c
--- linux-2.5/drivers/s390/net/netiucv.c	Sun Jun 22 20:32:56 2003
+++ linux-2.5-s390/drivers/s390/net/netiucv.c	Fri Jun 27 16:04:39 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.19 2003/04/08 16:00:17 mschwide Exp $
+ * $Id: netiucv.c,v 1.20 2003/05/27 11:34:24 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.19 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.20 $
  *
  */
 
@@ -1631,7 +1631,7 @@
 	dev->type                = ARPHRD_SLIP;
 	dev->tx_queue_len        = NETIUCV_QUEUELEN_DEFAULT;
 	dev->flags	         = IFF_POINTOPOINT | IFF_NOARP;
-	SET_MODULE_OWNER(&tun->dev);
+	SET_MODULE_OWNER(dev);
 	return dev;
 }
 
@@ -1717,7 +1717,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.19 $";
+	char vbuf[] = "$Revision: 1.20 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
