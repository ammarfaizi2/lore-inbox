Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUGIJ4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUGIJ4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUGIJ4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:56:39 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:5599 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S264791AbUGIJyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:54:10 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Jes Sorensen'" <jes@trained-monkey.org>, <mort@wildopensource.com>
Subject: [PATCH] PER_CPU [3/4] - PER_CPU-cpu_tlbstate
Date: Fri, 9 Jul 2004 02:54:05 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0049_01C46560.00D96710"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRlmquNDfWvTLwBRUe4CcgGbp5mfw==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S264791AbUGIJyK/20040709095410Z+25@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0049_01C46560.00D96710
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

PER_CPU-cpu_tlbstate:
 arch/i386/kernel/smp.c               |   12 ++++++------
 arch/i386/mach-voyager/voyager_smp.c |   12 ++++++------
 include/asm-i386/mmu_context.h       |   12 ++++++------
 include/asm-i386/tlbflush.h          |    2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

Signed-off-by: Martin Hicks <mort@wildopensource.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/09 01:15:31-07:00 shai@compile.(none)=20
#   tlbflush.h, mmu_context.h, voyager_smp.c, smp.c:
#     PER_CPU-cpu_tlbstate
#   Convert cpu_tlbstate into a per_cpu variable.
#    =20
#   Signed-off-by: Martin Hicks <mort@wildopensource.com>
#   Signed-off-by: Shai Fultheim <shai@scalex86.org>
#=20
# include/asm-i386/tlbflush.h
#   2004/07/09 01:14:52-07:00 shai@compile.(none) +1 -1
#   PER_CPU-cpu_tlbstate
#=20
# include/asm-i386/mmu_context.h
#   2004/07/09 01:14:52-07:00 shai@compile.(none) +6 -6
#   PER_CPU-cpu_tlbstate
#=20
# arch/i386/mach-voyager/voyager_smp.c
#   2004/07/09 01:14:52-07:00 shai@compile.(none) +6 -6
#   PER_CPU-cpu_tlbstate
#=20
# arch/i386/kernel/smp.c
#   2004/07/09 01:14:52-07:00 shai@compile.(none) +6 -6
#   PER_CPU-cpu_tlbstate
#=20
diff -Nru a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c	2004-07-09 01:34:17 -07:00
+++ b/arch/i386/kernel/smp.c	2004-07-09 01:34:17 -07:00
@@ -104,7 +104,7 @@
  *	about nothing of note with C stepping upwards.
  */
=20
-struct tlb_state cpu_tlbstate[NR_CPUS] __cacheline_aligned =3D {[0 ... =
NR_CPUS-1] =3D { &init_mm, 0, }};
+DEFINE_PER_CPU(struct tlb_state, cpu_tlbstate) ____cacheline_aligned =
=3D { &init_mm, 0, };
=20
 /*
  * the following functions deal with sending IPIs between CPUs.
@@ -255,9 +255,9 @@
  */
 static inline void leave_mm (unsigned long cpu)
 {
-	if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK)
+	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK)
 		BUG();
-	cpu_clear(cpu, cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
+	cpu_clear(cpu, per_cpu(cpu_tlbstate, cpu).active_mm->cpu_vm_mask);
 	load_cr3(swapper_pg_dir);
 }
=20
@@ -324,8 +324,8 @@
 		 * BUG();
 		 */
 		=20
-	if (flush_mm =3D=3D cpu_tlbstate[cpu].active_mm) {
-		if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK) {
+	if (flush_mm =3D=3D per_cpu(cpu_tlbstate, cpu).active_mm) {
+		if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK) {
 			if (flush_va =3D=3D FLUSH_ALL)
 				local_flush_tlb();
 			else
@@ -457,7 +457,7 @@
 	unsigned long cpu =3D smp_processor_id();
=20
 	__flush_tlb_all();
-	if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_LAZY)
+	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_LAZY)
 		leave_mm(cpu);
 }
=20
diff -Nru a/arch/i386/mach-voyager/voyager_smp.c =
b/arch/i386/mach-voyager/voyager_smp.c
--- a/arch/i386/mach-voyager/voyager_smp.c	2004-07-09 01:34:17 -07:00
+++ b/arch/i386/mach-voyager/voyager_smp.c	2004-07-09 01:34:17 -07:00
@@ -35,7 +35,7 @@
 int reboot_smp =3D 0;
=20
 /* TLB state -- visible externally, indexed physically */
-struct tlb_state cpu_tlbstate[NR_CPUS] __cacheline_aligned =3D {[0 ... =
NR_CPUS-1] =3D { &init_mm, 0 }};
+DEFINE_PER_CPU(struct tlb_state, cpu_tlbstate) ____cacheline_aligned =
=3D { &init_mm, 0 };
=20
 /* CPU IRQ affinity -- set to all ones initially */
 static unsigned long cpu_irq_affinity[NR_CPUS] __cacheline_aligned =3D =
{ [0 ... NR_CPUS-1]  =3D ~0UL };
@@ -860,9 +860,9 @@
 static inline void
 leave_mm (unsigned long cpu)
 {
-	if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK)
+	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK)
 		BUG();
-	cpu_clear(cpu,  cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
+	cpu_clear(cpu, per_cpu(cpu_tlbstate, cpu).active_mm->cpu_vm_mask);
 	load_cr3(swapper_pg_dir);
 }
=20
@@ -883,8 +883,8 @@
 		smp_processor_id()));
 	*/
=20
-	if (flush_mm =3D=3D cpu_tlbstate[cpu].active_mm) {
-		if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK) {
+	if (flush_mm =3D=3D per_cpu(cpu_tlbstate, cpu).active_mm) {
+		if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK) {
 			if (flush_va =3D=3D FLUSH_ALL)
 				local_flush_tlb();
 			else
@@ -1218,7 +1218,7 @@
 	unsigned long cpu =3D smp_processor_id();
=20
 	__flush_tlb_all();
-	if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_LAZY)
+	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_LAZY)
 		leave_mm(cpu);
 }
=20
diff -Nru a/include/asm-i386/mmu_context.h =
b/include/asm-i386/mmu_context.h
--- a/include/asm-i386/mmu_context.h	2004-07-09 01:34:17 -07:00
+++ b/include/asm-i386/mmu_context.h	2004-07-09 01:34:17 -07:00
@@ -18,8 +18,8 @@
 {
 #ifdef CONFIG_SMP
 	unsigned cpu =3D smp_processor_id();
-	if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK)
-		cpu_tlbstate[cpu].state =3D TLBSTATE_LAZY;=09
+	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK)
+		per_cpu(cpu_tlbstate, cpu).state =3D TLBSTATE_LAZY;=09
 #endif
 }
=20
@@ -33,8 +33,8 @@
 		/* stop flush ipis for the previous mm */
 		cpu_clear(cpu, prev->cpu_vm_mask);
 #ifdef CONFIG_SMP
-		cpu_tlbstate[cpu].state =3D TLBSTATE_OK;
-		cpu_tlbstate[cpu].active_mm =3D next;
+		per_cpu(cpu_tlbstate, cpu).state =3D TLBSTATE_OK;
+		per_cpu(cpu_tlbstate, cpu).active_mm =3D next;
 #endif
 		cpu_set(cpu, next->cpu_vm_mask);
=20
@@ -49,8 +49,8 @@
 	}
 #ifdef CONFIG_SMP
 	else {
-		cpu_tlbstate[cpu].state =3D TLBSTATE_OK;
-		BUG_ON(cpu_tlbstate[cpu].active_mm !=3D next);
+		per_cpu(cpu_tlbstate, cpu).state =3D TLBSTATE_OK;
+		BUG_ON(per_cpu(cpu_tlbstate, cpu).active_mm !=3D next);
=20
 		if (!cpu_test_and_set(cpu, next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled=20
diff -Nru a/include/asm-i386/tlbflush.h b/include/asm-i386/tlbflush.h
--- a/include/asm-i386/tlbflush.h	2004-07-09 01:34:17 -07:00
+++ b/include/asm-i386/tlbflush.h	2004-07-09 01:34:17 -07:00
@@ -131,7 +131,7 @@
 	int state;
 	char __cacheline_padding[L1_CACHE_BYTES-8];
 };
-extern struct tlb_state cpu_tlbstate[NR_CPUS];
+DECLARE_PER_CPU(struct tlb_state, cpu_tlbstate);
=20
=20
 #endif
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=A0
-----------------
Shai Fultheim
Scalex86.org



------=_NextPart_000_0049_01C46560.00D96710
Content-Type: application/octet-stream;
	name="rev-1.1821.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rev-1.1821.patch"

# This is a BitKeeper generated diff -Nru style patch.=0A=
#=0A=
# ChangeSet=0A=
#   2004/07/09 01:15:31-07:00 shai@compile.(none) =0A=
#   tlbflush.h, mmu_context.h, voyager_smp.c, smp.c:=0A=
#     PER_CPU-cpu_tlbstate=0A=
#   Convert cpu_tlbstate into a per_cpu variable.=0A=
#     =0A=
#   Signed-off-by: Martin Hicks <mort@wildopensource.com>=0A=
#   Signed-off-by: Shai Fultheim <shai@scalex86.org>=0A=
# =0A=
# include/asm-i386/tlbflush.h=0A=
#   2004/07/09 01:14:52-07:00 shai@compile.(none) +1 -1=0A=
#   PER_CPU-cpu_tlbstate=0A=
# =0A=
# include/asm-i386/mmu_context.h=0A=
#   2004/07/09 01:14:52-07:00 shai@compile.(none) +6 -6=0A=
#   PER_CPU-cpu_tlbstate=0A=
# =0A=
# arch/i386/mach-voyager/voyager_smp.c=0A=
#   2004/07/09 01:14:52-07:00 shai@compile.(none) +6 -6=0A=
#   PER_CPU-cpu_tlbstate=0A=
# =0A=
# arch/i386/kernel/smp.c=0A=
#   2004/07/09 01:14:52-07:00 shai@compile.(none) +6 -6=0A=
#   PER_CPU-cpu_tlbstate=0A=
# =0A=
diff -Nru a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c=0A=
--- a/arch/i386/kernel/smp.c	2004-07-09 01:34:17 -07:00=0A=
+++ b/arch/i386/kernel/smp.c	2004-07-09 01:34:17 -07:00=0A=
@@ -104,7 +104,7 @@=0A=
  *	about nothing of note with C stepping upwards.=0A=
  */=0A=
 =0A=
-struct tlb_state cpu_tlbstate[NR_CPUS] __cacheline_aligned =3D {[0 ... =
NR_CPUS-1] =3D { &init_mm, 0, }};=0A=
+DEFINE_PER_CPU(struct tlb_state, cpu_tlbstate) ____cacheline_aligned =
=3D { &init_mm, 0, };=0A=
 =0A=
 /*=0A=
  * the following functions deal with sending IPIs between CPUs.=0A=
@@ -255,9 +255,9 @@=0A=
  */=0A=
 static inline void leave_mm (unsigned long cpu)=0A=
 {=0A=
-	if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK)=0A=
+	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK)=0A=
 		BUG();=0A=
-	cpu_clear(cpu, cpu_tlbstate[cpu].active_mm->cpu_vm_mask);=0A=
+	cpu_clear(cpu, per_cpu(cpu_tlbstate, cpu).active_mm->cpu_vm_mask);=0A=
 	load_cr3(swapper_pg_dir);=0A=
 }=0A=
 =0A=
@@ -324,8 +324,8 @@=0A=
 		 * BUG();=0A=
 		 */=0A=
 		 =0A=
-	if (flush_mm =3D=3D cpu_tlbstate[cpu].active_mm) {=0A=
-		if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK) {=0A=
+	if (flush_mm =3D=3D per_cpu(cpu_tlbstate, cpu).active_mm) {=0A=
+		if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK) {=0A=
 			if (flush_va =3D=3D FLUSH_ALL)=0A=
 				local_flush_tlb();=0A=
 			else=0A=
@@ -457,7 +457,7 @@=0A=
 	unsigned long cpu =3D smp_processor_id();=0A=
 =0A=
 	__flush_tlb_all();=0A=
-	if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_LAZY)=0A=
+	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_LAZY)=0A=
 		leave_mm(cpu);=0A=
 }=0A=
 =0A=
diff -Nru a/arch/i386/mach-voyager/voyager_smp.c =
b/arch/i386/mach-voyager/voyager_smp.c=0A=
--- a/arch/i386/mach-voyager/voyager_smp.c	2004-07-09 01:34:17 -07:00=0A=
+++ b/arch/i386/mach-voyager/voyager_smp.c	2004-07-09 01:34:17 -07:00=0A=
@@ -35,7 +35,7 @@=0A=
 int reboot_smp =3D 0;=0A=
 =0A=
 /* TLB state -- visible externally, indexed physically */=0A=
-struct tlb_state cpu_tlbstate[NR_CPUS] __cacheline_aligned =3D {[0 ... =
NR_CPUS-1] =3D { &init_mm, 0 }};=0A=
+DEFINE_PER_CPU(struct tlb_state, cpu_tlbstate) ____cacheline_aligned =
=3D { &init_mm, 0 };=0A=
 =0A=
 /* CPU IRQ affinity -- set to all ones initially */=0A=
 static unsigned long cpu_irq_affinity[NR_CPUS] __cacheline_aligned =3D =
{ [0 ... NR_CPUS-1]  =3D ~0UL };=0A=
@@ -860,9 +860,9 @@=0A=
 static inline void=0A=
 leave_mm (unsigned long cpu)=0A=
 {=0A=
-	if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK)=0A=
+	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK)=0A=
 		BUG();=0A=
-	cpu_clear(cpu,  cpu_tlbstate[cpu].active_mm->cpu_vm_mask);=0A=
+	cpu_clear(cpu, per_cpu(cpu_tlbstate, cpu).active_mm->cpu_vm_mask);=0A=
 	load_cr3(swapper_pg_dir);=0A=
 }=0A=
 =0A=
@@ -883,8 +883,8 @@=0A=
 		smp_processor_id()));=0A=
 	*/=0A=
 =0A=
-	if (flush_mm =3D=3D cpu_tlbstate[cpu].active_mm) {=0A=
-		if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK) {=0A=
+	if (flush_mm =3D=3D per_cpu(cpu_tlbstate, cpu).active_mm) {=0A=
+		if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK) {=0A=
 			if (flush_va =3D=3D FLUSH_ALL)=0A=
 				local_flush_tlb();=0A=
 			else=0A=
@@ -1218,7 +1218,7 @@=0A=
 	unsigned long cpu =3D smp_processor_id();=0A=
 =0A=
 	__flush_tlb_all();=0A=
-	if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_LAZY)=0A=
+	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_LAZY)=0A=
 		leave_mm(cpu);=0A=
 }=0A=
 =0A=
diff -Nru a/include/asm-i386/mmu_context.h =
b/include/asm-i386/mmu_context.h=0A=
--- a/include/asm-i386/mmu_context.h	2004-07-09 01:34:17 -07:00=0A=
+++ b/include/asm-i386/mmu_context.h	2004-07-09 01:34:17 -07:00=0A=
@@ -18,8 +18,8 @@=0A=
 {=0A=
 #ifdef CONFIG_SMP=0A=
 	unsigned cpu =3D smp_processor_id();=0A=
-	if (cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK)=0A=
-		cpu_tlbstate[cpu].state =3D TLBSTATE_LAZY;	=0A=
+	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK)=0A=
+		per_cpu(cpu_tlbstate, cpu).state =3D TLBSTATE_LAZY;	=0A=
 #endif=0A=
 }=0A=
 =0A=
@@ -33,8 +33,8 @@=0A=
 		/* stop flush ipis for the previous mm */=0A=
 		cpu_clear(cpu, prev->cpu_vm_mask);=0A=
 #ifdef CONFIG_SMP=0A=
-		cpu_tlbstate[cpu].state =3D TLBSTATE_OK;=0A=
-		cpu_tlbstate[cpu].active_mm =3D next;=0A=
+		per_cpu(cpu_tlbstate, cpu).state =3D TLBSTATE_OK;=0A=
+		per_cpu(cpu_tlbstate, cpu).active_mm =3D next;=0A=
 #endif=0A=
 		cpu_set(cpu, next->cpu_vm_mask);=0A=
 =0A=
@@ -49,8 +49,8 @@=0A=
 	}=0A=
 #ifdef CONFIG_SMP=0A=
 	else {=0A=
-		cpu_tlbstate[cpu].state =3D TLBSTATE_OK;=0A=
-		BUG_ON(cpu_tlbstate[cpu].active_mm !=3D next);=0A=
+		per_cpu(cpu_tlbstate, cpu).state =3D TLBSTATE_OK;=0A=
+		BUG_ON(per_cpu(cpu_tlbstate, cpu).active_mm !=3D next);=0A=
 =0A=
 		if (!cpu_test_and_set(cpu, next->cpu_vm_mask)) {=0A=
 			/* We were in lazy tlb mode and leave_mm disabled =0A=
diff -Nru a/include/asm-i386/tlbflush.h b/include/asm-i386/tlbflush.h=0A=
--- a/include/asm-i386/tlbflush.h	2004-07-09 01:34:17 -07:00=0A=
+++ b/include/asm-i386/tlbflush.h	2004-07-09 01:34:17 -07:00=0A=
@@ -131,7 +131,7 @@=0A=
 	int state;=0A=
 	char __cacheline_padding[L1_CACHE_BYTES-8];=0A=
 };=0A=
-extern struct tlb_state cpu_tlbstate[NR_CPUS];=0A=
+DECLARE_PER_CPU(struct tlb_state, cpu_tlbstate);=0A=
 =0A=
 =0A=
 #endif=0A=

------=_NextPart_000_0049_01C46560.00D96710--

