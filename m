Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268136AbUIWB0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268136AbUIWB0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUIWBXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:23:45 -0400
Received: from [12.177.129.25] ([12.177.129.25]:3524 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267940AbUIWBTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:19:12 -0400
Message-Id: <200409230224.i8N2OQiF004285@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH] UML - Error message improvement
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Sep 2004 22:24:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Output a nice error message for people who need mem > 256M but don't increase
on the host /proc/sys/vm/max_map_count, telling them to do so.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9-rc2-mm1-orig/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/kernel/physmem.c	2004-09-22 19:51:02.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/kernel/physmem.c	2004-09-22 20:34:22.000000000 -0400
@@ -336,9 +336,14 @@
 
 	fd = phys_mapping(phys, &offset);
 	err = os_map_memory((void *) virt, fd, offset, len, r, w, x);
-	if(err)
+	if(err) {
+		if(err == -ENOMEM)
+			printk("try increasing the host's "
+			       "/proc/sys/vm/max_map_count to <physical "
+			       "memory size>/4096\n");
 		panic("map_memory(0x%lx, %d, 0x%llx, %ld, %d, %d, %d) failed, "
 		      "err = %d\n", virt, fd, offset, len, r, w, x, err);
+	}
 }
 
 #define PFN_UP(x) (((x) + PAGE_SIZE-1) >> PAGE_SHIFT)

