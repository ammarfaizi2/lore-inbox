Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267379AbTAGNBh>; Tue, 7 Jan 2003 08:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267380AbTAGNBh>; Tue, 7 Jan 2003 08:01:37 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:1237 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S267379AbTAGNBg>; Tue, 7 Jan 2003 08:01:36 -0500
Date: Tue, 7 Jan 2003 15:10:02 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: fix "ide_scan_direction defined but not used" in ide.c
Message-ID: <20030107131002.GI25540@alhambra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide_scan_drection is only used if CONFIG_BLK_DEV_IDEPCI is defined,
giving a compilation warning otherwise. Against 2.5.54-bk. 

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.974   -> 1.975  
#	   drivers/ide/ide.c	1.48    -> 1.49   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/07	mulix@alhambra.mulix.org	1.975
# fix "defined but not used" warning
# --------------------------------------------
#
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Tue Jan  7 14:17:42 2003
+++ b/drivers/ide/ide.c	Tue Jan  7 14:17:42 2003
@@ -179,7 +179,9 @@
 
 spinlock_t ide_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
+#ifdef CONFIG_BLK_DEV_IDEPCI
 static int ide_scan_direction; /* THIS was formerly 2.2.x pci=reverse */
+#endif /* CONFIG_BLK_DEV_IDEPCI */ 
 
 #ifdef CONFIG_IDEDMA_AUTO
 int noautodma = 0;

-- 
Muli Ben-Yehuda

my opinions may seem crazy. But they all make sense. Insane sense, but
sense nontheless. -- Shlomi Fish on #offtopic.

