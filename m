Return-Path: <linux-kernel-owner+w=401wt.eu-S1751574AbXALCfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbXALCfJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 21:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbXALCfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 21:35:08 -0500
Received: from rgminet02.oracle.com ([148.87.113.119]:33196 "EHLO
	rgminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbXALCfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 21:35:07 -0500
Subject: [PATCH] bonding: Replace kmalloc() + memset() pairs with the
	appropriate kzalloc() calls
From: joe jin <joe.jin@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, joe.jin@oracle.com
Content-Type: text/plain
Organization: Oracle
Date: Fri, 12 Jan 2007 10:28:23 +0800
Message-Id: <1168568903.10377.7.camel@joejin-pc.cn.oracle.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27.rhel4.6) 
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace kmalloc() + memset() pairs with the appropriate
kzalloc() calls.

Signed-off-by: Joe Jin <lkmaillist@gmail.com>
--
diff -urNp old/drivers/net/bonding/bond_alb.c
new/drivers/net/bonding/bond_alb.c
--- old/drivers/net/bonding/bond_alb.c	2006-11-30 05:57:37.000000000
+0800
+++ new/drivers/net/bonding/bond_alb.c	2007-01-09 13:13:16.000000000
+0800
@@ -184,7 +184,7 @@ static int tlb_initialize(struct bonding
 
 	spin_lock_init(&(bond_info->tx_hashtbl_lock));
 
-	new_hashtbl = kmalloc(size, GFP_KERNEL);
+	new_hashtbl = kzalloc(size, GFP_KERNEL);
 	if (!new_hashtbl) {
 		printk(KERN_ERR DRV_NAME
 		       ": %s: Error: Failed to allocate TLB hash table\n",
@@ -195,8 +195,6 @@ static int tlb_initialize(struct bonding
 
 	bond_info->tx_hashtbl = new_hashtbl;
 
-	memset(bond_info->tx_hashtbl, 0, size);
-
 	for (i = 0; i < TLB_HASH_TABLE_SIZE; i++) {
 		tlb_init_table_entry(&bond_info->tx_hashtbl[i], 1);
 	}
@@ -788,7 +786,7 @@ static int rlb_initialize(struct bonding
 
 	spin_lock_init(&(bond_info->rx_hashtbl_lock));
 
-	new_hashtbl = kmalloc(size, GFP_KERNEL);
+	new_hashtbl = kzalloc(size, GFP_KERNEL);
 	if (!new_hashtbl) {
 		printk(KERN_ERR DRV_NAME
 		       ": %s: Error: Failed to allocate RLB hash table\n",
diff -urNp old/drivers/net/bonding/bond_main.c
new/drivers/net/bonding/bond_main.c
--- old/drivers/net/bonding/bond_main.c	2006-11-30 05:57:37.000000000
+0800
+++ new/drivers/net/bonding/bond_main.c	2007-01-09 13:14:20.000000000
+0800
@@ -1336,14 +1336,12 @@ int bond_enslave(struct net_device *bond
 		goto err_undo_flags;
 	}
 
-	new_slave = kmalloc(sizeof(struct slave), GFP_KERNEL);
+	new_slave = kzalloc(sizeof(struct slave), GFP_KERNEL);
 	if (!new_slave) {
 		res = -ENOMEM;
 		goto err_undo_flags;
 	}
 
-	memset(new_slave, 0, sizeof(struct slave));
-
 	/* save slave's original flags before calling
 	 * netdev_set_master and dev_open
 	 */


