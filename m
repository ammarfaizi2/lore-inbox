Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUGIJzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUGIJzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGIJzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:55:25 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:3551 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S264782AbUGIJyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:54:00 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Jes Sorensen'" <jes@trained-monkey.org>, <mort@wildopensource.com>
Subject: [PATCH] PER_CPU [2/4] - PER_CPU-init_tss
Date: Fri, 9 Jul 2004 02:53:56 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0046_01C4655F.FA629640"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRlmqZi4fMtQQObQO2luxE/h+Ri3A==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S264782AbUGIJyA/20040709095400Z+24@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0046_01C4655F.FA629640
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

PER_CPU-init_tss:
 arch/i386/kernel/cpu/common.c |    2 +-
 arch/i386/kernel/init_task.c  |    7 ++-----
 arch/i386/kernel/ioport.c     |    2 +-
 arch/i386/kernel/process.c    |    4 ++--
 arch/i386/kernel/sysenter.c   |    2 +-
 arch/i386/kernel/vm86.c       |    4 ++--
 arch/i386/power/cpu.c         |    2 +-
 include/asm-i386/processor.h  |    4 ++--
 8 files changed, 12 insertions(+), 15 deletions(-)

Signed-off-by: Martin Hicks <mort@wildopensource.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/09 00:43:12-07:00 shai@compile.(none)=20
#   Many files:
#     PER_CPU-init_tss
#   Convert init_tss into a per_cpu variable. The only tricky bit is
#   that the esp1 initaliztion is not needed since Linux never uses
#   ring1.  esp1 is initalized at 'enable_sep_cpu' for
#   sysenter/sysexit.
#    =20
#   Signed-off-by: Martin Hicks <mort@wildopensource.com>
#   Signed-off-by: Shai Fultheim <shai@scalex86.org>
#=20
# include/asm-i386/processor.h
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +2 -2
#   PER_CPU-init_tss
#=20
# arch/i386/power/cpu.c
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +1 -1
#   PER_CPU-init_tss
#=20
# arch/i386/kernel/vm86.c
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +2 -2
#   PER_CPU-init_tss
#=20
# arch/i386/kernel/sysenter.c
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +1 -1
#   PER_CPU-init_tss
#=20
# arch/i386/kernel/process.c
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +2 -2
#   PER_CPU-init_tss
#=20
# arch/i386/kernel/ioport.c
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +1 -1
#   PER_CPU-init_tss
#=20
# arch/i386/kernel/init_task.c
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +2 -5
#   PER_CPU-init_tss
#=20
# arch/i386/kernel/cpu/common.c
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +1 -1
#   PER_CPU-init_tss
#=20
diff -Nru a/arch/i386/kernel/cpu/common.c =
b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	2004-07-09 01:34:21 -07:00
+++ b/arch/i386/kernel/cpu/common.c	2004-07-09 01:34:21 -07:00
@@ -504,7 +504,7 @@
 void __init cpu_init (void)
 {
 	int cpu =3D smp_processor_id();
-	struct tss_struct * t =3D init_tss + cpu;
+	struct tss_struct * t =3D &per_cpu(init_tss, cpu);
 	struct thread_struct *thread =3D &current->thread;
=20
 	if (test_and_set_bit(cpu, &cpu_initialized)) {
diff -Nru a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c
--- a/arch/i386/kernel/init_task.c	2004-07-09 01:34:21 -07:00
+++ b/arch/i386/kernel/init_task.c	2004-07-09 01:34:21 -07:00
@@ -40,10 +40,7 @@
=20
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
- * no more per-task TSS's. The TSS size is kept cacheline-aligned
- * so they are allowed to end up in the .data.cacheline_aligned
- * section. Since TSS's are completely CPU-local, we want them
- * on exact cacheline boundaries, to eliminate cacheline ping-pong.
+ * no more per-task TSS's.
  */=20
-struct tss_struct init_tss[NR_CPUS] __cacheline_aligned =3D { [0 ... =
NR_CPUS-1] =3D INIT_TSS };
+DEFINE_PER_CPU(struct tss_struct, init_tss) =
____cacheline_maxaligned_in_smp =3D INIT_TSS;
=20
diff -Nru a/arch/i386/kernel/ioport.c b/arch/i386/kernel/ioport.c
--- a/arch/i386/kernel/ioport.c	2004-07-09 01:34:21 -07:00
+++ b/arch/i386/kernel/ioport.c	2004-07-09 01:34:21 -07:00
@@ -83,7 +83,7 @@
 	 * do it in the per-thread copy and in the TSS ...
 	 */
 	set_bitmap(t->io_bitmap_ptr, from, num, !turn_on);
-	tss =3D init_tss + get_cpu();
+	tss =3D &per_cpu(init_tss, get_cpu());
 	if (tss->io_bitmap_base =3D=3D IO_BITMAP_OFFSET) { /* already active? =
*/
 		set_bitmap(tss->io_bitmap, from, num, !turn_on);
 	} else {
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	2004-07-09 01:34:21 -07:00
+++ b/arch/i386/kernel/process.c	2004-07-09 01:34:21 -07:00
@@ -298,7 +298,7 @@
 	/* The process may have allocated an io port bitmap... nuke it. */
 	if (unlikely(NULL !=3D tsk->thread.io_bitmap_ptr)) {
 		int cpu =3D get_cpu();
-		struct tss_struct *tss =3D init_tss + cpu;
+		struct tss_struct *tss =3D &per_cpu(init_tss, cpu);
 		kfree(tsk->thread.io_bitmap_ptr);
 		tsk->thread.io_bitmap_ptr =3D NULL;
 		tss->io_bitmap_base =3D INVALID_IO_BITMAP_OFFSET;
@@ -507,7 +507,7 @@
 	struct thread_struct *prev =3D &prev_p->thread,
 				 *next =3D &next_p->thread;
 	int cpu =3D smp_processor_id();
-	struct tss_struct *tss =3D init_tss + cpu;
+	struct tss_struct *tss =3D &per_cpu(init_tss, cpu);
=20
 	/* never put a printk in __switch_to... printk() calls wake_up*() =
indirectly */
=20
diff -Nru a/arch/i386/kernel/sysenter.c b/arch/i386/kernel/sysenter.c
--- a/arch/i386/kernel/sysenter.c	2004-07-09 01:34:21 -07:00
+++ b/arch/i386/kernel/sysenter.c	2004-07-09 01:34:21 -07:00
@@ -24,7 +24,7 @@
 void enable_sep_cpu(void *info)
 {
 	int cpu =3D get_cpu();
-	struct tss_struct *tss =3D init_tss + cpu;
+	struct tss_struct *tss =3D &per_cpu(init_tss, cpu);
=20
 	tss->ss1 =3D __KERNEL_CS;
 	tss->esp1 =3D sizeof(struct tss_struct) + (unsigned long) tss;
diff -Nru a/arch/i386/kernel/vm86.c b/arch/i386/kernel/vm86.c
--- a/arch/i386/kernel/vm86.c	2004-07-09 01:34:21 -07:00
+++ b/arch/i386/kernel/vm86.c	2004-07-09 01:34:21 -07:00
@@ -121,7 +121,7 @@
 		do_exit(SIGSEGV);
 	}
=20
-	tss =3D init_tss + get_cpu();
+	tss =3D &per_cpu(init_tss, get_cpu());
 	current->thread.esp0 =3D current->thread.saved_esp0;
 	current->thread.sysenter_cs =3D __KERNEL_CS;
 	load_esp0(tss, &current->thread);
@@ -303,7 +303,7 @@
 	asm volatile("movl %%fs,%0":"=3Dm" (tsk->thread.saved_fs));
 	asm volatile("movl %%gs,%0":"=3Dm" (tsk->thread.saved_gs));
=20
-	tss =3D init_tss + get_cpu();
+	tss =3D &per_cpu(init_tss, get_cpu());
 	tsk->thread.esp0 =3D (unsigned long) &info->VM86_TSS_ESP0;
 	if (cpu_has_sep)
 		tsk->thread.sysenter_cs =3D 0;
diff -Nru a/arch/i386/power/cpu.c b/arch/i386/power/cpu.c
--- a/arch/i386/power/cpu.c	2004-07-09 01:34:21 -07:00
+++ b/arch/i386/power/cpu.c	2004-07-09 01:34:21 -07:00
@@ -83,7 +83,7 @@
 static void fix_processor_context(void)
 {
 	int cpu =3D smp_processor_id();
-	struct tss_struct * t =3D init_tss + cpu;
+	struct tss_struct * t =3D &per_cpu(init_tss, cpu);
=20
 	set_tss_desc(cpu,t);	/* This just modifies memory; should not be =
necessary. But... This is necessary, because 386
hardware has concept of busy TSS or some similar stupidity. */
         per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TSS].b &=3D 0xfffffdff;
diff -Nru a/include/asm-i386/processor.h b/include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	2004-07-09 01:34:21 -07:00
+++ b/include/asm-i386/processor.h	2004-07-09 01:34:21 -07:00
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
+#include <asm/percpu.h>
=20
 /* flag for disabling the tsc */
 extern int tsc_disable;
@@ -84,8 +85,8 @@
=20
 extern struct cpuinfo_x86 boot_cpu_data;
 extern struct cpuinfo_x86 new_cpu_data;
-extern struct tss_struct init_tss[NR_CPUS];
 extern struct tss_struct doublefault_tss;
+DECLARE_PER_CPU(struct tss_struct, init_tss);
=20
 #ifdef CONFIG_SMP
 extern struct cpuinfo_x86 cpu_data[];
@@ -439,7 +440,6 @@
 #define INIT_TSS  {							\
 	.esp0		=3D sizeof(init_stack) + (long)&init_stack,	\
 	.ss0		=3D __KERNEL_DS,					\
-	.esp1		=3D sizeof(init_tss[0]) + (long)&init_tss[0],	\
 	.ss1		=3D __KERNEL_CS,					\
 	.ldt		=3D GDT_ENTRY_LDT,				\
 	.io_bitmap_base	=3D INVALID_IO_BITMAP_OFFSET,			\
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

=A0
-----------------
Shai Fultheim
Scalex86.org



------=_NextPart_000_0046_01C4655F.FA629640
Content-Type: application/octet-stream;
	name="rev-1.1820.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rev-1.1820.patch"

# This is a BitKeeper generated diff -Nru style patch.=0A=
#=0A=
# ChangeSet=0A=
#   2004/07/09 00:43:12-07:00 shai@compile.(none) =0A=
#   Many files:=0A=
#     PER_CPU-init_tss=0A=
#   Convert init_tss into a per_cpu variable. The only tricky bit is=0A=
#   that the esp1 initaliztion is not needed since Linux never uses=0A=
#   ring1.  esp1 is initalized at 'enable_sep_cpu' for=0A=
#   sysenter/sysexit.=0A=
#     =0A=
#   Signed-off-by: Martin Hicks <mort@wildopensource.com>=0A=
#   Signed-off-by: Shai Fultheim <shai@scalex86.org>=0A=
# =0A=
# include/asm-i386/processor.h=0A=
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +2 -2=0A=
#   PER_CPU-init_tss=0A=
# =0A=
# arch/i386/power/cpu.c=0A=
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +1 -1=0A=
#   PER_CPU-init_tss=0A=
# =0A=
# arch/i386/kernel/vm86.c=0A=
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +2 -2=0A=
#   PER_CPU-init_tss=0A=
# =0A=
# arch/i386/kernel/sysenter.c=0A=
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +1 -1=0A=
#   PER_CPU-init_tss=0A=
# =0A=
# arch/i386/kernel/process.c=0A=
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +2 -2=0A=
#   PER_CPU-init_tss=0A=
# =0A=
# arch/i386/kernel/ioport.c=0A=
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +1 -1=0A=
#   PER_CPU-init_tss=0A=
# =0A=
# arch/i386/kernel/init_task.c=0A=
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +2 -5=0A=
#   PER_CPU-init_tss=0A=
# =0A=
# arch/i386/kernel/cpu/common.c=0A=
#   2004/07/09 00:41:50-07:00 shai@compile.(none) +1 -1=0A=
#   PER_CPU-init_tss=0A=
# =0A=
diff -Nru a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c=0A=
--- a/arch/i386/kernel/cpu/common.c	2004-07-09 01:34:21 -07:00=0A=
+++ b/arch/i386/kernel/cpu/common.c	2004-07-09 01:34:21 -07:00=0A=
@@ -504,7 +504,7 @@=0A=
 void __init cpu_init (void)=0A=
 {=0A=
 	int cpu =3D smp_processor_id();=0A=
-	struct tss_struct * t =3D init_tss + cpu;=0A=
+	struct tss_struct * t =3D &per_cpu(init_tss, cpu);=0A=
 	struct thread_struct *thread =3D &current->thread;=0A=
 =0A=
 	if (test_and_set_bit(cpu, &cpu_initialized)) {=0A=
diff -Nru a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c=0A=
--- a/arch/i386/kernel/init_task.c	2004-07-09 01:34:21 -07:00=0A=
+++ b/arch/i386/kernel/init_task.c	2004-07-09 01:34:21 -07:00=0A=
@@ -40,10 +40,7 @@=0A=
 =0A=
 /*=0A=
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,=0A=
- * no more per-task TSS's. The TSS size is kept cacheline-aligned=0A=
- * so they are allowed to end up in the .data.cacheline_aligned=0A=
- * section. Since TSS's are completely CPU-local, we want them=0A=
- * on exact cacheline boundaries, to eliminate cacheline ping-pong.=0A=
+ * no more per-task TSS's.=0A=
  */ =0A=
-struct tss_struct init_tss[NR_CPUS] __cacheline_aligned =3D { [0 ... =
NR_CPUS-1] =3D INIT_TSS };=0A=
+DEFINE_PER_CPU(struct tss_struct, init_tss) =
____cacheline_maxaligned_in_smp =3D INIT_TSS;=0A=
 =0A=
diff -Nru a/arch/i386/kernel/ioport.c b/arch/i386/kernel/ioport.c=0A=
--- a/arch/i386/kernel/ioport.c	2004-07-09 01:34:21 -07:00=0A=
+++ b/arch/i386/kernel/ioport.c	2004-07-09 01:34:21 -07:00=0A=
@@ -83,7 +83,7 @@=0A=
 	 * do it in the per-thread copy and in the TSS ...=0A=
 	 */=0A=
 	set_bitmap(t->io_bitmap_ptr, from, num, !turn_on);=0A=
-	tss =3D init_tss + get_cpu();=0A=
+	tss =3D &per_cpu(init_tss, get_cpu());=0A=
 	if (tss->io_bitmap_base =3D=3D IO_BITMAP_OFFSET) { /* already active? =
*/=0A=
 		set_bitmap(tss->io_bitmap, from, num, !turn_on);=0A=
 	} else {=0A=
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c=0A=
--- a/arch/i386/kernel/process.c	2004-07-09 01:34:21 -07:00=0A=
+++ b/arch/i386/kernel/process.c	2004-07-09 01:34:21 -07:00=0A=
@@ -298,7 +298,7 @@=0A=
 	/* The process may have allocated an io port bitmap... nuke it. */=0A=
 	if (unlikely(NULL !=3D tsk->thread.io_bitmap_ptr)) {=0A=
 		int cpu =3D get_cpu();=0A=
-		struct tss_struct *tss =3D init_tss + cpu;=0A=
+		struct tss_struct *tss =3D &per_cpu(init_tss, cpu);=0A=
 		kfree(tsk->thread.io_bitmap_ptr);=0A=
 		tsk->thread.io_bitmap_ptr =3D NULL;=0A=
 		tss->io_bitmap_base =3D INVALID_IO_BITMAP_OFFSET;=0A=
@@ -507,7 +507,7 @@=0A=
 	struct thread_struct *prev =3D &prev_p->thread,=0A=
 				 *next =3D &next_p->thread;=0A=
 	int cpu =3D smp_processor_id();=0A=
-	struct tss_struct *tss =3D init_tss + cpu;=0A=
+	struct tss_struct *tss =3D &per_cpu(init_tss, cpu);=0A=
 =0A=
 	/* never put a printk in __switch_to... printk() calls wake_up*() =
indirectly */=0A=
 =0A=
diff -Nru a/arch/i386/kernel/sysenter.c b/arch/i386/kernel/sysenter.c=0A=
--- a/arch/i386/kernel/sysenter.c	2004-07-09 01:34:21 -07:00=0A=
+++ b/arch/i386/kernel/sysenter.c	2004-07-09 01:34:21 -07:00=0A=
@@ -24,7 +24,7 @@=0A=
 void enable_sep_cpu(void *info)=0A=
 {=0A=
 	int cpu =3D get_cpu();=0A=
-	struct tss_struct *tss =3D init_tss + cpu;=0A=
+	struct tss_struct *tss =3D &per_cpu(init_tss, cpu);=0A=
 =0A=
 	tss->ss1 =3D __KERNEL_CS;=0A=
 	tss->esp1 =3D sizeof(struct tss_struct) + (unsigned long) tss;=0A=
diff -Nru a/arch/i386/kernel/vm86.c b/arch/i386/kernel/vm86.c=0A=
--- a/arch/i386/kernel/vm86.c	2004-07-09 01:34:21 -07:00=0A=
+++ b/arch/i386/kernel/vm86.c	2004-07-09 01:34:21 -07:00=0A=
@@ -121,7 +121,7 @@=0A=
 		do_exit(SIGSEGV);=0A=
 	}=0A=
 =0A=
-	tss =3D init_tss + get_cpu();=0A=
+	tss =3D &per_cpu(init_tss, get_cpu());=0A=
 	current->thread.esp0 =3D current->thread.saved_esp0;=0A=
 	current->thread.sysenter_cs =3D __KERNEL_CS;=0A=
 	load_esp0(tss, &current->thread);=0A=
@@ -303,7 +303,7 @@=0A=
 	asm volatile("movl %%fs,%0":"=3Dm" (tsk->thread.saved_fs));=0A=
 	asm volatile("movl %%gs,%0":"=3Dm" (tsk->thread.saved_gs));=0A=
 =0A=
-	tss =3D init_tss + get_cpu();=0A=
+	tss =3D &per_cpu(init_tss, get_cpu());=0A=
 	tsk->thread.esp0 =3D (unsigned long) &info->VM86_TSS_ESP0;=0A=
 	if (cpu_has_sep)=0A=
 		tsk->thread.sysenter_cs =3D 0;=0A=
diff -Nru a/arch/i386/power/cpu.c b/arch/i386/power/cpu.c=0A=
--- a/arch/i386/power/cpu.c	2004-07-09 01:34:21 -07:00=0A=
+++ b/arch/i386/power/cpu.c	2004-07-09 01:34:21 -07:00=0A=
@@ -83,7 +83,7 @@=0A=
 static void fix_processor_context(void)=0A=
 {=0A=
 	int cpu =3D smp_processor_id();=0A=
-	struct tss_struct * t =3D init_tss + cpu;=0A=
+	struct tss_struct * t =3D &per_cpu(init_tss, cpu);=0A=
 =0A=
 	set_tss_desc(cpu,t);	/* This just modifies memory; should not be =
necessary. But... This is necessary, because 386 hardware has concept of =
busy TSS or some similar stupidity. */=0A=
         per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TSS].b &=3D 0xfffffdff;=0A=
diff -Nru a/include/asm-i386/processor.h b/include/asm-i386/processor.h=0A=
--- a/include/asm-i386/processor.h	2004-07-09 01:34:21 -07:00=0A=
+++ b/include/asm-i386/processor.h	2004-07-09 01:34:21 -07:00=0A=
@@ -19,6 +19,7 @@=0A=
 #include <linux/cache.h>=0A=
 #include <linux/config.h>=0A=
 #include <linux/threads.h>=0A=
+#include <asm/percpu.h>=0A=
 =0A=
 /* flag for disabling the tsc */=0A=
 extern int tsc_disable;=0A=
@@ -84,8 +85,8 @@=0A=
 =0A=
 extern struct cpuinfo_x86 boot_cpu_data;=0A=
 extern struct cpuinfo_x86 new_cpu_data;=0A=
-extern struct tss_struct init_tss[NR_CPUS];=0A=
 extern struct tss_struct doublefault_tss;=0A=
+DECLARE_PER_CPU(struct tss_struct, init_tss);=0A=
 =0A=
 #ifdef CONFIG_SMP=0A=
 extern struct cpuinfo_x86 cpu_data[];=0A=
@@ -439,7 +440,6 @@=0A=
 #define INIT_TSS  {							\=0A=
 	.esp0		=3D sizeof(init_stack) + (long)&init_stack,	\=0A=
 	.ss0		=3D __KERNEL_DS,					\=0A=
-	.esp1		=3D sizeof(init_tss[0]) + (long)&init_tss[0],	\=0A=
 	.ss1		=3D __KERNEL_CS,					\=0A=
 	.ldt		=3D GDT_ENTRY_LDT,				\=0A=
 	.io_bitmap_base	=3D INVALID_IO_BITMAP_OFFSET,			\=0A=

------=_NextPart_000_0046_01C4655F.FA629640--

