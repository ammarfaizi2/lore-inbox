Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTHXMDy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTHXMDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:03:54 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:6815 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263467AbTHXMDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:03:41 -0400
Date: Sun, 24 Aug 2003 13:47:08 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] vmlinux-*.lds (was: Re: Linux 2.6.0-test4)
In-Reply-To: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
Message-ID: <Pine.GSO.4.21.0308241341380.14814-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003, Linus Torvalds wrote:
> Kai Germaschewski:
>   o kbuild: Move generation of vmlinux.lds.s into arch/.../kernel

You forgot to move two files:

    mv arch/m68k/vmlinux-std.lds arch/m68k/kernel
    mv arch/m68k/vmlinux-sun3.lds arch/m68k/kernel

Or apply this patch:

--- linux-2.6.0-test4/arch/m68k/vmlinux-std.lds	Sun Jun 15 09:37:32 2003
+++ linux-m68k-2.6.0-test4/arch/m68k/vmlinux-std.lds	Tue Jun 24 14:30:53 2003
@@ -1,97 +0,0 @@
-/* ld script to make m68k Linux kernel */
-
-#include <asm-generic/vmlinux.lds.h>
-
-OUTPUT_FORMAT("elf32-m68k", "elf32-m68k", "elf32-m68k")
-OUTPUT_ARCH(m68k)
-ENTRY(_start)
-jiffies = jiffies_64 + 4;
-SECTIONS
-{
-  . = 0x1000;
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.text)
-	*(.fixup)
-	*(.gnu.warning)
-	} = 0x4e75
-
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  RODATA
-
-  _etext = .;			/* End of text section */
-
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
-	}
-
-  .bss : { *(.bss) }		/* BSS */
-
-  . = ALIGN(16);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  _edata = .;			/* End of data section */
-
-  /* will be freed after init */
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
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
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
-  SECURITY_INIT
-  . = ALIGN(8192);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
-  . = ALIGN(8192);
-  __init_end = .;
-
-  .data.init_task : { *(.data.init_task) }	/* The initial task and kernel stack */
-
-  _end = . ;
-
-  /* Sections to be discarded */
-  /DISCARD/ : {
-	*(.exit.text)
-	*(.exit.data)
-	*(.exitcall.exit)
-	}
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
--- linux-2.6.0-test4/arch/m68k/vmlinux-sun3.lds	Sun Jun 15 09:37:32 2003
+++ linux-m68k-2.6.0-test4/arch/m68k/vmlinux-sun3.lds	Tue Jun 24 14:30:53 2003
@@ -1,97 +0,0 @@
-/* ld script to make m68k Linux kernel */
-
-#include <asm-generic/vmlinux.lds.h>
-
-OUTPUT_FORMAT("elf32-m68k", "elf32-m68k", "elf32-m68k")
-OUTPUT_ARCH(m68k)
-ENTRY(_start)
-jiffies = jiffies_64 + 4;
-SECTIONS
-{
-  . = 0xE004000;
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.head)
-	*(.text)
-	*(.fixup)
-	*(.gnu.warning)
-	} = 0x4e75
-	RODATA
-
-  _etext = .;			/* End of text section */
-
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
-  	. = ALIGN(16);		/* Exception table */
-  	__start___ex_table = .;
-  	*(__ex_table) 
-  	__stop___ex_table = .;
-	}
-  /* End of data goes *here* so that freeing init code works properly. */
-  _edata = .;
-
-  /* will be freed after init */
-  . = ALIGN(8192);	/* Init code and data */
-__init_begin = .;
-	.init.text : { 
-		_sinittext = .;
-		*(.init.text)
-		_einittext = .;
-	}
-  	.init.data : { *(.init.data) }
-	. = ALIGN(16);
-	__setup_start = .;
-	.init.setup : { *(.init.setup) }
-	__setup_end = .;
-	__start___param = .;
-	__param : { *(__param) }
-	__stop___param = .;
-	__initcall_start = .;
-	.initcall.init : {
-		*(.initcall1.init) 
-		*(.initcall2.init) 
-		*(.initcall3.init) 
-		*(.initcall4.init) 
-		*(.initcall5.init) 
-		*(.initcall6.init) 
-		*(.initcall7.init)
-	}
-	__initcall_end = .;
-	__con_initcall_start = .;
-	.con_initcall.init : { *(.con_initcall.init) }
-	__con_initcall_end = .;
-	SECURITY_INIT
-	. = ALIGN(8192);
-	__initramfs_start = .;
-	.init.ramfs : { *(.init.ramfs) }
-	__initramfs_end = .;
-	. = ALIGN(8192);
-	__init_end = .;
-	.init.task : { *(init_task) }
-	
-
-  .bss : { *(.bss) }		/* BSS */
-
-  _end = . ;
-
-  /* Sections to be discarded */
-  /DISCARD/ : {
-	*(.exit.text)
-	*(.exit.data)
-	*(.exitcall.exit)
-	}
-
-  .crap : {
-  	/* Stabs debugging sections.  */
-	*(.stab)
-	*(.stabstr)
-	*(.stab.excl)
-	*(.stab.exclstr)
-	*(.stab.index)
-	*(.stab.indexstr)
-	*(.comment)
-	*(.note)
-  }
-
-}
--- linux-2.6.0-test4/arch/m68k/kernel/vmlinux-std.lds	Tue Jun 24 14:30:53 2003
+++ linux-m68k-2.6.0-test4/arch/m68k/kernel/vmlinux-std.lds	Sun Jun 15 10:46:43 2003
@@ -0,0 +1,97 @@
+/* ld script to make m68k Linux kernel */
+
+#include <asm-generic/vmlinux.lds.h>
+
+OUTPUT_FORMAT("elf32-m68k", "elf32-m68k", "elf32-m68k")
+OUTPUT_ARCH(m68k)
+ENTRY(_start)
+jiffies = jiffies_64 + 4;
+SECTIONS
+{
+  . = 0x1000;
+  _text = .;			/* Text and read-only data */
+  .text : {
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} = 0x4e75
+
+  . = ALIGN(16);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  RODATA
+
+  _etext = .;			/* End of text section */
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+	}
+
+  .bss : { *(.bss) }		/* BSS */
+
+  . = ALIGN(16);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  _edata = .;			/* End of data section */
+
+  /* will be freed after init */
+  . = ALIGN(4096);		/* Init code and data */
+  __init_begin = .;
+  .init.text : { 
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
+  .init.data : { *(.init.data) }
+  . = ALIGN(16);
+  __setup_start = .;
+  .init.setup : { *(.init.setup) }
+  __setup_end = .;
+  __start___param = .;
+  __param : { *(__param) }
+  __stop___param = .;
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
+  __con_initcall_start = .;
+  .con_initcall.init : { *(.con_initcall.init) }
+  __con_initcall_end = .;
+  SECURITY_INIT
+  . = ALIGN(8192);
+  __initramfs_start = .;
+  .init.ramfs : { *(.init.ramfs) }
+  __initramfs_end = .;
+  . = ALIGN(8192);
+  __init_end = .;
+
+  .data.init_task : { *(.data.init_task) }	/* The initial task and kernel stack */
+
+  _end = . ;
+
+  /* Sections to be discarded */
+  /DISCARD/ : {
+	*(.exit.text)
+	*(.exit.data)
+	*(.exitcall.exit)
+	}
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
--- linux-2.6.0-test4/arch/m68k/kernel/vmlinux-sun3.lds	Tue Jun 24 14:30:53 2003
+++ linux-m68k-2.6.0-test4/arch/m68k/kernel/vmlinux-sun3.lds	Sun Jun 15 10:46:43 2003
@@ -0,0 +1,97 @@
+/* ld script to make m68k Linux kernel */
+
+#include <asm-generic/vmlinux.lds.h>
+
+OUTPUT_FORMAT("elf32-m68k", "elf32-m68k", "elf32-m68k")
+OUTPUT_ARCH(m68k)
+ENTRY(_start)
+jiffies = jiffies_64 + 4;
+SECTIONS
+{
+  . = 0xE004000;
+  _text = .;			/* Text and read-only data */
+  .text : {
+	*(.head)
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} = 0x4e75
+	RODATA
+
+  _etext = .;			/* End of text section */
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+  	. = ALIGN(16);		/* Exception table */
+  	__start___ex_table = .;
+  	*(__ex_table) 
+  	__stop___ex_table = .;
+	}
+  /* End of data goes *here* so that freeing init code works properly. */
+  _edata = .;
+
+  /* will be freed after init */
+  . = ALIGN(8192);	/* Init code and data */
+__init_begin = .;
+	.init.text : { 
+		_sinittext = .;
+		*(.init.text)
+		_einittext = .;
+	}
+  	.init.data : { *(.init.data) }
+	. = ALIGN(16);
+	__setup_start = .;
+	.init.setup : { *(.init.setup) }
+	__setup_end = .;
+	__start___param = .;
+	__param : { *(__param) }
+	__stop___param = .;
+	__initcall_start = .;
+	.initcall.init : {
+		*(.initcall1.init) 
+		*(.initcall2.init) 
+		*(.initcall3.init) 
+		*(.initcall4.init) 
+		*(.initcall5.init) 
+		*(.initcall6.init) 
+		*(.initcall7.init)
+	}
+	__initcall_end = .;
+	__con_initcall_start = .;
+	.con_initcall.init : { *(.con_initcall.init) }
+	__con_initcall_end = .;
+	SECURITY_INIT
+	. = ALIGN(8192);
+	__initramfs_start = .;
+	.init.ramfs : { *(.init.ramfs) }
+	__initramfs_end = .;
+	. = ALIGN(8192);
+	__init_end = .;
+	.init.task : { *(init_task) }
+	
+
+  .bss : { *(.bss) }		/* BSS */
+
+  _end = . ;
+
+  /* Sections to be discarded */
+  /DISCARD/ : {
+	*(.exit.text)
+	*(.exit.data)
+	*(.exitcall.exit)
+	}
+
+  .crap : {
+  	/* Stabs debugging sections.  */
+	*(.stab)
+	*(.stabstr)
+	*(.stab.excl)
+	*(.stab.exclstr)
+	*(.stab.index)
+	*(.stab.indexstr)
+	*(.comment)
+	*(.note)
+  }
+
+}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

