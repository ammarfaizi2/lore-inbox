Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267932AbTBYLqH>; Tue, 25 Feb 2003 06:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267934AbTBYLqH>; Tue, 25 Feb 2003 06:46:07 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:11405 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S267932AbTBYLqG>; Tue, 25 Feb 2003 06:46:06 -0500
Date: Tue, 25 Feb 2003 06:56:09 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302251156.h1PBu8BT030035@locutus.cmf.nrl.navy.mil>
To: davem@redhat.com
Subject: [PATCH][ATM] let upper layer know lec supports multicast
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the ip layer uses the presence of the .set_multicast_list to determine
if the underlying network device supports multicast.

Index: linux/net/atm/lec.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/lec.c,v
retrieving revision 1.7
diff -u -d -b -w -r1.7 lec.c
--- linux/net/atm/lec.c	24 Feb 2003 13:34:43 -0000	1.7
+++ linux/net/atm/lec.c	25 Feb 2003 11:49:42 -0000
@@ -617,6 +617,14 @@
         return 0;
 }
 
+static void lec_set_multicast_list(struct net_device *dev)
+{
+	/* by default, all multicast frames arrive over the bus.
+         * eventually support selective multicast service
+         */
+        return;
+}
+
 static void 
 lec_init(struct net_device *dev)
 {
@@ -626,7 +634,7 @@
         dev->hard_start_xmit = lec_send_packet;
 
         dev->get_stats = lec_get_stats;
-        dev->set_multicast_list = NULL;
+        dev->set_multicast_list = lec_set_multicast_list;
         dev->do_ioctl  = NULL;
         printk("%s: Initialized!\n",dev->name);
         return;
