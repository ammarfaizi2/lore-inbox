Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTK0MEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 07:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTK0MEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 07:04:31 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:46852 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264498AbTK0ME2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 07:04:28 -0500
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "David S. Miller" <davem@redhat.com>
Cc: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <20031127025921.3fed8dd4.davem@redhat.com>
References: <1069920883.2476.1.camel@teapot.felipe-alfaro.com>
	 <20031127.173320.19253188.yoshfuji@linux-ipv6.org>
	 <20031127025921.3fed8dd4.davem@redhat.com>
Content-Type: multipart/mixed; boundary="=-rEH+SkxJJ+Bjdn2tnFIv"
Message-Id: <1069934643.2393.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 27 Nov 2003 13:04:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rEH+SkxJJ+Bjdn2tnFIv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-11-27 at 11:59, David S. Miller wrote:

> I agree, using sizeof() is the less error prone way of
> doing things like this.
> 
> Felipe could you please rewrite your patch like this?

Done!

--=-rEH+SkxJJ+Bjdn2tnFIv
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
+	strlcpy(t->parms.name, dev->name, sizeof(t->parms.name));
 }
 
 /**
diff -uNr linux-2.6.0-test11.orig/net/ipv6/netfilter/ip6_queue.c linux-2.6.0-test11/net/ipv6/netfilter/ip6_queue.c
--- linux-2.6.0-test11.orig/net/ipv6/netfilter/ip6_queue.c	2003-11-26 21:43:27.000000000 +0100
+++ linux-2.6.0-test11/net/ipv6/netfilter/ip6_queue.c	2003-11-27 00:26:47.000000000 +0100
@@ -240,12 +240,12 @@
 	pmsg->hw_protocol     = entry->skb->protocol;
 	
 	if (entry->info->indev)
-		strcpy(pmsg->indev_name, entry->info->indev->name);
+		strlcpy(pmsg->indev_name, entry->info->indev->name, sizeof(pmsg->indev_name));
 	else
 		pmsg->indev_name[0] = '\0';
 	
 	if (entry->info->outdev)
-		strcpy(pmsg->outdev_name, entry->info->outdev->name);
+		strlcpy(pmsg->outdev_name, entry->info->outdev->name, sizeof(pmsg->outdev_name));
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
+			strlcpy(info.name, name, sizeof(info.name));
 
 			if (copy_to_user(user, &info, *len) != 0)
 				ret = -EFAULT;
diff -uNr linux-2.6.0-test11.orig/net/ipv6/sit.c linux-2.6.0-test11/net/ipv6/sit.c
--- linux-2.6.0-test11.orig/net/ipv6/sit.c	2003-11-26 21:45:36.000000000 +0100
+++ linux-2.6.0-test11/net/ipv6/sit.c	2003-11-27 00:27:01.000000000 +0100
@@ -747,7 +747,7 @@
 	iph = &tunnel->parms.iph;
 
 	tunnel->dev = dev;
-	strcpy(tunnel->parms.name, dev->name);
+	strlcpy(tunnel->parms.name, dev->name, sizeof(tunnel->parms.name));
 
 	memcpy(dev->dev_addr, &tunnel->parms.iph.saddr, 4);
 	memcpy(dev->broadcast, &tunnel->parms.iph.daddr, 4);
@@ -786,7 +786,7 @@
 	struct iphdr *iph = &tunnel->parms.iph;
 
 	tunnel->dev = dev;
-	strcpy(tunnel->parms.name, dev->name);
+	strlcpy(tunnel->parms.name, dev->name, sizeof(tunnel->parms.name));
 
 	iph->version		= 4;
 	iph->protocol		= IPPROTO_IPV6;

--=-rEH+SkxJJ+Bjdn2tnFIv--

