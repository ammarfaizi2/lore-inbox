Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbWCCX3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWCCX3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWCCX3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:29:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18189 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932573AbWCCX3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:29:39 -0500
Date: Sat, 4 Mar 2006 00:29:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: chris@zankel.net, uclinux-v850@lsi.nec.co.jp, linux-kernel@vger.kernel.org
Subject: [2.6 patch] add missing pm_power_off's
Message-ID: <20060303232938.GE9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This untested patch adds the missing pm_power_off's for the h8300, v850 
and xtensa architectures.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

@Andrew:
Please apply for the next -mm.
The build on these architectures is anyway broken due to this issue, and 
I'll check at http://l4x.org/k/ whether this patch really fixes it.

 arch/h8300/kernel/process.c  |    3 +++
 arch/v850/kernel/process.c   |    3 +++
 arch/xtensa/kernel/process.c |    3 +++
 3 files changed, 9 insertions(+)

--- linux-2.6.16-rc5-mm2-full/arch/h8300/kernel/process.c.old	2006-03-04 00:24:12.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/arch/h8300/kernel/process.c	2006-03-04 00:24:59.000000000 +0100
@@ -45,6 +45,9 @@
 #include <asm/setup.h>
 #include <asm/pgtable.h>
 
+void (*pm_power_off)(void) = NULL;
+EXPORT_SYMBOL(pm_power_off);
+
 asmlinkage void ret_from_fork(void);
 
 /*
--- linux-2.6.16-rc5-mm2-full/arch/v850/kernel/process.c.old	2006-03-04 00:25:16.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/arch/v850/kernel/process.c	2006-03-04 00:25:30.000000000 +0100
@@ -30,6 +30,9 @@
 #include <asm/system.h>
 #include <asm/pgtable.h>
 
+void (*pm_power_off)(void) = NULL;
+EXPORT_SYMBOL(pm_power_off);
+
 extern void ret_from_fork (void);
 
 
--- linux-2.6.16-rc5-mm2-full/arch/xtensa/kernel/process.c.old	2006-03-04 00:25:43.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/arch/xtensa/kernel/process.c	2006-03-04 00:26:02.000000000 +0100
@@ -64,6 +64,9 @@
 
 struct task_struct *current_set[NR_CPUS] = {&init_task, };
 
+void (*pm_power_off)(void) = NULL;
+EXPORT_SYMBOL(pm_power_off);
+
 
 #if XCHAL_CP_NUM > 0
 

