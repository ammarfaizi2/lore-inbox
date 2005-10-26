Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbVJZHxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVJZHxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 03:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVJZHxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 03:53:23 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:16617 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932578AbVJZHxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 03:53:23 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Magnus Damm <magnus@valinux.co.jp>, pj@sgi.com
Message-Id: <20051026075345.21014.53533.sendpatchset@cherry.local>
Subject: [PATCH] CPUSETS: remove SMP dependency
Date: Wed, 26 Oct 2005 16:53:21 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the SMP dependency from CPUSETS.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 include/linux/sched.h |    4 ++++
 init/Kconfig          |    1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff -urNp linux-2.6.14-rc5-mm1/include/linux/sched.h linux-2.6.14-rc5-mm1-cpusets_no_smp/include/linux/sched.h
--- linux-2.6.14-rc5-mm1/include/linux/sched.h	2005-10-24 18:18:17.000000000 +0900
+++ linux-2.6.14-rc5-mm1-cpusets_no_smp/include/linux/sched.h	2005-10-26 16:42:34.000000000 +0900
@@ -636,6 +636,10 @@ struct sched_domain {
 
 extern void partition_sched_domains(cpumask_t *partition1,
 				    cpumask_t *partition2);
+#else /* CONFIG_SMP */
+
+static inline void partition_sched_domains(cpumask_t *partition1,
+					   cpumask_t *partition2) {}
 #endif /* CONFIG_SMP */
 
 
diff -urNp linux-2.6.14-rc5-mm1/init/Kconfig linux-2.6.14-rc5-mm1-cpusets_no_smp/init/Kconfig
--- linux-2.6.14-rc5-mm1/init/Kconfig	2005-10-24 18:18:17.000000000 +0900
+++ linux-2.6.14-rc5-mm1-cpusets_no_smp/init/Kconfig	2005-10-26 16:42:34.000000000 +0900
@@ -266,7 +266,6 @@ config IKCONFIG_PROC
 
 config CPUSETS
 	bool "Cpuset support"
-	depends on SMP
 	help
 	  This option will let you create and manage CPUSETs which
 	  allow dynamically partitioning a system into sets of CPUs and
