Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTEaLrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 07:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264294AbTEaLrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 07:47:10 -0400
Received: from ns.suse.de ([213.95.15.193]:37128 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264289AbTEaLrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 07:47:06 -0400
Date: Sat, 31 May 2003 14:00:27 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Some subarch warning fixes
Message-ID: <20030531120027.GA11314@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some recent subarch interface changes caused macro redefinition warnings for
GET_APIC_ID and APIC_ID_MASK with the generic subarchitecture.
Fixing it properly required some reorganization by giving the generic arch
a mach_apicdef.h too.

-Andi

Index: linux/arch/i386/mach-generic/default.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/mach-generic/default.c,v
retrieving revision 1.11
diff -u -u -r1.11 default.c
--- linux/arch/i386/mach-generic/default.c	30 May 2003 20:10:55 -0000	1.11
+++ linux/arch/i386/mach-generic/default.c	31 May 2003 10:24:21 -0000
@@ -2,6 +2,7 @@
  * Default generic APIC driver. This handles upto 8 CPUs.
  */
 #define APIC_DEFINITION 1
+#include <asm/mach-default/mach_apicdef.h>
 #include <asm/genapic.h>
 #include <asm/fixmap.h>
 #include <asm/apicdef.h>
@@ -10,7 +11,6 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <asm/mach-default/mach_apic.h>
-#include <asm/mach-default/mach_apicdef.h>
 #include <asm/mach-default/mach_ipi.h>
 #include <asm/mach-default/mach_mpparse.h>
 
Index: linux/include/asm-i386/mach-generic/mach_apic.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/mach-generic/mach_apic.h,v
retrieving revision 1.11
diff -u -u -r1.11 mach_apic.h
--- linux/include/asm-i386/mach-generic/mach_apic.h	30 May 2003 20:12:04 -0000	1.11
+++ linux/include/asm-i386/mach-generic/mach_apic.h	31 May 2003 10:24:24 -0000
@@ -24,8 +24,6 @@
 #define check_apicid_present (genapic->check_apicid_present)
 #define check_phys_apicid_present (genapic->check_phys_apicid_present)
 #define check_apicid_used (genapic->check_apicid_used)
-#define GET_APIC_ID (genapic->get_apic_id)
-#define APIC_ID_MASK (genapic->apic_id_mask)
 #define cpu_mask_to_apicid (genapic->cpu_mask_to_apicid)
 
 #endif /* __ASM_MACH_APIC_H */
 
--- /dev/null	2002-10-01 20:59:47.000000000 +0200
+++ linux-small/include/asm-i386/mach-generic/mach_apicdef.h	2003-05-31 12:20:12.000000000 +0200
@@ -0,0 +1,11 @@
+#ifndef _GENAPIC_MACH_APICDEF_H
+#define _GENAPIC_MACH_APICDEF_H 1
+
+#ifndef APIC_DEFINITION
+#include <asm/genapic.h>
+
+#define GET_APIC_ID (genapic->get_apic_id)
+#define APIC_ID_MASK (genapic->apic_id_mask)
+#endif
+
+#endif
