Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbUBJBMU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 20:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbUBJBLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 20:11:22 -0500
Received: from palrel12.hp.com ([156.153.255.237]:7351 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265621AbUBJBKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 20:10:54 -0500
Date: Mon, 9 Feb 2004 17:10:52 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Remove net notifier
Message-ID: <20040210011052.GD673@bougret.hpl.hp.com>
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

ir262_notifier.diff :
~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] remove unused code : device notifier handler.


diff -u -p linux/net/irda/irsyms.d7.c linux/net/irda/irsyms.c
--- linux/net/irda/irsyms.d7.c	Mon Feb  9 15:46:55 2004
+++ linux/net/irda/irsyms.c	Mon Feb  9 15:47:05 2004
@@ -193,45 +193,6 @@ static struct packet_type irda_packet_ty
 };
 
 /*
- * Function irda_device_event (this, event, ptr)
- *
- *    Called when a device is taken up or down
- *
- */
-static int irda_device_event(struct notifier_block *this, unsigned long event,
-			     void *ptr)
-{
-	struct net_device *dev = (struct net_device *) ptr;
-	
-        /* Reject non IrDA devices */
-	if (dev->type != ARPHRD_IRDA) 
-		return NOTIFY_DONE;
-	
-        switch (event) {
-	case NETDEV_UP:
-		IRDA_DEBUG(3, "%s(), NETDEV_UP\n", __FUNCTION__);
-		/* irda_dev_device_up(dev); */
-		break;
-	case NETDEV_DOWN:
-		IRDA_DEBUG(3, "%s(), NETDEV_DOWN\n", __FUNCTION__);
-		/* irda_kill_by_device(dev); */
-		/* irda_rt_device_down(dev); */
-		/* irda_dev_device_down(dev); */
-		break;
-	default:
-		break;
-        }
-
-        return NOTIFY_DONE;
-}
-
-static struct notifier_block irda_dev_notifier = {
-	irda_device_event,
-	NULL,
-	0
-};
-
-/*
  * Function irda_notify_init (notify)
  *
  *    Used for initializing the notify structure
@@ -272,9 +233,6 @@ int __init irda_init(void)
 	/* Add IrDA packet type (Start receiving packets) */
         dev_add_pack(&irda_packet_type);
 
-	/* Notifier for Interface changes */
-	register_netdevice_notifier(&irda_dev_notifier);
-
 	/* External APIs */
 #ifdef CONFIG_PROC_FS
 	irda_proc_register();
@@ -307,9 +265,6 @@ void __exit irda_cleanup(void)
 
 	/* Remove IrDA packet type (stop receiving packets) */
         dev_remove_pack(&irda_packet_type);
-	
-	/* Stop receiving interfaces notifications */
-        unregister_netdevice_notifier(&irda_dev_notifier);
 	
 	/* Remove higher layers */
 	irsock_cleanup();

