Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVAPH5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVAPH5R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 02:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVAPH5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 02:57:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64782 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262446AbVAPH5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 02:57:10 -0500
Date: Sun, 16 Jan 2005 08:57:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/mach-default/topology.c: make cpu_devices static
Message-ID: <20050116075707.GZ4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global struct static.


diffstat output:
 arch/i386/mach-default/topology.c |    2 +-
 include/asm-i386/cpu.h            |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/include/asm-i386/cpu.h.old	2005-01-16 05:41:55.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-i386/cpu.h	2005-01-16 05:42:09.000000000 +0100
@@ -12,7 +12,6 @@
 struct i386_cpu {
 	struct cpu cpu;
 };
-extern struct i386_cpu cpu_devices[NR_CPUS];
 extern int arch_register_cpu(int num);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void arch_unregister_cpu(int);
--- linux-2.6.11-rc1-mm1-full/arch/i386/mach-default/topology.c.old	2005-01-16 05:42:18.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/mach-default/topology.c	2005-01-16 05:42:43.000000000 +0100
@@ -30,7 +30,7 @@
 #include <linux/nodemask.h>
 #include <asm/cpu.h>
 
-struct i386_cpu cpu_devices[NR_CPUS];
+static struct i386_cpu cpu_devices[NR_CPUS];
 
 int arch_register_cpu(int num){
 	struct node *parent = NULL;


