Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbVKGW4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbVKGW4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965587AbVKGW4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:56:12 -0500
Received: from admingilde.org ([213.95.32.146]:46473 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S965345AbVKGW4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:56:08 -0500
Message-Id: <20051107225605.308645000@admingilde.org>
References: <20051107225408.911193000@admingilde.org>
Date: Mon, 07 Nov 2005 23:54:11 +0100
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2/4] DocBook: include printk documentation
Content-Disposition: inline; filename=docbook-document-printk.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: include printk documentation

Add printk documentation to kernel-api.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---
 Documentation/DocBook/kernel-api.tmpl |    4 +---
 kernel/printk.c                       |   16 ++++++++++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

Index: linux-docbook/kernel/printk.c
===================================================================
--- linux-docbook.orig/kernel/printk.c	2005-05-22 22:15:21.000000000 +0200
+++ linux-docbook/kernel/printk.c	2005-05-31 09:58:56.000000000 +0200
@@ -488,7 +488,10 @@ static int __init printk_time_setup(char
 
 __setup("time", printk_time_setup);
 
-/*
+/**
+ * printk - print a kernel message
+ * @fmt: format string
+ *
  * This is printk.  It can be called from any context.  We want it to work.
  * 
  * We try to grab the console_sem.  If we succeed, it's easy - we log the output and
@@ -500,6 +503,9 @@ __setup("time", printk_time_setup);
  * One effect of this deferred printing is that code which calls printk() and
  * then changes console_loglevel may break. This is because console_loglevel
  * is inspected when the actual printing occurs.
+ *
+ * See also:
+ * printf(3)
  */
 
 asmlinkage int printk(const char *fmt, ...)
@@ -636,6 +642,9 @@ static void call_console_drivers(unsigne
 
 /**
  * add_preferred_console - add a device to the list of preferred consoles.
+ * @name: device name
+ * @idx: device index
+ * @options: options for this console
  *
  * The last preferred console added will be used for kernel messages
  * and stdin/out/err for init.  Normally this is used by console_setup
@@ -745,7 +754,8 @@ void release_console_sem(void)
 }
 EXPORT_SYMBOL(release_console_sem);
 
-/** console_conditional_schedule - yield the CPU if required
+/**
+ * console_conditional_schedule - yield the CPU if required
  *
  * If the console code is currently allowed to sleep, and
  * if this CPU should yield the CPU to another task, do
@@ -949,6 +959,8 @@ EXPORT_SYMBOL(unregister_console);
 
 /**
  * tty_write_message - write a message to a certain tty, not just the console.
+ * @tty: the destination tty_struct
+ * @msg: the message to write
  *
  * This is used for messages that need to be redirected to a specific tty.
  * We don't put it into the syslog queue right now maybe in the future if
Index: linux-docbook/Documentation/DocBook/kernel-api.tmpl
===================================================================
--- linux-docbook.orig/Documentation/DocBook/kernel-api.tmpl	2005-05-31 09:58:55.000000000 +0200
+++ linux-docbook/Documentation/DocBook/kernel-api.tmpl	2005-05-31 09:58:56.000000000 +0200
@@ -68,9 +68,7 @@ X!Iinclude/linux/kobject.h
 
      <sect1><title>Kernel utility functions</title>
 !Iinclude/linux/kernel.h
-<!-- This needs to clean up to make kernel-doc happy
-X!Ekernel/printk.c
- -->
+!Ekernel/printk.c
 !Ekernel/panic.c
 !Ekernel/sys.c
 !Ekernel/rcupdate.c

--
Martin Waitz
