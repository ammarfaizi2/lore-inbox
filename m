Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTETWvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTETWvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:51:11 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.27]:63805 "EHLO
	mwinf0401.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261315AbTETWuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:50:52 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 11/14] USB speedtouch: kfree_skb -> dev_kfree_skb
Date: Wed, 21 May 2003 01:03:44 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210103.44924.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Always use dev_kfree_skb.

 speedtch.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:41:00 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:41:00 2003
@@ -757,7 +757,7 @@
 		if (vcc->pop)
 			vcc->pop (vcc, skb);
 		else
-			kfree_skb (skb);
+			dev_kfree_skb (skb);
 		instance->current_skb = NULL;
 
 		if (vcc->stats)
@@ -780,7 +780,7 @@
 			if (vcc->pop)
 				vcc->pop (vcc, skb);
 			else
-				kfree_skb (skb);
+				dev_kfree_skb (skb);
 		}
 	spin_unlock_irq (&instance->sndqueue.lock);
 
@@ -791,7 +791,7 @@
 		if (vcc->pop)
 			vcc->pop (vcc, skb);
 		else
-			kfree_skb (skb);
+			dev_kfree_skb (skb);
 	}
 	tasklet_enable (&instance->send_tasklet);
 	dbg ("udsl_cancel_send done");
@@ -987,7 +987,7 @@
 	tasklet_enable (&instance->receive_tasklet);
 
 	if (vcc_data->skb)
-		kfree_skb (vcc_data->skb);
+		dev_kfree_skb (vcc_data->skb);
 	vcc_data->skb = NULL;
 
 	kfree (vcc_data);
@@ -1219,7 +1219,7 @@
 		usb_free_urb (rcv->urb);
 
 		if (rcv->skb)
-			kfree_skb (rcv->skb);
+			dev_kfree_skb (rcv->skb);
 	}
 
 	kfree (instance);
@@ -1291,7 +1291,7 @@
 		struct udsl_receiver *rcv = &(instance->receivers [i]);
 
 		usb_free_urb (rcv->urb);
-		kfree_skb (rcv->skb);
+		dev_kfree_skb (rcv->skb);
 	}
 
 	/* send finalize */

