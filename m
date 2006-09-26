Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWIZRyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWIZRyh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWIZRyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:54:37 -0400
Received: from [198.99.130.12] ([198.99.130.12]:6307 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932215AbWIZRyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:54:35 -0400
Message-Id: <200609261753.k8QHrPth005550@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] UML - fix allocation size
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Sep 2006 13:53:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an instance of ptr=alloc(sizeof(ptr)).  Grepping showed no more instances
of this pattern.

Also fixed the formatting in the area.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2006-09-22 10:17:11.000000000 -0400
@@ -560,12 +560,13 @@ static int eth_setup(char *str)
 	int n, err;
 
 	err = eth_parse(str, &n, &str);
-	if(err) return(1);
+	if(err)
+		return 1;
 
-	new = alloc_bootmem(sizeof(new));
+	new = alloc_bootmem(sizeof(*new));
 	if (new == NULL){
 		printk("eth_init : alloc_bootmem failed\n");
-		return(1);
+		return 1;
 	}
 
 	INIT_LIST_HEAD(&new->list);
@@ -573,7 +574,7 @@ static int eth_setup(char *str)
 	new->init = str;
 
 	list_add_tail(&new->list, &eth_cmd_line);
-	return(1);
+	return 1;
 }
 
 __setup("eth", eth_setup);

