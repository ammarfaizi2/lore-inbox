Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277329AbRJEI02>; Fri, 5 Oct 2001 04:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277331AbRJEI0U>; Fri, 5 Oct 2001 04:26:20 -0400
Received: from rj.sgi.com ([204.94.215.100]:63112 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S277329AbRJEI0O>;
	Fri, 5 Oct 2001 04:26:14 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [patch] 2.4.11-pre4 EXPORT_SYMTAB, modversions.h, DocBook cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Oct 2001 18:26:30 +1000
Message-ID: <5772.1002270390@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove explicit references to EXPORT_SYMTAB and modversions.h, module.h
takes care of everything (or I want to know why it doesn't).  Side trek
into DocBook to update export symbol stuff and remove assorted sgml
warnings.

Index: 11-pre4.2/arch/mips/au1000/common/serial.c
--- 11-pre4.2/arch/mips/au1000/common/serial.c Mon, 10 Sep 2001 15:46:51 +1000 kaos (linux-2.4/k/f/41_serial.c 1.1 644)
+++ 11-pre4.2(w)/arch/mips/au1000/common/serial.c Fri, 05 Oct 2001 18:14:09 +1000 kaos (linux-2.4/k/f/41_serial.c 1.1 644)
@@ -68,9 +68,6 @@ static char *serial_revdate = "2001-02-0
  * End of serial driver configuration section.
  */
 
-#ifdef MODVERSIONS
-#include <linux/modversions.h>
-#endif
 #include <linux/module.h>
 
 #include <linux/types.h>
Index: 11-pre4.2/arch/mips/dec/wbflush.c
--- 11-pre4.2/arch/mips/dec/wbflush.c Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/J/c/42_wbflush.c 1.1 644)
+++ 11-pre4.2(w)/arch/mips/dec/wbflush.c Fri, 05 Oct 2001 17:36:06 +1000 kaos (linux-2.4/J/c/42_wbflush.c 1.1 644)
@@ -103,8 +103,6 @@ static void wbflush_kn03(void)
 {
 }
 
-#ifdef EXPORT_SYMTAB
 #include <linux/module.h>
 
 EXPORT_SYMBOL(__wbflush);
-#endif
Index: 11-pre4.2/drivers/block/paride/bpck6.c
--- 11-pre4.2/drivers/block/paride/bpck6.c Wed, 19 Sep 2001 14:59:20 +1000 kaos (linux-2.4/J/d/13_bpck6.c 1.1.1.1 644)
+++ 11-pre4.2(w)/drivers/block/paride/bpck6.c Fri, 05 Oct 2001 17:34:49 +1000 kaos (linux-2.4/J/d/13_bpck6.c 1.1.1.1 644)
@@ -25,7 +25,6 @@ int verbose=0; /* set this to 1 to see d
 
 #define BACKPACK_VERSION "2.0.2"
 
-#define EXPORT_SYMTAB 
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
Index: 11-pre4.2/drivers/block/paride/Makefile
--- 11-pre4.2/drivers/block/paride/Makefile Sun, 08 Apr 2001 14:10:15 +1000 kaos (linux-2.4/c/c/10_Makefile 1.2 644)
+++ 11-pre4.2(w)/drivers/block/paride/Makefile Fri, 05 Oct 2001 17:35:00 +1000 kaos (linux-2.4/c/c/10_Makefile 1.2 644)
@@ -7,6 +7,8 @@
 
 L_TARGET := paride.a
 
+export-objs := bpck6.o
+
 obj-$(CONFIG_PARIDE)		+= paride.o
 obj-$(CONFIG_PARIDE_PD)		+= pd.o
 obj-$(CONFIG_PARIDE_PCD)	+= pcd.o
Index: 11-pre4.2/drivers/mtd/devices/blkmtd.c
--- 11-pre4.2/drivers/mtd/devices/blkmtd.c Fri, 05 Oct 2001 15:05:09 +1000 kaos (linux-2.4/q/f/29_blkmtd.c 1.1 644)
+++ 11-pre4.2(w)/drivers/mtd/devices/blkmtd.c Fri, 05 Oct 2001 18:13:57 +1000 kaos (linux-2.4/q/f/29_blkmtd.c 1.1 644)
@@ -59,11 +59,6 @@
 #include <linux/mtd/compatmac.h>
 #include <linux/mtd/mtd.h>
 
-#if CONFIG_MODVERSION==1
-#define MODVERSIONS
-#include <linux/modversions.h>
-#endif
-
 /* Default erase size in K, always make it a multiple of PAGE_SIZE */
 #define CONFIG_MTD_BLKDEV_ERASESIZE 128
 #define VERSION "1.1"
Index: 11-pre4.2/drivers/usb/usb-uhci.c
--- 11-pre4.2/drivers/usb/usb-uhci.c Mon, 01 Oct 2001 12:23:40 +1000 kaos (linux-2.4/z/b/2_usb-uhci.c 1.2.1.1.1.12 644)
+++ 11-pre4.2(w)/drivers/usb/usb-uhci.c Fri, 05 Oct 2001 17:34:31 +1000 kaos (linux-2.4/z/b/2_usb-uhci.c 1.2.1.1.1.12 644)
@@ -71,9 +71,6 @@
 #define DEBUG_SYMBOLS
 #ifdef DEBUG_SYMBOLS
 	#define _static
-	#ifndef EXPORT_SYMTAB
-		#define EXPORT_SYMTAB
-	#endif
 #else
 	#define _static static
 #endif
Index: 11-pre4.2/scripts/kernel-doc
--- 11-pre4.2/scripts/kernel-doc Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/2_kernel-doc 1.1.1.2.1.2.1.1 644)
+++ 11-pre4.2(w)/scripts/kernel-doc Fri, 05 Oct 2001 17:59:48 +1000 kaos (linux-2.4/2_kernel-doc 1.1.1.2.1.2.1.1 644)
@@ -588,7 +588,7 @@ sub output_function_sgml(%) {
     } else {
 	print "  <void>\n";
     }
-    print "  </funcsynopsis>\n";
+    print "  </funcprototype></funcsynopsis>\n";
     print "</refsynopsisdiv>\n";
 
     # print parameters
Index: 11-pre4.2/Documentation/DocBook/kernel-api.tmpl
--- 11-pre4.2/Documentation/DocBook/kernel-api.tmpl Mon, 10 Sep 2001 15:46:51 +1000 kaos (linux-2.4/V/c/3_kernel-api 1.1.1.2.1.2.1.1 644)
+++ 11-pre4.2(w)/Documentation/DocBook/kernel-api.tmpl Fri, 05 Oct 2001 18:08:37 +1000 kaos (linux-2.4/V/c/3_kernel-api 1.1.1.2.1.2.1.1 644)
@@ -187,11 +187,6 @@
 !Edrivers/block/ll_rw_blk.c
   </chapter>
 
-  <chapter id="part">
-     <title>Partition Handling</title>
-!Edrivers/block/genhd.c
-  </chapter>
-
   <chapter id="miscdev">
      <title>Miscellaneous Devices</title>
 !Edrivers/char/misc.c
Index: 11-pre4.2/Documentation/DocBook/kernel-hacking.tmpl
--- 11-pre4.2/Documentation/DocBook/kernel-hacking.tmpl Sun, 20 May 2001 14:11:24 +1000 kaos (linux-2.4/V/c/1_kernel-hac 1.2.1.1.1.1 644)
+++ 11-pre4.2(w)/Documentation/DocBook/kernel-hacking.tmpl Fri, 05 Oct 2001 18:02:39 +1000 kaos (linux-2.4/V/c/1_kernel-hac 1.2.1.1.1.1 644)
@@ -976,17 +976,35 @@ foo_open (...)
    </para>
   </sect1>
 
-  <sect1 id="sym-exportsymtab">
-   <title><function>EXPORT_SYMTAB</function></title>
+  <sect1 id="sym-exportnosymbols">
+   <title><symbol>EXPORT_NO_SYMBOLS</symbol>
+    <filename class=headerfile>include/linux/module.h</filename></title>
+
+   <para>
+    If a module exports no symbols then you can specify
+    <programlisting>
+EXPORT_NO_SYMBOLS;
+    </programlisting>
+    anywhere in the module.
+    In kernel 2.4 and earlier, if a module contains neither
+    <function>EXPORT_SYMBOL()</function> nor
+    <symbol>EXPORT_NO_SYMBOLS</symbol> then the module defaults to
+    exporting all non-static global symbols.
+    In kernel 2.5 onwards you must explicitly specify whether a module
+    exports symbols or not.
+   </para>
+  </sect1>
 
-   <para>
-    For convenience, a module usually exports all non-file-scope
-    symbols (ie. all those not declared <type>static</type>).  If this
-    is defined before
+  <sect1 id="sym-exportsymbols-gpl">
+   <title><function>EXPORT_SYMBOL_GPL()</function>
+    <filename class=headerfile>include/linux/module.h</filename></title>
 
-    <filename class=headerfile>include/linux/module.h</filename> is
-    included, then only symbols explicit exported with
-    <function>EXPORT_SYMBOL()</function> will be exported.
+   <para>
+    Similar to <function>EXPORT_SYMBOL()</function> except that the
+    symbols exported by <function>EXPORT_SYMBOL_GPL()</function> can
+    only be seen by modules with a
+    <function>MODULE_LICENCE()</function> that specifies a GPL
+    compatible license.
    </para>
   </sect1>
  </chapter>
@@ -1241,9 +1259,19 @@ static struct block_device_operations op
      Edit the <filename>Makefile</filename>: the CONFIG variables are
      exported here so you can conditionalize compilation with `ifeq'.
      If your file exports symbols then add the names to
-     <varname>MX_OBJS</varname> or <varname>OX_OBJS</varname> instead
-     of <varname>M_OBJS</varname> or <varname>O_OBJS</varname>, so
-     that genksyms will find them.
+     <varname>export-objs</varname> so that genksyms will find them.
+     <caution>
+      <para>
+       There is a restriction on the kernel build system that objects
+       which export symbols must have globally unique names.
+       If your object does not have a globally unique name then the
+       standard fix is to move the
+       <function>EXPORT_SYMBOL()</function> statements to their own
+       object with a unique name.
+       This is why several systems have separate exporting objects,
+       usually suffixed with ksyms.
+      </para>
+     </caution>
     </para>
    </listitem>
 
Index: 11-pre4.2/Documentation/DocBook/tulip-user.tmpl
--- 11-pre4.2/Documentation/DocBook/tulip-user.tmpl Sun, 22 Apr 2001 08:26:07 +1000 kaos (linux-2.4/b/e/20_tulip-user 1.1 644)
+++ 11-pre4.2(w)/Documentation/DocBook/tulip-user.tmpl Fri, 05 Oct 2001 18:15:12 +1000 kaos (linux-2.4/b/e/20_tulip-user 1.1 644)
@@ -90,7 +90,7 @@ For 2.4.x and later kernels, the Linux T
 
   </chapter>
 
-  <chapter id="drvr_compat">
+  <chapter id="drvr-compat">
     <title>Driver Compatibility</title>
 
 <para>
@@ -111,7 +111,7 @@ increasing in the operational critical p
 </para>
   </chapter>
 
-  <chapter id="board_settings">
+  <chapter id="board-settings">
     <title>Board-specific Settings</title>
 
 <para>
@@ -129,7 +129,7 @@ autonegotiation.
 </para>
   </chapter>
 
-  <chapter id="driver_operation">
+  <chapter id="driver-operation">
     <title>Driver Operation</title>
 
 <sect1><title>Ring buffers</title>
Index: 11-pre4.2/Documentation/DocBook/Makefile
--- 11-pre4.2/Documentation/DocBook/Makefile Tue, 18 Sep 2001 13:43:44 +1000 kaos (linux-2.4/V/c/11_Makefile 1.2.1.1.1.1.1.4 644)
+++ 11-pre4.2(w)/Documentation/DocBook/Makefile Fri, 05 Oct 2001 18:15:37 +1000 kaos (linux-2.4/V/c/11_Makefile 1.2.1.1.1.1.1.4 644)
@@ -141,17 +141,18 @@ LOG	:=	$(patsubst %.sgml, %.log, $(BOOKS
 OUT	:=	$(patsubst %.sgml, %.out, $(BOOKS))
 
 clean:
-	-$(RM) core *~
-	-$(RM) $(BOOKS)
-	-$(RM) $(DVI) $(AUX) $(TEX) $(LOG) $(OUT)
-	-$(RM) $(JPG-parportbook) $(EPS-parportbook)
-	-$(RM) $(C-procfs-example)
+	rm -f core *~
+	rm -f $(BOOKS)
+	rm -f $(DVI) $(AUX) $(TEX) $(LOG) $(OUT)
+	rm -f $(JPG-parportbook) $(EPS-parportbook)
+	rm -f $(C-procfs-example)
 
 mrproper: clean
-	-$(RM) $(PS) $(PDF)
-	-$(RM) -r $(HTML)
-	-$(RM) .depend
-	-$(RM) $(TOPDIR)/scripts/mkdep-docbook
+	rm -f $(PS) $(PDF)
+	rm -f -r $(HTML)
+	rm -f .depend
+	rm -f $(TOPDIR)/scripts/mkdep-docbook
+	rm -rf DBTOHTML_OUTPUT*
 
 %.ps : %.sgml
 	@(which db2ps > /dev/null 2>&1) || \
@@ -169,7 +170,7 @@ mrproper: clean
 	@(which db2html > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
-	-$(RM) -r $@
+	rm -rf $@
 	db2html $<
 	if [ ! -z "$(JPG-$@)" ]; then cp $(JPG-$@) $@; fi
 

