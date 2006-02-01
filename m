Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWBAJDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWBAJDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWBAJDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:03:24 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:41289 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750769AbWBAJDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:21 -0500
Message-Id: <20060201090320.899381000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:25 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 01/44] ia64: use cpu_set() instead of __set_bit()
Content-Disposition: inline; filename=ia64-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__set_bit() --> cpu_set() cleanup

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/ia64/kernel/mca.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: 2.6-git/arch/ia64/kernel/mca.c
===================================================================
--- 2.6-git.orig/arch/ia64/kernel/mca.c
+++ 2.6-git/arch/ia64/kernel/mca.c
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
