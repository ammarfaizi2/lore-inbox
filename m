Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318008AbSGRESr>; Thu, 18 Jul 2002 00:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSGRESr>; Thu, 18 Jul 2002 00:18:47 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:7602 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318008AbSGRESn>;
	Thu, 18 Jul 2002 00:18:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] per-cpu patch 1/3
Date: Thu, 18 Jul 2002 13:46:21 +1000
Message-Id: <20020718042221.8E1DA421D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Name: Export __per_cpu_offset so modules can use per-cpu data.
Author: Rusty Russell
Status: Trivial

D: As per Andrew Morton's request.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/kernel/ksyms.c working-2.5.25-percpu/kernel/ksyms.c
--- linux-2.5.25/kernel/ksyms.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.25-percpu/kernel/ksyms.c	Fri Jul 12 16:03:47 2002
@@ -50,6 +50,7 @@
 #include <linux/namei.h>
 #include <linux/buffer_head.h>
 #include <linux/root_dev.h>
+#include <linux/percpu.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -597,3 +598,6 @@
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+#if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
+EXPORT_SYMBOL(__per_cpu_offset);
+#endif

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
