Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTDKRZJ (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTDKRZJ (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:25:09 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:1683 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S261305AbTDKRZH (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 13:25:07 -0400
Date: Fri, 11 Apr 2003 19:36:45 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@lists.samba.org
Subject: [CORRECTED][PATCH] net/ipv6/netfilter warning removal 2.[45]
Message-ID: <Pine.LNX.4.51.0304111933550.18066@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Joe Perches pointed out a mistake in the previous patch, here's a
corrected version.
there are simple warning to remove in 4 files there, here are the
warnings:
net/ipv6/netfilter/ip6t_rt.c: In function `match':
net/ipv6/netfilter/ip6t_rt.c:133: warning: assignment from incompatible pointer type
net/ipv6/netfilter/ip6t_frag.c: In function `match':
net/ipv6/netfilter/ip6t_frag.c:150: warning: assignment from incompatible pointer type
net/ipv6/netfilter/ip6t_esp.c: In function `match':
net/ipv6/netfilter/ip6t_esp.c:126: warning: assignment from incompatible pointer type
net/ipv6/netfilter/ip6t_ah.c: In function `match':
net/ipv6/netfilter/ip6t_ah.c:136: warning: assignment from incompatible pointer type

And here is the patch to remove those by using casts.

It applies both to 2.4.20 and 2.5.67.

Regards,
Maciej

diff -Nru linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_ah.c linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_ah.c
--- linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_ah.c	2003-04-11 18:41:29.000000000 +0200
+++ linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_ah.c	2003-04-11 18:49:41.000000000 +0200
@@ -133,7 +133,7 @@
        		return 0;
        }

-       ah=skb->data+ptr;
+       ah = (struct ahhdr *) (skb->data+ptr);

        DEBUGP("IPv6 AH LEN %u %u ", hdrlen, ah->hdrlen);
        DEBUGP("RES %04X ", ah->reserved);
Binary files linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_ah.ko and linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_ah.ko differ
Binary files linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_ah.o and linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_ah.o differ
diff -Nru linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_esp.c linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_esp.c
--- linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_esp.c	2003-04-11 18:41:29.000000000 +0200
+++ linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_esp.c	2003-04-11 18:48:24.000000000 +0200
@@ -123,7 +123,7 @@
        		return 0;
        }

-	esp=skb->data+ptr;
+	esp = (struct esphdr *) (skb->data+ptr);

 	DEBUGP("IPv6 ESP SPI %u %08X\n", ntohl(esp->spi), ntohl(esp->spi));

Binary files linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_esp.ko and linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_esp.ko differ
Binary files linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_esp.o and linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_esp.o differ
diff -Nru linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_frag.c linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_frag.c
--- linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_frag.c	2003-04-11 18:41:29.000000000 +0200
+++ linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_frag.c	2003-04-11 18:48:09.000000000 +0200
@@ -147,7 +147,7 @@
        		return 0;
        }

-       frag=skb->data+ptr;
+       frag = (struct fraghdr *) (skb->data+ptr);

        DEBUGP("IPv6 FRAG LEN %u %u ", hdrlen, frag->hdrlen);
        DEBUGP("INFO %04X ", frag->info);
Binary files linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_frag.ko and linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_frag.ko differ
Binary files linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_frag.o and linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_frag.o differ
diff -Nru linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_rt.c linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_rt.c
--- linux-2.5.67-bk3.orig/net/ipv6/netfilter/ip6t_rt.c	2003-04-11 18:41:29.000000000 +0200
+++ linux-2.5.67-bk3/net/ipv6/netfilter/ip6t_rt.c	2003-04-11 18:53:36.000000000 +0200
@@ -130,7 +130,7 @@
        		return 0;
        }

-       route=skb->data+ptr;
+       route = (struct ipv6_rt_hdr *) (skb->data+ptr);

        DEBUGP("IPv6 RT LEN %u %u ", hdrlen, route->hdrlen);
        DEBUGP("TYPE %04X ", route->type);
