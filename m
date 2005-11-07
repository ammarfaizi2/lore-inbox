Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965241AbVKGW1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbVKGW1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVKGW1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:27:55 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:45031 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S965241AbVKGW1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:27:54 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-mm1 - cpufreq build problem
Date: Mon, 7 Nov 2005 23:28:28 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051106182447.5f571a46.akpm@osdl.org>
In-Reply-To: <20051106182447.5f571a46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511072328.29003.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 7 of November 2005 03:24, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/

Apparently cpufreq cannot be built without CONFIG_SMP now.  I use the appended
patch as a workaround.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-mm1/include/linux/cpu.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/cpu.h	2005-11-07 22:35:11.000000000 +0100
+++ linux-2.6.14-mm1/include/linux/cpu.h	2005-11-07 22:37:12.000000000 +0100
@@ -33,7 +33,9 @@
 
 extern int register_cpu(struct cpu *, int, struct node *);
 extern struct sys_device *get_cpu_sysdev(int cpu);
+#ifdef CONFIG_SMP
 extern int current_in_cpu_hotplug(void);
+#endif
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *, struct node *);
 #endif
Index: linux-2.6.14-mm1/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/cpufreq/cpufreq.c	2005-11-07 22:38:00.000000000 +0100
+++ linux-2.6.14-mm1/drivers/cpufreq/cpufreq.c	2005-11-07 22:38:21.000000000 +0100
@@ -29,6 +29,10 @@
 
 #define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_CORE, "cpufreq-core", msg)
 
+#ifndef CONFIG_SMP
+static int current_in_cpu_hotplug(void) { return 0; }
+#endif
+
 /**
  * The "cpufreq driver" - the arch- or hardware-dependend low
  * level driver of CPUFreq support, and its spinlock. This lock
