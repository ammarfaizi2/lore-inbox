Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWBVXza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWBVXza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWBVXza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:55:30 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:47778 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751303AbWBVXz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:55:29 -0500
Subject: [PATCH] Fix boot panic by adding topology export to voyager
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 17:53:28 -0600
Message-Id: <1140652408.10417.6.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like I can't get away without exporting topology functions from
voyager any longer, so add them to the voyager subarchitecture.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

James

Index: BUILD-2.6/arch/i386/mach-voyager/voyager_basic.c
===================================================================
--- BUILD-2.6.orig/arch/i386/mach-voyager/voyager_basic.c	2006-02-22 14:42:44.000000000 -0600
+++ BUILD-2.6/arch/i386/mach-voyager/voyager_basic.c	2006-02-22 14:47:20.000000000 -0600
@@ -23,6 +23,9 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/sysrq.h>
+#include <linux/smp.h>
+#include <linux/nodemask.h>
+#include <asm/cpu.h>
 #include <asm/io.h>
 #include <asm/voyager.h>
 #include <asm/vic.h>
@@ -329,3 +332,15 @@
 		pm_power_off();
 }
 
+static struct i386_cpu cpu_devices[NR_CPUS];
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for_each_present_cpu(i)
+		register_cpu(&cpu_devices[i].cpu, i, NULL);
+	return 0;
+}
+
+subsys_initcall(topology_init);


