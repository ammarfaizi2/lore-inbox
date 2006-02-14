Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWBNFE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWBNFE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWBNFE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:04:57 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:6862 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030348AbWBNFEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:04:54 -0500
Message-Id: <20060214050442.027415000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:03:53 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 02/47] ia64: use cpu_set() instead of __set_bit()
Content-Disposition: inline; filename=ia64-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__set_bit() --> cpu_set() cleanup

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/ia64/kernel/mca.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: 2.6-rc/arch/ia64/kernel/mca.c
===================================================================
--- 2.6-rc.orig/arch/ia64/kernel/mca.c
+++ 2.6-rc/arch/ia64/kernel/mca.c
@@ -69,6 +69,7 @@
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/workqueue.h>
+#include <linux/cpumask.h>
 
 #include <asm/delay.h>
 #include <asm/kdebug.h>
@@ -1430,7 +1431,7 @@ format_mca_init_stack(void *mca_data, un
 	ti->cpu = cpu;
 	p->thread_info = ti;
 	p->state = TASK_UNINTERRUPTIBLE;
-	__set_bit(cpu, &p->cpus_allowed);
+	cpu_set(cpu, p->cpus_allowed);
 	INIT_LIST_HEAD(&p->tasks);
 	p->parent = p->real_parent = p->group_leader = p;
 	INIT_LIST_HEAD(&p->children);

--
