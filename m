Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTILS06 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbTILS05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:26:57 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:53765 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261804AbTILSZA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:25:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] NLS: Remove the nls modules for only alias (1/2)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 13 Sep 2003 03:24:46 +0900
Message-ID: <87isnx3lw1.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This does the following,

1) This removes the nls modules for only alias. For backward
   compatible, this adds ->alias, and ->alias provides alias of charset.

2) For autoloading the module by the alias, use MODULE_ALIAS mechanism.

3) From changelog of module-init-tools, looks like MODULE_ALIAS needs
   module-init-tools 0.9.10 or later. So change the "Documentation/Changes".

Please apply.

 linux-2.6.0-test5-hirofumi/Documentation/Changes |    2 
 linux-2.6.0-test5-hirofumi/fs/nls/Makefile       |   13 ++---
 linux-2.6.0-test5-hirofumi/fs/nls/nls_base.c     |    5 +
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp1255.c   |    5 +
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp874.c    |    5 +
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp932.c    |    3 +
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp936.c    |    3 +
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp949.c    |    3 +
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp950.c    |    3 +
 linux-2.6.0-test5-hirofumi/include/linux/nls.h   |    3 +
 linux-2.6.0-test5/fs/nls/nls_big5.c              |   59 -----------------------
 linux-2.6.0-test5/fs/nls/nls_euc-kr.c            |   59 -----------------------
 linux-2.6.0-test5/fs/nls/nls_gb2312.c            |   59 -----------------------
 linux-2.6.0-test5/fs/nls/nls_iso8859-8.c         |   59 -----------------------
 linux-2.6.0-test5/fs/nls/nls_sjis.c              |   59 -----------------------
 linux-2.6.0-test5/fs/nls/nls_tis-620.c           |   59 -----------------------
 16 files changed, 34 insertions(+), 365 deletions(-)

diff -puN -L fs/nls/nls_tis-620.c fs/nls/nls_tis-620.c~nls-alias /dev/null
--- linux-2.6.0-test5/fs/nls/nls_tis-620.c
+++ /dev/null	2003-09-06 05:00:19.000000000 +0900
@@ -1,59 +0,0 @@
-/*
- * linux/fs/nls_tis-620.c
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/nls.h>
-#include <linux/errno.h>
-
-static struct nls_table *p_nls;
-
-static struct nls_table table = {
-	.charset	= "tis-620",
-	.owner		= THIS_MODULE,
-};
-
-static int __init init_nls_tis_620(void)
-{
-	p_nls = load_nls("cp874");
-
-	if (p_nls) {
-		table.uni2char = p_nls->uni2char;
-		table.char2uni = p_nls->char2uni;
-		table.charset2upper = p_nls->charset2upper;
-		table.charset2lower = p_nls->charset2lower;
-		return register_nls(&table);
-	}
-
-	return -EINVAL;
-}
-
-static void __exit exit_nls_tis_620(void)
-{
-	unregister_nls(&table);
-	unload_nls(p_nls);
-}
-
-module_init(init_nls_tis_620)
-module_exit(exit_nls_tis_620)
-MODULE_LICENSE("Dual BSD/GPL");
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- *
----------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_cp874.c~nls-alias fs/nls/nls_cp874.c
--- linux-2.6.0-test5/fs/nls/nls_cp874.c~nls-alias	2003-09-13 03:22:32.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp874.c	2003-09-13 03:22:32.000000000 +0900
@@ -251,6 +251,7 @@ static int char2uni(const unsigned char 
 
 static struct nls_table table = {
 	.charset	= "cp874",
+	.alias		= "tis-620",
 	.uni2char	= uni2char,
 	.char2uni	= char2uni,
 	.charset2lower	= charset2lower,
@@ -271,6 +272,9 @@ static void __exit exit_nls_cp874(void)
 module_init(init_nls_cp874)
 module_exit(exit_nls_cp874)
 
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS_NLS(tis-620);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
@@ -287,4 +291,3 @@ module_exit(exit_nls_cp874)
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/Kconfig~nls-alias fs/nls/Kconfig
diff -puN fs/nls/Makefile~nls-alias fs/nls/Makefile
--- linux-2.6.0-test5/fs/nls/Makefile~nls-alias	2003-09-13 03:22:32.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/Makefile	2003-09-13 03:22:32.000000000 +0900
@@ -19,14 +19,13 @@ obj-$(CONFIG_NLS_CODEPAGE_864)	+= nls_cp
 obj-$(CONFIG_NLS_CODEPAGE_865)	+= nls_cp865.o
 obj-$(CONFIG_NLS_CODEPAGE_866)	+= nls_cp866.o
 obj-$(CONFIG_NLS_CODEPAGE_869)	+= nls_cp869.o
-obj-$(CONFIG_NLS_CODEPAGE_874)	+= nls_cp874.o nls_tis-620.o
-obj-$(CONFIG_NLS_CODEPAGE_932)	+= nls_cp932.o nls_sjis.o nls_euc-jp.o
-obj-$(CONFIG_NLS_CODEPAGE_936)	+= nls_cp936.o nls_gb2312.o
-obj-$(CONFIG_NLS_CODEPAGE_949)	+= nls_cp949.o nls_euc-kr.o
-obj-$(CONFIG_NLS_CODEPAGE_950)	+= nls_cp950.o nls_big5.o
+obj-$(CONFIG_NLS_CODEPAGE_874)	+= nls_cp874.o
+obj-$(CONFIG_NLS_CODEPAGE_932)	+= nls_cp932.o nls_euc-jp.o
+obj-$(CONFIG_NLS_CODEPAGE_936)	+= nls_cp936.o
+obj-$(CONFIG_NLS_CODEPAGE_949)	+= nls_cp949.o
+obj-$(CONFIG_NLS_CODEPAGE_950)	+= nls_cp950.o
 obj-$(CONFIG_NLS_CODEPAGE_1250) += nls_cp1250.o
 obj-$(CONFIG_NLS_CODEPAGE_1251)	+= nls_cp1251.o
-obj-$(CONFIG_NLS_CODEPAGE_1255)	+= nls_cp1255.o
 obj-$(CONFIG_NLS_ISO8859_1)	+= nls_iso8859-1.o
 obj-$(CONFIG_NLS_ISO8859_2)	+= nls_iso8859-2.o
 obj-$(CONFIG_NLS_ISO8859_3)	+= nls_iso8859-3.o
@@ -34,7 +33,7 @@ obj-$(CONFIG_NLS_ISO8859_4)	+= nls_iso88
 obj-$(CONFIG_NLS_ISO8859_5)	+= nls_iso8859-5.o
 obj-$(CONFIG_NLS_ISO8859_6)	+= nls_iso8859-6.o
 obj-$(CONFIG_NLS_ISO8859_7)	+= nls_iso8859-7.o
-obj-$(CONFIG_NLS_ISO8859_8)	+= nls_cp1255.o nls_iso8859-8.o
+obj-$(CONFIG_NLS_ISO8859_8)	+= nls_cp1255.o
 obj-$(CONFIG_NLS_ISO8859_9)	+= nls_iso8859-9.o
 obj-$(CONFIG_NLS_ISO8859_10)	+= nls_iso8859-10.o
 obj-$(CONFIG_NLS_ISO8859_13)	+= nls_iso8859-13.o
diff -puN -L fs/nls/nls_sjis.c fs/nls/nls_sjis.c~nls-alias /dev/null
--- linux-2.6.0-test5/fs/nls/nls_sjis.c
+++ /dev/null	2003-09-06 05:00:19.000000000 +0900
@@ -1,59 +0,0 @@
-/*
- * linux/fs/nls_sjis.c
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/nls.h>
-#include <linux/errno.h>
-
-static struct nls_table *p_nls;
-
-static struct nls_table table = {
-	.charset	= "sjis",
-	.owner		= THIS_MODULE,
-};
-
-static int __init init_nls_sjis(void)
-{
-	p_nls = load_nls("cp932");
-
-	if (p_nls) {
-		table.uni2char = p_nls->uni2char;
-		table.char2uni = p_nls->char2uni;
-		table.charset2upper = p_nls->charset2upper;
-		table.charset2lower = p_nls->charset2lower;
-		return register_nls(&table);
-	}
-
-	return -EINVAL;
-}
-
-static void __exit exit_nls_sjis(void)
-{
-	unregister_nls(&table);
-	unload_nls(p_nls);
-}
-
-module_init(init_nls_sjis)
-module_exit(exit_nls_sjis)
-MODULE_LICENSE("Dual BSD/GPL");
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- *
----------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_cp932.c~nls-alias fs/nls/nls_cp932.c
--- linux-2.6.0-test5/fs/nls/nls_cp932.c~nls-alias	2003-09-13 03:22:32.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp932.c	2003-09-13 03:22:32.000000000 +0900
@@ -7885,6 +7885,7 @@ static int char2uni(const unsigned char 
 
 static struct nls_table table = {
 	.charset	= "cp932",
+	.alias		= "sjis",
 	.uni2char	= uni2char,
 	.char2uni	= char2uni,
 	.charset2lower	= charset2lower,
@@ -7904,7 +7905,9 @@ static void __exit exit_nls_cp932(void)
 
 module_init(init_nls_cp932)
 module_exit(exit_nls_cp932)
+
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS_NLS(sjis);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN -L fs/nls/nls_gb2312.c fs/nls/nls_gb2312.c~nls-alias /dev/null
--- linux-2.6.0-test5/fs/nls/nls_gb2312.c
+++ /dev/null	2003-09-06 05:00:19.000000000 +0900
@@ -1,59 +0,0 @@
-/*
- * linux/fs/nls_gb2312.c
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/nls.h>
-#include <linux/errno.h>
-
-static struct nls_table *p_nls;
-
-static struct nls_table table = {
-	.charset	= "gb2312",
-	.owner		= THIS_MODULE,
-};
-
-static int __init init_nls_gb2312(void)
-{
-	p_nls = load_nls("cp936");
-
-	if (p_nls) {
-		table.uni2char = p_nls->uni2char;
-		table.char2uni = p_nls->char2uni;
-		table.charset2upper = p_nls->charset2upper;
-		table.charset2lower = p_nls->charset2lower;
-		return register_nls(&table);
-	}
-
-	return -EINVAL;
-}
-
-static void __exit exit_nls_gb2312(void)
-{
-	unregister_nls(&table);
-	unload_nls(p_nls);
-}
-
-module_init(init_nls_gb2312)
-module_exit(exit_nls_gb2312)
-MODULE_LICENSE("Dual BSD/GPL");
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- *
----------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_cp936.c~nls-alias fs/nls/nls_cp936.c
--- linux-2.6.0-test5/fs/nls/nls_cp936.c~nls-alias	2003-09-13 03:22:32.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp936.c	2003-09-13 03:22:32.000000000 +0900
@@ -11005,6 +11005,7 @@ static int char2uni(const unsigned char 
 
 static struct nls_table table = {
 	.charset	= "cp936",
+	.alias		= "gb2312",
 	.uni2char	= uni2char,
 	.char2uni	= char2uni,
 	.charset2lower	= charset2lower,
@@ -11024,7 +11025,9 @@ static void __exit exit_nls_cp936(void)
 
 module_init(init_nls_cp936)
 module_exit(exit_nls_cp936)
+
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS_NLS(gb2312);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN -L fs/nls/nls_euc-kr.c fs/nls/nls_euc-kr.c~nls-alias /dev/null
--- linux-2.6.0-test5/fs/nls/nls_euc-kr.c
+++ /dev/null	2003-09-06 05:00:19.000000000 +0900
@@ -1,59 +0,0 @@
-/*
- * linux/fs/nls_euc-kr.c
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/nls.h>
-#include <linux/errno.h>
-
-static struct nls_table *p_nls;
-
-static struct nls_table table = {
-	.charset	= "euc-kr",
-	.owner		= THIS_MODULE,
-};
-
-static int __init init_nls_euc_kr(void)
-{
-	p_nls = load_nls("cp949");
-
-	if (p_nls) {
-		table.uni2char = p_nls->uni2char;
-		table.char2uni = p_nls->char2uni;
-		table.charset2upper = p_nls->charset2upper;
-		table.charset2lower = p_nls->charset2lower;
-		return register_nls(&table);
-	}
-
-	return -EINVAL;
-}
-
-static void __exit exit_nls_euc_kr(void)
-{
-	unregister_nls(&table);
-	unload_nls(p_nls);
-}
-
-module_init(init_nls_euc_kr)
-module_exit(exit_nls_euc_kr)
-MODULE_LICENSE("Dual BSD/GPL");
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- *
----------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_cp949.c~nls-alias fs/nls/nls_cp949.c
--- linux-2.6.0-test5/fs/nls/nls_cp949.c~nls-alias	2003-09-13 03:22:32.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp949.c	2003-09-13 03:22:33.000000000 +0900
@@ -13922,6 +13922,7 @@ static int char2uni(const unsigned char 
 
 static struct nls_table table = {
 	.charset	= "cp949",
+	.alias		= "euc-kr",
 	.uni2char	= uni2char,
 	.char2uni	= char2uni,
 	.charset2lower	= charset2lower,
@@ -13941,7 +13942,9 @@ static void __exit exit_nls_cp949(void)
 
 module_init(init_nls_cp949)
 module_exit(exit_nls_cp949)
+
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS_NLS(euc-kr);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN -L fs/nls/nls_big5.c fs/nls/nls_big5.c~nls-alias /dev/null
--- linux-2.6.0-test5/fs/nls/nls_big5.c
+++ /dev/null	2003-09-06 05:00:19.000000000 +0900
@@ -1,59 +0,0 @@
-/*
- * linux/fs/nls_big5.c
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/nls.h>
-#include <linux/errno.h>
-
-static struct nls_table *p_nls;
-
-static struct nls_table table = {
-	.charset	= "big5",
-	.owner		= THIS_MODULE,
-};
-
-static int __init init_nls_big5(void)
-{
-	p_nls = load_nls("cp950");
-
-	if (p_nls) {
-		table.uni2char = p_nls->uni2char;
-		table.char2uni = p_nls->char2uni;
-		table.charset2upper = p_nls->charset2upper;
-		table.charset2lower = p_nls->charset2lower;
-		return register_nls(&table);
-	}
-
-	return -EINVAL;
-}
-
-static void __exit exit_nls_big5(void)
-{
-	unregister_nls(&table);
-	unload_nls(p_nls);
-}
-
-module_init(init_nls_big5)
-module_exit(exit_nls_big5)
-MODULE_LICENSE("Dual BSD/GPL");
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- *
----------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_cp950.c~nls-alias fs/nls/nls_cp950.c
--- linux-2.6.0-test5/fs/nls/nls_cp950.c~nls-alias	2003-09-13 03:22:32.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp950.c	2003-09-13 03:22:33.000000000 +0900
@@ -9461,6 +9461,7 @@ static int char2uni(const unsigned char 
 
 static struct nls_table table = {
 	.charset	= "cp950",
+	.alias		= "big5",
 	.uni2char	= uni2char,
 	.char2uni	= char2uni,
 	.charset2lower	= charset2lower,
@@ -9480,7 +9481,9 @@ static void __exit exit_nls_cp950(void)
 
 module_init(init_nls_cp950)
 module_exit(exit_nls_cp950)
+
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS_NLS(big5);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN -L fs/nls/nls_iso8859-8.c fs/nls/nls_iso8859-8.c~nls-alias /dev/null
--- linux-2.6.0-test5/fs/nls/nls_iso8859-8.c
+++ /dev/null	2003-09-06 05:00:19.000000000 +0900
@@ -1,59 +0,0 @@
-/*
- * linux/fs/nls_iso8859-8.c
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/nls.h>
-#include <linux/errno.h>
-
-static struct nls_table *p_nls;
-
-static struct nls_table table = {
-	.charset	= "iso8859-8",
-	.owner		= THIS_MODULE,
-};
-
-static int __init init_nls_iso8859_8(void)
-{
-	p_nls = load_nls("cp1255");
-
-	if (p_nls) {
-		table.uni2char = p_nls->uni2char;
-		table.char2uni = p_nls->char2uni;
-		table.charset2upper = p_nls->charset2upper;
-		table.charset2lower = p_nls->charset2lower;
-		return register_nls(&table);
-	}
-
-	return -EINVAL;
-}
-
-static void __exit exit_nls_iso8859_8(void)
-{
-	unregister_nls(&table);
-	unload_nls(p_nls);
-}
-
-module_init(init_nls_iso8859_8)
-module_exit(exit_nls_iso8859_8)
-MODULE_LICENSE("Dual BSD/GPL");
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- *
----------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_cp1255.c~nls-alias fs/nls/nls_cp1255.c
--- linux-2.6.0-test5/fs/nls/nls_cp1255.c~nls-alias	2003-09-13 03:22:32.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp1255.c	2003-09-13 03:22:33.000000000 +0900
@@ -360,6 +360,7 @@ static int char2uni(const unsigned char 
 
 static struct nls_table table = {
 	.charset	= "cp1255",
+	.alias		= "iso8859-8",
 	.uni2char	= uni2char,
 	.char2uni	= char2uni,
 	.charset2lower	= charset2lower,
@@ -380,6 +381,9 @@ static void __exit exit_nls_cp1255(void)
 module_init(init_nls_cp1255)
 module_exit(exit_nls_cp1255)
 
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS_NLS(iso8859-8);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
@@ -396,4 +400,3 @@ module_exit(exit_nls_cp1255)
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("Dual BSD/GPL");
diff -puN include/linux/nls.h~nls-alias include/linux/nls.h
--- linux-2.6.0-test5/include/linux/nls.h~nls-alias	2003-09-13 03:22:32.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/include/linux/nls.h	2003-09-13 03:22:33.000000000 +0900
@@ -8,6 +8,7 @@ typedef __u16 wchar_t;
 
 struct nls_table {
 	char *charset;
+	char *alias;
 	int (*uni2char) (wchar_t uni, unsigned char *out, int boundlen);
 	int (*char2uni) (const unsigned char *rawstring, int boundlen,
 			 wchar_t *uni);
@@ -32,5 +33,7 @@ extern int utf8_mbstowcs(wchar_t *, cons
 extern int utf8_wctomb(__u8 *, wchar_t, int);
 extern int utf8_wcstombs(__u8 *, const wchar_t *, int);
 
+#define MODULE_ALIAS_NLS(name)	MODULE_ALIAS("nls_" __stringify(name))
+
 #endif /* _LINUX_NLS_H */
 
diff -puN fs/nls/nls_base.c~nls-alias fs/nls/nls_base.c
--- linux-2.6.0-test5/fs/nls/nls_base.c~nls-alias	2003-09-13 03:22:32.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_base.c	2003-09-13 03:22:33.000000000 +0900
@@ -203,9 +203,12 @@ static struct nls_table *find_nls(char *
 {
 	struct nls_table *nls;
 	spin_lock(&nls_lock);
-	for (nls = tables; nls; nls = nls->next)
+	for (nls = tables; nls; nls = nls->next) {
 		if (!strcmp(nls->charset, charset))
 			break;
+		if (nls->alias && !strcmp(nls->alias, charset))
+			break;
+	}
 	if (nls && !try_module_get(nls->owner))
 		nls = NULL;
 	spin_unlock(&nls_lock);
diff -puN Documentation/Changes~nls-alias Documentation/Changes
--- linux-2.6.0-test5/Documentation/Changes~nls-alias	2003-09-13 03:22:32.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/Documentation/Changes	2003-09-13 03:22:33.000000000 +0900
@@ -52,7 +52,7 @@ o  Gnu C                  2.95.3        
 o  Gnu make               3.78                    # make --version
 o  binutils               2.12                    # ld -v
 o  util-linux             2.10o                   # fdformat --version
-o  module-init-tools      0.9.9                   # depmod -V
+o  module-init-tools      0.9.10                  # depmod -V
 o  e2fsprogs              1.29                    # tune2fs
 o  jfsutils               1.1.3                   # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
