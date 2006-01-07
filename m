Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932720AbWAGMMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbWAGMMI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 07:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWAGMMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 07:12:08 -0500
Received: from cantor2.suse.de ([195.135.220.15]:32969 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932720AbWAGMMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 07:12:07 -0500
Date: Sat, 7 Jan 2006 13:12:05 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix compilation with CONFIG_MEMORY_HOTPLUG=y and gcc41.
Message-ID: <20060107121205.GA13427@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix compilation with CONFIG_MEMORY_HOTPLUG=y and gcc41.
Also remove unneeded declations, add a public function.

drivers/base/memory.c:53: error: static declaration of 'register_memory_notifier' follows non-static declaration
include/linux/memory.h:85: error: previous declaration of 'register_memory_notifier' was here
drivers/base/memory.c:58: error: static declaration of 'unregister_memory_notifier' follows non-static declaration
include/linux/memory.h:86: error: previous declaration of 'unregister_memory_notifier' was here
drivers/base/memory.c:68: error: static declaration of 'register_memory' follows non-static declaration
include/linux/memory.h:73: error: previous declaration of 'register_memory' was here

drivers/base/memory.c:46: warning: initialization from incompatible pointer type

Signed-off-by: Olaf Hering <olh@suse.de>

 drivers/base/memory.c  |    2 +-
 include/linux/memory.h |    8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

Index: linux-2.6.15-olh/include/linux/memory.h
===================================================================
--- linux-2.6.15-olh.orig/include/linux/memory.h
+++ linux-2.6.15-olh/include/linux/memory.h
@@ -70,21 +70,15 @@ static inline void unregister_memory_not
 {
 }
 #else
-extern int register_memory(struct memory_block *, struct mem_section *section, struct node *);
 extern int register_new_memory(struct mem_section *);
 extern int unregister_memory_section(struct mem_section *);
 extern int memory_dev_init(void);
-extern int register_memory_notifier(struct notifier_block *nb);
-extern void unregister_memory_notifier(struct notifier_block *nb);
+extern int remove_memory_block(unsigned long, struct mem_section *, int)
 
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 
-extern int invalidate_phys_mapping(unsigned long, unsigned long);
 struct notifier_block;
 
-extern int register_memory_notifier(struct notifier_block *nb);
-extern void unregister_memory_notifier(struct notifier_block *nb);
-
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #define hotplug_memory_notifier(fn, pri) {			\
Index: linux-2.6.15-olh/drivers/base/memory.c
===================================================================
--- linux-2.6.15-olh.orig/drivers/base/memory.c
+++ linux-2.6.15-olh/drivers/base/memory.c
@@ -29,7 +29,7 @@ static struct sysdev_class memory_sysdev
 	set_kset_name(MEMORY_CLASS_NAME),
 };
 
-static char *memory_hotplug_name(struct kset *kset, struct kobject *kobj)
+static const char *memory_hotplug_name(struct kset *kset, struct kobject *kobj)
 {
 	return MEMORY_CLASS_NAME;
 }
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
