Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTJWVjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJWVjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:39:49 -0400
Received: from mail.gmx.de ([213.165.64.20]:48560 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261801AbTJWVjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:39:44 -0400
X-Authenticated: #20450766
Date: Thu, 23 Oct 2003 23:36:17 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] NLS as module
Message-ID: <Pine.LNX.4.44.0310232155320.3344-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Problem: NLS support can only be compiled in the kernel - and not as a
module. And if you don't configure one of Joliet / FAT and some other
filesystems at kernel compile-time, you can't compile these filesystems
later as modules(*). However, I see nothing that would prevent one from
compiling nls_base as a module. I tried - it worked, but I didn't actually
use any of the codepages. Just tried insmod nls_base, insmod <fs>, mount.
So, is it desired / really this trivial or are there some real reasons why
nls_base cannot be properly done as a module? I am attaching a naive
patch - but not really understanding NLS internals and not being able to
extensively test it, it might be not quite correct.

(*) This question has come up before - whether or not it is desirable to
be able to add modules to an existing kernel in the IPV6 context, IIRC.

Thanks
Guennadi
---
Guennadi Liakhovetski

diff -u linux-2.4.19-rmk7-tux1/fs/nls/Config.in linux-2.4.19-rmk7-tux1-rthal/fs/nls/Config.in
--- linux-2.4.19-rmk7-tux1/fs/nls/Config.in	Tue May 21 22:18:00 2002
+++ linux-2.4.19-rmk7-tux1-rthal/fs/nls/Config.in	Thu Oct 23 23:21:04 2003
@@ -10,54 +10,54 @@
 fi

 # msdos and Joliet want NLS
-if [ "$CONFIG_JOLIET" = "y" -o "$CONFIG_FAT_FS" != "n" \
-	-o "$CONFIG_NTFS_FS" != "n" -o "$CONFIG_NCPFS_NLS" = "y" \
+if [ "$CONFIG_JOLIET" = "y" -o "$CONFIG_FAT_FS" = "y" \
+	-o "$CONFIG_NTFS_FS" = "y" -o "$CONFIG_NCPFS_NLS" = "y" \
 	-o "$CONFIG_SMB_NLS" = "y" ]; then
   define_bool CONFIG_NLS y
 else
-  define_bool CONFIG_NLS n
+  tristate 'Base NLS support'	CONFIG_NLS
 fi

-if [ "$CONFIG_NLS" = "y" ]; then
+if [ "$CONFIG_NLS" != "n" ]; then
   mainmenu_option next_comment
   comment 'Native Language Support'
   string 'Default NLS Option' CONFIG_NLS_DEFAULT "iso8859-1"
-  tristate 'Codepage 437 (United States, Canada)'  CONFIG_NLS_CODEPAGE_437
-  tristate 'Codepage 737 (Greek)'                  CONFIG_NLS_CODEPAGE_737
-  tristate 'Codepage 775 (Baltic Rim)'             CONFIG_NLS_CODEPAGE_775
-  tristate 'Codepage 850 (Europe)'                 CONFIG_NLS_CODEPAGE_850
-  tristate 'Codepage 852 (Central/Eastern Europe)' CONFIG_NLS_CODEPAGE_852
-  tristate 'Codepage 855 (Cyrillic)'               CONFIG_NLS_CODEPAGE_855
-  tristate 'Codepage 857 (Turkish)'                CONFIG_NLS_CODEPAGE_857
-  tristate 'Codepage 860 (Portuguese)'             CONFIG_NLS_CODEPAGE_860
-  tristate 'Codepage 861 (Icelandic)'              CONFIG_NLS_CODEPAGE_861
-  tristate 'Codepage 862 (Hebrew)'                 CONFIG_NLS_CODEPAGE_862
-  tristate 'Codepage 863 (Canadian French)'        CONFIG_NLS_CODEPAGE_863
-  tristate 'Codepage 864 (Arabic)'                 CONFIG_NLS_CODEPAGE_864
-  tristate 'Codepage 865 (Norwegian, Danish)'      CONFIG_NLS_CODEPAGE_865
-  tristate 'Codepage 866 (Cyrillic/Russian)'       CONFIG_NLS_CODEPAGE_866
-  tristate 'Codepage 869 (Greek)'                  CONFIG_NLS_CODEPAGE_869
-  tristate 'Simplified Chinese charset (CP936, GB2312)' CONFIG_NLS_CODEPAGE_936
-  tristate 'Traditional Chinese charset (Big5)'    CONFIG_NLS_CODEPAGE_950
-  tristate 'Japanese charsets (Shift-JIS, EUC-JP)' CONFIG_NLS_CODEPAGE_932
-  tristate 'Korean charset (CP949, EUC-KR)'        CONFIG_NLS_CODEPAGE_949
-  tristate 'Thai charset (CP874, TIS-620)'         CONFIG_NLS_CODEPAGE_874
-  tristate 'Hebrew charsets (ISO-8859-8, CP1255)'  CONFIG_NLS_ISO8859_8
-  tristate 'Windows CP1250 (Slavic/Central European Languages)' CONFIG_NLS_CODEPAGE_1250
-  tristate 'Windows CP1251 (Bulgarian, Belarusian)' CONFIG_NLS_CODEPAGE_1251
-  tristate 'NLS ISO 8859-1  (Latin 1; Western European Languages)' CONFIG_NLS_ISO8859_1
-  tristate 'NLS ISO 8859-2  (Latin 2; Slavic/Central European Languages)' CONFIG_NLS_ISO8859_2
-  tristate 'NLS ISO 8859-3  (Latin 3; Esperanto, Galician, Maltese, Turkish)' CONFIG_NLS_ISO8859_3
-  tristate 'NLS ISO 8859-4  (Latin 4; old Baltic charset)' CONFIG_NLS_ISO8859_4
-  tristate 'NLS ISO 8859-5  (Cyrillic)'             CONFIG_NLS_ISO8859_5
-  tristate 'NLS ISO 8859-6  (Arabic)'               CONFIG_NLS_ISO8859_6
-  tristate 'NLS ISO 8859-7  (Modern Greek)'         CONFIG_NLS_ISO8859_7
-  tristate 'NLS ISO 8859-9  (Latin 5; Turkish)'     CONFIG_NLS_ISO8859_9
-  tristate 'NLS ISO 8859-13 (Latin 7; Baltic)'      CONFIG_NLS_ISO8859_13
-  tristate 'NLS ISO 8859-14 (Latin 8; Celtic)'      CONFIG_NLS_ISO8859_14
-  tristate 'NLS ISO 8859-15 (Latin 9; Western European Languages with Euro)' CONFIG_NLS_ISO8859_15
-  tristate 'NLS KOI8-R (Russian)'                   CONFIG_NLS_KOI8_R
-  tristate 'NLS KOI8-U/RU (Ukrainian, Belarusian)' CONFIG_NLS_KOI8_U
-  tristate 'NLS UTF8'                               CONFIG_NLS_UTF8
+  dep_tristate 'Codepage 437 (United States, Canada)'  CONFIG_NLS_CODEPAGE_437	$CONFIG_NLS
+  dep_tristate 'Codepage 737 (Greek)'                  CONFIG_NLS_CODEPAGE_737	$CONFIG_NLS
+  dep_tristate 'Codepage 775 (Baltic Rim)'             CONFIG_NLS_CODEPAGE_775	$CONFIG_NLS
+  dep_tristate 'Codepage 850 (Europe)'                 CONFIG_NLS_CODEPAGE_850	$CONFIG_NLS
+  dep_tristate 'Codepage 852 (Central/Eastern Europe)' CONFIG_NLS_CODEPAGE_852	$CONFIG_NLS
+  dep_tristate 'Codepage 855 (Cyrillic)'               CONFIG_NLS_CODEPAGE_855	$CONFIG_NLS
+  dep_tristate 'Codepage 857 (Turkish)'                CONFIG_NLS_CODEPAGE_857	$CONFIG_NLS
+  dep_tristate 'Codepage 860 (Portuguese)'             CONFIG_NLS_CODEPAGE_860	$CONFIG_NLS
+  dep_tristate 'Codepage 861 (Icelandic)'              CONFIG_NLS_CODEPAGE_861	$CONFIG_NLS
+  dep_tristate 'Codepage 862 (Hebrew)'                 CONFIG_NLS_CODEPAGE_862	$CONFIG_NLS
+  dep_tristate 'Codepage 863 (Canadian French)'        CONFIG_NLS_CODEPAGE_863	$CONFIG_NLS
+  dep_tristate 'Codepage 864 (Arabic)'                 CONFIG_NLS_CODEPAGE_864	$CONFIG_NLS
+  dep_tristate 'Codepage 865 (Norwegian, Danish)'      CONFIG_NLS_CODEPAGE_865	$CONFIG_NLS
+  dep_tristate 'Codepage 866 (Cyrillic/Russian)'       CONFIG_NLS_CODEPAGE_866	$CONFIG_NLS
+  dep_tristate 'Codepage 869 (Greek)'                  CONFIG_NLS_CODEPAGE_869	$CONFIG_NLS
+  dep_tristate 'Simplified Chinese charset (CP936, GB2312)' CONFIG_NLS_CODEPAGE_936	$CONFIG_NLS
+  dep_tristate 'Traditional Chinese charset (Big5)'    CONFIG_NLS_CODEPAGE_950	$CONFIG_NLS
+  dep_tristate 'Japanese charsets (Shift-JIS, EUC-JP)' CONFIG_NLS_CODEPAGE_932	$CONFIG_NLS
+  dep_tristate 'Korean charset (CP949, EUC-KR)'        CONFIG_NLS_CODEPAGE_949	$CONFIG_NLS
+  dep_tristate 'Thai charset (CP874, TIS-620)'         CONFIG_NLS_CODEPAGE_874	$CONFIG_NLS
+  dep_tristate 'Hebrew charsets (ISO-8859-8, CP1255)'  CONFIG_NLS_ISO8859_8	$CONFIG_NLS
+  dep_tristate 'Windows CP1250 (Slavic/Central European Languages)' CONFIG_NLS_CODEPAGE_1250	$CONFIG_NLS
+  dep_tristate 'Windows CP1251 (Bulgarian, Belarusian)' CONFIG_NLS_CODEPAGE_1251	$CONFIG_NLS
+  dep_tristate 'NLS ISO 8859-1  (Latin 1; Western European Languages)' CONFIG_NLS_ISO8859_1	$CONFIG_NLS
+  dep_tristate 'NLS ISO 8859-2  (Latin 2; Slavic/Central European Languages)' CONFIG_NLS_ISO8859_2	$CONFIG_NLS
+  dep_tristate 'NLS ISO 8859-3  (Latin 3; Esperanto, Galician, Maltese, Turkish)' CONFIG_NLS_ISO8859_3	$CONFIG_NLS
+  dep_tristate 'NLS ISO 8859-4  (Latin 4; old Baltic charset)' CONFIG_NLS_ISO8859_4	$CONFIG_NLS
+  dep_tristate 'NLS ISO 8859-5  (Cyrillic)'             CONFIG_NLS_ISO8859_5	$CONFIG_NLS
+  dep_tristate 'NLS ISO 8859-6  (Arabic)'               CONFIG_NLS_ISO8859_6	$CONFIG_NLS
+  dep_tristate 'NLS ISO 8859-7  (Modern Greek)'         CONFIG_NLS_ISO8859_7	$CONFIG_NLS
+  dep_tristate 'NLS ISO 8859-9  (Latin 5; Turkish)'     CONFIG_NLS_ISO8859_9	$CONFIG_NLS
+  dep_tristate 'NLS ISO 8859-13 (Latin 7; Baltic)'      CONFIG_NLS_ISO8859_13	$CONFIG_NLS
+  dep_tristate 'NLS ISO 8859-14 (Latin 8; Celtic)'      CONFIG_NLS_ISO8859_14	$CONFIG_NLS
+  dep_tristate 'NLS ISO 8859-15 (Latin 9; Western European Languages with Euro)' CONFIG_NLS_ISO8859_15	$CONFIG_NLS
+  dep_tristate 'NLS KOI8-R (Russian)'                   CONFIG_NLS_KOI8_R	$CONFIG_NLS
+  dep_tristate 'NLS KOI8-U/RU (Ukrainian, Belarusian)' CONFIG_NLS_KOI8_U	$CONFIG_NLS
+  dep_tristate 'NLS UTF8'                               CONFIG_NLS_UTF8	$CONFIG_NLS
   endmenu
 fi
diff -u linux-2.4.19-rmk7-tux1/fs/nls/Makefile linux-2.4.19-rmk7-tux1-rthal/fs/nls/Makefile
--- linux-2.4.19-rmk7-tux1/fs/nls/Makefile	Mon Nov 26 00:12:17 2001
+++ linux-2.4.19-rmk7-tux1-rthal/fs/nls/Makefile	Thu Oct 23 23:09:06 2003
@@ -2,10 +2,13 @@
 # Makefile for native language support
 #

-obj-y	:=	nls_base.o
+nls_base			:= nls_base.o
+
+obj-y	:=
 obj-m	:=
 obj-n	:=
 obj-	:=
+obj-$(CONFIG_NLS)		:= $(nls_base)

 obj-$(CONFIG_NLS_CODEPAGE_437)	+= nls_cp437.o
 obj-$(CONFIG_NLS_CODEPAGE_737)	+= nls_cp737.o
@@ -53,7 +56,7 @@
 obj-$(CONFIG_NLS_ABC)		+= nls_abc.o
 obj-$(CONFIG_NLS_UTF8)		+= nls_utf8.o

-export-objs = $(obj-y)
+export-objs = $(nls_base)

 O_TARGET = nls.o

diff -u linux-2.4.19-rmk7-tux1/fs/nls/nls_base.c linux-2.4.19-rmk7-tux1-rthal/fs/nls/nls_base.c
--- linux-2.4.19-rmk7-tux1/fs/nls/nls_base.c	Wed Nov 27 22:47:04 2002
+++ linux-2.4.19-rmk7-tux1-rthal/fs/nls/nls_base.c	Thu Oct 23 22:04:49 2003
@@ -10,6 +10,7 @@

 #include <linux/version.h>
 #include <linux/module.h>
+#include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/config.h>
 #include <linux/nls.h>
@@ -489,6 +490,18 @@
 	else
                return &default_table;
 }
+
+static int __init init_nls_base(void)
+{
+	return 0;
+}
+
+static void __exit exit_nls_base(void)
+{
+}
+
+module_init(init_nls_base)
+module_exit(exit_nls_base)

 EXPORT_SYMBOL(register_nls);
 EXPORT_SYMBOL(unregister_nls);

