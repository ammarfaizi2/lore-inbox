Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUGQWpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUGQWpb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUGQWo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:44:59 -0400
Received: from digitalimplant.org ([64.62.235.95]:57065 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262932AbUGQWgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:36:12 -0400
Date: Sat, 17 Jul 2004 15:36:02 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [22/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171532260.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1864, 2004/07/17 13:30:02-07:00, mochel@digitalimplant.org

[Power Mgmt] Remove pmdisk.

- Remove kernel/power/pmdisk.c.
- Remove CONFIG_PM_STD config option.
- Fix up Makefile.


 kernel/power/pmdisk.c |   35 -----------------------------------
 kernel/power/Kconfig  |   12 ------------
 kernel/power/Makefile |    3 +--
 kernel/power/power.h  |    2 +-
 4 files changed, 2 insertions(+), 50 deletions(-)


diff -Nru a/kernel/power/Kconfig b/kernel/power/Kconfig
--- a/kernel/power/Kconfig	2004-07-17 14:50:33 -07:00
+++ b/kernel/power/Kconfig	2004-07-17 14:50:33 -07:00
@@ -42,18 +42,6 @@

 	  For more information take a look at Documentation/power/swsusp.txt.

-config PM_DISK
-	bool "PMDisk Support"
-	depends on SOFTWARE_SUSPEND && X86 && !X86_64
-	---help---
-
-	This option enables an alternative implementation of Suspend-to-Disk.
-	It is functionally equivalent to Software Suspend, and uses many of
-	the same internal routines. But, it offers a slightly different
-	interface.
-
-	If unsure, Say N.
-
 config PM_STD_PARTITION
 	string "Default resume partition"
 	depends on SOFTWARE_SUSPEND
diff -Nru a/kernel/power/Makefile b/kernel/power/Makefile
--- a/kernel/power/Makefile	2004-07-17 14:50:33 -07:00
+++ b/kernel/power/Makefile	2004-07-17 14:50:33 -07:00
@@ -2,7 +2,6 @@
 swsusp-smp-$(CONFIG_SMP)	+= smp.o

 obj-y				:= main.o process.o console.o pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o $(swsusp-smp-y)
-obj-$(CONFIG_PM_DISK)		+= disk.o pmdisk.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o $(swsusp-smp-y) disk.o

 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:50:33 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,35 +0,0 @@
-/*
- * kernel/power/pmdisk.c - Suspend-to-disk implmentation
- *
- * This STD implementation is initially derived from swsusp (suspend-to-swap).
- * The original copyright on that was:
- *
- * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
- * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
- *
- * The additional parts are:
- *
- * Copyright (C) 2003 Patrick Mochel
- * Copyright (C) 2003 Open Source Development Lab
- *
- * This file is released under the GPLv2.
- *
- * For more information, please see the text files in Documentation/power/
- *
- */
-
-#undef DEBUG
-
-#include <linux/mm.h>
-#include <linux/bio.h>
-#include <linux/suspend.h>
-#include <linux/version.h>
-#include <linux/reboot.h>
-#include <linux/device.h>
-#include <linux/swapops.h>
-#include <linux/bootmem.h>
-
-#include <asm/mmu_context.h>
-
-#include "power.h"
-
diff -Nru a/kernel/power/power.h b/kernel/power/power.h
--- a/kernel/power/power.h	2004-07-17 14:50:33 -07:00
+++ b/kernel/power/power.h	2004-07-17 14:50:33 -07:00
@@ -23,7 +23,7 @@



-#ifdef CONFIG_PM_DISK
+#ifdef CONFIG_SOFTWARE_SUSPEND
 extern int pm_suspend_disk(void);

 #else
