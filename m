Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317904AbSGKT64>; Thu, 11 Jul 2002 15:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSGKT6z>; Thu, 11 Jul 2002 15:58:55 -0400
Received: from stingr.net ([212.193.32.15]:34969 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S317904AbSGKT6y>;
	Thu, 11 Jul 2002 15:58:54 -0400
Date: Fri, 12 Jul 2002 00:01:40 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: misc fixes - part 2
Message-ID: <20020711200140.GB2280@stingr.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-ac specifics

1. after sharing zlib zlib.h still including "zconf.h" and at least under
   kbuild 2.5 it breaks at cramfs/uncompress.c.
   
2. ac specific part of exports for modular binfmt_elf to load.

kbuild 2.5 for 2.4.19-rc1-ac1 will be available at usual place tomorrow.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	v2.4.19-rc1-ac1 -> 1.555  
#	     kernel/Makefile	1.4     -> 1.5    
#	include/linux/zlib.h	1.2     -> 1.3    
#	      kernel/sched.c	1.28    -> 1.29   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/10	stingray@proxy.sgu.ru	1.553
# 2.4.19-rc1-ac1 run
# --------------------------------------------
# 02/07/11	stingray@proxy.sgu.ru	1.554
# Fix bogus curdir include of zconf.h
# --------------------------------------------
# 02/07/11	stingray@proxy.sgu.ru	1.555
# Fix unresolved symbols in modular binfmt_elf
# --------------------------------------------
#
diff -Nru a/include/linux/zlib.h b/include/linux/zlib.h
--- a/include/linux/zlib.h	Thu Jul 11 23:41:22 2002
+++ b/include/linux/zlib.h	Thu Jul 11 23:41:22 2002
@@ -31,7 +31,7 @@
 #ifndef _ZLIB_H
 #define _ZLIB_H
 
-#include "zconf.h"
+#include <linux/zconf.h>
 
 #ifdef __cplusplus
 extern "C" {
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	Thu Jul 11 23:41:22 2002
+++ b/kernel/Makefile	Thu Jul 11 23:41:22 2002
@@ -9,7 +9,7 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o suspend.o cpufreq.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o suspend.o cpufreq.o sched.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Thu Jul 11 23:41:22 2002
+++ b/kernel/sched.c	Thu Jul 11 23:41:22 2002
@@ -25,6 +25,9 @@
 #include <asm/mmu_context.h>
 #include <linux/kernel_stat.h>
 
+#include <linux/config.h>
+#include <linux/module.h>
+
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
@@ -1026,6 +1029,8 @@
 {
 	return TASK_NICE(p);
 }
+
+EXPORT_SYMBOL(task_nice);
 
 static inline task_t *find_process_by_pid(pid_t pid)
 {

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
