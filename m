Return-Path: <linux-kernel-owner+w=401wt.eu-S1755096AbWL2Xrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbWL2Xrz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbWL2Xr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:47:29 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:45699 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965225AbWL2Xq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:46:58 -0500
Message-Id: <200612292341.kBTNfWu0005554@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/6] UML - Network driver whitespace and style fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Dec 2006 18:41:32 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some whitespace and coding style cleanups in the network driver code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

--
 arch/um/drivers/net_kern.c |   29 +++++++++++++++--------------
 arch/um/include/net_kern.h |    6 +++---
 2 files changed, 18 insertions(+), 17 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2006-12-29 17:42:37.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2006-12-29 18:18:48.000000000 -0500
@@ -108,7 +108,7 @@ irqreturn_t uml_net_interrupt(int irq, v
 
 out:
 	spin_unlock(&lp->lock);
-	return(IRQ_HANDLED);
+	return IRQ_HANDLED;
 }
 
 static int uml_net_open(struct net_device *dev)
@@ -239,7 +239,7 @@ static int uml_net_set_mac(struct net_de
 	set_ether_mac(dev, hwaddr->sa_data);
 	spin_unlock_irq(&lp->lock);
 
-	return(0);
+	return 0;
 }
 
 static int uml_net_change_mtu(struct net_device *dev, int new_mtu)
@@ -460,7 +460,7 @@ static struct uml_net *find_device(int n
 	device = NULL;
  out:
 	spin_unlock(&devices_lock);
-	return(device);
+	return device;
 }
 
 static int eth_parse(char *str, int *index_out, char **str_out,
@@ -511,23 +511,23 @@ static int check_transport(struct transp
 
 	len = strlen(transport->name);
 	if(strncmp(eth, transport->name, len))
-		return(0);
+		return 0;
 
 	eth += len;
 	if(*eth == ',')
 		eth++;
 	else if(*eth != '\0')
-		return(0);
+		return 0;
 
 	*init_out = kmalloc(transport->setup_size, GFP_KERNEL);
 	if(*init_out == NULL)
-		return(1);
+		return 1;
 
 	if(!transport->setup(eth, mac_out, *init_out)){
 		kfree(*init_out);
 		*init_out = NULL;
 	}
-	return(1);
+	return 1;
 }
 
 void register_transport(struct transport *new)
@@ -572,9 +572,9 @@ static int eth_setup_common(char *str, i
 			eth_configure(index, init, mac, transport);
 			kfree(init);
 		}
-		return(1);
+		return 1;
 	}
-	return(0);
+	return 0;
 }
 
 static int eth_setup(char *str)
@@ -678,7 +678,7 @@ static int net_remove(int n, char **erro
 	dev = device->dev;
 	lp = dev->priv;
 	if(lp->fd > 0)
-                return -EBUSY;
+		return -EBUSY;
 	if(lp->remove != NULL) (*lp->remove)(&lp->user);
 	unregister_netdev(dev);
 	platform_device_unregister(&device->pdev);
@@ -693,7 +693,7 @@ static struct mc_device net_mc = {
 	.name		= "eth",
 	.config		= net_config,
 	.get_config	= NULL,
-        .id		= net_id,
+	.id		= net_id,
 	.remove		= net_remove,
 };
 
@@ -706,7 +706,8 @@ static int uml_inetaddr_event(struct not
 	void (*proc)(unsigned char *, unsigned char *, void *);
 	unsigned char addr_buf[4], netmask_buf[4];
 
-	if(dev->open != uml_net_open) return(NOTIFY_DONE);
+	if(dev->open != uml_net_open)
+		return NOTIFY_DONE;
 
 	lp = dev->priv;
 
@@ -724,7 +725,7 @@ static int uml_inetaddr_event(struct not
 		memcpy(netmask_buf, &ifa->ifa_mask, sizeof(netmask_buf));
 		(*proc)(addr_buf, netmask_buf, &lp->user);
 	}
-	return(NOTIFY_DONE);
+	return NOTIFY_DONE;
 }
 
 struct notifier_block uml_inetaddr_notifier = {
@@ -834,7 +835,7 @@ void *get_output_buffer(int *len_out)
 	ret = (void *) __get_free_pages(GFP_KERNEL, 0);
 	if(ret) *len_out = PAGE_SIZE;
 	else *len_out = 0;
-	return(ret);
+	return ret;
 }
 
 void free_output_buffer(void *buffer)
Index: linux-2.6.18-mm/arch/um/include/net_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/net_kern.h	2006-12-29 17:42:37.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/net_kern.h	2006-12-29 18:19:07.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -36,7 +36,7 @@ struct uml_net_private {
 	void (*remove)(void *);
 	int (*read)(int, struct sk_buff **skb, struct uml_net_private *);
 	int (*write)(int, struct sk_buff **skb, struct uml_net_private *);
-	
+
 	void (*add_address)(unsigned char *, unsigned char *, void *);
 	void (*delete_address)(unsigned char *, unsigned char *, void *);
 	int (*set_mtu)(int mtu, void *);
@@ -63,7 +63,7 @@ struct transport {
 extern struct net_device *ether_init(int);
 extern unsigned short ether_protocol(struct sk_buff *);
 extern struct sk_buff *ether_adjust_skb(struct sk_buff *skb, int extra);
-extern int tap_setup_common(char *str, char *type, char **dev_name, 
+extern int tap_setup_common(char *str, char *type, char **dev_name,
 			    char **mac_out, char **gate_addr);
 extern void register_transport(struct transport *new);
 extern unsigned short eth_protocol(struct sk_buff *skb);

