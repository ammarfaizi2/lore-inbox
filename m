Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTFHRrj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 13:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263610AbTFHRri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 13:47:38 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:34831 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263600AbTFHRrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 13:47:37 -0400
Date: Sun, 8 Jun 2003 20:01:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Document lib-y
Message-ID: <20030608180113.GA3987@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, documentation for the newly added lib-y.

	Sam
===== Documentation/kbuild/makefiles.txt 1.8 vs edited =====
--- 1.8/Documentation/kbuild/makefiles.txt	Sun Mar 16 06:52:28 2003
+++ edited/Documentation/kbuild/makefiles.txt	Sun Jun  8 19:55:25 2003
@@ -11,7 +11,7 @@
 	   --- 3.2 Built-in object goals - obj-y
 	   --- 3.3 Loadable module goals - obj-m
 	   --- 3.4 Objects which export symbols
-	   --- 3.5 Library file goals - L_TARGET
+	   --- 3.5 Library file goals - lib-y
 	   --- 3.6 Descending down in directories
 	   --- 3.7 Compilation flags
 	   --- 3.8 Command line dependency
@@ -214,20 +214,33 @@
 	modules exporting symbols.
 	See also Documentation/modules.txt.
 
---- 3.5 Library file goals - L_TARGET
+--- 3.5 Library file goals - lib-y
 
-	Instead of building a built-in.o file, you may also
-	build an archive which again contains objects listed in $(obj-y).
-	This is normally not necessary and only used in lib/ and 
-	arch/$(ARCH)/lib directories.
-	Only the name lib.a is allowed.
+	Objects listed with obj-* is used for modules or
+	are combined in a built-in.o for that specific directory.
+	There is also the possibility to list objects that will
+	be included in a library, lib.a.
+	All objects listed with lib-y are combined in a single
+	library for that directory.
+	Objects that are listed in obj-y and additional listed in
+	lib-y will not be included in the library, since they will anyway
+	be accessible.
+	For consistency objects listed in lib-m will be included in lib.a. 
+
+	Note that the same kbuild makefile may list files to be built-in
+	and to be part of a library. Therefore the same directory
+	may contain both a built-in.o and a lib.a file.
 
 	Example:
 		#arch/i386/lib/Makefile
-		L_TARGET := lib.a
-		obj-y    := checksum.o delay.o
+		lib-y    := checksum.o delay.o
 
 	This will create a library lib.a based on checksum.o and delay.o.
+	For kbuild to actually recognize that there is a lib.a being build
+	the directory shall be listed in libs-y.
+	See also "6.3 List directories to visit when descending".
+ 
+	Usage of lib-y is normally restricted to lib/ and arch/*/lib.
 
 --- 3.6 Descending down in directories
 
@@ -727,7 +740,7 @@
     head-y, init-y, core-y, libs-y, drivers-y, net-y
 
 	$(head-y) list objects to be linked first in vmlinux.
-	$(libs-y) list directories where a libs.a archive can be located.
+	$(libs-y) list directories where a lib.a archive can be located.
 	The rest list directories where a built-in.o object file can be located.
 
 	$(init-y) objects will be located after $(head-y).
