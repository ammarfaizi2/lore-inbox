Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbRABCWX>; Mon, 1 Jan 2001 21:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130357AbRABCWE>; Mon, 1 Jan 2001 21:22:04 -0500
Received: from mx2.utanet.at ([195.70.253.46]:53916 "EHLO smtp1.utaiop.at")
	by vger.kernel.org with ESMTP id <S129666AbRABCVp>;
	Mon, 1 Jan 2001 21:21:45 -0500
Message-ID: <3A514236.2000801@grips.com>
Date: Tue, 02 Jan 2001 03:51:34 +0100
From: Gerold Jury <geroldj@grips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-prerelease i686; en-US; m18) Gecko/20001229
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <Pine.LNX.4.10.10012311205020.1210-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080409060305080303020801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080409060305080303020801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The ISDN changes for the HISAX drivers
that came in since test12 have introduced a bug that causes a 
AIEE-something and a complete kernel hang when i hangup the isdn line.
I have reversed the patch for all occurences of INIT_LIST_HEAD in the 
isdn patch part and it works for me now.

The relevant part is attached. Please back it out for 2.4.0.

Happy new year

Gerold Jury

--------------080409060305080303020801
Content-Type: text/plain;
 name="patch-2.4.0-prerelease.isdnrev"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.4.0-prerelease.isdnrev"

diff -u --recursive --new-file v2.4.0-test12/linux/drivers/isdn/hisax/config.c linux/drivers/isdn/hisax/config.c
--- v2.4.0-test12/linux/drivers/isdn/hisax/config.c	Mon Dec 11 17:59:44 2000
+++ linux/drivers/isdn/hisax/config.c	Fri Dec 29 14:07:22 2000
@@ -1,4 +1,4 @@
-/* $Id: config.c,v 2.57.6.3 2000/11/29 17:48:59 kai Exp $
+/* $Id: config.c,v 2.57.6.6 2000/12/10 23:39:19 kai Exp $
  *
  * Author       Karsten Keil (keil@isdn4linux.de)
  *              based on the teles driver from Jan den Ouden
@@ -1180,7 +1180,6 @@
 	cs->tx_skb = NULL;
 	cs->tx_cnt = 0;
 	cs->event = 0;
-	INIT_LIST_HEAD(&cs->tqueue.list);
 	cs->tqueue.sync = 0;
 	cs->tqueue.data = cs;
 
@@ -1756,6 +1755,7 @@
 	{PCI_VENDOR_ID_CCD,      PCI_DEVICE_ID_CCD_B00B,         PCI_ANY_ID, PCI_ANY_ID},
 	{PCI_VENDOR_ID_CCD,      PCI_DEVICE_ID_CCD_B00C,         PCI_ANY_ID, PCI_ANY_ID},
 	{PCI_VENDOR_ID_CCD,      PCI_DEVICE_ID_CCD_B100,         PCI_ANY_ID, PCI_ANY_ID},
+	{PCI_VENDOR_ID_ABOCOM,   PCI_DEVICE_ID_ABOCOM_2BD1,      PCI_ANY_ID, PCI_ANY_ID},
 	{PCI_VENDOR_ID_ASUSTEK,  PCI_DEVICE_ID_ASUSTEK_0675,     PCI_ANY_ID, PCI_ANY_ID},
 	{PCI_VENDOR_ID_BERKOM,   PCI_DEVICE_ID_BERKOM_T_CONCEPT, PCI_ANY_ID, PCI_ANY_ID},
 	{PCI_VENDOR_ID_BERKOM,   PCI_DEVICE_ID_BERKOM_A1T,       PCI_ANY_ID, PCI_ANY_ID},
diff -u --recursive --new-file v2.4.0-test12/linux/drivers/isdn/hisax/isdnl1.c linux/drivers/isdn/hisax/isdnl1.c
--- v2.4.0-test12/linux/drivers/isdn/hisax/isdnl1.c	Mon Dec 11 17:59:44 2000
+++ linux/drivers/isdn/hisax/isdnl1.c	Fri Dec 29 14:07:22 2000
@@ -1,4 +1,4 @@
-/* $Id: isdnl1.c,v 2.41 2000/11/24 17:05:37 kai Exp $
+/* $Id: isdnl1.c,v 2.41.6.1 2000/12/10 22:01:04 kai Exp $
  *
  * isdnl1.c     common low level stuff for Siemens Chipsetbased isdn cards
  *              based on the teles driver from Jan den Ouden
@@ -15,7 +15,7 @@
  *
  */
 
-const char *l1_revision = "$Revision: 2.41 $";
+const char *l1_revision = "$Revision: 2.41.6.1 $";
 
 #define __NO_VERSION__
 #include <linux/init.h>
@@ -343,7 +343,6 @@
 
 	bcs->cs = cs;
 	bcs->channel = bc;
-	INIT_LIST_HEAD(&bcs->tqueue.list);
 	bcs->tqueue.sync = 0;
 	bcs->tqueue.routine = (void *) (void *) BChannel_bh;
 	bcs->tqueue.data = bcs;
diff -u --recursive --new-file v2.4.0-test12/linux/drivers/isdn/hysdn/boardergo.c linux/drivers/isdn/hysdn/boardergo.c
--- v2.4.0-test12/linux/drivers/isdn/hysdn/boardergo.c	Mon Dec 11 17:59:44 2000
+++ linux/drivers/isdn/hysdn/boardergo.c	Fri Dec 29 14:07:22 2000
@@ -1,4 +1,4 @@
-/* $Id: boardergo.c,v 1.5 2000/11/22 17:13:13 kai Exp $
+/* $Id: boardergo.c,v 1.5.6.1 2000/12/10 22:01:04 kai Exp $
 
  * Linux driver for HYSDN cards, specific routines for ergo type boards.
  *
@@ -458,7 +458,6 @@
 	card->writebootseq = ergo_writebootseq;
 	card->waitpofready = ergo_waitpofready;
 	card->set_errlog_state = ergo_set_errlog_state;
-	INIT_LIST_HEAD(&card->irq_queue.list);
 	card->irq_queue.sync = 0;
 	card->irq_queue.data = card;	/* init task queue for interrupt */
 	card->irq_queue.routine = (void *) (void *) ergo_irq_bh;
diff -u --recursive --new-file v2.4.0-test12/linux/drivers/isdn/isdn_net.c linux/drivers/isdn/isdn_net.c
--- v2.4.0-test12/linux/drivers/isdn/isdn_net.c	Sun Nov 19 18:44:08 2000
+++ linux/drivers/isdn/isdn_net.c	Fri Dec 29 14:07:22 2000
@@ -1,4 +1,4 @@
-/* $Id: isdn_net.c,v 1.140 2000/11/01 17:54:01 detabc Exp $
+/* $Id: isdn_net.c,v 1.140.6.1 2000/12/10 22:01:04 kai Exp $
 
  * Linux ISDN subsystem, network interfaces and related functions (linklevel).
  *
@@ -181,7 +181,7 @@
 int isdn_net_force_dial_lp(isdn_net_local *);
 static int isdn_net_start_xmit(struct sk_buff *, struct net_device *);
 
-char *isdn_net_revision = "$Revision: 1.140 $";
+char *isdn_net_revision = "$Revision: 1.140.6.1 $";
 
  /*
   * Code for raw-networking over ISDN
@@ -2371,7 +2371,7 @@
 	netdev->local->netdev = netdev;
 	netdev->local->next = netdev->local;
 
-	memset(&netdev->local->tqueue, 0, sizeof(struct tq_struct));
+	netdev->local->tqueue.sync = 0;
 	netdev->local->tqueue.routine = isdn_net_softint;
 	netdev->local->tqueue.data = netdev->local;
 	spin_lock_init(&netdev->local->xmit_lock);
diff -u --recursive --new-file v2.4.0-test12/linux/drivers/isdn/pcbit/drv.c linux/drivers/isdn/pcbit/drv.c
--- v2.4.0-test12/linux/drivers/isdn/pcbit/drv.c	Mon Dec 11 17:59:44 2000
+++ linux/drivers/isdn/pcbit/drv.c	Fri Dec 29 14:07:22 2000
@@ -134,8 +134,6 @@
 	memset(dev->b2, 0, sizeof(struct pcbit_chan));
 	dev->b2->id = 1;
 
-
-	INIT_LIST_HEAD(&dev->qdelivery.list);
 	dev->qdelivery.sync = 0;
 	dev->qdelivery.routine = pcbit_deliver;
 	dev->qdelivery.data = dev;

--------------080409060305080303020801--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
