Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbTAFED3>; Sun, 5 Jan 2003 23:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTAFED2>; Sun, 5 Jan 2003 23:03:28 -0500
Received: from dp.samba.org ([66.70.73.150]:43744 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266078AbTAFEDP>;
	Sun, 5 Jan 2003 23:03:15 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Handle kmalloc fails: drivers_pci_probe.c
Date: Mon, 06 Jan 2003 15:00:08 +1100
Message-Id: <20030106041151.825982C267@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Looks trivially correct --RR ]
From:  Pablo Menichini <pablo@menichini.com.ar>

  Best regards,
          Pablo
  

--- trivial-2.5-bk/drivers/pci/probe.c.orig	2003-01-06 14:10:57.000000000 +1100
+++ trivial-2.5-bk/drivers/pci/probe.c	2003-01-06 14:10:57.000000000 +1100
@@ -558,9 +558,15 @@
 	b = pci_alloc_bus();
 	if (!b)
 		return NULL;
+	
+	b->dev = kmalloc(sizeof(*(b->dev)),GFP_KERNEL);
+	if (!b->dev){
+		kfree(b);
+		return NULL;
+	}
+	
 	list_add_tail(&b->node, &pci_root_buses);
 
-	b->dev = kmalloc(sizeof(*(b->dev)),GFP_KERNEL);
 	memset(b->dev,0,sizeof(*(b->dev)));
 	sprintf(b->dev->bus_id,"pci%d",bus);
 	strcpy(b->dev->name,"Host/PCI Bridge");
-- 
  Don't blame me: the Monkey is driving
  File: Pablo Menichini <pablo@menichini.com.ar>: [PATCH][2.5.53] Handle kmalloc fails: drivers_pci_probe.c
