Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUGIJyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUGIJyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUGIJyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:54:38 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:3039 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S264781AbUGIJx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:53:59 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Jes Sorensen'" <jes@trained-monkey.org>, <mort@wildopensource.com>
Subject: [PATCH] PER_CPU [1/4] - PER_CPU-cpu_gdt_table
Date: Fri, 9 Jul 2004 02:53:51 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0043_01C4655F.F9048CE0"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRlmqNgxpdGyvj+Q8e3wuE8CBg9Dg==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S264781AbUGIJx7/20040709095359Z+23@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0043_01C4655F.F9048CE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[SECOND SUBBMITAL - Thanks for all the comments]
Andrew,

Please find below one out of collection of patched that move NR_CPU =
array=20
variables to the per-cpu area.  Please consider applying, any comment =
will
highly appreciated.

Patches (altogether) tested using make allmodconfig, and defconfig, and
booted my system very nicely.

1/4. PER_CPU-cpu_gdt_table
2/4. PER_CPU-init_tss
3/4. PER_CPU-cpu_tlbstate
4/4. PER_CPU-irq_stat

PER_CPU-cpu_gdt_table:
 arch/i386/kernel/apm.c          |   34 =
+++++++++++++++++-----------------
 arch/i386/kernel/cpu/common.c   |   21 +++++++++++++--------
 arch/i386/kernel/head.S         |    3 ---
 arch/i386/mm/fault.c            |    2 +-
 arch/i386/power/cpu.c           |    2 +-
 drivers/pnp/pnpbios/bioscalls.c |   14 +++++++-------
 include/asm-i386/desc.h         |   10 ++++++----
 7 files changed, 45 insertions(+), 41 deletions(-)

Signed-off-by: Martin Hicks <mort@wildopensource.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/08 23:02:52-07:00 shai@compile.(none)=20
#   desc.h, bioscalls.c, cpu.c, fault.c, head.S, common.c, apm.c:
#     PER_CPU-cpu_gdt_table
#   Convert cpu_gdt_table into a per_cpu variable. The only tricky bit =
is
#   that the boot CPU uses a static gdt_table during the initial =
startup.
#   Then we switch the processor over to using the gdt_table in the
#   per_cpu area during the SMP init.
#  =20
#   Signed-off-by: Martin Hicks <mort@wildopensource.com>
#   Signed-off-by: Shai Fultheim <shai@scalex86.org>
#=20
# include/asm-i386/desc.h
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +6 -4
#   PER_CPU-cpu_gdt_table
#=20
# drivers/pnp/pnpbios/bioscalls.c
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +7 -7
#   PER_CPU-cpu_gdt_table
#=20
# arch/i386/power/cpu.c
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +1 -1
#   PER_CPU-cpu_gdt_table
#=20
# arch/i386/mm/fault.c
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +1 -1
#   PER_CPU-cpu_gdt_table
#=20
# arch/i386/kernel/head.S
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +0 -3
#   PER_CPU-cpu_gdt_table
#=20
# arch/i386/kernel/cpu/common.c
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +13 -8
#   PER_CPU-cpu_gdt_table
#=20
# arch/i386/kernel/apm.c
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +17 -17
#   PER_CPU-cpu_gdt_table
#=20
diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	2004-07-09 01:34:25 -07:00
+++ b/arch/i386/kernel/apm.c	2004-07-09 01:34:25 -07:00
@@ -601,8 +601,8 @@
 	cpus =3D apm_save_cpus();
 =09
 	cpu =3D get_cpu();
-	save_desc_40 =3D cpu_gdt_table[cpu][0x40 / 8];
-	cpu_gdt_table[cpu][0x40 / 8] =3D bad_bios_desc;
+	save_desc_40 =3D per_cpu(cpu_gdt_table, cpu)[0x40 / 8];
+	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] =3D bad_bios_desc;
=20
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -610,7 +610,7 @@
 	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	cpu_gdt_table[cpu][0x40 / 8] =3D save_desc_40;
+	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] =3D save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);
 =09
@@ -644,8 +644,8 @@
 	cpus =3D apm_save_cpus();
 =09
 	cpu =3D get_cpu();
-	save_desc_40 =3D cpu_gdt_table[cpu][0x40 / 8];
-	cpu_gdt_table[cpu][0x40 / 8] =3D bad_bios_desc;
+	save_desc_40 =3D per_cpu(cpu_gdt_table, cpu)[0x40 / 8];
+	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] =3D bad_bios_desc;
=20
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -653,7 +653,7 @@
 	error =3D apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	cpu_gdt_table[smp_processor_id()][0x40 / 8] =3D save_desc_40;
+	__get_cpu_var(cpu_gdt_table)[0x40 / 8] =3D save_desc_40;
 	put_cpu();
 	apm_restore_cpus(cpus);
 	return error;
@@ -2292,35 +2292,35 @@
 	apm_bios_entry.segment =3D APM_CS;
=20
 	for (i =3D 0; i < NR_CPUS; i++) {
-		set_base(cpu_gdt_table[i][APM_CS >> 3],
+		set_base(per_cpu(cpu_gdt_table, i)[APM_CS >> 3],
 			 __va((unsigned long)apm_info.bios.cseg << 4));
-		set_base(cpu_gdt_table[i][APM_CS_16 >> 3],
+		set_base(per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3],
 			 __va((unsigned long)apm_info.bios.cseg_16 << 4));
-		set_base(cpu_gdt_table[i][APM_DS >> 3],
+		set_base(per_cpu(cpu_gdt_table, i)[APM_DS >> 3],
 			 __va((unsigned long)apm_info.bios.dseg << 4));
 #ifndef APM_RELAX_SEGMENTS
 		if (apm_info.bios.version =3D=3D 0x100) {
 #endif
 			/* For ASUS motherboard, Award BIOS rev 110 (and others?) */
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS >> 3], 64 * 1024 - 1);
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS >> 3], 64 * =
1024 - 1);
 			/* For some unknown machine. */
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS_16 >> 3], 64 * 1024 - =
1);
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3], 64 * =
1024 - 1);
 			/* For the DEC Hinote Ultra CT475 (and others?) */
-			_set_limit((char *)&cpu_gdt_table[i][APM_DS >> 3], 64 * 1024 - 1);
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_DS >> 3], 64 * =
1024 - 1);
 #ifndef APM_RELAX_SEGMENTS
 		} else {
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS >> 3],
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS >> 3],
 				(apm_info.bios.cseg_len - 1) & 0xffff);
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS_16 >> 3],
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3],
 				(apm_info.bios.cseg_16_len - 1) & 0xffff);
-			_set_limit((char *)&cpu_gdt_table[i][APM_DS >> 3],
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_DS >> 3],
 				(apm_info.bios.dseg_len - 1) & 0xffff);
 		      /* workaround for broken BIOSes */
 	                if (apm_info.bios.cseg_len <=3D apm_info.bios.offset)
-        	                _set_limit((char *)&cpu_gdt_table[i][APM_CS >> =
3], 64 * 1024 -1);
+        	                _set_limit((char *)&per_cpu(cpu_gdt_table, =
i)[APM_CS >> 3], 64 * 1024 -1);
                        if (apm_info.bios.dseg_len <=3D 0x40) { /* 0x40 =
* 4kB =3D=3D 64kB */
                         	/* for the BIOS that assumes granularity =3D 1 =
*/
-                        	cpu_gdt_table[i][APM_DS >> 3].b |=3D 0x800000;
+                        	per_cpu(cpu_gdt_table, i)[APM_DS >> 3].b |=3D =
0x800000;
                         	printk(KERN_NOTICE "apm: we set the =
granularity of dseg.\n");
         	        }
 		}
diff -Nru a/arch/i386/kernel/cpu/common.c =
b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	2004-07-09 01:34:25 -07:00
+++ b/arch/i386/kernel/cpu/common.c	2004-07-09 01:34:25 -07:00
@@ -2,6 +2,7 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
+#include <linux/percpu.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
@@ -11,6 +12,8 @@
=20
 #include "cpu.h"
=20
+DEFINE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
+
 static int cachesize_override __initdata =3D -1;
 static int disable_x86_fxsr __initdata =3D 0;
 static int disable_x86_serial_nr __initdata =3D 1;
@@ -523,15 +526,17 @@
 	 * Initialize the per-CPU GDT with the boot GDT,
 	 * and set up the GDT descriptor:
 	 */
-	if (cpu) {
-		memcpy(cpu_gdt_table[cpu], cpu_gdt_table[0], GDT_SIZE);
-		cpu_gdt_descr[cpu].size =3D GDT_SIZE - 1;
-		cpu_gdt_descr[cpu].address =3D (unsigned long)cpu_gdt_table[cpu];
-	}
+	memcpy(&per_cpu(cpu_gdt_table, cpu), cpu_gdt_table,
+	       GDT_SIZE);
+	cpu_gdt_descr[cpu].size =3D GDT_SIZE - 1;
+	cpu_gdt_descr[cpu].address =3D
+	    (unsigned long)&per_cpu(cpu_gdt_table, cpu);
+
 	/*
 	 * Set up the per-thread TLS descriptor cache:
 	 */
-	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_ENTRIES * =
8);
+	memcpy(thread->tls_array, &per_cpu(cpu_gdt_table, cpu),
+		GDT_ENTRY_TLS_ENTRIES * 8);
=20
 	__asm__ __volatile__("lgdt %0" : : "m" (cpu_gdt_descr[cpu]));
 	__asm__ __volatile__("lidt %0" : : "m" (idt_descr));
@@ -552,13 +557,13 @@
=20
 	load_esp0(t, thread);
 	set_tss_desc(cpu,t);
-	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &=3D 0xfffffdff;
+	per_cpu(cpu_gdt_table,cpu)[GDT_ENTRY_TSS].b &=3D 0xfffffdff;
 	load_TR_desc();
 	load_LDT(&init_mm.context);
=20
 	/* Set up doublefault TSS pointer in the GDT */
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
-	cpu_gdt_table[cpu][GDT_ENTRY_DOUBLEFAULT_TSS].b &=3D 0xfffffdff;
+	per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_DOUBLEFAULT_TSS].b &=3D =
0xfffffdff;
=20
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
diff -Nru a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	2004-07-09 01:34:25 -07:00
+++ b/arch/i386/kernel/head.S	2004-07-09 01:34:25 -07:00
@@ -521,6 +521,3 @@
 	.quad 0x0000000000000000	/* 0xf0 - unused */
 	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
=20
-#ifdef CONFIG_SMP
-	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
-#endif
diff -Nru a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
--- a/arch/i386/mm/fault.c	2004-07-09 01:34:25 -07:00
+++ b/arch/i386/mm/fault.c	2004-07-09 01:34:25 -07:00
@@ -107,7 +107,7 @@
 		desc =3D (void *)desc + (seg & ~7);
 	} else {
 		/* Must disable preemption while reading the GDT. */
-		desc =3D (u32 *)&cpu_gdt_table[get_cpu()];
+		desc =3D (u32 *)&per_cpu(cpu_gdt_table, get_cpu());
 		desc =3D (void *)desc + (seg & ~7);
 	}
=20
diff -Nru a/arch/i386/power/cpu.c b/arch/i386/power/cpu.c
--- a/arch/i386/power/cpu.c	2004-07-09 01:34:25 -07:00
+++ b/arch/i386/power/cpu.c	2004-07-09 01:34:25 -07:00
@@ -86,7 +86,7 @@
 	struct tss_struct * t =3D init_tss + cpu;
=20
 	set_tss_desc(cpu,t);	/* This just modifies memory; should not be =
necessary. But... This is necessary, because 386
hardware has concept of busy TSS or some similar stupidity. */
-        cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &=3D 0xfffffdff;
+        per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TSS].b &=3D 0xfffffdff;
=20
 	load_TR_desc();				/* This does ltr */
 	load_LDT(&current->active_mm->context);	/* This does lldt */
diff -Nru a/drivers/pnp/pnpbios/bioscalls.c =
b/drivers/pnp/pnpbios/bioscalls.c
--- a/drivers/pnp/pnpbios/bioscalls.c	2004-07-09 01:34:25 -07:00
+++ b/drivers/pnp/pnpbios/bioscalls.c	2004-07-09 01:34:25 -07:00
@@ -69,14 +69,14 @@
=20
 #define Q_SET_SEL(cpu, selname, address, size) \
 do { \
-set_base(cpu_gdt_table[cpu][(selname) >> 3], __va((u32)(address))); \
-set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
+set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], =
__va((u32)(address))); \
+set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \
 } while(0)
=20
 #define Q2_SET_SEL(cpu, selname, address, size) \
 do { \
-set_base(cpu_gdt_table[cpu][(selname) >> 3], (u32)(address)); \
-set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
+set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], (u32)(address)); \
+set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \
 } while(0)
=20
 static struct desc_struct bad_bios_desc =3D { 0, 0x00409200 };
@@ -115,8 +115,8 @@
 		return PNP_FUNCTION_NOT_SUPPORTED;
=20
 	cpu =3D get_cpu();
-	save_desc_40 =3D cpu_gdt_table[cpu][0x40 / 8];
-	cpu_gdt_table[cpu][0x40 / 8] =3D bad_bios_desc;
+	save_desc_40 =3D per_cpu(cpu_gdt_table,cpu)[0x40 / 8];
+	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] =3D bad_bios_desc;
=20
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
@@ -158,7 +158,7 @@
 	);
 	spin_unlock_irqrestore(&pnp_bios_lock, flags);
=20
-	cpu_gdt_table[cpu][0x40 / 8] =3D save_desc_40;
+	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] =3D save_desc_40;
 	put_cpu();
=20
 	/* If we get here and this is set then the PnP BIOS faulted on us. */
diff -Nru a/include/asm-i386/desc.h b/include/asm-i386/desc.h
--- a/include/asm-i386/desc.h	2004-07-09 01:34:25 -07:00
+++ b/include/asm-i386/desc.h	2004-07-09 01:34:25 -07:00
@@ -8,10 +8,12 @@
=20
 #include <linux/preempt.h>
 #include <linux/smp.h>
+#include <linux/percpu.h>
=20
 #include <asm/mmu.h>
=20
-extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];
+extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
+DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
=20
 struct Xgt_desc_struct {
 	unsigned short size;
@@ -44,7 +46,7 @@
=20
 static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, =
void *addr)
 {
-	_set_tssldt_desc(&cpu_gdt_table[cpu][entry], (int)addr,
+	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[entry], (int)addr,
 		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
 }
=20
@@ -52,7 +54,7 @@
=20
 static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned =
int size)
 {
-	_set_tssldt_desc(&cpu_gdt_table[cpu][GDT_ENTRY_LDT], (int)addr, ((size =
<< 3)-1), 0x82);
+	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_LDT], =
(int)addr, ((size << 3)-1), 0x82);
 }
=20
 #define LDT_entry_a(info) \
@@ -86,7 +88,7 @@
=20
 static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
 {
-#define C(i) cpu_gdt_table[cpu][GDT_ENTRY_TLS_MIN + i] =3D =
t->tls_array[i]
+#define C(i) per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN + i] =3D =
t->tls_array[i]
 	C(0); C(1); C(2);
 #undef C
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=A0
-----------------
Shai Fultheim
Scalex86.org



------=_NextPart_000_0043_01C4655F.F9048CE0
Content-Type: application/octet-stream;
	name="rev-1.1819.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rev-1.1819.patch"

# This is a BitKeeper generated diff -Nru style patch.=0A=
#=0A=
# ChangeSet=0A=
#   2004/07/08 23:02:52-07:00 shai@compile.(none) =0A=
#   desc.h, bioscalls.c, cpu.c, fault.c, head.S, common.c, apm.c:=0A=
#     PER_CPU-cpu_gdt_table=0A=
#   Convert cpu_gdt_table into a per_cpu variable. The only tricky bit is=0A=
#   that the boot CPU uses a static gdt_table during the initial startup.=0A=
#   Then we switch the processor over to using the gdt_table in the=0A=
#   per_cpu area during the SMP init.=0A=
#   =0A=
#   Signed-off-by: Martin Hicks <mort@wildopensource.com>=0A=
#   Signed-off-by: Shai Fultheim <shai@scalex86.org>=0A=
# =0A=
# include/asm-i386/desc.h=0A=
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +6 -4=0A=
#   PER_CPU-cpu_gdt_table=0A=
# =0A=
# drivers/pnp/pnpbios/bioscalls.c=0A=
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +7 -7=0A=
#   PER_CPU-cpu_gdt_table=0A=
# =0A=
# arch/i386/power/cpu.c=0A=
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +1 -1=0A=
#   PER_CPU-cpu_gdt_table=0A=
# =0A=
# arch/i386/mm/fault.c=0A=
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +1 -1=0A=
#   PER_CPU-cpu_gdt_table=0A=
# =0A=
# arch/i386/kernel/head.S=0A=
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +0 -3=0A=
#   PER_CPU-cpu_gdt_table=0A=
# =0A=
# arch/i386/kernel/cpu/common.c=0A=
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +13 -8=0A=
#   PER_CPU-cpu_gdt_table=0A=
# =0A=
# arch/i386/kernel/apm.c=0A=
#   2004/07/08 23:00:23-07:00 shai@compile.(none) +17 -17=0A=
#   PER_CPU-cpu_gdt_table=0A=
# =0A=
diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c=0A=
--- a/arch/i386/kernel/apm.c	2004-07-09 01:34:25 -07:00=0A=
+++ b/arch/i386/kernel/apm.c	2004-07-09 01:34:25 -07:00=0A=
@@ -601,8 +601,8 @@=0A=
 	cpus =3D apm_save_cpus();=0A=
 	=0A=
 	cpu =3D get_cpu();=0A=
-	save_desc_40 =3D cpu_gdt_table[cpu][0x40 / 8];=0A=
-	cpu_gdt_table[cpu][0x40 / 8] =3D bad_bios_desc;=0A=
+	save_desc_40 =3D per_cpu(cpu_gdt_table, cpu)[0x40 / 8];=0A=
+	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] =3D bad_bios_desc;=0A=
 =0A=
 	local_save_flags(flags);=0A=
 	APM_DO_CLI;=0A=
@@ -610,7 +610,7 @@=0A=
 	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);=0A=
 	APM_DO_RESTORE_SEGS;=0A=
 	local_irq_restore(flags);=0A=
-	cpu_gdt_table[cpu][0x40 / 8] =3D save_desc_40;=0A=
+	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] =3D save_desc_40;=0A=
 	put_cpu();=0A=
 	apm_restore_cpus(cpus);=0A=
 	=0A=
@@ -644,8 +644,8 @@=0A=
 	cpus =3D apm_save_cpus();=0A=
 	=0A=
 	cpu =3D get_cpu();=0A=
-	save_desc_40 =3D cpu_gdt_table[cpu][0x40 / 8];=0A=
-	cpu_gdt_table[cpu][0x40 / 8] =3D bad_bios_desc;=0A=
+	save_desc_40 =3D per_cpu(cpu_gdt_table, cpu)[0x40 / 8];=0A=
+	per_cpu(cpu_gdt_table, cpu)[0x40 / 8] =3D bad_bios_desc;=0A=
 =0A=
 	local_save_flags(flags);=0A=
 	APM_DO_CLI;=0A=
@@ -653,7 +653,7 @@=0A=
 	error =3D apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);=0A=
 	APM_DO_RESTORE_SEGS;=0A=
 	local_irq_restore(flags);=0A=
-	cpu_gdt_table[smp_processor_id()][0x40 / 8] =3D save_desc_40;=0A=
+	__get_cpu_var(cpu_gdt_table)[0x40 / 8] =3D save_desc_40;=0A=
 	put_cpu();=0A=
 	apm_restore_cpus(cpus);=0A=
 	return error;=0A=
@@ -2292,35 +2292,35 @@=0A=
 	apm_bios_entry.segment =3D APM_CS;=0A=
 =0A=
 	for (i =3D 0; i < NR_CPUS; i++) {=0A=
-		set_base(cpu_gdt_table[i][APM_CS >> 3],=0A=
+		set_base(per_cpu(cpu_gdt_table, i)[APM_CS >> 3],=0A=
 			 __va((unsigned long)apm_info.bios.cseg << 4));=0A=
-		set_base(cpu_gdt_table[i][APM_CS_16 >> 3],=0A=
+		set_base(per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3],=0A=
 			 __va((unsigned long)apm_info.bios.cseg_16 << 4));=0A=
-		set_base(cpu_gdt_table[i][APM_DS >> 3],=0A=
+		set_base(per_cpu(cpu_gdt_table, i)[APM_DS >> 3],=0A=
 			 __va((unsigned long)apm_info.bios.dseg << 4));=0A=
 #ifndef APM_RELAX_SEGMENTS=0A=
 		if (apm_info.bios.version =3D=3D 0x100) {=0A=
 #endif=0A=
 			/* For ASUS motherboard, Award BIOS rev 110 (and others?) */=0A=
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS >> 3], 64 * 1024 - 1);=0A=
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS >> 3], 64 * =
1024 - 1);=0A=
 			/* For some unknown machine. */=0A=
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS_16 >> 3], 64 * 1024 - 1);=0A=
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3], 64 * =
1024 - 1);=0A=
 			/* For the DEC Hinote Ultra CT475 (and others?) */=0A=
-			_set_limit((char *)&cpu_gdt_table[i][APM_DS >> 3], 64 * 1024 - 1);=0A=
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_DS >> 3], 64 * =
1024 - 1);=0A=
 #ifndef APM_RELAX_SEGMENTS=0A=
 		} else {=0A=
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS >> 3],=0A=
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS >> 3],=0A=
 				(apm_info.bios.cseg_len - 1) & 0xffff);=0A=
-			_set_limit((char *)&cpu_gdt_table[i][APM_CS_16 >> 3],=0A=
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_CS_16 >> 3],=0A=
 				(apm_info.bios.cseg_16_len - 1) & 0xffff);=0A=
-			_set_limit((char *)&cpu_gdt_table[i][APM_DS >> 3],=0A=
+			_set_limit((char *)&per_cpu(cpu_gdt_table, i)[APM_DS >> 3],=0A=
 				(apm_info.bios.dseg_len - 1) & 0xffff);=0A=
 		      /* workaround for broken BIOSes */=0A=
 	                if (apm_info.bios.cseg_len <=3D apm_info.bios.offset)=0A=
-        	                _set_limit((char *)&cpu_gdt_table[i][APM_CS >> =
3], 64 * 1024 -1);=0A=
+        	                _set_limit((char *)&per_cpu(cpu_gdt_table, =
i)[APM_CS >> 3], 64 * 1024 -1);=0A=
                        if (apm_info.bios.dseg_len <=3D 0x40) { /* 0x40 =
* 4kB =3D=3D 64kB */=0A=
                         	/* for the BIOS that assumes granularity =3D 1 =
*/=0A=
-                        	cpu_gdt_table[i][APM_DS >> 3].b |=3D 0x800000;=0A=
+                        	per_cpu(cpu_gdt_table, i)[APM_DS >> 3].b |=3D =
0x800000;=0A=
                         	printk(KERN_NOTICE "apm: we set the =
granularity of dseg.\n");=0A=
         	        }=0A=
 		}=0A=
diff -Nru a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c=0A=
--- a/arch/i386/kernel/cpu/common.c	2004-07-09 01:34:25 -07:00=0A=
+++ b/arch/i386/kernel/cpu/common.c	2004-07-09 01:34:25 -07:00=0A=
@@ -2,6 +2,7 @@=0A=
 #include <linux/string.h>=0A=
 #include <linux/delay.h>=0A=
 #include <linux/smp.h>=0A=
+#include <linux/percpu.h>=0A=
 #include <asm/semaphore.h>=0A=
 #include <asm/processor.h>=0A=
 #include <asm/i387.h>=0A=
@@ -11,6 +12,8 @@=0A=
 =0A=
 #include "cpu.h"=0A=
 =0A=
+DEFINE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);=0A=
+=0A=
 static int cachesize_override __initdata =3D -1;=0A=
 static int disable_x86_fxsr __initdata =3D 0;=0A=
 static int disable_x86_serial_nr __initdata =3D 1;=0A=
@@ -523,15 +526,17 @@=0A=
 	 * Initialize the per-CPU GDT with the boot GDT,=0A=
 	 * and set up the GDT descriptor:=0A=
 	 */=0A=
-	if (cpu) {=0A=
-		memcpy(cpu_gdt_table[cpu], cpu_gdt_table[0], GDT_SIZE);=0A=
-		cpu_gdt_descr[cpu].size =3D GDT_SIZE - 1;=0A=
-		cpu_gdt_descr[cpu].address =3D (unsigned long)cpu_gdt_table[cpu];=0A=
-	}=0A=
+	memcpy(&per_cpu(cpu_gdt_table, cpu), cpu_gdt_table,=0A=
+	       GDT_SIZE);=0A=
+	cpu_gdt_descr[cpu].size =3D GDT_SIZE - 1;=0A=
+	cpu_gdt_descr[cpu].address =3D=0A=
+	    (unsigned long)&per_cpu(cpu_gdt_table, cpu);=0A=
+=0A=
 	/*=0A=
 	 * Set up the per-thread TLS descriptor cache:=0A=
 	 */=0A=
-	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_ENTRIES * =
8);=0A=
+	memcpy(thread->tls_array, &per_cpu(cpu_gdt_table, cpu),=0A=
+		GDT_ENTRY_TLS_ENTRIES * 8);=0A=
 =0A=
 	__asm__ __volatile__("lgdt %0" : : "m" (cpu_gdt_descr[cpu]));=0A=
 	__asm__ __volatile__("lidt %0" : : "m" (idt_descr));=0A=
@@ -552,13 +557,13 @@=0A=
 =0A=
 	load_esp0(t, thread);=0A=
 	set_tss_desc(cpu,t);=0A=
-	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &=3D 0xfffffdff;=0A=
+	per_cpu(cpu_gdt_table,cpu)[GDT_ENTRY_TSS].b &=3D 0xfffffdff;=0A=
 	load_TR_desc();=0A=
 	load_LDT(&init_mm.context);=0A=
 =0A=
 	/* Set up doublefault TSS pointer in the GDT */=0A=
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);=0A=
-	cpu_gdt_table[cpu][GDT_ENTRY_DOUBLEFAULT_TSS].b &=3D 0xfffffdff;=0A=
+	per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_DOUBLEFAULT_TSS].b &=3D =
0xfffffdff;=0A=
 =0A=
 	/* Clear %fs and %gs. */=0A=
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");=0A=
diff -Nru a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S=0A=
--- a/arch/i386/kernel/head.S	2004-07-09 01:34:25 -07:00=0A=
+++ b/arch/i386/kernel/head.S	2004-07-09 01:34:25 -07:00=0A=
@@ -521,6 +521,3 @@=0A=
 	.quad 0x0000000000000000	/* 0xf0 - unused */=0A=
 	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */=0A=
 =0A=
-#ifdef CONFIG_SMP=0A=
-	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */=0A=
-#endif=0A=
diff -Nru a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c=0A=
--- a/arch/i386/mm/fault.c	2004-07-09 01:34:25 -07:00=0A=
+++ b/arch/i386/mm/fault.c	2004-07-09 01:34:25 -07:00=0A=
@@ -107,7 +107,7 @@=0A=
 		desc =3D (void *)desc + (seg & ~7);=0A=
 	} else {=0A=
 		/* Must disable preemption while reading the GDT. */=0A=
-		desc =3D (u32 *)&cpu_gdt_table[get_cpu()];=0A=
+		desc =3D (u32 *)&per_cpu(cpu_gdt_table, get_cpu());=0A=
 		desc =3D (void *)desc + (seg & ~7);=0A=
 	}=0A=
 =0A=
diff -Nru a/arch/i386/power/cpu.c b/arch/i386/power/cpu.c=0A=
--- a/arch/i386/power/cpu.c	2004-07-09 01:34:25 -07:00=0A=
+++ b/arch/i386/power/cpu.c	2004-07-09 01:34:25 -07:00=0A=
@@ -86,7 +86,7 @@=0A=
 	struct tss_struct * t =3D init_tss + cpu;=0A=
 =0A=
 	set_tss_desc(cpu,t);	/* This just modifies memory; should not be =
necessary. But... This is necessary, because 386 hardware has concept of =
busy TSS or some similar stupidity. */=0A=
-        cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &=3D 0xfffffdff;=0A=
+        per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TSS].b &=3D 0xfffffdff;=0A=
 =0A=
 	load_TR_desc();				/* This does ltr */=0A=
 	load_LDT(&current->active_mm->context);	/* This does lldt */=0A=
diff -Nru a/drivers/pnp/pnpbios/bioscalls.c =
b/drivers/pnp/pnpbios/bioscalls.c=0A=
--- a/drivers/pnp/pnpbios/bioscalls.c	2004-07-09 01:34:25 -07:00=0A=
+++ b/drivers/pnp/pnpbios/bioscalls.c	2004-07-09 01:34:25 -07:00=0A=
@@ -69,14 +69,14 @@=0A=
 =0A=
 #define Q_SET_SEL(cpu, selname, address, size) \=0A=
 do { \=0A=
-set_base(cpu_gdt_table[cpu][(selname) >> 3], __va((u32)(address))); \=0A=
-set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \=0A=
+set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], =
__va((u32)(address))); \=0A=
+set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \=0A=
 } while(0)=0A=
 =0A=
 #define Q2_SET_SEL(cpu, selname, address, size) \=0A=
 do { \=0A=
-set_base(cpu_gdt_table[cpu][(selname) >> 3], (u32)(address)); \=0A=
-set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \=0A=
+set_base(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], (u32)(address)); \=0A=
+set_limit(per_cpu(cpu_gdt_table,cpu)[(selname) >> 3], size); \=0A=
 } while(0)=0A=
 =0A=
 static struct desc_struct bad_bios_desc =3D { 0, 0x00409200 };=0A=
@@ -115,8 +115,8 @@=0A=
 		return PNP_FUNCTION_NOT_SUPPORTED;=0A=
 =0A=
 	cpu =3D get_cpu();=0A=
-	save_desc_40 =3D cpu_gdt_table[cpu][0x40 / 8];=0A=
-	cpu_gdt_table[cpu][0x40 / 8] =3D bad_bios_desc;=0A=
+	save_desc_40 =3D per_cpu(cpu_gdt_table,cpu)[0x40 / 8];=0A=
+	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] =3D bad_bios_desc;=0A=
 =0A=
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */=0A=
 	spin_lock_irqsave(&pnp_bios_lock, flags);=0A=
@@ -158,7 +158,7 @@=0A=
 	);=0A=
 	spin_unlock_irqrestore(&pnp_bios_lock, flags);=0A=
 =0A=
-	cpu_gdt_table[cpu][0x40 / 8] =3D save_desc_40;=0A=
+	per_cpu(cpu_gdt_table,cpu)[0x40 / 8] =3D save_desc_40;=0A=
 	put_cpu();=0A=
 =0A=
 	/* If we get here and this is set then the PnP BIOS faulted on us. */=0A=
diff -Nru a/include/asm-i386/desc.h b/include/asm-i386/desc.h=0A=
--- a/include/asm-i386/desc.h	2004-07-09 01:34:25 -07:00=0A=
+++ b/include/asm-i386/desc.h	2004-07-09 01:34:25 -07:00=0A=
@@ -8,10 +8,12 @@=0A=
 =0A=
 #include <linux/preempt.h>=0A=
 #include <linux/smp.h>=0A=
+#include <linux/percpu.h>=0A=
 =0A=
 #include <asm/mmu.h>=0A=
 =0A=
-extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];=0A=
+extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];=0A=
+DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);=0A=
 =0A=
 struct Xgt_desc_struct {=0A=
 	unsigned short size;=0A=
@@ -44,7 +46,7 @@=0A=
 =0A=
 static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, =
void *addr)=0A=
 {=0A=
-	_set_tssldt_desc(&cpu_gdt_table[cpu][entry], (int)addr,=0A=
+	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[entry], (int)addr,=0A=
 		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);=0A=
 }=0A=
 =0A=
@@ -52,7 +54,7 @@=0A=
 =0A=
 static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned =
int size)=0A=
 {=0A=
-	_set_tssldt_desc(&cpu_gdt_table[cpu][GDT_ENTRY_LDT], (int)addr, ((size =
<< 3)-1), 0x82);=0A=
+	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_LDT], =
(int)addr, ((size << 3)-1), 0x82);=0A=
 }=0A=
 =0A=
 #define LDT_entry_a(info) \=0A=
@@ -86,7 +88,7 @@=0A=
 =0A=
 static inline void load_TLS(struct thread_struct *t, unsigned int cpu)=0A=
 {=0A=
-#define C(i) cpu_gdt_table[cpu][GDT_ENTRY_TLS_MIN + i] =3D =
t->tls_array[i]=0A=
+#define C(i) per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN + i] =3D =
t->tls_array[i]=0A=
 	C(0); C(1); C(2);=0A=
 #undef C=0A=
 }=0A=

------=_NextPart_000_0043_01C4655F.F9048CE0--

