Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUBGWV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 17:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265952AbUBGWV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 17:21:58 -0500
Received: from adsl-68-23-213-254.dsl.wotnoh.ameritech.net ([68.23.213.254]:25925
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S265951AbUBGWVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 17:21:55 -0500
Date: Sat, 7 Feb 2004 17:21:48 -0500
From: Ryan Boder <icanoop@bitwiser.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@digeo.com
Subject: [PATCH] 2.6.2 Documentation fix (Documentation/kbuild/modules.txt)
Message-ID: <20040207222148.GA3209@bitwiser.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Explains how to compile external modules in
Documentation/kbuild/modules.txt.

-- 
Ryan Boder
http://www.bitwiser.org/icanoop



--- linux-2.6.2/Documentation/kbuild/modules.txt	2004-02-06 12:31:04.000000000 -0500
+++ linux-2.6.2-icanoop/Documentation/kbuild/modules.txt	2004-02-07 16:46:52.000000000 -0500
@@ -17,12 +17,52 @@
 
 Compiling modules outside the official kernel
 ---------------------------------------------
-Often modules are developed outside the official kernel.
-To keep up with changes in the build system the most portable way
-to compile a module outside the kernel is to use the following command-line:
+
+Often modules are developed outside the official kernel.  To keep up
+with changes in the build system the most portable way to compile a
+module outside the kernel is to use the kernel build system,
+kbuild. Use the following command-line:
 
 make -C path/to/kernel/src SUBDIRS=$PWD modules
 
 This requires that a makefile exits made in accordance to
-Documentation/kbuild/makefiles.txt.
+Documentation/kbuild/makefiles.txt. Read that file for more details on
+the build system.
+
+The following is a short summary of how to write your Makefile to get
+you up and running fast. Assuming your module will be called
+yourmodule.ko, your code should be in yourmodule.c and your Makefile
+should include
+
+obj-m := yourmodule.o
+
+If the code for your module is in multiple files that need to be
+linked, you need to tell the build system which files to compile. In
+the case of multiple files, none of these files can be named
+yourmodule.c because doing so would cause a problem with the linking
+step. Assuming your code exists in file1.c, file2.c, and file3.c and
+you want to build yourmodule.ko from them, your Makefile should
+include
+
+obj-m := yourmodule.o
+yourmodule-objs := file1.o file2.o file3.o
+
+Now for a final example to put it all together. Assuming the
+KERNEL_SOURCE environment variable is set to the directory where you
+compiled the kernel, a simple Makefile that builds yourmodule.ko as
+described above would look like
+
+# Tells the build system to build yourmodule.ko.
+obj-m := yourmodule.o
+
+# Tells the build system to build these object files and link them as
+# yourmodule.o, before building yourmodule.ko. This line can be left
+# out if all the code for your module is in one file, yourmodule.c. If
+# you are using multiple files, none of these files can be named
+# yourmodule.c.
+yourmodule-objs := file1.o file2.o file3.o
 
+# Invokes the kernel build system to come back to the current
+# directory and build yourmodule.ko.
+default:	
+	make -C ${KERNEL_SOURCE} SUBDIRS=`pwd` modules

