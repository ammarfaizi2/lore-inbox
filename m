Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSGXV1H>; Wed, 24 Jul 2002 17:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSGXV1G>; Wed, 24 Jul 2002 17:27:06 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:51982 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317580AbSGXV1C>;
	Wed, 24 Jul 2002 17:27:02 -0400
Date: Wed, 24 Jul 2002 23:37:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] docbook: Update documentation to reflect new docproc [7/9]
Message-ID: <20020724233732.F12782@mars.ravnborg.org>
References: <20020724232021.A12622@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020724232021.A12622@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Jul 24, 2002 at 11:20:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.437   -> 1.438  
#	Documentation/DocBook/kernel-api.tmpl	1.16    -> 1.17   
#	Documentation/DocBook/parportbook.tmpl	1.5     -> 1.6    
#	Documentation/kernel-doc-nano-HOWTO.txt	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	sam@mars.ravnborg.org	1.438
# [PATCH] docbook: Update documentation to reflect new docproc [7/9]
# kernel-doc-nano-HOWTO.txt updated to reflect new functionality
# provided by docproc. 
# gen-all-syms and docgen description removed.
# kernel-api.tmpl and parportbook.tmpl updated to specify files to search
# for EXPORT-SYMBOL* to enable documentation of all relevant functions.
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl	Wed Jul 24 23:03:18 2002
+++ b/Documentation/DocBook/kernel-api.tmpl	Wed Jul 24 23:03:18 2002
@@ -50,7 +50,7 @@
   kernel/sched.c has no docs, which stuffs up the sgml.  Comment
   out until somebody adds docs.  KAO
      <sect1><title>Delaying, scheduling, and timer routines</title>
-!Ekernel/sched.c
+X!Ekernel/sched.c
      </sect1>
 KAO -->
   </chapter>
@@ -367,7 +367,7 @@
   drivers/video/fbgen.c has no docs, which stuffs up the sgml.  Comment
   out until somebody adds docs.  KAO
      <sect1><title>Frame Buffer Generic Functions</title>
-!Idrivers/video/fbgen.c
+X!Idrivers/video/fbgen.c
      </sect1>
 KAO -->
      <sect1><title>Frame Buffer Video Mode Database</title>
@@ -381,5 +381,9 @@
 !Idrivers/video/fonts.c
      </sect1>
   </chapter>
-
+<!-- Needs ksyms to list additional exported symbols, but no specific doc.
+     docproc do not care about sgml commants.
+!Dkernel/ksyms.c
+!Dnet/netsyms.c
+-->
 </book>
diff -Nru a/Documentation/DocBook/parportbook.tmpl b/Documentation/DocBook/parportbook.tmpl
--- a/Documentation/DocBook/parportbook.tmpl	Wed Jul 24 23:03:18 2002
+++ b/Documentation/DocBook/parportbook.tmpl	Wed Jul 24 23:03:18 2002
@@ -2729,7 +2729,9 @@
  </appendix>
 
 </book>
-
+<!-- Additional function to be documented:
+!Ddrivers/parport/init.c
+-->
 <!-- Local Variables: -->
 <!-- sgml-indent-step: 1 -->
 <!-- sgml-indent-data: 1 -->
diff -Nru a/Documentation/kernel-doc-nano-HOWTO.txt b/Documentation/kernel-doc-nano-HOWTO.txt
--- a/Documentation/kernel-doc-nano-HOWTO.txt	Wed Jul 24 23:03:18 2002
+++ b/Documentation/kernel-doc-nano-HOWTO.txt	Wed Jul 24 23:03:18 2002
@@ -20,18 +20,14 @@
 - scripts/docproc.c
 
   This is a program for converting SGML template files into SGML
-  files.  It invokes kernel-doc, giving it the list of functions that
+  files. When a file is referenced it is searched for symbols
+  exported (EXPORT_SYMBOL), to be able to distingush between internal
+  and external functions.
+  It invokes kernel-doc, giving it the list of functions that
   are to be documented.
-
-- scripts/gen-all-syms
-
-  This is a script that lists the EXPORT_SYMBOL symbols in a list of C
-  files.
-
-- scripts/docgen
-
-  This script invokes docproc, telling it which functions are to be
-  documented (this list comes from gen-all-syms).
+  Additionally it is used to scan the SGML template files to locate
+  all the files referenced herein. This is used to generate dependency
+  information as used by make.
 
 - Makefile
 
@@ -141,6 +137,10 @@
 
 !I<filename> is replaced by the documentation for functions that are
 _not_ exported using EXPORT_SYMBOL.
+
+!D<filename> is used to name additional files to search for functions
+exported using EXPORT_SYMBOL. For example many symbols are only exported
+in kernel/ksyms.c, therefore kernel-api.sgml include this file with !D.
 
 !F<filename> <function [functions...]> is replaced by the
 documentation, in <filename>, for the functions listed.
