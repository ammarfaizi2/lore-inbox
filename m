Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTETWyT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbTETWxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:53:53 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:44305 "EHLO
	mwinf0303.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261383AbTETWwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:52:11 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 12/14] USB speedtouch: remove useless NULL pointer checks
Date: Wed, 21 May 2003 01:05:06 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210105.06006.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The stats field is never NULL.

 speedtch.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:41:05 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:41:05 2003
@@ -358,8 +358,7 @@
 
 	/* is skb long enough ? */
 	if (skb->len < pdu_length) {
-		if (ctx->vcc->stats)
-			atomic_inc (&ctx->vcc->stats->rx_err);
+		atomic_inc (&ctx->vcc->stats->rx_err);
 		return NULL;
 	}
 
@@ -378,8 +377,7 @@
 	/* check crc */
 	if (pdu_crc != crc) {
 		dbg ("udsl_decode_aal5: crc check failed!");
-		if (ctx->vcc->stats)
-			atomic_inc (&ctx->vcc->stats->rx_err);
+		atomic_inc (&ctx->vcc->stats->rx_err);
 		return NULL;
 	}
 
@@ -387,8 +385,7 @@
 	skb_trim (skb, length);
 
 	/* update stats */
-	if (ctx->vcc->stats)
-		atomic_inc (&ctx->vcc->stats->rx);
+	atomic_inc (&ctx->vcc->stats->rx);
 
 	vdbg ("udsl_decode_aal5 returns pdu 0x%p with length %d", skb, skb->len);
 	return skb;
@@ -760,8 +757,7 @@
 			dev_kfree_skb (skb);
 		instance->current_skb = NULL;
 
-		if (vcc->stats)
-			atomic_inc (&vcc->stats->tx);
+		atomic_inc (&vcc->stats->tx);
 	}
 
 	goto made_progress;

