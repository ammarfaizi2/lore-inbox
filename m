Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268237AbUIWDrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268237AbUIWDrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 23:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUIWDrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 23:47:04 -0400
Received: from zeus.kernel.org ([204.152.189.113]:9930 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268237AbUIWDqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:46:44 -0400
Message-Id: <200409230219.i8N2JPiF004248@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH] UML - Move linker script
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Sep 2004 22:19:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/um/uml.lds.S has already been moved to arch/um/kernel. dyn.lds.S has just
been forgotten, so fix this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9-rc2-mm1-orig/arch/um/dyn.lds.S
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/dyn.lds.S	2004-09-22 19:51:02.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/dyn.lds.S	2003-09-15 09:40:47.000000000 -0400
@@ -1,174 +0,0 @@
-#include <asm-generic/vmlinux.lds.h>
-
-OUTPUT_FORMAT(ELF_FORMAT)
-OUTPUT_ARCH(ELF_ARCH)
-ENTRY(_start)
-jiffies = jiffies_64;
-
-SEARCH_DIR("/usr/local/i686-pc-linux-gnu/lib"); SEARCH_DIR("/usr/local/lib"); SEARCH_DIR("/lib"); SEARCH_DIR("/usr/lib");
-/* Do we need any of these for elf?
-   __DYNAMIC = 0;    */
-SECTIONS
-{
-  . = START + SIZEOF_HEADERS;
-  .interp         : { *(.interp) }
-  __binary_start = .;
-  . = ALIGN(4096);		/* Init code and data */
-  _stext = .;
-  __init_begin = .;
-  .init.text : {
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-
-  . = ALIGN(4096);
-
-  /* Read-only sections, merged into text segment: */
-  .hash           : { *(.hash) }
-  .dynsym         : { *(.dynsym) }
-  .dynstr         : { *(.dynstr) }
-  .gnu.version    : { *(.gnu.version) }
-  .gnu.version_d  : { *(.gnu.version_d) }
-  .gnu.version_r  : { *(.gnu.version_r) }
-  .rel.init       : { *(.rel.init) }
-  .rela.init      : { *(.rela.init) }
-  .rel.text       : { *(.rel.text .rel.text.* .rel.gnu.linkonce.t.*) }
-  .rela.text      : { *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*) }
-  .rel.fini       : { *(.rel.fini) }
-  .rela.fini      : { *(.rela.fini) }
-  .rel.rodata     : { *(.rel.rodata .rel.rodata.* .rel.gnu.linkonce.r.*) }
-  .rela.rodata    : { *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*) }
-  .rel.data       : { *(.rel.data .rel.data.* .rel.gnu.linkonce.d.*) }
-  .rela.data      : { *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*) }
-  .rel.tdata	  : { *(.rel.tdata .rel.tdata.* .rel.gnu.linkonce.td.*) }
-  .rela.tdata	  : { *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*) }
-  .rel.tbss	  : { *(.rel.tbss .rel.tbss.* .rel.gnu.linkonce.tb.*) }
-  .rela.tbss	  : { *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*) }
-  .rel.ctors      : { *(.rel.ctors) }
-  .rela.ctors     : { *(.rela.ctors) }
-  .rel.dtors      : { *(.rel.dtors) }
-  .rela.dtors     : { *(.rela.dtors) }
-  .rel.got        : { *(.rel.got) }
-  .rela.got       : { *(.rela.got) }
-  .rel.bss        : { *(.rel.bss .rel.bss.* .rel.gnu.linkonce.b.*) }
-  .rela.bss       : { *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*) }
-  .rel.plt        : { *(.rel.plt) }
-  .rela.plt       : { *(.rela.plt) }
-  .init           : {
-    KEEP (*(.init))
-  } =0x90909090
-  .plt            : { *(.plt) }
-  .text           : {
-    *(.text)
-    SCHED_TEXT
-    *(.stub .text.* .gnu.linkonce.t.*)
-    /* .gnu.warning sections are handled specially by elf32.em.  */
-    *(.gnu.warning)
-  } =0x90909090
-  .fini           : {
-    KEEP (*(.fini))
-  } =0x90909090
-
-  .kstrtab : { *(.kstrtab) }
-
-  #include "asm/common.lds.S"
-
-  init.data : { *(.init.data) }
-
-  /* Ensure the __preinit_array_start label is properly aligned.  We
-     could instead move the label definition inside the section, but
-     the linker would then create the section even if it turns out to
-     be empty, which isn't pretty.  */
-  . = ALIGN(32 / 8);
-  .preinit_array     : { *(.preinit_array) }
-  .init_array     : { *(.init_array) }
-  .fini_array     : { *(.fini_array) }
-  .data           : {
-    . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
-    *(.data.init_task)
-    *(.data .data.* .gnu.linkonce.d.*)
-    SORT(CONSTRUCTORS)
-  }
-  .data1          : { *(.data1) }
-  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
-  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
-  .eh_frame       : { KEEP (*(.eh_frame)) }
-  .gcc_except_table   : { *(.gcc_except_table) }
-  .dynamic        : { *(.dynamic) }
-  .ctors          : {
-    /* gcc uses crtbegin.o to find the start of
-       the constructors, so we make sure it is
-       first.  Because this is a wildcard, it
-       doesn't matter if the user does not
-       actually link against crtbegin.o; the
-       linker won't look for a file to match a
-       wildcard.  The wildcard also means that it
-       doesn't matter which directory crtbegin.o
-       is in.  */
-    KEEP (*crtbegin.o(.ctors))
-    /* We don't want to include the .ctor section from
-       from the crtend.o file until after the sorted ctors.
-       The .ctor section from the crtend file contains the
-       end of ctors marker and it must be last */
-    KEEP (*(EXCLUDE_FILE (*crtend.o ) .ctors))
-    KEEP (*(SORT(.ctors.*)))
-    KEEP (*(.ctors))
-  }
-  .dtors          : {
-    KEEP (*crtbegin.o(.dtors))
-    KEEP (*(EXCLUDE_FILE (*crtend.o ) .dtors))
-    KEEP (*(SORT(.dtors.*)))
-    KEEP (*(.dtors))
-  }
-  .jcr            : { KEEP (*(.jcr)) }
-  .got            : { *(.got.plt) *(.got) }
-  _edata = .;
-  PROVIDE (edata = .);
-  __bss_start = .;
-  .bss            : {
-   *(.dynbss)
-   *(.bss .bss.* .gnu.linkonce.b.*)
-   *(COMMON)
-   /* Align here to ensure that the .bss section occupies space up to
-      _end.  Align after .bss to ensure correct alignment even if the
-      .bss section disappears because there are no input sections.  */
-   . = ALIGN(32 / 8);
-  . = ALIGN(32 / 8);
-  }
-  _end = .;
-  PROVIDE (end = .);
-   /* Stabs debugging sections.  */
-  .stab          0 : { *(.stab) }
-  .stabstr       0 : { *(.stabstr) }
-  .stab.excl     0 : { *(.stab.excl) }
-  .stab.exclstr  0 : { *(.stab.exclstr) }
-  .stab.index    0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment       0 : { *(.comment) }
-  /* DWARF debug sections.
-     Symbols in the DWARF debugging sections are relative to the beginning
-     of the section so we begin them at 0.  */
-  /* DWARF 1 */
-  .debug          0 : { *(.debug) }
-  .line           0 : { *(.line) }
-  /* GNU DWARF 1 extensions */
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  /* DWARF 1.1 and DWARF 2 */
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  /* DWARF 2 */
-  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
-  .debug_abbrev   0 : { *(.debug_abbrev) }
-  .debug_line     0 : { *(.debug_line) }
-  .debug_frame    0 : { *(.debug_frame) }
-  .debug_str      0 : { *(.debug_str) }
-  .debug_loc      0 : { *(.debug_loc) }
-  .debug_macinfo  0 : { *(.debug_macinfo) }
-  /* SGI/MIPS DWARF 2 extensions */
-  .debug_weaknames 0 : { *(.debug_weaknames) }
-  .debug_funcnames 0 : { *(.debug_funcnames) }
-  .debug_typenames 0 : { *(.debug_typenames) }
-  .debug_varnames  0 : { *(.debug_varnames) }
-}
Index: linux-2.6.9-rc2-mm1-orig/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/kernel/Makefile	2004-09-22 19:51:02.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/kernel/Makefile	2004-09-22 19:51:41.000000000 -0400
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-extra-y := vmlinux.lds uml.lds
+extra-y := vmlinux.lds uml.lds dyn.lds
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
Index: linux-2.6.9-rc2-mm1-orig/arch/um/kernel/dyn.lds.S
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/kernel/dyn.lds.S	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/kernel/dyn.lds.S	2004-09-22 19:51:41.000000000 -0400
@@ -0,0 +1,174 @@
+#include <asm-generic/vmlinux.lds.h>
+
+OUTPUT_FORMAT(ELF_FORMAT)
+OUTPUT_ARCH(ELF_ARCH)
+ENTRY(_start)
+jiffies = jiffies_64;
+
+SEARCH_DIR("/usr/local/i686-pc-linux-gnu/lib"); SEARCH_DIR("/usr/local/lib"); SEARCH_DIR("/lib"); SEARCH_DIR("/usr/lib");
+/* Do we need any of these for elf?
+   __DYNAMIC = 0;    */
+SECTIONS
+{
+  . = START + SIZEOF_HEADERS;
+  .interp         : { *(.interp) }
+  __binary_start = .;
+  . = ALIGN(4096);		/* Init code and data */
+  _stext = .;
+  __init_begin = .;
+  .init.text : {
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
+
+  . = ALIGN(4096);
+
+  /* Read-only sections, merged into text segment: */
+  .hash           : { *(.hash) }
+  .dynsym         : { *(.dynsym) }
+  .dynstr         : { *(.dynstr) }
+  .gnu.version    : { *(.gnu.version) }
+  .gnu.version_d  : { *(.gnu.version_d) }
+  .gnu.version_r  : { *(.gnu.version_r) }
+  .rel.init       : { *(.rel.init) }
+  .rela.init      : { *(.rela.init) }
+  .rel.text       : { *(.rel.text .rel.text.* .rel.gnu.linkonce.t.*) }
+  .rela.text      : { *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*) }
+  .rel.fini       : { *(.rel.fini) }
+  .rela.fini      : { *(.rela.fini) }
+  .rel.rodata     : { *(.rel.rodata .rel.rodata.* .rel.gnu.linkonce.r.*) }
+  .rela.rodata    : { *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*) }
+  .rel.data       : { *(.rel.data .rel.data.* .rel.gnu.linkonce.d.*) }
+  .rela.data      : { *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*) }
+  .rel.tdata	  : { *(.rel.tdata .rel.tdata.* .rel.gnu.linkonce.td.*) }
+  .rela.tdata	  : { *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*) }
+  .rel.tbss	  : { *(.rel.tbss .rel.tbss.* .rel.gnu.linkonce.tb.*) }
+  .rela.tbss	  : { *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*) }
+  .rel.ctors      : { *(.rel.ctors) }
+  .rela.ctors     : { *(.rela.ctors) }
+  .rel.dtors      : { *(.rel.dtors) }
+  .rela.dtors     : { *(.rela.dtors) }
+  .rel.got        : { *(.rel.got) }
+  .rela.got       : { *(.rela.got) }
+  .rel.bss        : { *(.rel.bss .rel.bss.* .rel.gnu.linkonce.b.*) }
+  .rela.bss       : { *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*) }
+  .rel.plt        : { *(.rel.plt) }
+  .rela.plt       : { *(.rela.plt) }
+  .init           : {
+    KEEP (*(.init))
+  } =0x90909090
+  .plt            : { *(.plt) }
+  .text           : {
+    *(.text)
+    SCHED_TEXT
+    *(.stub .text.* .gnu.linkonce.t.*)
+    /* .gnu.warning sections are handled specially by elf32.em.  */
+    *(.gnu.warning)
+  } =0x90909090
+  .fini           : {
+    KEEP (*(.fini))
+  } =0x90909090
+
+  .kstrtab : { *(.kstrtab) }
+
+  #include "asm/common.lds.S"
+
+  init.data : { *(.init.data) }
+
+  /* Ensure the __preinit_array_start label is properly aligned.  We
+     could instead move the label definition inside the section, but
+     the linker would then create the section even if it turns out to
+     be empty, which isn't pretty.  */
+  . = ALIGN(32 / 8);
+  .preinit_array     : { *(.preinit_array) }
+  .init_array     : { *(.init_array) }
+  .fini_array     : { *(.fini_array) }
+  .data           : {
+    . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
+    *(.data.init_task)
+    *(.data .data.* .gnu.linkonce.d.*)
+    SORT(CONSTRUCTORS)
+  }
+  .data1          : { *(.data1) }
+  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
+  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
+  .eh_frame       : { KEEP (*(.eh_frame)) }
+  .gcc_except_table   : { *(.gcc_except_table) }
+  .dynamic        : { *(.dynamic) }
+  .ctors          : {
+    /* gcc uses crtbegin.o to find the start of
+       the constructors, so we make sure it is
+       first.  Because this is a wildcard, it
+       doesn't matter if the user does not
+       actually link against crtbegin.o; the
+       linker won't look for a file to match a
+       wildcard.  The wildcard also means that it
+       doesn't matter which directory crtbegin.o
+       is in.  */
+    KEEP (*crtbegin.o(.ctors))
+    /* We don't want to include the .ctor section from
+       from the crtend.o file until after the sorted ctors.
+       The .ctor section from the crtend file contains the
+       end of ctors marker and it must be last */
+    KEEP (*(EXCLUDE_FILE (*crtend.o ) .ctors))
+    KEEP (*(SORT(.ctors.*)))
+    KEEP (*(.ctors))
+  }
+  .dtors          : {
+    KEEP (*crtbegin.o(.dtors))
+    KEEP (*(EXCLUDE_FILE (*crtend.o ) .dtors))
+    KEEP (*(SORT(.dtors.*)))
+    KEEP (*(.dtors))
+  }
+  .jcr            : { KEEP (*(.jcr)) }
+  .got            : { *(.got.plt) *(.got) }
+  _edata = .;
+  PROVIDE (edata = .);
+  __bss_start = .;
+  .bss            : {
+   *(.dynbss)
+   *(.bss .bss.* .gnu.linkonce.b.*)
+   *(COMMON)
+   /* Align here to ensure that the .bss section occupies space up to
+      _end.  Align after .bss to ensure correct alignment even if the
+      .bss section disappears because there are no input sections.  */
+   . = ALIGN(32 / 8);
+  . = ALIGN(32 / 8);
+  }
+  _end = .;
+  PROVIDE (end = .);
+   /* Stabs debugging sections.  */
+  .stab          0 : { *(.stab) }
+  .stabstr       0 : { *(.stabstr) }
+  .stab.excl     0 : { *(.stab.excl) }
+  .stab.exclstr  0 : { *(.stab.exclstr) }
+  .stab.index    0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment       0 : { *(.comment) }
+  /* DWARF debug sections.
+     Symbols in the DWARF debugging sections are relative to the beginning
+     of the section so we begin them at 0.  */
+  /* DWARF 1 */
+  .debug          0 : { *(.debug) }
+  .line           0 : { *(.line) }
+  /* GNU DWARF 1 extensions */
+  .debug_srcinfo  0 : { *(.debug_srcinfo) }
+  .debug_sfnames  0 : { *(.debug_sfnames) }
+  /* DWARF 1.1 and DWARF 2 */
+  .debug_aranges  0 : { *(.debug_aranges) }
+  .debug_pubnames 0 : { *(.debug_pubnames) }
+  /* DWARF 2 */
+  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
+  .debug_abbrev   0 : { *(.debug_abbrev) }
+  .debug_line     0 : { *(.debug_line) }
+  .debug_frame    0 : { *(.debug_frame) }
+  .debug_str      0 : { *(.debug_str) }
+  .debug_loc      0 : { *(.debug_loc) }
+  .debug_macinfo  0 : { *(.debug_macinfo) }
+  /* SGI/MIPS DWARF 2 extensions */
+  .debug_weaknames 0 : { *(.debug_weaknames) }
+  .debug_funcnames 0 : { *(.debug_funcnames) }
+  .debug_typenames 0 : { *(.debug_typenames) }
+  .debug_varnames  0 : { *(.debug_varnames) }
+}
More recent patches modify files in move-dyn-ld-script.

