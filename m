Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUANMyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 07:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUANMyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 07:54:05 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:34784 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S261193AbUANMyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 07:54:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16389.15334.488239.326067@gargle.gargle.HOWL>
Date: Wed, 14 Jan 2004 07:53:58 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.1-mm3 remove null-ilizers
X-Mailer: VM 7.03 under Emacs 21.2.1
From: Jes Sorensen <jes@trained-monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch removes a couple of null-ilizers of global
variables. Not a big deal, but every byte helps in the .data segment ;-)

Cheers,
Jes

diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/fs/bio.c linux-2.6.1-mm3/fs/bio.c
--- orig/linux-2.6.1-mm3-boot/fs/bio.c	Wed Jan 14 02:59:50 2004
+++ linux-2.6.1-mm3/fs/bio.c	Wed Jan 14 04:46:23 2004
@@ -594,7 +594,7 @@
 
 static DECLARE_WORK(bio_dirty_work, bio_dirty_fn, NULL);
 static spinlock_t bio_dirty_lock = SPIN_LOCK_UNLOCKED;
-static struct bio *bio_dirty_list = NULL;
+static struct bio *bio_dirty_list;
 
 /*
  * This runs in process context
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/init/main.c linux-2.6.1-mm3/init/main.c
--- orig/linux-2.6.1-mm3-boot/init/main.c	Wed Jan 14 02:59:53 2004
+++ linux-2.6.1-mm3/init/main.c	Wed Jan 14 04:43:10 2004
@@ -105,7 +105,7 @@
 
 extern void time_init(void);
 /* Default late time init is NULL. archs can override this later. */
-void (*late_time_init)(void) = NULL;
+void (*late_time_init)(void);
 extern void softirq_init(void);
 
 static char *execute_command;
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/kernel/cpu.c linux-2.6.1-mm3/kernel/cpu.c
--- orig/linux-2.6.1-mm3-boot/kernel/cpu.c	Wed Dec 17 18:59:35 2003
+++ linux-2.6.1-mm3/kernel/cpu.c	Wed Jan 14 04:43:29 2004
@@ -14,7 +14,7 @@
 /* This protects CPUs going up and down... */
 DECLARE_MUTEX(cpucontrol);
 
-static struct notifier_block *cpu_chain = NULL;
+static struct notifier_block *cpu_chain;
 
 /* Need to know about CPUs going up/down? */
 int register_cpu_notifier(struct notifier_block *nb)
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/mm/nommu.c linux-2.6.1-mm3/mm/nommu.c
--- orig/linux-2.6.1-mm3-boot/mm/nommu.c	Wed Jan 14 02:59:53 2004
+++ linux-2.6.1-mm3/mm/nommu.c	Wed Jan 14 04:47:22 2004
@@ -25,12 +25,12 @@
 #include <asm/tlbflush.h>
 
 void *high_memory;
-struct page *mem_map = NULL;
+struct page *mem_map;
 unsigned long max_mapnr;
 unsigned long num_physpages;
 unsigned long askedalloc, realalloc;
 atomic_t vm_committed_space = ATOMIC_INIT(0);
-int sysctl_overcommit_memory = 0; /* default is heuristic overcommit */
+int sysctl_overcommit_memory; /* default is heuristic overcommit */
 int sysctl_overcommit_ratio = 50; /* default is 50% */
 
 /*
