Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262770AbTDATJq>; Tue, 1 Apr 2003 14:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262764AbTDATJq>; Tue, 1 Apr 2003 14:09:46 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5785 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262749AbTDATJf>;
	Tue, 1 Apr 2003 14:09:35 -0500
Subject: Re: [PATCH 2.5.66] sychronize_net patch (1/2)
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030401.095153.92005641.davem@redhat.com>
References: <1049152378.2204.22.camel@dell_ss3.pdx.osdl.net>
	 <20030401.095153.92005641.davem@redhat.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1049224852.2197.38.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2003 11:20:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-01 at 09:51, David S. Miller wrote:


> Please fix this stuff.

Here is an update with the correct style.

diff -urN -X dontdiff linux-2.5/include/linux/netdevice.h linux-2.5-netsync/include/linux/netdevice.h
--- linux-2.5/include/linux/netdevice.h	2003-03-31 10:45:58.000000000 -0800
+++ linux-2.5-netsync/include/linux/netdevice.h	2003-03-31 13:42:39.000000000 -0800
@@ -486,6 +486,7 @@
 extern int		dev_queue_xmit(struct sk_buff *skb);
 extern int		register_netdevice(struct net_device *dev);
 extern int		unregister_netdevice(struct net_device *dev);
+extern void		synchronize_net(void);
 extern int 		register_netdevice_notifier(struct notifier_block *nb);
 extern int		unregister_netdevice_notifier(struct notifier_block *nb);
 extern int		call_netdevice_notifiers(unsigned long val, void *v);
diff -urN -X dontdiff linux-2.5/net/core/dev.c linux-2.5-netsync/net/core/dev.c
--- linux-2.5/net/core/dev.c	2003-03-31 10:46:01.000000000 -0800
+++ linux-2.5-netsync/net/core/dev.c	2003-04-01 10:29:35.000000000 -0800
@@ -2646,6 +2646,13 @@
 	return 0;
 }
 
+/* Synchronize with packet receive processing. */
+void synchronize_net(void) 
+{
+	br_write_lock_bh(BR_NETPROTO_LOCK);
+	br_write_unlock_bh(BR_NETPROTO_LOCK);
+}
+
 /**
  *	unregister_netdevice - remove device from the kernel
  *	@dev: device
@@ -2688,10 +2695,7 @@
 		return -ENODEV;
 	}
 
-	/* Synchronize to net_rx_action. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
-
+	synchronize_net();
 
 #ifdef CONFIG_NET_FASTROUTE
 	dev_clear_fastroute(dev);
diff -urN -X dontdiff linux-2.5/net/netsyms.c linux-2.5-netsync/net/netsyms.c
--- linux-2.5/net/netsyms.c	2003-03-31 10:46:00.000000000 -0800
+++ linux-2.5-netsync/net/netsyms.c	2003-03-31 13:42:41.000000000 -0800
@@ -548,6 +548,7 @@
 EXPORT_SYMBOL(loopback_dev);
 EXPORT_SYMBOL(register_netdevice);
 EXPORT_SYMBOL(unregister_netdevice);
+EXPORT_SYMBOL(synchronize_net);
 EXPORT_SYMBOL(netdev_state_change);
 EXPORT_SYMBOL(dev_new_index);
 EXPORT_SYMBOL(dev_get_by_flags);



