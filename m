Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWIYSiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWIYSiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWIYSg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:36:29 -0400
Received: from [198.99.130.12] ([198.99.130.12]:53652 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751439AbWIYSgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:36:03 -0400
Message-Id: <200609251834.k8PIYftQ005046@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Paolo Giarrusso <blaisorblade@yahoo.it>, Matt Mackall <mpm@selenic.com>,
       Joern Engel <joern@wohnheim.fh-wedel.de>
Subject: [PATCH 6/8] UML - Add checkstack support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Sep 2006 14:34:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make checkstack work for UML.  We need to pass the underlying architecture
name, rather than "um" to checkstack.pl.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/Makefile
===================================================================
--- linux-2.6.18-mm.orig/Makefile	2006-09-22 11:34:57.000000000 -0400
+++ linux-2.6.18-mm/Makefile	2006-09-22 11:35:38.000000000 -0400
@@ -1333,9 +1333,13 @@ endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
 
 PHONY += checkstack kernelrelease kernelversion
+
+# Use $(SUBARCH) here instead of $(ARCH) so that this works for UML.
+# In the UML case, $(SUBARCH) is the name of the underlying
+# architecture, while for all other arches, it is the same as $(ARCH).
 checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
-	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
+	$(PERL) $(src)/scripts/checkstack.pl $(SUBARCH)
 
 kernelrelease:
 	$(if $(wildcard include/config/kernel.release), $(Q)echo $(KERNELRELEASE), \

