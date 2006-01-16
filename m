Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWAPEym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWAPEym (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 23:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWAPEym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 23:54:42 -0500
Received: from xenotime.net ([66.160.160.81]:54228 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751023AbWAPEyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 23:54:41 -0500
Date: Sun, 15 Jan 2006 20:54:34 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, pavel@suse.cz, mochel <mochel@digitalimplant.org>
Subject: [PATCH] (-mm) kernel/power: move externs to header files
Message-Id: <20060115205434.7b803673.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Move externs from C source files to header files.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/pm.h   |    3 ++-
 kernel/power/disk.c  |   11 -----------
 kernel/power/power.h |    6 +++++-
 3 files changed, 7 insertions(+), 13 deletions(-)

--- linux-2615-mm4.orig/include/linux/pm.h
+++ linux-2615-mm4/include/linux/pm.h
@@ -188,6 +188,8 @@ extern void device_power_up(void);
 extern void device_resume(void);
 
 #ifdef CONFIG_PM
+extern suspend_disk_method_t pm_disk_mode;
+
 extern int device_suspend(pm_message_t state);
 
 #define device_set_wakeup_enable(dev,val) \
@@ -215,7 +217,6 @@ static inline int dpm_runtime_suspend(st
 
 static inline void dpm_runtime_resume(struct device * dev)
 {
-
 }
 
 #endif
--- linux-2615-mm4.orig/kernel/power/disk.c
+++ linux-2615-mm4/kernel/power/disk.c
@@ -23,17 +23,6 @@
 #include "power.h"
 
 
-extern suspend_disk_method_t pm_disk_mode;
-
-extern int swsusp_shrink_memory(void);
-extern int swsusp_suspend(void);
-extern int swsusp_write(void);
-extern int swsusp_check(void);
-extern int swsusp_read(void);
-extern void swsusp_close(void);
-extern int swsusp_resume(void);
-
-
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
 dev_t swsusp_resume_device;
--- linux-2615-mm4.orig/kernel/power/power.h
+++ linux-2615-mm4/kernel/power/power.h
@@ -59,7 +59,6 @@ extern asmlinkage int swsusp_arch_suspen
 extern asmlinkage int swsusp_arch_resume(void);
 
 extern unsigned int count_data_pages(void);
-extern void swsusp_free(void);
 
 struct snapshot_handle {
 	loff_t		offset;
@@ -102,6 +101,11 @@ extern struct bitmap_page *alloc_bitmap(
 extern unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap);
 extern void free_all_swap_pages(int swap, struct bitmap_page *bitmap);
 
+extern int swsusp_check(void);
 extern int swsusp_shrink_memory(void);
+extern void swsusp_free(void);
 extern int swsusp_suspend(void);
 extern int swsusp_resume(void);
+extern int swsusp_read(void);
+extern int swsusp_write(void);
+extern void swsusp_close(void);


---
~Randy
