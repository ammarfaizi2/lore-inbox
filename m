Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVA1TUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVA1TUU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVA1TR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:17:57 -0500
Received: from fsmlabs.com ([168.103.115.128]:3528 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262771AbVA1TNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:13:33 -0500
Date: Fri, 28 Jan 2005 12:14:06 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: John Levon <levon@movementarian.org>, Andrew Morton <akpm@osdl.org>,
       Philippe Elie <phil.el@wanadoo.fr>
Subject: [PATCH] OProfile: Support model 4 P4
Message-ID: <Pine.LNX.4.61.0501281209360.22859@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following processor was marked as unsupported, there are no documented
changes in the performance counter interface for this processor.

Hardware courtesy of Intel Corporation

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Genuine Intel(R) CPU 3.60GHz
stepping        : 1
cpu MHz         : 3600.761
cache size      : 1024 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm pni 
monitor ds_cpl tm2 cid cx16 xtpr
bogomips        : 7110.65

CPU: P4 / Xeon with 2 hyper-threads, speed 3601.79 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not 
stopped) with a unit mask of 0x01 (count cycles when processor is active) 
count 10000

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

===== arch/i386/oprofile/nmi_int.c 1.26 vs edited =====
--- 1.26/arch/i386/oprofile/nmi_int.c	2005-01-07 22:44:02 -07:00
+++ edited/arch/i386/oprofile/nmi_int.c	2005-01-28 12:07:33 -07:00
@@ -304,7 +304,7 @@ static int __init p4_init(char ** cpu_ty
 {
 	__u8 cpu_model = boot_cpu_data.x86_model;
 
-	if (cpu_model > 3)
+	if (cpu_model > 4)
 		return 0;
 
 #ifndef CONFIG_SMP
