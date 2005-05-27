Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVE0JEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVE0JEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVE0JEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:04:14 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:40124 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262405AbVE0JDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:03:20 -0400
Date: Fri, 27 May 2005 11:04:55 +0200
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch 9/10] s390: qeth bug fixes
Message-ID: <20050527090455.GI8213@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Frank Pavlic <pavlic@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 9/10] s390: qeth bug fixes.

From: Frank Pavlic <pavlic@de.ibm.com>

qeth network driver changes:
 - Use sizeof(__u16) instead of '2' in qeth_fill_header.

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 drivers/s390/net/qeth_main.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2005-05-06 11:26:16.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2005-05-06 11:26:17.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.209 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.210 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.209 $	 $Date: 2005/04/18 11:58:48 $
+ *    $Revision: 1.210 $	 $Date: 2005/04/18 17:27:39 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -80,7 +80,7 @@ qeth_eyecatcher(void)
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.209 $"
+#define VERSION_QETH_C "$Revision: 1.210 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -3959,10 +3959,10 @@ qeth_fill_header(struct qeth_card *card,
 		}
 	} else { /* passthrough */
                 if((skb->dev->type == ARPHRD_IEEE802_TR) &&
-                        !memcmp(skb->data + sizeof(struct qeth_hdr) + 2,
-                        skb->dev->broadcast, 6)) {
-                        hdr->hdr.l3.flags = QETH_CAST_BROADCAST |
-                                                QETH_HDR_PASSTHRU;
+		    !memcmp(skb->data + sizeof(struct qeth_hdr) + 
+		    sizeof(__u16), skb->dev->broadcast, 6)) {
+			hdr->hdr.l3.flags = QETH_CAST_BROADCAST |
+						QETH_HDR_PASSTHRU;
 		} else if (!memcmp(skb->data + sizeof(struct qeth_hdr),
 			    skb->dev->broadcast, 6)) {   /* broadcast? */
 			hdr->hdr.l3.flags = QETH_CAST_BROADCAST |
