Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVASE4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVASE4C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 23:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVASE4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 23:56:02 -0500
Received: from colin2.muc.de ([193.149.48.15]:40210 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261573AbVASEzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 23:55:54 -0500
Date: 19 Jan 2005 05:55:52 +0100
Date: Wed, 19 Jan 2005 05:55:52 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use -Wno-pointer-sign for gcc 4.0
Message-ID: <20050119045552.GA77900@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiling an allyesconfig kernel straight with a gcc 4.0 snapshot
gives nearly 10k new warnings like:

warning: pointer targets in passing argument 5 of `cpuid' differ in signedness

Since the sheer number of these warnings was too much even for the 
most determined kernel janitors (I actually asked ;-) and I don't
think it's a very serious issue to have these mismatches I submitted
an new option to gcc to disable it. It was incorporated in gcc mainline
now. 

This patch makes the kernel compilation use it. There are still
quite a lot of new warnings with 4.0 (mostly about uninitialized variables),
but the compile log looks much nicer nnow.

Signed-off-by: Andi Kleen <ak@suse.de>

--- linux-2.6.11-rc1-bk4/Makefile-o	2005-01-17 10:39:39.000000000 +0100
+++ linux-2.6.11-rc1-bk4/Makefile	2005-01-19 05:43:29.000000000 +0100
@@ -533,6 +533,9 @@
 # warn about C99 declaration after statement
 CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
 
+# disable pointer signedness warnings in gcc 4.0
+CFLAGS += $(call cc-option,-Wno-pointer-sign,)
+
 # Default kernel image to build when no specific target is given.
 # KBUILD_IMAGE may be overruled on the commandline or
 # set in the environment
