Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbSJDWvE>; Fri, 4 Oct 2002 18:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbSJDWto>; Fri, 4 Oct 2002 18:49:44 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:34123 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261772AbSJDWti>; Fri, 4 Oct 2002 18:49:38 -0400
Date: Fri, 4 Oct 2002 16:03:36 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210042303.g94N3aZ10016@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40: lkcd (2/9): dump notifier
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dump notification list additions.

diff -urN -X /home/bharata/dontdiff linux-2.5.40/kernel/sys.c linux-2.5.40+lkcd/kernel/sys.c
--- linux-2.5.40/kernel/sys.c	Tue Oct  1 12:36:17 2002
+++ linux-2.5.40+lkcd/kernel/sys.c	Thu Oct  3 07:19:06 2002
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/times.h>
 #include <linux/security.h>
+#include <linux/dump.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -76,6 +77,7 @@
  */
 
 static struct notifier_block *reboot_notifier_list;
+struct notifier_block *dump_notifier_list;
 rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
 
 /**
@@ -194,6 +196,37 @@
 	return notifier_chain_unregister(&reboot_notifier_list, nb);
 }
 
+/**
+ *	register_dump_notifier - Register function to be called at dump time
+ *	@nb: Info about notifier function to be called
+ *
+ *	Registers a function with the list of functions
+ *	to be called at dump time.
+ *
+ *	Currently always returns zero, as notifier_chain_register
+ *	always returns zero.
+ */
+ 
+int register_dump_notifier(struct notifier_block * nb)
+{
+	return notifier_chain_register(&dump_notifier_list, nb);
+}
+
+/**
+ *	unregister_dump_notifier - Unregister previously registered dump notifier
+ *	@nb: Hook to be unregistered
+ *
+ *	Unregisters a previously registered dump
+ *	notifier function.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ */
+ 
+int unregister_dump_notifier(struct notifier_block * nb)
+{
+	return notifier_chain_unregister(&dump_notifier_list, nb);
+}
+
 asmlinkage long sys_ni_syscall(void)
 {
 	return -ENOSYS;
