Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbSL1Fnr>; Sat, 28 Dec 2002 00:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSL1Fnr>; Sat, 28 Dec 2002 00:43:47 -0500
Received: from fmr05.intel.com ([134.134.136.6]:33728 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S265475AbSL1Fnp>; Sat, 28 Dec 2002 00:43:45 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2601AA1377@pdsmsx32.pd.intel.com>
From: "Zhuang, Louis" <louis.zhuang@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'rusty@rustcorp.com.au'" <rusty@rustcorp.com.au>
Subject: [PATCH] fix os release detection in module-init-tools-0.9.6
Date: Sat, 28 Dec 2002 13:49:49 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rusty,
	IMHO, try_old_version can tell kernel release better with this
patch, don't you? ;->
  - Louis

diff -Nur module-init-tools-0.9.6/backwards_compat.c
module-init-tools-0.9.6-lz1/backwards_compat.c
--- module-init-tools-0.9.6/backwards_compat.c	2002-12-21
12:31:11.000000000 +0800
+++ module-init-tools-0.9.6-lz1/backwards_compat.c	2002-12-28
13:29:50.000000000 +0800
@@ -4,6 +4,7 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/utsname.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <errno.h>
@@ -59,10 +60,14 @@
 static void try_old_version(const char *progname, char *argv[])
 {
 	struct stat buf;
-	/* 2.2 and 2.4 have a syscall.  2.0 doesn't, but does have
-           /proc/ksyms */
+	struct utsname un;
+
+	uname(&un);
+	
+	/* 2.2 and 2.4 have a syscall.  2.0 doesn't, so we compare
+	   release */
 	if (query_module(NULL, 0, NULL, 0, NULL) == 0
-	    || stat("/proc/ksyms", &buf) == 0)
+	    || strncmp("2.0", un.release, 3) == 0)
 		exec_old(progname, argv);
 }
 #else /* CONFIG_NO_BACKWARDS_COMPAT */
