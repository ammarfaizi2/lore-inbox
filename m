Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVGMRXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVGMRXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVGMRVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:21:33 -0400
Received: from mta02.mail.t-online.hu ([195.228.240.51]:29942 "EHLO
	mta02.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261166AbVGMRSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:18:37 -0400
Subject: [PATCH 8/19] Kconfig I18N: gconfig: GUI
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 19:18:29 +0200
Message-Id: <1121275109.2975.27.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I18N support for menu and toolbar.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/Makefile    |    7 +++++--
 scripts/kconfig/POTFILES.in |    1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff -puN scripts/kconfig/POTFILES.in~kconfig-i18n-08-gconfig-gui scripts/kconfig/POTFILES.in
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/POTFILES.in~kconfig-i18n-08-gconfig-gui	2005-07-13 18:32:17.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/POTFILES.in	2005-07-13 18:32:17.000000000 +0200
@@ -10,4 +10,5 @@ scripts/kconfig/mconf.c
 scripts/kconfig/conf.c
 scripts/kconfig/confdata.c
 scripts/kconfig/gconf.c
+scripts/kconfig/gconf.glade.h
 scripts/kconfig/qconf.cc
diff -puN scripts/kconfig/Makefile~kconfig-i18n-08-gconfig-gui scripts/kconfig/Makefile
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/Makefile~kconfig-i18n-08-gconfig-gui	2005-07-13 18:32:17.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/Makefile	2005-07-13 18:32:17.000000000 +0200
@@ -29,7 +29,7 @@ silentoldconfig: $(obj)/conf
 	$(Q)sh $(obj)/set_locale.sh
 	$< -s arch/$(ARCH)/Kconfig
 
-update-po-config: $(obj)/kxgettext
+update-po-config: $(obj)/kxgettext $(obj)/gconf.glade.h
 	xgettext --default-domain=linux \
           --add-comments --keyword=_ --keyword=N_ \
           --files-from=scripts/kconfig/POTFILES.in \
@@ -108,7 +108,8 @@ gconf-objs	:= gconf.o kconfig_load.o zco
 endif
 
 clean-files	:= lkc_defs.h qconf.moc .tmp_qtcheck \
-		   .tmp_gtkcheck zconf.tab.c zconf.tab.h lex.zconf.c
+		   .tmp_gtkcheck zconf.tab.c zconf.tab.h lex.zconf.c \
+		   gconf.glade.h
 
 # generated files seem to need this to find local include files
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
@@ -201,6 +202,8 @@ $(obj)/%.moc: $(src)/%.h
 $(obj)/lkc_defs.h: $(src)/lkc_proto.h
 	sed < $< > $@ 's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'
 
+$(obj)/gconf.glade.h: $(obj)/gconf.glade
+	intltool-extract --type=gettext/glade $(obj)/gconf.glade
 
 ###
 # The following requires flex/bison
_


