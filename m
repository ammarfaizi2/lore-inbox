Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268765AbUI3FnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268765AbUI3FnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 01:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268791AbUI3FnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 01:43:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:44965 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268765AbUI3FnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 01:43:08 -0400
Subject: [PATCH] ppc64: Fix incorrect initialization of hash table on some
	pSeries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>
Content-Type: text/plain
Message-Id: <1096522795.32719.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 15:39:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The hash table wasn't fully initialized on some pSeries that had
the workaround for no batching. Please apply.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc64/mm/hash_native.c 1.18 vs edited =====
--- 1.18/arch/ppc64/mm/hash_native.c	2004-09-22 14:40:30 +10:00
+++ edited/arch/ppc64/mm/hash_native.c	2004-09-30 15:34:39 +10:00
@@ -407,13 +407,13 @@
 		model = get_property(root, "model", NULL);
 		if (!strcmp(model, "CHRP IBM,9076-N81")) {
 			of_node_put(root);
-			return;
+			goto bail;
 		}
 		of_node_put(root);
 	}
 #endif /* CONFIG_PPC_PSERIES */
 
 	ppc_md.flush_hash_range = native_flush_hash_range;
-
+ bail:
 	htab_finish_init();
 }


