Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267646AbTBLU7I>; Wed, 12 Feb 2003 15:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbTBLU7I>; Wed, 12 Feb 2003 15:59:08 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:25593 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267647AbTBLU6w>; Wed, 12 Feb 2003 15:58:52 -0500
Date: Wed, 12 Feb 2003 22:07:40 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.60] cpufreq: properly initialize memory
Message-ID: <20030212210740.GA2098@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Properly set memory allocated by x86 cpufreq drivers to zero.

 elanfreq.c    |    4 ++--
 gx-suspmod.c  |    4 ++++
 longhaul.c    |    5 +++--
 longrun.c     |    5 +++--
 p4-clockmod.c |    4 ++--
 powernow-k6.c |    4 ++--
 speedstep.c   |    4 ++--
 7 files changed, 18 insertions(+), 12 deletions(-)

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-02-10 20:54:58.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-02-10 21:26:14.000000000 +0100
@@ -242,6 +242,8 @@
 			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!driver)
 		return -ENOMEM;
+	memset(driver, 0, sizeof(struct cpufreq_driver) +
+			NR_CPUS * sizeof(struct cpufreq_policy));
 
 	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
@@ -260,8 +262,6 @@
 
 	driver->verify        = &elanfreq_verify;
 	driver->setpolicy     = &elanfreq_setpolicy;
-	driver->init = NULL;
-	driver->exit = NULL;
 	strncpy(driver->name, "elanfreq", CPUFREQ_NAME_LEN);
 
 	driver->policy[0].cpu    = 0;
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c linux/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2003-02-10 20:54:58.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2003-02-10 21:26:39.000000000 +0100
@@ -431,11 +431,15 @@
 	driver = kmalloc(sizeof(struct cpufreq_driver) + NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (driver == NULL) 
 		return -ENOMEM;
+	memset(driver, 0, sizeof(struct cpufreq_driver) +
+			NR_CPUS * sizeof(struct cpufreq_policy));
+
 	params = kmalloc(sizeof(struct gxfreq_params), GFP_KERNEL);
 	if (params == NULL) {
 		kfree(driver);
 		return -ENOMEM;
 	}
+	memset(params, 0, sizeof(struct gxfreq_params));
 
 	driver->policy = (struct cpufreq_policy *)(driver + 1);
 	params->cs55x0 = gx_pci;
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c	2003-02-10 20:54:58.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	2003-02-10 21:27:16.000000000 +0100
@@ -762,6 +762,8 @@
 			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!driver)
 		return -ENOMEM;
+	memset(driver, 0, sizeof(struct cpufreq_driver) +
+			NR_CPUS * sizeof(struct cpufreq_policy));
 
 	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
@@ -771,8 +773,7 @@
 
 	driver->verify    = &longhaul_verify;
 	driver->setpolicy = &longhaul_setpolicy;
-	driver->init = NULL;
-	driver->exit = NULL;
+
 	strncpy(driver->name, "longhaul", CPUFREQ_NAME_LEN);
 
 	driver->policy[0].cpu = 0;
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c linux/arch/i386/kernel/cpu/cpufreq/longrun.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longrun.c	2003-02-10 20:54:58.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longrun.c	2003-02-10 21:27:28.000000000 +0100
@@ -241,6 +241,8 @@
 			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!driver)
 		return -ENOMEM;
+	memset(driver, 0, sizeof(struct cpufreq_driver) +
+			NR_CPUS * sizeof(struct cpufreq_policy));
 
 	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
@@ -251,8 +253,7 @@
 	driver->policy[0].cpuinfo.min_freq = longrun_low_freq;
 	driver->policy[0].cpuinfo.max_freq = longrun_high_freq;
 	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	driver->init = NULL;
-	driver->exit = NULL;
+
 	strncpy(driver->name, "longrun", CPUFREQ_NAME_LEN);
 
 	longrun_get_policy(&driver->policy[0]);
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-02-10 20:54:58.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-02-10 21:24:17.000000000 +0100
@@ -220,6 +220,8 @@
 			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!driver)
 		return -ENOMEM;
+	memset(driver, 0, sizeof(struct cpufreq_driver) +
+			NR_CPUS * sizeof(struct cpufreq_policy));
 
 	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
@@ -240,8 +242,6 @@
 
 	driver->verify        = &cpufreq_p4_verify;
 	driver->setpolicy     = &cpufreq_p4_setpolicy;
-	driver->init = NULL;
-	driver->exit = NULL;
 	strncpy(driver->name, "p4-clockmod", CPUFREQ_NAME_LEN);
 
 	for (i=0;i<NR_CPUS;i++) {
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2003-02-10 20:54:58.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2003-02-10 21:24:38.000000000 +0100
@@ -172,6 +172,8 @@
 		release_region (POWERNOW_IOPORT, 16);
 		return -ENOMEM;
 	}
+	memset(driver, 0, sizeof(struct cpufreq_driver) +
+			NR_CPUS * sizeof(struct cpufreq_policy));
 	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
 	/* table init */
@@ -184,8 +186,6 @@
 
 	driver->verify        = &powernow_k6_verify;
 	driver->setpolicy     = &powernow_k6_setpolicy;
-	driver->init = NULL;
-	driver->exit = NULL;
 	strncpy(driver->name, "powernow-k6", CPUFREQ_NAME_LEN);
 
 	/* cpuinfo and default policy values */
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-02-10 20:54:58.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-02-10 21:24:52.000000000 +0100
@@ -674,6 +674,8 @@
 			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!driver)
 		return -ENOMEM;
+	memset(driver, 0, sizeof(struct cpufreq_driver) +
+			NR_CPUS * sizeof(struct cpufreq_policy));
 
 	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
@@ -690,8 +692,6 @@
 
 	driver->verify      = &speedstep_verify;
 	driver->setpolicy   = &speedstep_setpolicy;
-	driver->init = NULL;
-	driver->exit = NULL;
 	strncpy(driver->name, "speedstep", CPUFREQ_NAME_LEN);
 
 	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
