Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266837AbTAOTHl>; Wed, 15 Jan 2003 14:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTAOTHl>; Wed, 15 Jan 2003 14:07:41 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:27290 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266837AbTAOTHf>; Wed, 15 Jan 2003 14:07:35 -0500
Date: Wed, 15 Jan 2003 19:45:05 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.58] cpufreq: fix compilation, name of gx-suspmod driver
Message-ID: <20030115184505.GA1702@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- fix cpufreq drivers compilation on not-bleeding-edge-gcc's (Adrian Bunk)
- gx-suspmod.c hasn't had a name yet

	Dominik

--- linux-2.5.58/include/linux/cpufreq.h.old	2003-01-14 08:53:27.000000000 +0100
+++ linux-2.5.58/include/linux/cpufreq.h	2003-01-14 08:53:56.000000000 +0100
@@ -130,7 +130,7 @@
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 /* deprecated */
 #define cpufreq_register(x)   cpufreq_register_driver(x)
-#define cpufreq_unregister(x) cpufreq_unregister_driver(NULL)
+#define cpufreq_unregister() cpufreq_unregister_driver(NULL)
 
 
 void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state);

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c linux/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2003-01-15 19:39:37.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2003-01-15 19:41:54.000000000 +0100
@@ -482,6 +482,7 @@
 	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	driver->verify = &cpufreq_gx_verify;
 	driver->setpolicy = &cpufreq_gx_setpolicy;
+	strncpy(driver->name, "gx-suspmod", CPUFREQ_NAME_LEN);
 
 	gx_driver = driver;
 
