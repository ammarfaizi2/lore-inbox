Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268728AbTBZMUs>; Wed, 26 Feb 2003 07:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268729AbTBZMUs>; Wed, 26 Feb 2003 07:20:48 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:54670 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S268728AbTBZMUr>; Wed, 26 Feb 2003 07:20:47 -0500
Date: Wed, 26 Feb 2003 07:30:50 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302261230.h1QCUox9003790@locutus.cmf.nrl.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][ATM] remove mod_inc_use_count from lec
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch removes the deprecated MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT
from the lane client.

Index: linux/net/atm/lec.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/lec.c,v
retrieving revision 1.8
retrieving revision 1.9
diff -u -r1.8 -r1.9
--- linux/net/atm/lec.c	25 Feb 2003 11:59:08 -0000	1.8
+++ linux/net/atm/lec.c	25 Feb 2003 19:48:44 -0000	1.9
@@ -543,7 +543,6 @@
         }
   
 	printk("%s: Shut down!\n", dev->name);
-        MOD_DEC_USE_COUNT;
 }
 
 static struct atmdev_ops lecdev_ops = {
@@ -824,7 +823,6 @@
         if (dev_lec[i]->flags & IFF_UP) {
                 netif_start_queue(dev_lec[i]);
         }
-        MOD_INC_USE_COUNT;
         return i;
 }
 
Index: linux/net/atm/mpc.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/mpc.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- linux/net/atm/mpc.c	20 Feb 2003 13:46:30 -0000	1.1
+++ linux/net/atm/mpc.c	26 Feb 2003 12:27:30 -0000	1.2
@@ -799,7 +799,6 @@
 			send_set_mps_ctrl_addr(mpc->mps_ctrl_addr, mpc);
 	}
 
-	MOD_INC_USE_COUNT;
 	return arg;
 }
 
@@ -848,7 +847,6 @@
 	
 	printk("mpoa: (%s) going down\n",
 		(mpc->dev) ? mpc->dev->name : "<unknown>");
-	MOD_DEC_USE_COUNT;
 
 	return;
 }
