Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTJIRne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTJIRne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:43:34 -0400
Received: from web40908.mail.yahoo.com ([66.218.78.205]:55700 "HELO
	web40908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262363AbTJIRnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:43:25 -0400
Message-ID: <20031009174324.2806.qmail@web40908.mail.yahoo.com>
Date: Thu, 9 Oct 2003 10:43:24 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: [PATCH] Allow UDF debugging messages to be disabled in the build system
To: Ben Fennema <bfennema@falcon.csc.calpoly.edu>,
       Dave Boynton <dave@trylinux.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Fennema, Mr. Boynton,

This patch to the UDF filesystem driver allows you to enable and disable
the UDF debugging messages through the build system instead of editing
linux/udf_fs.h.

Patch was created against 2.6.0-test7-osdl1 but it applies cleanly to
2.6.0-test6-mm4. Compile-tested and used on 2.6.0-test7-osdl1.

Please apply.

Thanks,

Brad Chapman

-----
diff -urN -X /home/bhchapm/source/dontdiff include/linux/udf_fs.h.orig
include/linux/udf_fs.h
--- include/linux/udf_fs.h.orig	2003-10-09 18:14:19.935562952 -0400
+++ include/linux/udf_fs.h	2003-10-09 18:16:25.896413992 -0400
@@ -34,15 +34,15 @@
 #ifndef _UDF_FS_H
 #define _UDF_FS_H 1
 
+#include <linux/config.h>
+
 #define UDF_PREALLOCATE
 #define UDF_DEFAULT_PREALLOC_BLOCKS	8
 
 #define UDFFS_DATE			"2002/11/15"
 #define UDFFS_VERSION			"0.9.7"
 
-#define UDFFS_DEBUG
-
-#ifdef UDFFS_DEBUG
+#ifdef CONFIG_UDF_FS_DEBUG
 #define udf_debug(f, a...) \
 	{ \
 		printk (KERN_DEBUG "UDF-fs DEBUG %s:%d:%s: ", \
diff -urN -X /home/bhchapm/source/dontdiff fs/Kconfig.orig fs/Kconfig
--- fs/Kconfig.orig	2003-10-09 18:16:48.056045216 -0400
+++ fs/Kconfig	2003-10-09 18:34:53.930967136 -0400
@@ -523,6 +523,17 @@
 	  module will be called udf.
 
 	  If unsure, say N.
+	  
+config UDF_FS_DEBUG
+	bool "UDF file system debugging"
+	depends on UDF_FS
+	default y
+	help
+	  Say Y here if you want the UDF filesystem driver to output debugging
+	  messages every time a UDF volume is mounted, accessed or otherwise
+	  used.
+	  
+	  If unsure, say N.
 
 endmenu
 


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
