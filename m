Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbUA3UVI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUA3UVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:21:08 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:15322 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263903AbUA3UVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:21:05 -0500
Date: Fri, 30 Jan 2004 12:20:36 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>, Matthew Dobson <colpatch@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] missing export of cpu_2_node
Message-ID: <20040130122036.A12659@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

While compiling on a NUMAQ with st as a module, cpu_2_node comes up as
undefined:

WARNING: /lib/modules/2.6.2-rc2/kernel/drivers/scsi/st.ko needs unknown symbol cpu_2_node

This patch exports cpu_2_node.

===== arch/i386/kernel/smpboot.c 1.67 vs edited =====
--- 1.67/arch/i386/kernel/smpboot.c	Sun Oct  5 01:07:44 2003
+++ edited/arch/i386/kernel/smpboot.c	Fri Jan 30 10:16:05 2004
@@ -33,6 +33,7 @@
  *		Dave Jones	:	Report invalid combinations of Athlon CPUs.
 *		Rusty Russell	:	Hacked into shape for new "hotplug" boot process. */
 
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -503,6 +504,7 @@
 				{ [0 ... MAX_NUMNODES-1] = CPU_MASK_NONE };
 /* which node each logical CPU is on */
 int cpu_2_node[NR_CPUS] = { [0 ... NR_CPUS-1] = 0 };
+EXPORT_SYMBOL(cpu_2_node);
 
 /* set up a mapping between cpu and node. */
 static inline void map_cpu_to_node(int cpu, int node)
