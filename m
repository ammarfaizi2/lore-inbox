Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316179AbSEKAnZ>; Fri, 10 May 2002 20:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316180AbSEKAnY>; Fri, 10 May 2002 20:43:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50173 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316179AbSEKAnW>;
	Fri, 10 May 2002 20:43:22 -0400
Message-ID: <3CDC6906.B0288387@mvista.com>
Date: Fri, 10 May 2002 17:42:46 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2
In-Reply-To: <Pine.LNX.4.33.0205101538400.25826-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 10 May 2002, george anzinger wrote:
> >
> > If that were only true.  The problem is that some architectures can be
> > built with either endian.  Mips, for example, seems to take the endian
> > stuff in as an environment variable.  The linker seems to know this
> > stuff, but does not provide the "built in" to allow it to be used.
> 
> Ignore those for now, and let the architecture maintainer sort it out.
> >From what I can tell, those architectures do things like generate the
> linker script dynamically anyway, so..
> 
>                 Linus
Ok, here it is.  The following arch are not covered:
Mips, Mips64 in 32-bit mode, parisc in __LP64__ mode.

In addition, x86_64 mentions jiffies in the existing script.  
This may be a problem.


diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/alpha/vmlinux.lds.in linux/arch/alpha/vmlinux.lds.in
--- linux-2.5.14-org/arch/alpha/vmlinux.lds.in	Tue May  7 16:08:34 2002
+++ linux/arch/alpha/vmlinux.lds.in	Fri May 10 16:56:03 2002
@@ -3,6 +3,7 @@
 OUTPUT_FORMAT("elf64-alpha")
 ENTRY(__start)
 PHDRS { kernel PT_LOAD ; }
+jiffies = jiffies_64;
 SECTIONS
 {
 #ifdef CONFIG_ALPHA_LEGACY_START_ADDRESS
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/arm/vmlinux-armo.lds.in linux/arch/arm/vmlinux-armo.lds.in
--- linux-2.5.14-org/arch/arm/vmlinux-armo.lds.in	Tue May  7 15:59:35 2002
+++ linux/arch/arm/vmlinux-armo.lds.in	Fri May 10 17:07:31 2002
@@ -4,6 +4,7 @@
  */
 OUTPUT_ARCH(arm)
 ENTRY(stext)
+jiffies = jiffies_64 + 4;
 SECTIONS
 {
 	. = TEXTADDR;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/arm/vmlinux-armv.lds.in linux/arch/arm/vmlinux-armv.lds.in
--- linux-2.5.14-org/arch/arm/vmlinux-armv.lds.in	Tue May  7 15:59:35 2002
+++ linux/arch/arm/vmlinux-armv.lds.in	Fri May 10 17:07:34 2002
@@ -4,6 +4,7 @@
  */
 OUTPUT_ARCH(arm)
 ENTRY(stext)
+jiffies = jiffies_64 + 4;
 SECTIONS
 {
 	. = TEXTADDR;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/cris/cris.ld linux/arch/cris/cris.ld
--- linux-2.5.14-org/arch/cris/cris.ld	Tue May  7 16:06:14 2002
+++ linux/arch/cris/cris.ld	Fri May 10 17:08:39 2002
@@ -8,6 +8,7 @@
  * the kernel has booted. 
  */	
 
+jiffies = jiffies_64;
 SECTIONS
 {
 	. = @CONFIG_ETRAX_DRAM_VIRTUAL_BASE@;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/i386/vmlinux.lds linux/arch/i386/vmlinux.lds
--- linux-2.5.14-org/arch/i386/vmlinux.lds	Tue May  7 16:13:12 2002
+++ linux/arch/i386/vmlinux.lds	Fri May 10 16:53:50 2002
@@ -4,6 +4,7 @@
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(_start)
+jiffies = jiffies_64;
 SECTIONS
 {
   . = 0xC0000000 + 0x100000;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/ia64/vmlinux.lds.S linux/arch/ia64/vmlinux.lds.S
--- linux-2.5.14-org/arch/ia64/vmlinux.lds.S	Tue May  7 16:20:04 2002
+++ linux/arch/ia64/vmlinux.lds.S	Fri May 10 17:10:14 2002
@@ -7,6 +7,7 @@
 OUTPUT_FORMAT("elf64-ia64-little")
 OUTPUT_ARCH(ia64)
 ENTRY(phys_start)
+jiffies = jiffies_64; 
 SECTIONS
 {
   /* Sections to be discarded */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/m68k/vmlinux-sun3.lds linux/arch/m68k/vmlinux-sun3.lds
--- linux-2.5.14-org/arch/m68k/vmlinux-sun3.lds	Tue May  7 16:06:15 2002
+++ linux/arch/m68k/vmlinux-sun3.lds	Fri May 10 17:12:23 2002
@@ -2,6 +2,7 @@
 OUTPUT_FORMAT("elf32-m68k", "elf32-m68k", "elf32-m68k")
 OUTPUT_ARCH(m68k)
 ENTRY(_start)
+jiffies = jiffies_64 + 4;
 SECTIONS
 {
   . = 0xE004000;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/m68k/vmlinux.lds linux/arch/m68k/vmlinux.lds
--- linux-2.5.14-org/arch/m68k/vmlinux.lds	Tue May  7 16:06:15 2002
+++ linux/arch/m68k/vmlinux.lds	Fri May 10 17:11:58 2002
@@ -2,6 +2,7 @@
 OUTPUT_FORMAT("elf32-m68k", "elf32-m68k", "elf32-m68k")
 OUTPUT_ARCH(m68k)
 ENTRY(_start)
+jiffies = jiffies_64 + 4;
 SECTIONS
 {
   . = 0x1000;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/mips64/ld.script.elf64 linux/arch/mips64/ld.script.elf64
--- linux-2.5.14-org/arch/mips64/ld.script.elf64	Tue May  7 15:59:38 2002
+++ linux/arch/mips64/ld.script.elf64	Fri May 10 17:30:11 2002
@@ -1,5 +1,6 @@
 OUTPUT_ARCH(mips)
 ENTRY(kernel_entry)
+jiffies = jiffies_64;
 SECTIONS
 {
   /* Read-only sections, merged into text segment: */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/parisc/vmlinux.lds linux/arch/parisc/vmlinux.lds
--- linux-2.5.14-org/arch/parisc/vmlinux.lds	Tue May  7 15:59:38 2002
+++ linux/arch/parisc/vmlinux.lds	Fri May 10 17:17:14 2002
@@ -2,6 +2,7 @@
 OUTPUT_FORMAT("elf32-hppa")
 OUTPUT_ARCH(hppa)
 ENTRY(_stext)
+jiffies = jiffies_64 + 4;
 SECTIONS
 {
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/ppc/vmlinux.lds linux/arch/ppc/vmlinux.lds
--- linux-2.5.14-org/arch/ppc/vmlinux.lds	Tue May  7 16:13:12 2002
+++ linux/arch/ppc/vmlinux.lds	Fri May 10 17:18:01 2002
@@ -2,6 +2,7 @@
 SEARCH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib); SEARCH_DIR(/usr/local/powerpc-any-elf/lib);
 /* Do we need any of these for elf?
    __DYNAMIC = 0;    */
+jiffies = jiffies_64 + 4;
 SECTIONS
 {
   /* Read-only sections, merged into text segment: */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/ppc64/vmlinux.lds linux/arch/ppc64/vmlinux.lds
--- linux-2.5.14-org/arch/ppc64/vmlinux.lds	Tue May  7 16:18:05 2002
+++ linux/arch/ppc64/vmlinux.lds	Fri May 10 17:19:02 2002
@@ -2,6 +2,7 @@
 SEARCH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib); SEARCH_DIR(/usr/local/powerpc-any-elf/lib);
 /* Do we need any of these for elf?
    __DYNAMIC = 0;    */
+jiffies = jiffies_64;
 SECTIONS
 {
   /* Read-only sections, merged into text segment: */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/s390/vmlinux-shared.lds linux/arch/s390/vmlinux-shared.lds
--- linux-2.5.14-org/arch/s390/vmlinux-shared.lds	Tue May  7 16:06:16 2002
+++ linux/arch/s390/vmlinux-shared.lds	Fri May 10 17:19:59 2002
@@ -4,6 +4,7 @@
 OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
 OUTPUT_ARCH(s390)
 ENTRY(_start)
+jiffies = jiffies_64 + 4;
 SECTIONS
 {
   . = 0x00000000;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/s390/vmlinux.lds linux/arch/s390/vmlinux.lds
--- linux-2.5.14-org/arch/s390/vmlinux.lds	Tue May  7 16:06:16 2002
+++ linux/arch/s390/vmlinux.lds	Fri May 10 17:20:38 2002
@@ -4,6 +4,7 @@
 OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
 OUTPUT_ARCH(s390)
 ENTRY(_start)
+jiffies = jiffies_64 + 4;
 SECTIONS
 {
   . = 0x00000000;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/s390x/vmlinux-shared.lds linux/arch/s390x/vmlinux-shared.lds
--- linux-2.5.14-org/arch/s390x/vmlinux-shared.lds	Tue May  7 16:06:16 2002
+++ linux/arch/s390x/vmlinux-shared.lds	Fri May 10 17:21:53 2002
@@ -4,6 +4,7 @@
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
 OUTPUT_ARCH(s390)
 ENTRY(_start)
+jiffies = jiffies_64;
 SECTIONS
 {
   . = 0x00000000;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/s390x/vmlinux.lds linux/arch/s390x/vmlinux.lds
--- linux-2.5.14-org/arch/s390x/vmlinux.lds	Tue May  7 16:06:16 2002
+++ linux/arch/s390x/vmlinux.lds	Fri May 10 17:22:29 2002
@@ -4,6 +4,7 @@
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
 OUTPUT_ARCH(s390)
 ENTRY(_start)
+jiffies = jiffies_64;
 SECTIONS
 {
   . = 0x00000000;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/sh/vmlinux.lds.S linux/arch/sh/vmlinux.lds.S
--- linux-2.5.14-org/arch/sh/vmlinux.lds.S	Tue May  7 16:06:16 2002
+++ linux/arch/sh/vmlinux.lds.S	Fri May 10 17:24:46 2002
@@ -5,8 +5,10 @@
 #include <linux/config.h>
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 OUTPUT_FORMAT("elf32-sh-linux", "elf32-sh-linux", "elf32-sh-linux")
+jiffies = jiffies_64;        
 #else
 OUTPUT_FORMAT("elf32-shbig-linux", "elf32-shbig-linux", "elf32-shbig-linux")
+jiffies = jiffies_64 + 4;
 #endif
 OUTPUT_ARCH(sh)
 ENTRY(_start)
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/sparc/vmlinux.lds linux/arch/sparc/vmlinux.lds
--- linux-2.5.14-org/arch/sparc/vmlinux.lds	Tue May  7 16:15:28 2002
+++ linux/arch/sparc/vmlinux.lds	Fri May 10 17:25:31 2002
@@ -2,6 +2,7 @@
 OUTPUT_FORMAT("elf32-sparc", "elf32-sparc", "elf32-sparc")
 OUTPUT_ARCH(sparc)
 ENTRY(_start)
+jiffies = jiffies_64 + 4;
 SECTIONS
 {
   . = 0x10000 + SIZEOF_HEADERS;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/sparc64/vmlinux.lds linux/arch/sparc64/vmlinux.lds
--- linux-2.5.14-org/arch/sparc64/vmlinux.lds	Tue May  7 16:15:30 2002
+++ linux/arch/sparc64/vmlinux.lds	Fri May 10 17:26:14 2002
@@ -3,6 +3,7 @@
 OUTPUT_ARCH(sparc:v9a)
 ENTRY(_start)
 
+jiffies = jiffies_64;
 SECTIONS
 {
   swapper_pmd_dir = 0x0000000000402000;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/x86_64/vmlinux.lds linux/arch/x86_64/vmlinux.lds
--- linux-2.5.14-org/arch/x86_64/vmlinux.lds	Tue May  7 16:20:04 2002
+++ linux/arch/x86_64/vmlinux.lds	Fri May 10 17:26:45 2002
@@ -3,6 +3,7 @@
  */
 OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
 OUTPUT_ARCH(i386:x86-64)
+jiffies = jiffies_64;
 ENTRY(_start)
 SECTIONS
 {
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.14-org/include/linux/sched.h	Tue May  7 16:57:58 2002
+++ linux/include/linux/sched.h	Thu May  9 17:26:25 2002
@@ -459,6 +459,11 @@
 
 #include <asm/current.h>
 
+/*
+ * The 64-bit value is not volatile - you MUST NOT read it
+ * without holding read_lock_irq(&xtime_lock)
+ */
+extern u64 jiffies_64;
 extern unsigned long volatile jiffies;
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.14-org/kernel/ksyms.c	Tue May  7 16:25:15 2002
+++ linux/kernel/ksyms.c	Thu May  9 17:21:43 2002
@@ -471,6 +471,7 @@
 EXPORT_SYMBOL_GPL(set_cpus_allowed);
 #endif
 EXPORT_SYMBOL(jiffies);
+EXPORT_SYMBOL(jiffies_64);
 EXPORT_SYMBOL(xtime);
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.14-org/kernel/timer.c	Tue May  7 16:15:52 2002
+++ linux/kernel/timer.c	Fri May 10 16:35:39 2002
@@ -67,7 +67,12 @@
 
 extern int do_setitimer(int, struct itimerval *, struct itimerval *);
 
-unsigned long volatile jiffies;
+/*
+ * The 64-bit value is not volatile - you MUST NOT read it
+ * without holding read_lock_irq(&xtime_lock).
+ * jiffies is defined in the linker script...
+ */
+u64 jiffies_64;
 
 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -664,7 +669,7 @@
 
 void do_timer(struct pt_regs *regs)
 {
-	(*(unsigned long *)&jiffies)++;
+	(*(u64 *)&jiffies_64)++;
 #ifndef CONFIG_SMP
 	/* SMP process accounting uses the local APIC timer */
 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
