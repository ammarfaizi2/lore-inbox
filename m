Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262740AbSJCFoI>; Thu, 3 Oct 2002 01:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262741AbSJCFoI>; Thu, 3 Oct 2002 01:44:08 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:40120 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262740AbSJCFoH>; Thu, 3 Oct 2002 01:44:07 -0400
From: <peterc@gelato.unsw.edu.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 3 Oct 2002 15:49:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15771.55917.32838.890081@lemon.gelato.unsw.EDU.AU>
Subject: [PATCH] Large Block Device patch part 5/4
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes I forgot something...

Without this patch, trying to use RAID without CONFIG_LBD would fail.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.677   -> 1.678  
#	     drivers/md/md.c	1.113   -> 1.114  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/03	peterc@numbat.chubb.wattle.id.au	1.678
# Fix md operation without CONFIG_LBD --- don't try to include __udivdi3 etc.
# --------------------------------------------
#
diff -Nru a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Thu Oct  3 15:47:43 2002
+++ b/drivers/md/md.c	Thu Oct  3 15:47:43 2002
@@ -3480,8 +3480,12 @@
 }
 #endif
 
+#ifdef CONFIG_LBD
 extern u64 __udivdi3(u64, u64);
 extern u64 __umoddi3(u64, u64);
+EXPORT_SYMBOL(__udivdi3);
+EXPORT_SYMBOL(__umoddi3);
+#endif
 EXPORT_SYMBOL(md_size);
 EXPORT_SYMBOL(register_md_personality);
 EXPORT_SYMBOL(unregister_md_personality);
@@ -3493,6 +3497,4 @@
 EXPORT_SYMBOL(md_wakeup_thread);
 EXPORT_SYMBOL(md_print_devices);
 EXPORT_SYMBOL(md_interrupt_thread);
-EXPORT_SYMBOL(__udivdi3);
-EXPORT_SYMBOL(__umoddi3);
 MODULE_LICENSE("GPL");
