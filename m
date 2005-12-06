Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVLFKgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVLFKgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVLFKgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:36:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:42451 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964945AbVLFKgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:36:50 -0500
From: "David Engraf" <engraf.david@netcom-sicherheitstechnik.de>
To: <linux-kernel@vger.kernel.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>
Subject: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
Date: Tue, 6 Dec 2005 11:36:42 +0100
Message-ID: <009201c5fa50$f3f58a10$0a016696@EW10>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcX6UOubYVOdLZgMSe2dYzztiLYpAA==
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:79a9c929f10b28b00e544b1aedb42267
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new systemcall on i386 architectures returning the jiffies
value to the application. 
As a kernel developer you can use jiffies but from the user space there is
no equivalent function which counts every millisecond like the Win32
GetTickCount.

linux-2.6.15-rc5-mm1



diff -puN include/asm-i386/unistd_orig.h include/asm-i386/unistd.h
--- include/asm-i386/unistd_orig.h	2005-12-06 12:07:16.000000000 +0100
+++ include/asm-i386/unistd.h	2005-12-06 12:10:07.000000000 +0100
@@ -300,8 +300,9 @@
 #define __NR_inotify_add_watch	292
 #define __NR_inotify_rm_watch	293
 #define __NR_migrate_pages	294
+#define __NR_tickcount	295
 
-#define NR_syscalls 295
+#define NR_syscalls 296
 
 /*
  * user-visible error numbers are in the range -1 - -128: see




diff -puN arch/i386/kernel/syscall_table_orig.S
arch/i386/kernel/syscall_table.S
--- arch/i386/kernel/syscall_table_orig.S	2005-12-06
12:07:14.000000000 +0100
+++ arch/i386/kernel/syscall_table.S	2005-12-06 12:10:40.000000000 +0100
@@ -294,3 +294,4 @@ ENTRY(sys_call_table)
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
 	.long sys_migrate_pages
+	.long sys_tickcount



diff -puN kernel/sys_orig.c kernel/sys.c
--- kernel/sys_orig.c	2005-12-06 12:06:49.000000000 +0100
+++ kernel/sys.c	2005-12-06 12:08:57.000000000 +0100
@@ -1855,3 +1855,9 @@ asmlinkage long sys_prctl(int option, un
 	}
 	return error;
 }
+
+asmlinkage long sys_tickcount(long __user *ret)
+{
+	if (copy_to_user(ret, (void*)&jiffies, sizeof(long)))
+	return 0;
+}



Thanks
David Engraf


____________
Virus checked by G DATA AntiVirusKit
Version: AVK 16.2037 from 06.12.2005
Virus news: www.antiviruslab.com

