Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317938AbSFSQ4u>; Wed, 19 Jun 2002 12:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317939AbSFSQ4t>; Wed, 19 Jun 2002 12:56:49 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:21739 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317938AbSFSQ4s>; Wed, 19 Jun 2002 12:56:48 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 19 Jun 2002 09:56:41 -0700
Message-Id: <200206191656.JAA00313@baldur.yggdrasil.com>
To: kai@tp1.ruhr-uni-bochum.de
Subject: Patch: linux-2.5.23/Rules.make - enable modversions.h to build even if some files do not compile
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The following patch enables "make include/linux/modversions.h" to
complete even if some symbol exporting files do not pass gcc, due
to #error statements.  This problem had absorbed at least an hour a
day as I commented out #error lines or Makefile lines and worked
around the problem, which only interferes with my ability to later
see which drivers still do not compile.

	I could live with a patch that only allowed modversions.h
to build in these circumstances with "make -k".

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.23/Rules.make	2002-06-18 19:11:52.000000000 -0700
+++ linux/Rules.make	2002-06-19 02:53:38.000000000 -0700
@@ -165,7 +165,7 @@
 define rule_cc_ver_c
 	$(if $($(quiet)cmd_cc_ver_c),echo '  $($(quiet)cmd_cc_ver_c)';) \
 	$(cmd_cc_ver_c); \
-	if [ ! -r $(depfile) ]; then exit 1; fi; \
+	if [ ! -r $(depfile) ]; then touch $(depfile); fi; \
 	$(TOPDIR)/scripts/fixdep $(depfile) $@ $(TOPDIR) '$(cmd_cc_ver_c)' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	if [ ! -r $@ ] || cmp -s $@ $@.tmp; then \
