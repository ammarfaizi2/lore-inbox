Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSJJIZz>; Thu, 10 Oct 2002 04:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSJJIZz>; Thu, 10 Oct 2002 04:25:55 -0400
Received: from [195.39.17.254] ([195.39.17.254]:24836 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263321AbSJJIZy>;
	Thu, 10 Oct 2002 04:25:54 -0400
Date: Thu, 10 Oct 2002 10:28:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Make kernel/suspend.c compile with DISCONTIGMEM
Message-ID: <20021010082813.GA700@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans up includes a tiny bit and makes it compile on
CONFIG_DISCONTIGMEM. Thanx to BUG_ON(), code is not really changed at
all.
								Pavel

--- clean/kernel/suspend.c	2002-10-08 21:25:38.000000000 +0200
+++ linux-swsusp/kernel/suspend.c	2002-10-08 22:29:36.000000000 +0200
@@ -57,12 +57,13 @@
 #include <linux/pm.h>
 #include <linux/device.h>
 #include <linux/buffer_head.h>
+#include <linux/swapops.h>
+#include <linux/bootmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
-#include <linux/swapops.h>
 
 extern void signal_wake_up(struct task_struct *t);
 extern int sys_sync(void);
@@ -474,9 +475,9 @@
 #ifdef CONFIG_DISCONTIGMEM
 	panic("Discontingmem not supported");
 #else
-	BUG_ON (max_mapnr != num_physpages);
+	BUG_ON (max_pfn != num_physpages);
 #endif
-	for (pfn = 0; pfn < max_mapnr; pfn++) {
+	for (pfn = 0; pfn < max_pfn; pfn++) {
 		page = pfn_to_page(pfn);
 		if (PageHighMem(page))
 			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
