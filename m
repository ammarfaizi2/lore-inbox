Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSHKLkd>; Sun, 11 Aug 2002 07:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318291AbSHKLkd>; Sun, 11 Aug 2002 07:40:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49621 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318290AbSHKLkc>; Sun, 11 Aug 2002 07:40:32 -0400
Date: Sun, 11 Aug 2002 13:44:15 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       <linux-atalk@lists.netspace.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.31
In-Reply-To: <Pine.LNX.4.33.0208101854340.2656-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0208111337560.3636-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Aug 2002, Linus Torvalds wrote:

>...
> Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
>...
>   o Appletalk: more cleanups and code reorganization
>...

The s/at_addr/atalk_addr/ in atalk.h broke the compilation of
drivers/net/appletalk/*. The patch below fixes it.

cu
Adrian


--- drivers/net/appletalk/cops.c.old	2002-08-11 13:32:53.000000000 +0200
+++ drivers/net/appletalk/cops.c	2002-08-11 13:33:32.000000000 +0200
@@ -181,7 +181,7 @@
         int board;			/* Holds what board type is. */
 	int nodeid;			/* Set to 1 once have nodeid. */
         unsigned char node_acquire;	/* Node ID when acquired. */
-        struct at_addr node_addr;	/* Full node address */
+        struct atalk_addr node_addr;	/* Full node address */
 };

 /* Index to functions, as function prototypes. */
@@ -956,7 +956,7 @@
 {
         struct cops_local *lp = (struct cops_local *)dev->priv;
         struct sockaddr_at *sa=(struct sockaddr_at *)&ifr->ifr_addr;
-        struct at_addr *aa=(struct at_addr *)&lp->node_addr;
+        struct atalk_addr *aa=(struct atalk_addr *)&lp->node_addr;

         switch(cmd)
         {
--- drivers/net/appletalk/ipddp.c.old	2002-08-11 13:33:55.000000000 +0200
+++ drivers/net/appletalk/ipddp.c	2002-08-11 13:34:05.000000000 +0200
@@ -116,7 +116,7 @@
 	u32 paddr = ((struct rtable*)skb->dst)->rt_gateway;
         struct ddpehdr *ddp;
         struct ipddp_route *rt;
-        struct at_addr *our_addr;
+        struct atalk_addr *our_addr;

 	/*
          * Find appropriate route to use, based only on IP number.
--- drivers/net/appletalk/ipddp.h.old	2002-08-11 13:34:59.000000000 +0200
+++ drivers/net/appletalk/ipddp.h	2002-08-11 13:36:06.000000000 +0200
@@ -15,7 +15,7 @@
 {
         struct net_device *dev;             /* Carrier device */
         __u32 ip;                       /* IP address */
-        struct at_addr at;              /* Gateway appletalk address */
+        struct atalk_addr at;              /* Gateway appletalk address */
         int flags;
         struct ipddp_route *next;
 };
--- drivers/net/appletalk/ltpc.c.old	2002-08-11 13:36:16.000000000 +0200
+++ drivers/net/appletalk/ltpc.c	2002-08-11 13:36:36.000000000 +0200
@@ -262,7 +262,7 @@
 struct ltpc_private
 {
 	struct net_device_stats stats;
-	struct at_addr my_addr;
+	struct atalk_addr my_addr;
 };

 /* transmit queue element struct */
@@ -826,7 +826,7 @@
 {
 	struct sockaddr_at *sa = (struct sockaddr_at *) &ifr->ifr_addr;
 	/* we'll keep the localtalk node address in dev->pa_addr */
-	struct at_addr *aa = &((struct ltpc_private *)dev->priv)->my_addr;
+	struct atalk_addr *aa = &((struct ltpc_private *)dev->priv)->my_addr;
 	struct lt_init c;
 	int ltflags;


