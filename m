Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbUCITIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbUCITIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:08:10 -0500
Received: from palrel10.hp.com ([156.153.255.245]:5303 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262113AbUCITFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:05:51 -0500
Date: Tue, 9 Mar 2004 11:05:50 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (4/14) irttp exports
Message-ID: <20040309190550.GE14543@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir264_irsyms_04_irttp.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(4/14) irttp exports

Move irttp_exports out of irsyms


diff -u -p -r linux/net/irda.s3/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.s3/irsyms.c	Mon Mar  8 18:55:49 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 18:57:25 2004
@@ -68,17 +68,6 @@ extern void irsock_cleanup(void);
 extern int  irlap_driver_rcv(struct sk_buff *, struct net_device *, 
 			     struct packet_type *);
 
-/* IrTTP */
-EXPORT_SYMBOL(irttp_open_tsap);
-EXPORT_SYMBOL(irttp_close_tsap);
-EXPORT_SYMBOL(irttp_connect_response);
-EXPORT_SYMBOL(irttp_data_request);
-EXPORT_SYMBOL(irttp_disconnect_request);
-EXPORT_SYMBOL(irttp_flow_request);
-EXPORT_SYMBOL(irttp_connect_request);
-EXPORT_SYMBOL(irttp_udata_request);
-EXPORT_SYMBOL(irttp_dup);
-
 /* Main IrDA module */
 #ifdef CONFIG_IRDA_DEBUG
 EXPORT_SYMBOL(irda_debug);
diff -u -p -r linux/net/irda.s3/irttp.c linux/net/irda/irttp.c
--- linux/net/irda.s3/irttp.c	Wed Dec 17 18:58:57 2003
+++ linux/net/irda/irttp.c	Mon Mar  8 18:57:25 2004
@@ -450,6 +450,7 @@ struct tsap_cb *irttp_open_tsap(__u8 sts
 
 	return self;
 }
+EXPORT_SYMBOL(irttp_open_tsap);
 
 /*
  * Function irttp_close (handle)
@@ -525,6 +526,7 @@ int irttp_close_tsap(struct tsap_cb *sel
 
 	return 0;
 }
+EXPORT_SYMBOL(irttp_close_tsap);
 
 /*
  * Function irttp_udata_request (self, skb)
@@ -562,6 +564,8 @@ err:
 	dev_kfree_skb(skb);
 	return -1;
 }
+EXPORT_SYMBOL(irttp_udata_request);
+
 
 /*
  * Function irttp_data_request (handle, skb)
@@ -672,6 +676,7 @@ err:
 	dev_kfree_skb(skb);
 	return ret;
 }
+EXPORT_SYMBOL(irttp_data_request);
 
 /*
  * Function irttp_run_tx_queue (self)
@@ -1058,6 +1063,7 @@ void irttp_flow_request(struct tsap_cb *
 		IRDA_DEBUG(1, "%s(), Unknown flow command!\n", __FUNCTION__);
 	}
 }
+EXPORT_SYMBOL(irttp_flow_request);
 
 /*
  * Function irttp_connect_request (self, dtsap_sel, daddr, qos)
@@ -1153,6 +1159,7 @@ int irttp_connect_request(struct tsap_cb
 	return irlmp_connect_request(self->lsap, dtsap_sel, saddr, daddr, qos,
 				     tx_skb);
 }
+EXPORT_SYMBOL(irttp_connect_request);
 
 /*
  * Function irttp_connect_confirm (handle, qos, skb)
@@ -1397,6 +1404,7 @@ int irttp_connect_response(struct tsap_c
 
 	return ret;
 }
+EXPORT_SYMBOL(irttp_connect_response);
 
 /*
  * Function irttp_dup (self, instance)
@@ -1455,6 +1463,7 @@ struct tsap_cb *irttp_dup(struct tsap_cb
 
 	return new;
 }
+EXPORT_SYMBOL(irttp_dup);
 
 /*
  * Function irttp_disconnect_request (self)
@@ -1549,6 +1558,7 @@ int irttp_disconnect_request(struct tsap
 
 	return ret;
 }
+EXPORT_SYMBOL(irttp_disconnect_request);
 
 /*
  * Function irttp_disconnect_indication (self, reason)
