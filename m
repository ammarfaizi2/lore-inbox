Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbWHJBzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWHJBzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030520AbWHJBzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:55:36 -0400
Received: from [198.99.130.12] ([198.99.130.12]:47580 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030448AbWHJBzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:55:35 -0400
Message-Id: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Matt Mackall <mpm@selenic.com>,
       Joern Engel <joern@wohnheim.fh-wedel.de>
Subject: [PATCH] UML - support checkstack
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Aug 2006 14:15:24 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make checkstack work for UML.  We need to pass the underlying architecture
name, rather than "um" to checkstack.pl.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/Makefile
===================================================================
--- linux-2.6.18-mm.orig/Makefile	2006-08-07 13:49:52.000000000 -0400
+++ linux-2.6.18-mm/Makefile	2006-08-07 13:53:34.000000000 -0400
@@ -1315,9 +1315,13 @@ endif #ifeq ($(config-targets),1)
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

