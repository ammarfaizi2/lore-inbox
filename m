Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVEBCgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVEBCgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 22:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVEBCQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 22:16:01 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46352 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261705AbVEBBrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:47:49 -0400
Date: Mon, 2 May 2005 03:47:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pazke@donpac.ru,
       linux-visws-devel@lists.sf.net
Subject: [2.6 patch] i386: cleanup boot_cpu_logical_apicid variables
Message-ID: <20050502014743.GJ3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently two different boot_cpu_logical_apicid variables:
- a global one in mpparse.c
- a static one in smpboot.c

Of these two, only the one in smpboot.c might be used (through 
boot_cpu_apicid).

This patch therefore removes the one in mpparse.c .

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrey Panin <pazke@donpac.ru>

---

This patch was already sent on:
- 15 Apr 2005

 arch/i386/kernel/mpparse.c     |    2 --
 arch/i386/mach-visws/mpparse.c |    5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

--- linux-2.6.12-rc2-mm3-full/arch/i386/kernel/mpparse.c.old	2005-04-15 14:21:41.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/arch/i386/kernel/mpparse.c	2005-04-15 14:22:00.000000000 +0200
@@ -67,7 +67,6 @@
 
 /* Processor that is doing the boot up */
 unsigned int boot_cpu_physical_apicid = -1U;
-unsigned int boot_cpu_logical_apicid = -1U;
 /* Internal processor count */
 static unsigned int __initdata num_processors;
 
@@ -180,7 +179,6 @@
 	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
 		Dprintk("    Bootup CPU\n");
 		boot_cpu_physical_apicid = m->mpc_apicid;
-		boot_cpu_logical_apicid = apicid;
 	}
 
 	if (num_processors >= NR_CPUS) {
--- linux-2.6.12-rc2-mm3-full/arch/i386/mach-visws/mpparse.c.old	2005-04-15 14:22:10.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/arch/i386/mach-visws/mpparse.c	2005-04-15 14:22:27.000000000 +0200
@@ -23,7 +23,6 @@
 
 /* Processor that is doing the boot up */
 unsigned int boot_cpu_physical_apicid = -1U;
-unsigned int boot_cpu_logical_apicid = -1U;
 
 /* Bitmask of physically existing CPUs */
 physid_mask_t phys_cpu_present_map;
@@ -52,10 +51,8 @@
 		(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
 		m->mpc_apicver);
 
-	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
+	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR)
 		boot_cpu_physical_apicid = m->mpc_apicid;
-		boot_cpu_logical_apicid = logical_apicid;
-	}
 
 	ver = m->mpc_apicver;
 	if ((ver >= 0x14 && m->mpc_apicid >= 0xff) || m->mpc_apicid >= 0xf) {

