Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUGJCR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUGJCR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 22:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUGJCR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 22:17:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29160 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266073AbUGJCRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 22:17:53 -0400
Date: Sat, 10 Jul 2004 04:17:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: bfennema@falcon.csc.calpoly.edu
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [2.6 patch] fix (UDF_FS=y && NLS=m) compile error
Message-ID: <20040710021749.GB28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes Bugzilla #3030 ((UDF_FS=y && NLS=m) results in a 
compile error).

diffstat output:
 fs/Kconfig     |    5 +++++
 fs/udf/super.c |    8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-modular/fs/Kconfig.old	2004-07-10 04:04:10.000000000 +0200
+++ linux-2.6.7-mm7-modular/fs/Kconfig	2004-07-10 04:06:26.000000000 +0200
@@ -575,6 +575,11 @@
 
 	  If unsure, say N.
 
+config UDF_NLS
+	bool
+	default y
+	depends on (UDF_FS=m && NLS) || (UDF_FS=y && NLS=y)
+
 endmenu
 
 menu "DOS/FAT/NT Filesystems"
--- linux-2.6.7-mm7-modular/fs/udf/super.c.old	2004-07-10 04:03:01.000000000 +0200
+++ linux-2.6.7-mm7-modular/fs/udf/super.c	2004-07-10 04:03:55.000000000 +0200
@@ -417,7 +417,7 @@
 			case Opt_utf8:
 				uopt->flags |= (1 << UDF_FLAG_UTF8);
 				break;
-#if defined(CONFIG_NLS) || defined(CONFIG_NLS_MODULE)
+#ifdef CONFIG_UDF_NLS
 			case Opt_iocharset:
 				uopt->nls_map = load_nls(args[0].from);
 				uopt->flags |= (1 << UDF_FLAG_NLS_MAP);
@@ -1518,7 +1518,7 @@
 			"utf8 cannot be combined with iocharset\n");
 		goto error_out;
 	}
-#if defined(CONFIG_NLS) || defined(CONFIG_NLS_MODULE)
+#ifdef CONFIG_UDF_NLS
 	if ((uopt.flags & (1 << UDF_FLAG_NLS_MAP)) && !uopt.nls_map)
 	{
 		uopt.nls_map = load_nls_default();
@@ -1668,7 +1668,7 @@
 				udf_release_data(UDF_SB_TYPESPAR(sb, UDF_SB_PARTITION(sb)).s_spar_map[i]);
 		}
 	}
-#if defined(CONFIG_NLS) || defined(CONFIG_NLS_MODULE)
+#ifdef CONFIG_UDF_NLS
 	if (UDF_QUERY_FLAG(sb, UDF_FLAG_NLS_MAP))
 		unload_nls(UDF_SB(sb)->s_nls_map);
 #endif
@@ -1746,7 +1746,7 @@
 				udf_release_data(UDF_SB_TYPESPAR(sb, UDF_SB_PARTITION(sb)).s_spar_map[i]);
 		}
 	}
-#if defined(CONFIG_NLS) || defined(CONFIG_NLS_MODULE)
+#ifdef CONFIG_UDF_NLS
 	if (UDF_QUERY_FLAG(sb, UDF_FLAG_NLS_MAP))
 		unload_nls(UDF_SB(sb)->s_nls_map);
 #endif
