Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVJCILW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVJCILW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 04:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVJCILW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 04:11:22 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:27528 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932186AbVJCILV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 04:11:21 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20051003081045.29997.88069.sendpatchset@cherry.local>
Subject: [PATCH] CPUSETS: remove SMP dependency
Date: Mon,  3 Oct 2005 17:11:21 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the SMP dependency from CPUSETS.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 include/linux/sched.h |    4 ++++
 init/Kconfig          |    1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

--- from-0002/include/linux/sched.h
+++ to-work/include/linux/sched.h	2005-10-03 16:18:15.000000000 +0900
@@ -590,6 +590,10 @@ struct sched_domain {
 
 extern void partition_sched_domains(cpumask_t *partition1,
 				    cpumask_t *partition2);
+#else /* CONFIG_SMP */
+
+static inline void partition_sched_domains(cpumask_t *partition1,
+					   cpumask_t *partition2) {}
 #endif /* CONFIG_SMP */
 
 
--- from-0002/init/Kconfig
+++ to-work/init/Kconfig	2005-10-03 15:40:51.000000000 +0900
@@ -245,7 +245,6 @@ config IKCONFIG_PROC
 
 config CPUSETS
 	bool "Cpuset support"
-	depends on SMP
 	help
 	  This option will let you create and manage CPUSETs which
 	  allow dynamically partitioning a system into sets of CPUs and
