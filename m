Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVFUFlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVFUFlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVFTWm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:42:27 -0400
Received: from coderock.org ([193.77.147.115]:27547 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262287AbVFTWFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:05:23 -0400
Message-Id: <20050620215712.840835000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:57:13 +0200
From: domen@coderock.org
To: pavel@suse.cz
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: [patch 2/2] kernel/power/disk.c string fix and if-less iterator
Content-Disposition: inline; filename=string-kernel_power_disk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>



The attached patch:

o  Fixes kernel/power/disk.c string declared as 'char *p = "...";' to be
   declared as 'char p[] = "...";', as pointed by Jeff Garzik.

o  Replaces:
	i++:
	if (i > 3) i = 0;

   By:
	i = (i + 1) % (sizeof(p) - 1);

   Which is if-less, and the adjust value is evaluated by the compiler in
   compile-time in case the string related to this loop is modified.


---
 disk.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

Index: quilt/kernel/power/disk.c
===================================================================
--- quilt.orig/kernel/power/disk.c
+++ quilt/kernel/power/disk.c
@@ -91,15 +91,13 @@ static void free_some_memory(void)
 	unsigned int i = 0;
 	unsigned int tmp;
 	unsigned long pages = 0;
-	char *p = "-\\|/";
+	char p[] = "-\\|/";
 
 	printk("Freeing memory...  ");
 	while ((tmp = shrink_all_memory(10000))) {
 		pages += tmp;
 		printk("\b%c", p[i]);
-		i++;
-		if (i > 3)
-			i = 0;
+		i = (i + 1) % (sizeof(p) - 1);
 	}
 	printk("\bdone (%li pages freed)\n", pages);
 }

--
