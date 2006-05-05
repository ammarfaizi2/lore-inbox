Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWEEQL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWEEQL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWEEQL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:11:26 -0400
Received: from mail.deathmatch.net ([216.200.85.210]:63176 "EHLO
	mail.deathmatch.net") by vger.kernel.org with ESMTP
	id S1751135AbWEEQL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:11:26 -0400
Date: Fri, 5 May 2006 12:10:35 -0400
From: Bob Copeland <me@bobcopeland.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, torvalds@osdl.org, pavel@suse.cz
Subject: [PATCH] docs: update sparse.txt with CHECK_ENDIAN
Message-ID: <20060505161035.GA6308@hash.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Copeland <me@bobcopeland.com>

Update the sparse documentation to omit the -Wbitwise flag example (as
it is now passed by default), and document the kernel defines to enable
endianness checking.

Signed-off-by: Bob Copeland <me@bobcopeland.com>
---
diff -urp linux/Documentation/sparse.txt b/Documentation/sparse.txt
--- linux/Documentation/sparse.txt	2006-04-23 19:13:02.000000000 -0400
+++ b/Documentation/sparse.txt	2006-05-05 11:49:09.000000000 -0400
@@ -1,5 +1,6 @@
 Copyright 2004 Linus Torvalds
 Copyright 2004 Pavel Machek <pavel@suse.cz>
+Copyright 2006 Bob Copeland <me@bobcopeland.com>
 
 Using sparse for typechecking
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -41,15 +42,8 @@ sure that bitwise types don't get mixed 
 vs cpu-endian vs whatever), and there the constant "0" really _is_
 special.
 
-Use
-
-	make C=[12] CF=-Wbitwise
-
-or you don't get any checking at all.
-
-
-Where to get sparse
-~~~~~~~~~~~~~~~~~~~
+Getting sparse
+~~~~~~~~~~~~~~
 
 With git, you can just get it from
 
@@ -57,7 +51,7 @@ With git, you can just get it from
 
 and DaveJ has tar-balls at
 
-	http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
+        http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
 
 
 Once you have it, just do
@@ -65,8 +59,20 @@ Once you have it, just do
         make
         make install
 
-as your regular user, and it will install sparse in your ~/bin directory.
-After that, doing a kernel make with "make C=1" will run sparse on all the
-C files that get recompiled, or with "make C=2" will run sparse on the
-files whether they need to be recompiled or not (ie the latter is fast way
-to check the whole tree if you have already built it).
+as a regular user, and it will install sparse in your ~/bin directory.
+
+Using sparse
+~~~~~~~~~~~~
+
+Do a kernel make with "make C=1" to run sparse on all the C files that get
+recompiled, or use "make C=2" to run sparse on the files whether they need to
+be recompiled or not.  The latter is a fast way to check the whole tree if you
+have already built it.
+
+The optional make variable CF can be used to pass arguments to sparse.  The 
+build system passes -Wbitwise to sparse automatically.  To perform endianness
+checks, you may define __CHECK_ENDIAN__:
+
+        make C=2 CF="-D__CHECK_ENDIAN__"
+
+These checks are disabled by default as they generate a host of warnings.
