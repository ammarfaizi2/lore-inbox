Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266173AbTAFED2>; Sun, 5 Jan 2003 23:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbTAFEDX>; Sun, 5 Jan 2003 23:03:23 -0500
Received: from dp.samba.org ([66.70.73.150]:35552 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266043AbTAFEDO>;
	Sun, 5 Jan 2003 23:03:14 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] [PATCH 1 of 3] Fix errors making Docbook documentation
Date: Mon, 06 Jan 2003 14:47:32 +1100
Message-Id: <20030106041150.EBCA42C26D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Craig Wilkie <craig@homerjay.homelinux.org>

  The attached patch (against 2.5.53) modifies the following files: -
  
  Documentation/Docbook/Makefile - Fix dependencies generating parportbook 
  which caused tex to choke.
  
  Documentation/Docbook/kernel-api.tmpl - Remove references to source 
  files which do not contain kernel-doc comments, which caused "errors" in 
  the generated documentation.
  
  include/linux/init.h - fix a trivial function comment to correct the 
  generated documentation.
  
  This patch partially addresses one of the issues on the Kernel Janitor 
  TODO list -
  
  "someone who knows DocBook, or is willing to learn, should go through 
  and clean up Documentation/DocBook to kill all the warnings that occur 
  during "make pdfdocs" and generally make the documents look nicer, and 
  render smaller PDFs."
  
  Cheers.
  
  -- 
  Craig Wilkie

--- trivial-2.5-bk/Documentation/DocBook/Makefile.orig	2003-01-06 14:08:33.000000000 +1100
+++ trivial-2.5-bk/Documentation/DocBook/Makefile	2003-01-06 14:08:33.000000000 +1100
@@ -90,7 +90,7 @@
 EPS-parportbook := $(patsubst %.fig,%.eps, $(IMG-parportbook2))
 PNG-parportbook := $(patsubst %.fig,%.png, $(IMG-parportbook2))
 $(obj)/parportbook.html: $(PNG-parportbook)
-$(obj)/parportbook.ps $(obj)/parportbook.pdf: $(EPS-parportbook)
+$(obj)/parportbook.ps $(obj)/parportbook.pdf: $(EPS-parportbook) $(PNG-parportbook)
 
 ###
 # Rules to generate postscript, PDF and HTML
--- trivial-2.5-bk/Documentation/DocBook/kernel-api.tmpl.orig	2003-01-06 14:08:33.000000000 +1100
+++ trivial-2.5-bk/Documentation/DocBook/kernel-api.tmpl	2003-01-06 14:08:33.000000000 +1100
@@ -150,7 +150,12 @@
 !Ekernel/kmod.c
      </sect1>
      <sect1><title>Inter Module support</title>
-!Ekernel/module.c
+        <para>
+           Refer to the file kernel/module.c for more information.
+        </para>
+<!-- FIXME: Removed for now since no structured comments in source
+X!Ekernel/module.c
+-->
      </sect1>
   </chapter>
 
@@ -172,7 +177,12 @@
      </sect1>
      <sect1><title>MCA Architecture</title>
 	<sect2><title>MCA Device Functions</title>
-!Earch/i386/kernel/mca.c
+           <para>
+              Refer to the file arch/i386/kernel/mca.c for more information.
+           </para>
+<!-- FIXME: Removed for now since no structured comments in source
+X!Earch/i386/kernel/mca.c
+-->
 	</sect2>
 	<sect2><title>MCA Bus DMA</title>
 !Iinclude/asm-i386/mca_dma.h
@@ -213,7 +223,9 @@
   <chapter id="snddev">
      <title>Sound Devices</title>
 !Esound/sound_core.c
-!Isound/sound_firmware.c
+<!-- FIXME: Removed for now since no structured comments in source
+X!Isound/sound_firmware.c
+-->
   </chapter>
 
   <chapter id="usb">
@@ -292,7 +304,9 @@
 
     <sect1><title>USB Core APIs</title>
 !Edrivers/usb/core/urb.c
-!Edrivers/usb/core/config.c
+<!-- FIXME: Removed for now since no structured comments in source
+X!Edrivers/usb/core/config.c
+-->
 !Edrivers/usb/core/message.c
 !Edrivers/usb/core/file.c
 !Edrivers/usb/core/usb.c
@@ -385,7 +399,12 @@
 !Idrivers/video/macmodes.c
      </sect1>
      <sect1><title>Frame Buffer Fonts</title>
-!Idrivers/video/console/fonts.c
+        <para>
+           Refer to the file drivers/video/console/fonts.c for more information.
+        </para>
+<!-- FIXME: Removed for now since no structured comments in source
+X!Idrivers/video/console/fonts.c
+-->
      </sect1>
   </chapter>
 <!-- Needs ksyms to list additional exported symbols, but no specific doc.
--- trivial-2.5-bk/include/linux/init.h.orig	2003-01-06 14:08:33.000000000 +1100
+++ trivial-2.5-bk/include/linux/init.h	2003-01-06 14:08:33.000000000 +1100
@@ -111,7 +111,8 @@
  * 
  * module_init() will either be called during do_initcalls (if
  * builtin) or at module insertion time (if a module).  There can only
- * be one per module. */
+ * be one per module.
+ */
 #define module_init(x)	__initcall(x);
 
 /**
-- 
  Don't blame me: the Monkey is driving
  File: Craig Wilkie <craig@homerjay.homelinux.org>: [PATCH 1 of 3] Fix errors making Docbook documentation
