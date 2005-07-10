Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVGJUCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVGJUCC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVGJUBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 16:01:48 -0400
Received: from mta04.mail.t-online.hu ([195.228.240.57]:38880 "EHLO
	mta04.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261652AbVGJUBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 16:01:25 -0400
Subject: [PATCH 3/3] kconfig: linux.pot for all arch
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Content-Type: text/plain
Date: Sun, 10 Jul 2005 22:01:19 +0200
Message-Id: <1121025679.3008.10.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 'make update-po-config' creates the .pot file for the
default arch. This patch enhances it with all arch.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>

---

 Makefile |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff -Nru linux-2.6.13-rc2/scripts/kconfig/Makefile
linux-2.6.13-rc2-i18n-kconfig/scripts/kconfig/Makefile
--- linux-2.6.13-rc2/scripts/kconfig/Makefile	2005-07-09
12:16:04.000000000 +0200
+++ linux-2.6.13-rc2-i18n-kconfig/scripts/kconfig/Makefile	2005-07-10
21:13:00.000000000 +0200
@@ -27,8 +27,20 @@
 	xgettext --default-domain=linux \
           --add-comments --keyword=_ --keyword=N_ \
           --files-from=scripts/kconfig/POTFILES.in \
-	-o scripts/kconfig/linux.pot
-	scripts/kconfig/kxgettext arch/$(ARCH)/Kconfig >>
scripts/kconfig/linux.pot
+          --output scripts/kconfig/config.pot
+	$(Q)ln -fs Kconfig_i386 arch/um/Kconfig_arch
+	$(Q)for i in `ls arch/`; \
+	do \
+	  scripts/kconfig/kxgettext arch/$$i/Kconfig \
+	    | msguniq -o scripts/kconfig/linux_$${i}.pot; \
+	done
+	$(Q)msgcat scripts/kconfig/config.pot \
+	  `find scripts/kconfig/ -type f -name linux_*.pot` \
+	  --output scripts/kconfig/linux_raw.pot
+	$(Q)msguniq --sort-by-file scripts/kconfig/linux_raw.pot \
+	    --output scripts/kconfig/linux.pot
+	$(Q)rm -f arch/um/Kconfig_arch
+	$(Q)rm -f scripts/kconfig/linux_*.pot scripts/kconfig/config.pot
 
 .PHONY: randconfig allyesconfig allnoconfig allmodconfig defconfig
 


