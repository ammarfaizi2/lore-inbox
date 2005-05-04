Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVEDXLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVEDXLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 19:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVEDXLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 19:11:18 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:49332
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261941AbVEDXLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 19:11:13 -0400
Subject: [PATCH] Saving ARCH and CROSS_COMPILE in generated Makefile
From: Pavel Roskin <proski@gnu.org>
To: linux <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 May 2005 19:11:07 -0400
Message-Id: <1115248267.12758.21.camel@dv.roinet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I don't want to specify ARCH and CROSS_COMPILE with every make
invocation when cross-compiling the kernel.  I believe they should be
saved somewhere.  The most natural place would be .config, but I guess
it's not acceptable for some reason, or it would have been done long
ago.

The second best place would be the Makefile generated in the build
directory when the kernel is compiled outside the source tree.  The
patch below implements that.

Unfortunately, builds in the source directory would not profit from this
patch.  Perhaps we could always generate "makefile" or "GNUmakefile" in
the build directory, but it would be another patch.  Anyway, few people
cross-compile their kernels, and it's not unreasonable to encourage them
to use out-of-tree builds.

SUBARCH is not saved on purpose, since users are not supposed to
override it.

Compiling external modules against the build tree does the right thing
without ARCH and CROSS_COMPILE being specified.

Signed-off-by: Pavel Roskin <proski@gnu.org>

Index: scripts/mkmakefile
===================================================================
--- 2aa9e4732d7014dcda4c0e80d2e377f52e2262e9/scripts/mkmakefile  (mode:100644 sha1:c4d621b30d0db1649d99f9cebf31377cc2d8d32b)
+++ uncommitted/scripts/mkmakefile  (mode:100644)
@@ -21,6 +21,11 @@
 
 MAKEFLAGS += --no-print-directory
 
+ARCH = $ARCH
+CROSS_COMPILE = $CROSS_COMPILE
+
+export ARCH CROSS_COMPILE
+
 all:
 	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT)
 


-- 
Regards,
Pavel Roskin

