Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTK0IPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 03:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264447AbTK0IPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 03:15:24 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:40452 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264446AbTK0IPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 03:15:12 -0500
Subject: [PATCH 2.6]: IPv6: strcpy -> strlcpy
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: davem@redhat.com
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Esdrj25KrevGQqGJ5Eas"
Message-Id: <1069920883.2476.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 27 Nov 2003 09:14:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Esdrj25KrevGQqGJ5Eas
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

Attached is a patch against 2.6.0-test11 to convert all strcpy() calls
to their corresponding strlcpy() for IPv6. Compiled and tested.

Thanks!

--=-Esdrj25KrevGQqGJ5Eas
Content-Disposition: attachment; filename=strlcpy-ipv6.patch
Content-Type: text/x-patch; name=strlcpy-ipv6.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uNr linux-2.6.0-test11.orig/net/ipv6/ip6_tunnel.c linux-2.6.0-test11/net/ipv6/ip6_tunnel.c
--- linux-2.6.0-test11.orig/net/ipv6/ip6_tunnel.c	2003-11-26 21:42:56.000000000 +0100
+++ linux-2.6.0-test11/net/ipv6/ip6_tunnel.c	2003-11-27 00:27:09.000000000 +0100
@@ -1056,7 +1056,7 @@
 	struct ip6_tnl *t = (struct ip6_tnl *) dev->priv;
 	t->fl.proto = IPPROTO_IPV6;
 	t->dev = dev;
-	strcpy(t->parms.name, dev->name);
+	strlcpy(t->parms.name, dev->name, IFNAMSIZ);
 }
 
 /**
diff -uNr linux-2.6.0-test11.orig/net/ipv6/netfilter/ip6_queue.c linux-2.6.0-test11/net/ipv6/netfilter/ip6_queue.c
--- linux-2.6.0-test11.orig/net/ipv6/netfilter/ip6_queue.c	2003-11-26 21:43:27.000000000 +0100
+++ linux-2.6.0-test11/net/ipv6/netfilter/ip6_queue.c	2003-11-27 00:26:47.000000000 +0100
@@ -240,12 +240,12 @@
 	pmsg->hw_protocol     = entry->skb->protocol;
 	
 	if (entry->info->indev)
-		strcpy(pmsg->indev_name, entry->info->indev->name);
+		strlcpy(pmsg->indev_name, entry->info->indev->name, IFNAMSIZ);
 	else
 		pmsg->indev_name[0] = '\0';
 	
 	if (entry->info->outdev)
-		strcpy(pmsg->outdev_name, entry->info->outdev->name);
+		strlcpy(pmsg->outdev_name, entry->info->outdev->name, IFNAMSIZ);
 	else
 		pmsg->outdev_name[0] = '\0';
 	
diff -uNr linux-2.6.0-test11.orig/net/ipv6/netfilter/ip6_tables.c linux-2.6.0-test11/net/ipv6/netfilter/ip6_tables.c
--- linux-2.6.0-test11.orig/net/ipv6/netfilter/ip6_tables.c	2003-11-26 21:45:30.000000000 +0100
+++ linux-2.6.0-test11/net/ipv6/netfilter/ip6_tables.c	2003-11-27 00:24:07.000000000 +0100
@@ -1357,7 +1357,7 @@
 			       sizeof(info.underflow));
 			info.num_entries = t->private->number;
 			info.size = t->private->size;
-			strcpy(info.name, name);
+			strlcpy(info.name, name, IP6T_TABLE_MAXNAMELEN);
 
 			if (copy_to_user(user, &info, *len) != 0)
 				ret = -EFAULT;
diff -uNr linux-2.6.0-test11.orig/net/ipv6/sit.c linux-2.6.0-test11/net/ipv6/sit.c
--- linux-2.6.0-test11.orig/net/ipv6/sit.c	2003-11-26 21:45:36.000000000 +0100
+++ linux-2.6.0-test11/net/ipv6/sit.c	2003-11-27 00:27:01.000000000 +0100
@@ -747,7 +747,7 @@
 	iph = &tunnel->parms.iph;
 
 	tunnel->dev = dev;
-	strcpy(tunnel->parms.name, dev->name);
+	strlcpy(tunnel->parms.name, dev->name, IFNAMSIZ);
 
 	memcpy(dev->dev_addr, &tunnel->parms.iph.saddr, 4);
 	memcpy(dev->broadcast, &tunnel->parms.iph.daddr, 4);
@@ -786,7 +786,7 @@
 	struct iphdr *iph = &tunnel->parms.iph;
 
 	tunnel->dev = dev;
-	strcpy(tunnel->parms.name, dev->name);
+	strlcpy(tunnel->parms.name, dev->name, IFNAMSIZ);
 
 	iph->version		= 4;
 	iph->protocol		= IPPROTO_IPV6;

--=-Esdrj25KrevGQqGJ5Eas--

