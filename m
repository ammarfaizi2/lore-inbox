Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVCCKuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVCCKuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVCCKtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:49:11 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:9652 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261572AbVCCKmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:42:54 -0500
Date: Thu, 3 Mar 2005 11:42:43 +0100
Message-Id: <200503031042.j23Aghhj020757@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 11/16] DocBook: s/sgml/xml/ in Documentation/DocBook/Makefile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: s/sgml/xml/ in Documentation/DocBook/Makefile
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2035  -> 1.2036 
#	Documentation/DocBook/Makefile	1.50    -> 1.51   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/02/08	tali@admingilde.org	1.2036
# DocBook: s/sgml/xml/ in Documentation/DocBook/Makefile
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Thu Mar  3 11:42:47 2005
+++ b/Documentation/DocBook/Makefile	Thu Mar  3 11:42:47 2005
@@ -6,38 +6,39 @@
 # To add a new book the only step required is to add the book to the
 # list of DOCBOOKS.
 
-DOCBOOKS := wanbook.sgml z8530book.sgml mcabook.sgml videobook.sgml \
-	    kernel-hacking.sgml kernel-locking.sgml via-audio.sgml \
-	    deviceiobook.sgml procfs-guide.sgml tulip-user.sgml \
-	    writing_usb_driver.sgml scsidrivers.sgml sis900.sgml \
-	    kernel-api.sgml journal-api.sgml lsm.sgml usb.sgml \
-	    gadget.sgml libata.sgml mtdnand.sgml librs.sgml
+DOCBOOKS := wanbook.xml z8530book.xml mcabook.xml videobook.xml \
+	    kernel-hacking.xml kernel-locking.xml via-audio.xml \
+	    deviceiobook.xml procfs-guide.xml tulip-user.xml \
+	    writing_usb_driver.xml scsidrivers.xml sis900.xml \
+	    kernel-api.xml journal-api.xml lsm.xml usb.xml \
+	    gadget.xml libata.xml mtdnand.xml librs.xml
 
 ###
 # The build process is as follows (targets):
-#              (sgmldocs)
-# file.tmpl --> file.sgml +--> file.ps  (psdocs)
-#                         +--> file.pdf  (pdfdocs)
-#                         +--> DIR=file  (htmldocs)
-#                         +--> man/      (mandocs)
+#              (xmldocs)
+# file.tmpl --> file.xml +--> file.ps   (psdocs)
+#                        +--> file.pdf  (pdfdocs)
+#                        +--> DIR=file  (htmldocs)
+#                        +--> man/      (mandocs)
 
 ###
 # The targets that may be used.
-.PHONY:	sgmldocs psdocs pdfdocs htmldocs mandocs installmandocs
+.PHONY:	xmldocs sgmldocs psdocs pdfdocs htmldocs mandocs installmandocs
 
 BOOKS := $(addprefix $(obj)/,$(DOCBOOKS))
-sgmldocs: $(BOOKS)
+xmldocs: $(BOOKS)
+sgmldocs: xmldocs
 
-PS := $(patsubst %.sgml, %.ps, $(BOOKS))
+PS := $(patsubst %.xml, %.ps, $(BOOKS))
 psdocs: $(PS)
 
-PDF := $(patsubst %.sgml, %.pdf, $(BOOKS))
+PDF := $(patsubst %.xml, %.pdf, $(BOOKS))
 pdfdocs: $(PDF)
 
-HTML := $(patsubst %.sgml, %.html, $(BOOKS))
+HTML := $(patsubst %.xml, %.html, $(BOOKS))
 htmldocs: $(HTML)
 
-MAN := $(patsubst %.sgml, %.9, $(BOOKS))
+MAN := $(patsubst %.xml, %.9, $(BOOKS))
 mandocs: $(MAN)
 
 installmandocs: mandocs
@@ -55,7 +56,7 @@
 # 1) To generate a dependency list for a .tmpl file
 # 2) To preprocess a .tmpl file and call kernel-doc with
 #     appropriate parameters.
-# The following rules are used to generate the .sgml documentation
+# The following rules are used to generate the .xml documentation
 # required to generate the final targets. (ps, pdf, html).
 quiet_cmd_docproc = DOCPROC $@
       cmd_docproc = SRCTREE=$(srctree)/ $(DOCPROC) doc $< >$@
@@ -69,7 +70,7 @@
         ) > $(dir $@).$(notdir $@).cmd
 endef
 
-%.sgml: %.tmpl FORCE
+%.xml: %.tmpl FORCE
 	$(call if_changed_rule,docproc)
 
 ###
@@ -87,9 +88,9 @@
 ###
 # procfs guide uses a .c file as example code.
 # This requires an explicit dependency
-C-procfs-example = procfs_example.sgml
+C-procfs-example = procfs_example.xml
 C-procfs-example2 = $(addprefix $(obj)/,$(C-procfs-example))
-$(obj)/procfs-guide.sgml: $(C-procfs-example2)
+$(obj)/procfs-guide.xml: $(C-procfs-example2)
 
 ###
 # Rules to generate postscript, PDF and HTML
@@ -97,7 +98,7 @@
 
 quiet_cmd_db2ps = DB2PS   $@
       cmd_db2ps = db2ps -o $(dir $@) $<
-%.ps : %.sgml
+%.ps : %.xml
 	@(which db2ps > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
@@ -105,7 +106,7 @@
 
 quiet_cmd_db2pdf = DB2PDF  $@
       cmd_db2pdf = db2pdf -o $(dir $@) $<
-%.pdf : %.sgml
+%.pdf : %.xml
 	@(which db2pdf > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
@@ -116,7 +117,7 @@
 		echo '<a HREF="$(patsubst %.html,%,$(notdir $@))/book1.html"> \
          Goto $(patsubst %.html,%,$(notdir $@))</a><p>' > $@
 
-%.html:	%.sgml
+%.html:	%.xml
 	@(which db2html > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
@@ -128,7 +129,7 @@
 ###
 # Rule to generate man files - output is placed in the man subdirectory
 
-%.9:	%.sgml
+%.9:	%.xml
 ifneq ($(KBUILD_SRC),)
 	$(Q)mkdir -p $(objtree)/Documentation/DocBook/man
 endif
@@ -156,8 +157,8 @@
 	$(call cmd,fig2png)
 
 ###
-# Rule to convert a .c file to inline SGML documentation
-%.sgml: %.c
+# Rule to convert a .c file to inline XML documentation
+%.xml: %.c
 	@echo '  GEN     $@'
 	@(                            \
 	   echo "<programlisting>";   \
@@ -171,24 +172,24 @@
 # Help targets as used by the top-level makefile
 dochelp:
 	@echo  '  Linux kernel internal documentation in different formats:'
-	@echo  '  sgmldocs (SGML), psdocs (Postscript), pdfdocs (PDF)'
+	@echo  '  xmldocs (XML DocBook), psdocs (Postscript), pdfdocs (PDF)'
 	@echo  '  htmldocs (HTML), mandocs (man pages, use installmandocs to install)'
 
 ###
 # Temporary files left by various tools
 clean-files := $(DOCBOOKS) \
-	$(patsubst %.sgml, %.dvi,  $(DOCBOOKS)) \
-	$(patsubst %.sgml, %.aux,  $(DOCBOOKS)) \
-	$(patsubst %.sgml, %.tex,  $(DOCBOOKS)) \
-	$(patsubst %.sgml, %.log,  $(DOCBOOKS)) \
-	$(patsubst %.sgml, %.out,  $(DOCBOOKS)) \
-	$(patsubst %.sgml, %.ps,   $(DOCBOOKS)) \
-	$(patsubst %.sgml, %.pdf,  $(DOCBOOKS)) \
-	$(patsubst %.sgml, %.html, $(DOCBOOKS)) \
-	$(patsubst %.sgml, %.9,    $(DOCBOOKS)) \
+	$(patsubst %.xml, %.dvi,  $(DOCBOOKS)) \
+	$(patsubst %.xml, %.aux,  $(DOCBOOKS)) \
+	$(patsubst %.xml, %.tex,  $(DOCBOOKS)) \
+	$(patsubst %.xml, %.log,  $(DOCBOOKS)) \
+	$(patsubst %.xml, %.out,  $(DOCBOOKS)) \
+	$(patsubst %.xml, %.ps,   $(DOCBOOKS)) \
+	$(patsubst %.xml, %.pdf,  $(DOCBOOKS)) \
+	$(patsubst %.xml, %.html, $(DOCBOOKS)) \
+	$(patsubst %.xml, %.9,    $(DOCBOOKS)) \
 	$(C-procfs-example)
 
-clean-dirs := $(patsubst %.sgml,%,$(DOCBOOKS))
+clean-dirs := $(patsubst %.xml,%,$(DOCBOOKS))
 
 #man put files in man subdir - traverse down
 subdir- := man/
