Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUA1NFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbUA1NFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:05:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:58125 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265958AbUA1NFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:05:41 -0500
Date: Wed, 28 Jan 2004 14:04:56 +0100
From: Willy Tarreau <willy@w.ods.org>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH-2.4] add missing '\n' in bonding messages
Message-ID: <20040128130456.GA12362@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there are a few places where the bonding driver displays informational
messages without the trailing '\n', which is sometimes annoying because
messages get logged at the wrong level.

Here's the patch against 2.4.25-pre7. I haven't checked 2.6 nor the bonding
cleanup patch against those typos.

Regards,
Willy

diff -urN linux-2.4.25-pre7/drivers/net/bonding/bond_main.c linux-2.4.25-pre7-bondfix/drivers/net/bonding/bond_main.c
--- linux-2.4.25-pre7/drivers/net/bonding/bond_main.c	Sat Nov 22 16:55:37 2003
+++ linux-2.4.25-pre7-bondfix/drivers/net/bonding/bond_main.c	Wed Jan 28 13:58:22 2004
@@ -1712,7 +1712,7 @@
 			 * all 0's.
 			 */
 #ifdef BONDING_DEBUG
-			printk(KERN_DEBUG "%s doesn't have a MAC address yet.  ",
+			printk(KERN_DEBUG "%s doesn't have a MAC address yet.\n",
 			       master_dev->name);
 			printk(KERN_DEBUG "Going to give assign it from %s.\n",
 			       slave_dev->name);
@@ -2311,7 +2311,7 @@
 
 					printk(KERN_INFO
 						"%s: link status definitely down "
-						"for interface %s, disabling it",
+						"for interface %s, disabling it.\n",
 						master->name,
 						dev->name);
 
@@ -2524,7 +2524,7 @@
 				if (oldcurrent == NULL) {
 					printk(KERN_INFO
 						"%s: link status definitely up "
-						"for interface %s, ",
+						"for interface %s.\n",
 						master->name,
 						slave->dev->name);
 					do_failover = 1;
@@ -2733,7 +2733,7 @@
 				slave->link_failure_count++;
 			}
 			printk(KERN_INFO "%s: link status down for "
-					 "active interface %s, disabling it",
+					 "active interface %s, disabling it.\n",
 			       master->name,
 			       slave->dev->name);
 			write_lock(&bond->ptrlock);
@@ -4101,7 +4101,7 @@
 	if (max_bonds < 1 || max_bonds > INT_MAX) {
 		printk(KERN_WARNING 
 		       "bonding_init(): max_bonds (%d) not in range %d-%d, "
-		       "so it was reset to BOND_DEFAULT_MAX_BONDS (%d)",
+		       "so it was reset to BOND_DEFAULT_MAX_BONDS (%d)\n",
 		       max_bonds, 1, INT_MAX, BOND_DEFAULT_MAX_BONDS);
 		max_bonds = BOND_DEFAULT_MAX_BONDS;
 	}
