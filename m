Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262399AbTCIEHV>; Sat, 8 Mar 2003 23:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262401AbTCIEHV>; Sat, 8 Mar 2003 23:07:21 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:39808 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262399AbTCIEHQ>; Sat, 8 Mar 2003 23:07:16 -0500
Date: Sun, 9 Mar 2003 13:17:22 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 subarch. support for 2.5.64-ac3 (5/20) core update
Message-ID: <20030309041722.GF1231@yuzuki.cinet.co.jp>
References: <20030309035245.GA1231@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309035245.GA1231@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.64-ac3. (5/20)

Updates core patches for PC98.
 - topology.c: remove NUMA code.
 - setup_arch_pre.h: change tick_usec, tick_nsec to extern.

Regards,
Osamu Tomita


diff -Nru linux-2.5.64-ac1/arch/i386/mach-pc9800/topology.c linux98-2.5.64/arch/i386/mach-pc9800/topology.c
--- linux-2.5.64-ac1/arch/i386/mach-pc9800/topology.c	2003-03-07 08:51:59.000000000 +0900
+++ linux98-2.5.64/arch/i386/mach-pc9800/topology.c	2003-03-05 13:24:31.000000000 +0900
@@ -1,5 +1,5 @@
 /*
- * arch/i386/mach-generic/topology.c - Populate driverfs with topology information
+ * arch/i386/mach-pc9800/topology.c - Populate driverfs with topology information
  *
  * Written by: Matthew Dobson, IBM Corporation
  * Original Code: Paul Dorwin, IBM Corporation, Patrick Mochel, OSDL
@@ -23,7 +23,8 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <colpatch@us.ibm.com>
+ * Modify for PC-9800 by Osamu Tomita <tomita@cinet.co.jp>
+ *
  */
 #include <linux/init.h>
 #include <linux/smp.h>
@@ -31,29 +32,6 @@
 
 struct i386_cpu cpu_devices[NR_CPUS];
 
-#ifdef CONFIG_NUMA
-#include <linux/mmzone.h>
-#include <asm/node.h>
-#include <asm/memblk.h>
-
-struct i386_node node_devices[MAX_NUMNODES];
-struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for (i = 0; i < num_online_nodes(); i++)
-		arch_register_node(i);
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_possible(i)) arch_register_cpu(i);
-	for (i = 0; i < num_online_memblks(); i++)
-		arch_register_memblk(i);
-	return 0;
-}
-
-#else /* !CONFIG_NUMA */
-
 static int __init topology_init(void)
 {
 	int i;
@@ -63,6 +41,4 @@
 	return 0;
 }
 
-#endif /* CONFIG_NUMA */
-
 subsys_initcall(topology_init);
diff -Nru linux-2.5.64-ac1/include/asm-i386/mach-pc9800/setup_arch_pre.h linux98-2.5.64/include/asm-i386/mach-pc9800/setup_arch_pre.h
--- linux-2.5.64-ac1/include/asm-i386/mach-pc9800/setup_arch_pre.h	2003-03-07 08:52:10.000000000 +0900
+++ linux98-2.5.64/include/asm-i386/mach-pc9800/setup_arch_pre.h	2003-03-05 16:32:02.000000000 +0900
@@ -10,8 +10,8 @@
 #include <asm/pc9800_sca.h>
 
 int CLOCK_TICK_RATE;
-unsigned long tick_usec;	/* ACTHZ          period (usec) */
-unsigned long tick_nsec;	/* USER_HZ period (nsec) */
+extern unsigned long tick_usec;	/* ACTHZ          period (usec) */
+extern unsigned long tick_nsec;	/* USER_HZ period (nsec) */
 unsigned char pc9800_misc_flags;
 /* (bit 0) 1:High Address Video ram exists 0:otherwise */
 
