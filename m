Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbTBCLbB>; Mon, 3 Feb 2003 06:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTBCLbB>; Mon, 3 Feb 2003 06:31:01 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:17515
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266224AbTBCLab>; Mon, 3 Feb 2003 06:30:31 -0500
Date: Mon, 3 Feb 2003 06:39:06 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Anton Blanchard <anton@samba.org>
Subject: [PATCH][6/6] CPU Hotplug PPC
Message-ID: <Pine.LNX.4.44.0302030551560.9361-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty, Anton,
	Nothing was touched here, just a mindless sync.

	Zwane

 arch/ppc/kernel/smp.c |   11 +++++++++++
 include/asm-ppc/smp.h |    2 ++
 2 files changed, 13 insertions(+)

Index: linux-2.5.59-lch2/arch/ppc/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/ppc/kernel/smp.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/arch/ppc/kernel/smp.c	17 Jan 2003 11:14:47 -0000	1.1.1.1
+++ linux-2.5.59-lch2/arch/ppc/kernel/smp.c	20 Jan 2003 13:48:26 -0000	1.1.1.1.2.1
@@ -441,6 +441,17 @@
 	return 0;
 }
 
+int __cpu_disable(unsigned int cpu)
+{
+	return -ENOSYS;
+}
+
+/* Since we fail __cpu_disable, this is never called. */
+void __cpu_die(unsigned int cpu)
+{
+	BUG();
+}
+
 void smp_cpus_done(unsigned int max_cpus)
 {
 	smp_ops->setup_cpu(0);
Index: linux-2.5.59-lch2/include/asm-ppc/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/asm-ppc/smp.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/include/asm-ppc/smp.h	17 Jan 2003 11:16:05 -0000	1.1.1.1
+++ linux-2.5.59-lch2/include/asm-ppc/smp.h	20 Jan 2003 13:48:27 -0000	1.1.1.1.2.1
@@ -62,6 +62,8 @@
 }
 
 extern int __cpu_up(unsigned int cpu);
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
 
 extern int smp_hw_index[];
 #define hard_smp_processor_id() (smp_hw_index[smp_processor_id()])
-- 
function.linuxpower.ca


