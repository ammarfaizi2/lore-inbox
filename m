Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269060AbTBXBSt>; Sun, 23 Feb 2003 20:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269061AbTBXBSt>; Sun, 23 Feb 2003 20:18:49 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:49804 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S269060AbTBXBSl>; Sun, 23 Feb 2003 20:18:41 -0500
Date: Sun, 23 Feb 2003 20:28:42 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302240128.h1O1SgdN027866@locutus.cmf.nrl.navy.mil>
To: davem@redhat.com
Subject: [PATCH][ATM] prevent compiler warning when compiling w/o bridging
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Index: linux/net/atm/lec.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/lec.c,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -d -b -w -r1.2 -r1.3
--- linux/net/atm/lec.c	22 Feb 2003 17:35:45 -0000	1.2
+++ linux/net/atm/lec.c	22 Feb 2003 17:38:23 -0000	1.3
@@ -36,6 +36,10 @@
 #include <linux/if_bridge.h>
 #include "../bridge/br_private.h"
 static unsigned char bridge_ula_lec[] = {0x01, 0x80, 0xc2, 0x00, 0x00};
+
+extern struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
+       unsigned char *addr);
+extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
 #endif
 
 /* Modular too */
@@ -51,10 +55,6 @@
 #else
 #define DPRINTK(format,args...)
 #endif
-
-extern struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
-       unsigned char *addr);
-extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
 
 static spinlock_t lec_arp_spinlock = SPIN_LOCK_UNLOCKED;
 
