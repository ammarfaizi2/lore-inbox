Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbSJDOrZ>; Fri, 4 Oct 2002 10:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261853AbSJDOnI>; Fri, 4 Oct 2002 10:43:08 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:23474 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261854AbSJDOh2> convert rfc822-to-8bit; Fri, 4 Oct 2002 10:37:28 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.40 s390 (12/27): linker scripts.
Date: Fri, 4 Oct 2002 16:29:32 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041629.32650.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use a preprocessed linker script for building vmlinux on s390/s390x.

diff -urN linux-2.5.40/arch/s390/vmlinux-shared.lds linux-2.5.40-s390/arch/s390/vmlinux-shared.lds
--- linux-2.5.40/arch/s390/vmlinux-shared.lds	Tue Oct  1 09:07:48 2002
+++ linux-2.5.40-s390/arch/s390/vmlinux-shared.lds	Thu Jan  1 01:00:00 1970
@@ -1,93 +0,0 @@
-/* ld script to make s390 Linux kernel
- * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
- */
-OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
-OUTPUT_ARCH(s390)
-ENTRY(_start)
-jiffies = jiffies_64 + 4;
-SECTIONS
-{
-  . = 0x00000000;
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.text)
-	*(.fixup)
-	*(.gnu.warning)
-	} = 0x0700
-
-  _etext = .;			/* End of text section */
-
-  .rodata : { *(.rodata) }
-  .kstrtab : { *(.kstrtab) }
-
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  . = ALIGN(1048576);		/* VM shared segments are 1MB aligned */
-
-  _eshared = .;			/* End of shareable data */
-
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
-	}
-
-  _edata = .;			/* End of data section */
-
-  . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-  . = ALIGN(256);
-  __setup_start = .;
-  .setup.init : { *(.setup.init) }
-  __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  . = ALIGN(256);
-  __per_cpu_start = .;
-  .date.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
-
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
-
-
-  __bss_start = .;		/* BSS */
-  .bss : {
-	*(.bss)
-	}
-  _end = . ;
-
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-}
diff -urN linux-2.5.40/arch/s390/vmlinux.lds linux-2.5.40-s390/arch/s390/vmlinux.lds
--- linux-2.5.40/arch/s390/vmlinux.lds	Tue Oct  1 09:06:28 2002
+++ linux-2.5.40-s390/arch/s390/vmlinux.lds	Thu Jan  1 01:00:00 1970
@@ -1,88 +0,0 @@
-/* ld script to make s390 Linux kernel
- * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
- */
-OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
-OUTPUT_ARCH(s390)
-ENTRY(_start)
-jiffies = jiffies_64 + 4;
-SECTIONS
-{
-  . = 0x00000000;
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.text)
-	*(.fixup)
-	*(.gnu.warning)
-	} = 0x0700
-
-  _etext = .;			/* End of text section */
-
-  .rodata : { *(.rodata) *(.rodata.*) }
-  .kstrtab : { *(.kstrtab) }
-
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
-	}
-
-  _edata = .;			/* End of data section */
-
-  . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-  . = ALIGN(256);
-  __setup_start = .;
-  .setup.init : { *(.setup.init) }
-  __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  . = ALIGN(256);
-  __per_cpu_start = .;
-  .date.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
-
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
-
-  __bss_start = .;		/* BSS */
-  .bss : {
-	*(.bss)
-	}
-  _end = . ;
-
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-}
diff -urN linux-2.5.40/arch/s390/vmlinux.lds.S linux-2.5.40-s390/arch/s390/vmlinux.lds.S
--- linux-2.5.40/arch/s390/vmlinux.lds.S	Tue Oct  1 09:06:30 2002
+++ linux-2.5.40-s390/arch/s390/vmlinux.lds.S	Fri Oct  4 16:15:37 2002
@@ -1,7 +1,94 @@
-#include <linux/config.h>
+/* ld script to make s390 Linux kernel
+ * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
+ */
+OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
+OUTPUT_ARCH(s390)
+ENTRY(_start)
+jiffies = jiffies_64 + 4;
+SECTIONS
+{
+  . = 0x00000000;
+  _text = .;			/* Text and read-only data */
+  .text : {
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} = 0x0700
+
+  _etext = .;			/* End of text section */
+
+  .rodata : { *(.rodata) *(.rodata.*) }
+  .kstrtab : { *(.kstrtab) }
+
+  . = ALIGN(16);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
 
 #ifdef CONFIG_SHARED_KERNEL
-#include "vmlinux-shared.lds"
-#else
-#include "vmlinux.lds"
+  . = ALIGN(1048576);		/* VM shared segments are 1MB aligned */
+
+  _eshared = .;			/* End of shareable data */
 #endif
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+	}
+
+  _edata = .;			/* End of data section */
+
+  . = ALIGN(8192);		/* init_task */
+  .data.init_task : { *(.data.init_task) }
+
+  . = ALIGN(4096);		/* Init code and data */
+  __init_begin = .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . = ALIGN(256);
+  __setup_start = .;
+  .setup.init : { *(.setup.init) }
+  __setup_end = .;
+  __initcall_start = .;
+  .initcall.init : {
+	*(.initcall1.init) 
+	*(.initcall2.init) 
+	*(.initcall3.init) 
+	*(.initcall4.init) 
+	*(.initcall5.init) 
+	*(.initcall6.init) 
+	*(.initcall7.init)
+  }
+  __initcall_end = .;
+  . = ALIGN(256);
+  __per_cpu_start = .;
+  .date.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
+  . = ALIGN(4096);
+  __init_end = .;
+
+  . = ALIGN(32);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  . = ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+
+  __bss_start = .;		/* BSS */
+  .bss : {
+	*(.bss)
+	}
+  _end = . ;
+
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+}
diff -urN linux-2.5.40/arch/s390x/vmlinux-shared.lds linux-2.5.40-s390/arch/s390x/vmlinux-shared.lds
--- linux-2.5.40/arch/s390x/vmlinux-shared.lds	Tue Oct  1 09:07:34 2002
+++ linux-2.5.40-s390/arch/s390x/vmlinux-shared.lds	Thu Jan  1 01:00:00 1970
@@ -1,93 +0,0 @@
-/* ld script to make s390 Linux kernel
- * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
- */
-OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
-OUTPUT_ARCH(s390)
-ENTRY(_start)
-jiffies = jiffies_64;
-SECTIONS
-{
-  . = 0x00000000;
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.text)
-	*(.fixup)
-	*(.gnu.warning)
-	} = 0x0700
-
-  _etext = .;			/* End of text section */
-
-  .rodata : { *(.rodata) }
-  .kstrtab : { *(.kstrtab) }
-
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  . = ALIGN(1048576);		/* VM shared segments are 1MB aligned */
-
-  _eshared = .;			/* End of shareable data */
-
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
-	}
-
-  _edata = .;			/* End of data section */
-
-  . = ALIGN(16384);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-  . = ALIGN(256);
-  __setup_start = .;
-  .setup.init : { *(.setup.init) }
-  __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  . = ALIGN(256);
-  __per_cpu_start = .;
-  .date.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
-
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
-
-
-  __bss_start = .;		/* BSS */
-  .bss : {
-	*(.bss)
-	}
-  _end = . ;
-
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-}
diff -urN linux-2.5.40/arch/s390x/vmlinux.lds linux-2.5.40-s390/arch/s390x/vmlinux.lds
--- linux-2.5.40/arch/s390x/vmlinux.lds	Tue Oct  1 09:07:36 2002
+++ linux-2.5.40-s390/arch/s390x/vmlinux.lds	Thu Jan  1 01:00:00 1970
@@ -1,89 +0,0 @@
-/* ld script to make s390 Linux kernel
- * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
- */
-OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
-OUTPUT_ARCH(s390)
-ENTRY(_start)
-jiffies = jiffies_64;
-SECTIONS
-{
-  . = 0x00000000;
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.text)
-	*(.fixup)
-	*(.gnu.warning)
-	} = 0x0700
-
-  _etext = .;			/* End of text section */
-
-  .rodata : { *(.rodata) *(.rodata.*) }
-  .kstrtab : { *(.kstrtab) }
-
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
-	}
-
-  _edata = .;			/* End of data section */
-
-  . = ALIGN(16384);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-  . = ALIGN(256);
-  __setup_start = .;
-  .setup.init : { *(.setup.init) }
-  __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  . = ALIGN(256);
-  __per_cpu_start = .;
-  .date.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
-
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
-
-
-  __bss_start = .;		/* BSS */
-  .bss : {
-	*(.bss)
-	}
-  _end = . ;
-
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-}
diff -urN linux-2.5.40/arch/s390x/vmlinux.lds.S linux-2.5.40-s390/arch/s390x/vmlinux.lds.S
--- linux-2.5.40/arch/s390x/vmlinux.lds.S	Tue Oct  1 09:06:28 2002
+++ linux-2.5.40-s390/arch/s390x/vmlinux.lds.S	Fri Oct  4 16:15:37 2002
@@ -1,7 +1,95 @@
-#include <linux/config.h>
+/* ld script to make s390 Linux kernel
+ * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
+ */
+OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
+OUTPUT_ARCH(s390:64-bit)
+ENTRY(_start)
+jiffies = jiffies_64;
+SECTIONS
+{
+  . = 0x00000000;
+  _text = .;			/* Text and read-only data */
+  .text : {
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} = 0x0700
+
+  _etext = .;			/* End of text section */
+
+  .rodata : { *(.rodata) *(.rodata.*) }
+  .kstrtab : { *(.kstrtab) }
+
+  . = ALIGN(16);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
 
 #ifdef CONFIG_SHARED_KERNEL
-#include "vmlinux-shared.lds"
-#else
-#include "vmlinux.lds"
+  . = ALIGN(1048576);		/* VM shared segments are 1MB aligned */
+
+  _eshared = .;			/* End of shareable data */
 #endif
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+	}
+
+  _edata = .;			/* End of data section */
+
+  . = ALIGN(16384);		/* init_task */
+  .data.init_task : { *(.data.init_task) }
+
+  . = ALIGN(4096);		/* Init code and data */
+  __init_begin = .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . = ALIGN(256);
+  __setup_start = .;
+  .setup.init : { *(.setup.init) }
+  __setup_end = .;
+  __initcall_start = .;
+  .initcall.init : {
+	*(.initcall1.init) 
+	*(.initcall2.init) 
+	*(.initcall3.init) 
+	*(.initcall4.init) 
+	*(.initcall5.init) 
+	*(.initcall6.init) 
+	*(.initcall7.init)
+  }
+  __initcall_end = .;
+  . = ALIGN(256);
+  __per_cpu_start = .;
+  .date.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
+  . = ALIGN(4096);
+  __init_end = .;
+
+  . = ALIGN(32);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  . = ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+
+
+  __bss_start = .;		/* BSS */
+  .bss : {
+	*(.bss)
+	}
+  _end = . ;
+
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+}

