Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUIARRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUIARRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUIAPzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:55:54 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:60338 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267338AbUIAPvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:46 -0400
Date: Wed, 1 Sep 2004 16:51:21 +0100
Message-Id: <200409011551.i81FpLVF000615@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix another PNP leak.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pnp/pnpbios/core.c linux-2.6/drivers/pnp/pnpbios/core.c
--- bk-linus/drivers/pnp/pnpbios/core.c	2004-07-14 00:00:48.000000000 +0100
+++ linux-2.6/drivers/pnp/pnpbios/core.c	2004-08-23 14:08:16.000000000 +0100
@@ -252,8 +252,10 @@ static int pnpbios_set_resources(struct 
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
-	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node))
+	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
+		kfree(node);
 		return -ENODEV;
+	}
 	if(pnpbios_write_resources_to_node(res, node)<0) {
 		kfree(node);
 		return -1;
