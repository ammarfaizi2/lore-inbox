Return-Path: <linux-kernel-owner+w=401wt.eu-S932419AbXAPGn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbXAPGn3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 01:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbXAPGn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 01:43:29 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:53138 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbXAPGn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 01:43:28 -0500
X-Greylist: delayed 100411 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 01:43:28 EST
Subject: [PATCH] slip: Replace kmalloc() + memset() pairs with the
	appropriate kzalloc() calls
From: joe jin <joe.jin@oracle.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: joe.jin@oracle.com
Content-Type: text/plain
Organization: Oracle
Date: Tue, 16 Jan 2007 14:42:57 +0800
Message-Id: <1168929777.1498.3.camel@joejin-pc.cn.oracle.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27.rhel4.6) 
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace kmalloc() + memset() pairs with the appropriate
kzalloc().

Signed-off-by: Joe Jin <joe.jin@oracle.com>

--- drivers/net/slip.c.orig	2007-01-16 14:21:52.000000000 +0800
+++ drivers/net/slip.c	2007-01-16 14:23:07.000000000 +0800
@@ -1343,15 +1343,12 @@
 	printk(KERN_INFO "SLIP linefill/keepalive option.\n");
 #endif
 
-	slip_devs = kmalloc(sizeof(struct net_device *)*slip_maxdev,
GFP_KERNEL);
+	slip_devs = kzalloc(sizeof(struct net_device *)*slip_maxdev,
GFP_KERNEL);
 	if (!slip_devs) {
 		printk(KERN_ERR "SLIP: Can't allocate slip devices array!  Uaargh! (-
> No SLIP available)\n");
 		return -ENOMEM;
 	}
 
-	/* Clear the pointer array, we allocate devices when we need them */
-	memset(slip_devs, 0, sizeof(struct net_device *)*slip_maxdev);
-
 	/* Fill in our line protocol discipline, and register it */
 	if ((status = tty_register_ldisc(N_SLIP, &sl_ldisc)) != 0)  {
 		printk(KERN_ERR "SLIP: can't register line discipline (err = %d)\n",
status);



