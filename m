Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbTAVFRY>; Wed, 22 Jan 2003 00:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267328AbTAVFRY>; Wed, 22 Jan 2003 00:17:24 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:1285
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267320AbTAVFRO>; Wed, 22 Jan 2003 00:17:14 -0500
Date: Wed, 22 Jan 2003 00:26:36 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: [PATCH][2.5][8/18] smp_call_function_on_cpu - mips64
Message-ID: <Pine.LNX.4.44.0301220025510.29944-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.59/arch/mips64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/mips64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/mips64/kernel/smp.c	17 Jan 2003 11:15:17 -0000	1.1.1.1
+++ linux-2.5.59/arch/mips64/kernel/smp.c	22 Jan 2003 00:40:42 -0000
@@ -92,7 +92,7 @@
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 1, 0);
+	smp_call_function(stop_this_cpu, NULL, 0);
 	smp_num_cpus = 1;
 }
 
@@ -116,7 +116,6 @@
  * Run a function on all other CPUs.
  *  <func>      The function to run. This must be fast and non-blocking.
  *  <info>      An arbitrary pointer to pass to the function.
- *  <retry>     If true, keep retrying until ready.
  *  <wait>      If true, wait until function has completed on other CPUs.
  *  [RETURNS]   0 on success, else a negative status code.
  *
@@ -131,8 +130,7 @@
 	int wait;
 } *call_data;
 
-int smp_call_function (void (*func) (void *info), void *info, int retry, 
-								int wait)
+int smp_call_function (void (*func) (void *info), void *info, int wait)
 {
 	struct call_data_struct data;
 	int i, cpus = smp_num_cpus-1;
@@ -195,7 +193,7 @@
 
 void flush_tlb_all(void)
 {
-	smp_call_function(flush_tlb_all_ipi, 0, 1, 1);
+	smp_call_function(flush_tlb_all_ipi, NULL, 1);
 	_flush_tlb_all();
 }
 
@@ -220,7 +218,7 @@
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
-		smp_call_function(flush_tlb_mm_ipi, (void *)mm, 1, 1);
+		smp_call_function(flush_tlb_mm_ipi, (void *)mm, 1);
 	} else {
 		int i;
 		for (i = 0; i < smp_num_cpus; i++)
@@ -252,7 +250,7 @@
 		fd.vma = vma;
 		fd.addr1 = start;
 		fd.addr2 = end;
-		smp_call_function(flush_tlb_range_ipi, (void *)&fd, 1, 1);
+		smp_call_function(flush_tlb_range_ipi, (void *)&fd, 1);
 	} else {
 		int i;
 		for (i = 0; i < smp_num_cpus; i++)
@@ -276,7 +274,7 @@
 
 		fd.vma = vma;
 		fd.addr1 = page;
-		smp_call_function(flush_tlb_page_ipi, (void *)&fd, 1, 1);
+		smp_call_function(flush_tlb_page_ipi, (void *)&fd, 1);
 	} else {
 		int i;
 		for (i = 0; i < smp_num_cpus; i++)

-- 
function.linuxpower.ca


