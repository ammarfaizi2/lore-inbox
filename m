Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVHVUnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVHVUnV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVHVUnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:43:21 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:33255 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751127AbVHVUnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:43:20 -0400
Date: Mon, 22 Aug 2005 18:21:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] arch/i386/kernel/traps.c: fix SYSFS=n compile
Message-ID: <20050822162101.GE9927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with CONFIG_SYSFS=n 
introduced by sysfs-crash-debugging.patch:

<--  snip  -->

...
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `die':
: undefined reference to `last_sysfs_file'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/arch/i386/kernel/traps.c.old	2005-08-22 03:19:52.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/arch/i386/kernel/traps.c	2005-08-22 03:20:23.000000000 +0200
@@ -370,7 +370,9 @@
 #endif
 		if (nl)
 			printk("\n");
+#ifdef CONFIG_SYSFS
 		printk(KERN_ALERT "last sysfs file: %s\n", last_sysfs_file);
+#endif
 #ifdef CONFIG_KGDB
 	/* This is about the only place we want to go to kgdb even if in
 	 * user mode.  But we must go in via a trap so within kgdb we will

