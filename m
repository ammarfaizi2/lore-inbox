Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbTEGMRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 08:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTEGMRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 08:17:44 -0400
Received: from mail-4.tiscali.it ([195.130.225.150]:47217 "EHLO
	mail-4.tiscali.it") by vger.kernel.org with ESMTP id S263132AbTEGMRo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 08:17:44 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Daniele Bellucci <danielebellucci@libero.it>
To: linux-kernel@vger.kernel.org
Subject: PATCH: 2.5.69 kernel/suspend.c compile warning
Date: Wed, 7 May 2003 14:30:11 +0200
User-Agent: KMail/1.4.3
Cc: seasons@fornax.hu, pavel@suse.cz
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305071430.11269.danielebellucci@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -Wp,-MD,kernel/.suspend.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototype
s -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-b
oundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefi
x include    -DKBUILD_BASENAME=suspend -DKBUILD_MODNAME=suspend -c -o kernel/.t
mp_suspend.o kernel/suspend.c
kernel/suspend.c: In function `freeze_processes':
kernel/suspend.c:228: warning: comparison of distinct pointer types lacks a cast


--- linux-2.5.69-orig/kernel/suspend.c  2003-05-05 09:51:08.000000000 +0200
+++ linux-2.5.69-my/kernel/suspend.c    2003-05-08 14:07:19.000000000 +0200
@@ -201,7 +201,8 @@
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
-       int todo, start_time;
+       int todo;
+       unsigned long start_time;
        struct task_struct *g, *p;

        printk( "Stopping tasks: " );



http://web.tiscali.it/bellucda/2.5.69-freeze_processes.diff


