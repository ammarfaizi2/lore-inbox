Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUDXQSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUDXQSO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 12:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUDXQSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 12:18:14 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:2691 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261234AbUDXQSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 12:18:08 -0400
Date: Sat, 24 Apr 2004 12:18:35 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH][2.6] SubmittingPatches diffing update.
Message-ID: <Pine.LNX.4.58.0404241213180.3745@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel janitor recently got confused by the advice in SubmittingPatches
and was sending patches with the wrong strip level, i think just about
everyone would prefer standard patches. Also mention various patch
management scripts for batching up large deltas.

Index: linux-2.6.6-rc1-stage/Documentation/SubmittingPatches
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-rc1/Documentation/SubmittingPatches,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 SubmittingPatches
--- linux-2.6.6-rc1-stage/Documentation/SubmittingPatches	15 Apr 2004 19:33:08 -0000	1.1.1.1
+++ linux-2.6.6-rc1-stage/Documentation/SubmittingPatches	23 Apr 2004 17:55:46 -0000
@@ -35,13 +35,14 @@ not in any lower subdirectory.

 To create a patch for a single file, it is often sufficient to do:

-	SRCTREE= /devel/linux-2.4
+	SRCTREE= linux-2.4
 	MYFILE=  drivers/net/mydriver.c

 	cd $SRCTREE
 	cp $MYFILE $MYFILE.orig
 	vi $MYFILE	# make your change
-	diff -up $MYFILE.orig $MYFILE > /tmp/patch
+	cd ..
+	diff -up $SRCTREE/$MYFILE{.orig,} > /tmp/patch

 To create a patch for multiple files, you should unpack a "vanilla",
 or unmodified kernel source tree, and generate a diff against your
@@ -63,6 +64,20 @@ Make sure your patch does not include an
 belong in a patch submission.  Make sure to review your patch -after-
 generated it with diff(1), to ensure accuracy.

+If your changes produce a lot of deltas, you may want to look into
+splitting them into individual patches which modify things in
+logical stages, this will facilitate easier reviewing by other
+kernel developers, very important if you want your patch accepted.
+There are a number of scripts which can aid in this;
+
+Quilt:
+http://savannah.nongnu.org/projects/quilt
+
+Randy Dunlap's patch scripts:
+http://developer.osdl.org/rddunlap/scripts/patching-scripts.tgz
+
+Andrew Morton's patch scripts:
+http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.16

 2) Describe your changes.

