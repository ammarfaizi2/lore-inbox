Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTEZRVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTEZRUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:20:38 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:27595 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id S261873AbTEZRTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:19:49 -0400
Date: Mon, 26 May 2003 19:32:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (10/10): network device drivers.
Message-ID: <20030526173200.GK3748@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 network device driver fixes:
 - Make use of SET_MODULE_OWNER.
 - Fix ctc interrupt handler.

diffstat:
 drivers/s390/net/ctcmain.c |   10 +++++-----
 drivers/s390/net/ctctty.c  |    2 +-
 drivers/s390/net/lcs.c     |    2 +-
 drivers/s390/net/netiucv.c |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff -urN linux-2.5/drivers/s390/net/ctcmain.c linux-2.5-s390/drivers/s390/net/ctcmain.c
--- linux-2.5/drivers/s390/net/ctcmain.c	Mon May 26 19:20:46 2003
+++ linux-2.5-s390/drivers/s390/net/ctcmain.c	Mon May 26 19:20:48 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.41 2003/04/15 16:45:37 aberg Exp $
+ * $Id: ctcmain.c,v 1.42 2003/05/23 17:45:57 felfert Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.41 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.42 $
  *
  */
 
@@ -272,7 +272,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.41 $";
+	char vbuf[] = "$Revision: 1.42 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -1966,7 +1966,7 @@
 	if (priv->channel[READ]->cdev == cdev)
 		ch = priv->channel[READ];
 	else if (priv->channel[WRITE]->cdev == cdev)
-		ch = priv->channel[READ];
+		ch = priv->channel[WRITE];
 	else {
 		printk(KERN_ERR
 		       "ctc: Can't determine channel for interrupt, "
@@ -2751,8 +2751,8 @@
 	dev->addr_len = 0;
 	dev->type = ARPHRD_SLIP;
 	dev->tx_queue_len = 100;
-	dev->owner = THIS_MODULE;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+	SET_MODULE_OWNER(&tun->dev);
 	return dev;
 }
 
diff -urN linux-2.5/drivers/s390/net/ctctty.c linux-2.5-s390/drivers/s390/net/ctctty.c
--- linux-2.5/drivers/s390/net/ctctty.c	Mon May  5 01:53:31 2003
+++ linux-2.5-s390/drivers/s390/net/ctctty.c	Mon May 26 19:20:48 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctctty.c,v 1.10 2003/03/21 18:47:31 aberg Exp $
+ * $Id: ctctty.c,v 1.11 2003/05/06 09:40:55 mschwide Exp $
  *
  * CTC / ESCON network driver, tty interface.
  *
diff -urN linux-2.5/drivers/s390/net/lcs.c linux-2.5-s390/drivers/s390/net/lcs.c
--- linux-2.5/drivers/s390/net/lcs.c	Mon May  5 01:53:02 2003
+++ linux-2.5-s390/drivers/s390/net/lcs.c	Mon May 26 19:20:48 2003
@@ -1786,7 +1786,7 @@
 		dev->set_multicast_list = lcs_set_multicast_list;
 #endif
 	dev->get_stats = lcs_getstats;
-	dev->owner = THIS_MODULE;
+	SET_MODULE_OWNER(&tun->dev);
 	netif_stop_queue(dev);
 	lcs_stopcard(card);
 	return 0;
diff -urN linux-2.5/drivers/s390/net/netiucv.c linux-2.5-s390/drivers/s390/net/netiucv.c
--- linux-2.5/drivers/s390/net/netiucv.c	Mon May  5 01:53:32 2003
+++ linux-2.5-s390/drivers/s390/net/netiucv.c	Mon May 26 19:20:48 2003
@@ -1630,8 +1630,8 @@
 	dev->addr_len            = 0;
 	dev->type                = ARPHRD_SLIP;
 	dev->tx_queue_len        = NETIUCV_QUEUELEN_DEFAULT;
-	dev->owner               = THIS_MODULE;
 	dev->flags	         = IFF_POINTOPOINT | IFF_NOARP;
+	SET_MODULE_OWNER(&tun->dev);
 	return dev;
 }
 
