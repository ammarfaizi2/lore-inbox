Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUHMTxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUHMTxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267380AbUHMTtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:49:09 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:60734 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267335AbUHMToM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:44:12 -0400
Date: Fri, 13 Aug 2004 21:46:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [3/12] kconfig: save kernel version in .config file
Message-ID: <20040813194630.GC10556@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813192804.GA10486@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/08 16:29:57+02:00 rddunlap@osdl.org 
#   kconfig: save kernel version in .config file
#   
#   Save kernel version info and date when writing .config file.
#   Tested with 'make {menuconfig|xconfig|gconfig}'.
#   
#   Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/kconfig/confdata.c
#   2004/06/20 06:14:24+02:00 rddunlap@osdl.org +15 -2
#   kconfig: save kernel version in .config file
# 
diff -Nru a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
--- a/scripts/kconfig/confdata.c	2004-08-13 21:09:11 +02:00
+++ b/scripts/kconfig/confdata.c	2004-08-13 21:09:11 +02:00
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <time.h>
 #include <unistd.h>
 
 #define LKC_DIRECT_LINK
@@ -268,6 +269,7 @@
 	char dirname[128], tmpname[128], newname[128];
 	int type, l;
 	const char *str;
+	time_t now;
 
 	dirname[0] = 0;
 	if (name && name[0]) {
@@ -301,14 +303,25 @@
 		if (!out_h)
 			return 1;
 	}
+	sym = sym_lookup("KERNELRELEASE", 0);
+	sym_calc_value(sym);
+	time(&now);
 	fprintf(out, "#\n"
 		     "# Automatically generated make config: don't edit\n"
-		     "#\n");
+		     "# Linux kernel version: %s\n"
+		     "# %s"
+		     "#\n",
+		     sym_get_string_value(sym),
+		     ctime(&now));
 	if (out_h)
 		fprintf(out_h, "/*\n"
 			       " * Automatically generated C config: don't edit\n"
+			       " * Linux kernel version: %s\n"
+			       " * %s"
 			       " */\n"
-			       "#define AUTOCONF_INCLUDED\n");
+			       "#define AUTOCONF_INCLUDED\n",
+			       sym_get_string_value(sym),
+			       ctime(&now));
 
 	if (!sym_change_count)
 		sym_clear_all_valid();
