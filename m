Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbTFLRGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbTFLRGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:06:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41703 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264904AbTFLRG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:06:26 -0400
Date: Thu, 12 Jun 2003 18:20:11 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Consolidate binfmt choices in Kconfig
Message-ID: <20030612172011.GO30843@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The full patch is around 60k, and is available from
http://ftp.linux.org.uk/pub/linux/willy/patches/binfmt-Kconfig.diff

 21 files changed, 117 insertions(+), 922 deletions(-)

It's very repetitive, so to give a flavour for it, here's i386, m68knommu
and fs/Kconfig.binfmt.  I rewrote the BINFMT_AOUT helptext to bring it
into this decade.

Comments welcomed; I'll send it to Linus tomorrow if I don't hear anything.

Index: arch/i386/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.5/arch/i386/Kconfig,v
retrieving revision 1.22
diff -u -p -r1.22 Kconfig
--- arch/i386/Kconfig	27 May 2003 17:21:14 -0000	1.22
+++ arch/i386/Kconfig	10 Jun 2003 18:48:27 -0000
@@ -1176,81 +1176,7 @@ config KCORE_AOUT
 
 endchoice
 
-config BINFMT_AOUT
-	tristate "Kernel support for a.out binaries"
-	---help---
-	  A.out (Assembler.OUTput) is a set of formats for libraries and
-	  executables used in the earliest versions of UNIX. Linux used the
-	  a.out formats QMAGIC and ZMAGIC until they were replaced with the
-	  ELF format.
-
-	  As more and more programs are converted to ELF, the use for a.out
-	  will gradually diminish. If you disable this option it will reduce
-	  your kernel by one page. This is not much and by itself does not
-	  warrant removing support. However its removal is a good idea if you
-	  wish to ensure that absolutely none of your programs will use this
-	  older executable format. If you don't know what to answer at this
-	  point then answer Y. If someone told you "You need a kernel with
-	  QMAGIC support" then you'll have to say Y here. You may answer M to
-	  compile a.out support as a module and later load the module when you
-	  want to use a program or library in a.out format. The module will be
-	  called binfmt_aout. Saying M or N here is dangerous though,
-	  because some crucial programs on your system might still be in A.OUT
-	  format.
-
-config BINFMT_ELF
-	tristate "Kernel support for ELF binaries"
-	---help---
-	  ELF (Executable and Linkable Format) is a format for libraries and
-	  executables used across different architectures and operating
-	  systems. Saying Y here will enable your kernel to run ELF binaries
-	  and enlarge it by about 13 KB. ELF support under Linux has now all
-	  but replaced the traditional Linux a.out formats (QMAGIC and ZMAGIC)
-	  because it is portable (this does *not* mean that you will be able
-	  to run executables from different architectures or operating systems
-	  however) and makes building run-time libraries very easy. Many new
-	  executables are distributed solely in ELF format. You definitely
-	  want to say Y here.
-
-	  Information about ELF is contained in the ELF HOWTO available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  If you find that after upgrading from Linux kernel 1.2 and saying Y
-	  here, you still can't run any ELF binaries (they just crash), then
-	  you'll have to install the newest ELF runtime libraries, including
-	  ld.so (check the file <file:Documentation/Changes> for location and
-	  latest version).
-
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called binfmt_elf. Saying M or N here is dangerous because
-	  some crucial programs on your system might be in ELF format.
-
-config BINFMT_MISC
-	tristate "Kernel support for MISC binaries"
-	---help---
-	  If you say Y here, it will be possible to plug wrapper-driven binary
-	  formats into the kernel. You will like this especially when you use
-	  programs that need an interpreter to run like Java, Python or
-	  Emacs-Lisp. It's also useful if you often run DOS executables under
-	  the Linux DOS emulator DOSEMU (read the DOSEMU-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>). Once you have
-	  registered such a binary class with the kernel, you can start one of
-	  those programs simply by typing in its name at a shell prompt; Linux
-	  will automatically feed it to the correct interpreter.
-
-	  You can do other nice things, too. Read the file
-	  <file:Documentation/binfmt_misc.txt> to learn how to use this
-	  feature, and <file:Documentation/java.txt> for information about how
-	  to include Java support.
-
-	  You must say Y to "/proc file system support" (CONFIG_PROC_FS) to
-	  use this part of the kernel.
-
-	  You may say M here for module support and later load the module when
-	  you have use for it; the module is called binfmt_misc. If you
-	  don't know what to answer at this point, say Y.
+source "fs/Kconfig.binfmt"
 
 endmenu
 
Index: arch/m68knommu/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.5/arch/m68knommu/Kconfig,v
retrieving revision 1.10
diff -u -p -r1.10 Kconfig
--- arch/m68knommu/Kconfig	27 May 2003 17:21:31 -0000	1.10
+++ arch/m68knommu/Kconfig	10 Jun 2003 19:39:27 -0000
@@ -501,16 +501,7 @@ config KCORE_AOUT
 config KCORE_ELF
 	default y
 
-config BINFMT_FLAT
-	tristate "Kernel support for flat binaries"
-	help
-	  Support uClinux FLAT format binaries.
-
-config BINFMT_ZFLAT
-	bool "  Enable ZFLAT support"
-	depends on BINFMT_FLAT
-	help
-	  Supoprt FLAT format compressed binaries
+source "fs/Kconfig.binfmt"
 
 endmenu
 
Index: fs/Kconfig.binfmt
===================================================================
RCS file: fs/Kconfig.binfmt
diff -N fs/Kconfig.binfmt
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ fs/Kconfig.binfmt	12 Jun 2003 17:01:08 -0000
@@ -0,0 +1,96 @@
+config BINFMT_ELF
+	tristate "Kernel support for ELF binaries"
+	depends on MMU
+	default y
+	---help---
+	  ELF (Executable and Linkable Format) is a format for libraries and
+	  executables used across different architectures and operating
+	  systems. Saying Y here will enable your kernel to run ELF binaries
+	  and enlarge it by about 13 KB. ELF support under Linux has now all
+	  but replaced the traditional Linux a.out formats (QMAGIC and ZMAGIC)
+	  because it is portable (this does *not* mean that you will be able
+	  to run executables from different architectures or operating systems
+	  however) and makes building run-time libraries very easy. Many new
+	  executables are distributed solely in ELF format. You definitely
+	  want to say Y here.
+
+	  Information about ELF is contained in the ELF HOWTO available from
+	  <http://www.tldp.org/docs.html#howto>.
+
+	  If you find that after upgrading from Linux kernel 1.2 and saying Y
+	  here, you still can't run any ELF binaries (they just crash), then
+	  you'll have to install the newest ELF runtime libraries, including
+	  ld.so (check the file <file:Documentation/Changes> for location and
+	  latest version).
+
+	  If you want to compile this as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module
+	  will be called binfmt_elf. Saying M or N here is dangerous because
+	  some crucial programs on your system might be in ELF format.
+
+config BINFMT_FLAT
+	tristate "Kernel support for flat binaries"
+	depends on !MMU
+	help
+	  Support uClinux FLAT format binaries.
+
+config BINFMT_ZFLAT
+	bool "  Enable ZFLAT support"
+	depends on BINFMT_FLAT
+	help
+	  Support FLAT format compressed binaries
+
+config BINFMT_AOUT
+	tristate "Kernel support for a.out binaries"
+	depends on X86 || ALPHA || ARM || M68K || MIPS || SPARC
+	---help---
+	  A.out (Assembler.OUTput) is a set of formats for libraries and
+	  executables used in the earliest versions of UNIX. Linux used the
+	  a.out formats QMAGIC and ZMAGIC until they were replaced with the
+	  ELF format.
+
+	  The conversion to ELF started in 1995.  This option is primarily
+	  provided for historical interest and for the benefit of those
+	  who need to run binaries from that era.
+
+	  Most people should answer N here.  If you think you may have
+	  occasional use for this format, enable module support above
+	  and answer M here to compile this support as a module called
+	  binfmt_aout.
+
+	  If any crucial components of your system (such as /sbin/init
+	  or /lib/ld.so) are still in a.out format, you will have to
+	  say Y here.
+
+config BINFMT_SOM
+	tristate "Kernel support for SOM binaries"
+	depends on PARISC && HPUX
+	help
+	  SOM is a binary executable format inherited from HP/UX.  Say
+	  Y here to be able to load and execute SOM binaries directly.
+
+config BINFMT_MISC
+	tristate "Kernel support for MISC binaries"
+	---help---
+	  If you say Y here, it will be possible to plug wrapper-driven binary
+	  formats into the kernel. You will like this especially when you use
+	  programs that need an interpreter to run like Java, Python or
+	  Emacs-Lisp. It's also useful if you often run DOS executables under
+	  the Linux DOS emulator DOSEMU (read the DOSEMU-HOWTO, available from
+	  <http://www.tldp.org/docs.html#howto>). Once you have
+	  registered such a binary class with the kernel, you can start one of
+	  those programs simply by typing in its name at a shell prompt; Linux
+	  will automatically feed it to the correct interpreter.
+
+	  You can do other nice things, too. Read the file
+	  <file:Documentation/binfmt_misc.txt> to learn how to use this
+	  feature, and <file:Documentation/java.txt> for information about how
+	  to include Java support.
+
+	  You must say Y to "/proc file system support" (CONFIG_PROC_FS) to
+	  use this part of the kernel.
+
+	  You may say M here for module support and later load the module when
+	  you have use for it; the module is called binfmt_misc. If you
+	  don't know what to answer at this point, say Y.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
