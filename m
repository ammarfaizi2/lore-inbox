Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265958AbUFIUoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUFIUoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUFIUoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:44:06 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:24461
	"EHLO voidhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S265958AbUFIUnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:43:51 -0400
Date: Wed, 9 Jun 2004 21:43:23 +0100
From: Andy Whitcroft <apw@shadowen.org>
Message-Id: <200406092043.i59KhNh7030885@voidhawk.shadowen.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] modprobe_path and hotplug_path sizes and sysctl
Cc: akpm@osdl.org, apw@shadowen.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both modprobe_path and hotplug_path are arbitrarily sized at 256
bytes and that size is also expressed directly in the sysctl code.
It seems reasonable to define a standard length and use that for
consitancy.  This patch introduces the constant KMOD_PATH_LEN and
uses that.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---
 include/linux/kmod.h |    2 ++
 kernel/kmod.c        |    4 ++--
 kernel/sysctl.c      |    4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/kmod.h current/include/linux/kmod.h
--- reference/include/linux/kmod.h	2004-01-09 06:59:10.000000000 +0000
+++ current/include/linux/kmod.h	2004-06-08 15:55:20.000000000 +0100
@@ -23,6 +23,8 @@
 #include <linux/errno.h>
 #include <linux/compiler.h>
 
+#define KMOD_PATH_LEN 256
+
 #ifdef CONFIG_KMOD
 /* modprobe exit status on success, -ve on error.  Return value
  * usually useless though. */
diff -X /home/apw/lib/vdiff.excl -rupN reference/kernel/kmod.c current/kernel/kmod.c
--- reference/kernel/kmod.c	2004-05-10 14:55:16.000000000 +0100
+++ current/kernel/kmod.c	2004-06-08 15:55:20.000000000 +0100
@@ -47,7 +47,7 @@ static struct workqueue_struct *khelper_
 /*
 	modprobe_path is set via /proc/sys.
 */
-char modprobe_path[256] = "/sbin/modprobe";
+char modprobe_path[KMOD_PATH_LEN] = "/sbin/modprobe";
 
 /**
  * request_module - try to load a kernel module
@@ -132,7 +132,7 @@ EXPORT_SYMBOL(request_module);
 	events.  the command is expected to load drivers when
 	necessary, and may perform additional system setup.
 */
-char hotplug_path[256] = "/sbin/hotplug";
+char hotplug_path[KMOD_PATH_LEN] = "/sbin/hotplug";
 
 EXPORT_SYMBOL(hotplug_path);
 
diff -X /home/apw/lib/vdiff.excl -rupN reference/kernel/sysctl.c current/kernel/sysctl.c
--- reference/kernel/sysctl.c	2004-06-08 13:40:46.000000000 +0100
+++ current/kernel/sysctl.c	2004-06-08 15:55:20.000000000 +0100
@@ -392,7 +392,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_MODPROBE,
 		.procname	= "modprobe",
 		.data		= &modprobe_path,
-		.maxlen		= 256,
+		.maxlen		= KMOD_PATH_LEN,
 		.mode		= 0644,
 		.proc_handler	= &proc_dostring,
 		.strategy	= &sysctl_string,
@@ -403,7 +403,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_HOTPLUG,
 		.procname	= "hotplug",
 		.data		= &hotplug_path,
-		.maxlen		= 256,
+		.maxlen		= KMOD_PATH_LEN,
 		.mode		= 0644,
 		.proc_handler	= &proc_dostring,
 		.strategy	= &sysctl_string,
