Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSJLPLI>; Sat, 12 Oct 2002 11:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbSJLPLI>; Sat, 12 Oct 2002 11:11:08 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:22694 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261246AbSJLPLH>; Sat, 12 Oct 2002 11:11:07 -0400
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH] 2.5.42: UML build error
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Sat, 12 Oct 2002 17:16:35 +0200
Message-ID: <877kgn7kmk.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building 2.5.42 UML it fails with:

make -C arch/um/sys-i386/util mk_sc
  gcc -Wp,-MD,./.mk_sc.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -c -o mk_sc
.o mk_sc.c
/bin/sh: scripts/fixdep: No such file or directory
make[1]: *** [mk_sc.o] Error 1
make[1]: Target `mk_sc' not remade because of errors.
make: *** [arch/um/sys-i386/util/mk_sc] Error 2

This patch readds the path to scripts/fixdep in Rules.make. It doesn't
break _my_ regular build, but I can't tell for others.

diff -urN a/Rules.make b/Rules.make
--- a/Rules.make	Sat Oct 12 14:24:11 2002
+++ b/Rules.make	Sat Oct 12 16:45:47 2002
@@ -561,7 +561,7 @@
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) \
 	$(cmd_$(1)); \
-	scripts/fixdep $(depfile) $@ '$(cmd_$(1))' > $(@D)/.$(@F).tmp; \
+	$(TOPDIR)/scripts/fixdep $(depfile) $@ '$(cmd_$(1))' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)
 
