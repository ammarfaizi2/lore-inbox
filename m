Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbRCCSQ2>; Sat, 3 Mar 2001 13:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129661AbRCCSQT>; Sat, 3 Mar 2001 13:16:19 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:30094 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129657AbRCCSQL>; Sat, 3 Mar 2001 13:16:11 -0500
Message-ID: <3AA13505.62109EEC@uow.edu.au>
Date: Sun, 04 Mar 2001 05:16:37 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] 2.4.3-pre1 dependencies are broken
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mkdep has got itself a new feature, but the makefiles haven't
been updated.

We're getting zero-length .depend files.

I assume something like this was intended:



--- linux-2.4.3-pre1/Makefile	Sat Mar  3 20:52:23 2001
+++ linux-akpm/Makefile	Sun Mar  4 05:13:01 2001
@@ -440,8 +440,8 @@
 	find . -type f -print | sort | xargs sum > .SUMS
 
 dep-files: scripts/mkdep archdep include/linux/version.h
-	scripts/mkdep init/*.c > .depend
-	scripts/mkdep `find $(FINDHPATH) -name SCCS -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
+	scripts/mkdep -- init/*.c > .depend
+	scripts/mkdep -- `find $(FINDHPATH) -name SCCS -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
 	$(MAKE) $(patsubst %,_sfdep_%,$(SUBDIRS)) _FASTDEP_ALL_SUB_DIRS="$(SUBDIRS)"
 ifdef CONFIG_MODVERSIONS
 	$(MAKE) update-modverfile
--- linux-2.4.3-pre1/Rules.make	Sat Dec 30 09:07:19 2000
+++ linux-akpm/Rules.make	Sun Mar  4 05:11:25 2001
@@ -123,7 +123,7 @@
 # This make dependencies quickly
 #
 fastdep: dummy
-	$(TOPDIR)/scripts/mkdep $(wildcard *.[chS] local.h.master) > .depend
+	$(TOPDIR)/scripts/mkdep -- $(wildcard *.[chS] local.h.master) > .depend
 ifdef ALL_SUB_DIRS
 	$(MAKE) $(patsubst %,_sfdep_%,$(ALL_SUB_DIRS)) _FASTDEP_ALL_SUB_DIRS="$(ALL_SUB_DIRS)"
 endif
