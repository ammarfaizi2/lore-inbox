Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUFFQK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUFFQK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUFFQK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:10:28 -0400
Received: from may.priocom.com ([213.156.65.50]:44030 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S263770AbUFFQKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:10:22 -0400
Subject: [PATCH] 2.6.6 memory allocation checks in eth1394_update()
From: Yury Umanets <torque@ukrpost.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086538251.2793.74.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 19:10:51 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds memory allocation checks in eth1394_update().

 ./linux-2.6.6-modified/drivers/ieee1394/eth1394.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Signed-off-by: Yury Umanets <torque@ukrpost.net>

diff -rupN ./linux-2.6.6/drivers/ieee1394/eth1394.c
./linux-2.6.6-modified/drivers/ieee1394/eth1394.c
--- ./linux-2.6.6/drivers/ieee1394/eth1394.c	Mon May 10 05:32:52 2004
+++ ./linux-2.6.6-modified/drivers/ieee1394/eth1394.c	Wed Jun  2
14:19:59 2004
@@ -431,9 +431,12 @@ static int eth1394_update(struct unit_di
 		if (!node)
 			return -ENOMEM;
 
-
 		node_info = kmalloc(sizeof(struct eth1394_node_info),
 				    in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
+		if (!node_info) {
+			kfree(node);
+			return -ENOMEM;
+                }
 
 		spin_lock_init(&node_info->pdg.lock);
 		INIT_LIST_HEAD(&node_info->pdg.list);

-- 
umka

