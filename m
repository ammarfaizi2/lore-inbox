Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263307AbUDZXse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbUDZXse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 19:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUDZXse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 19:48:34 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:30190 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263307AbUDZXsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 19:48:30 -0400
Date: Mon, 26 Apr 2004 16:48:22 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: hugepagetlb, include linux/module.h
Message-Id: <20040426164822.46bc97cc.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The #include of linux/module.h in several arch/*/mm/hugetlbpage.c files
for EXPORT_SYMBOL(hugetlb_total_pages) was late to the party, and now
appears to be late leaving.  The hugetlb consolidation should have taken
these includes out.

This patch removes the #include of module.h from 4 arch/*/mm/hugetlbpage.c
files.  It is based off 2.6.6-rc2-mm2.

I have only managed to rebuild 1 of these 4 w/o this include, but still
this patch seems "obviously right".

    I rebuilt i386 successfully.

    I tried using the http://developer.osdl.org/dev/plm/cross_compile/
    stuff to compile this for sparc64, but ran afoul of missing PCI
    IDS for the Creator cards on sparc, as Andrew reported last week.

    I don't know how to test the ppc64 build.

    I'm running afoul of some elf32_map breakage with the ia64 build,
    which will likely result in a separate patch.  Still working that ...

The patch, for what it's worth:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1898  -> 1.1899 
#	arch/ppc64/mm/hugetlbpage.c	1.25    -> 1.26   
#	arch/ia64/mm/hugetlbpage.c	1.25    -> 1.26   
#	arch/sparc64/mm/hugetlbpage.c	1.16    -> 1.17   
#	arch/i386/mm/hugetlbpage.c	1.49    -> 1.50   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/04/26	pj@sgi.com	1.1899
# Now that hugetlb consolidation removed EXPORT_SYMBOL, dont need module.h.
# --------------------------------------------
#
diff -Nru a/arch/i386/mm/hugetlbpage.c b/arch/i386/mm/hugetlbpage.c
--- a/arch/i386/mm/hugetlbpage.c	Mon Apr 26 16:41:14 2004
+++ b/arch/i386/mm/hugetlbpage.c	Mon Apr 26 16:41:14 2004
@@ -12,7 +12,6 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/err.h>
 #include <linux/sysctl.h>
 #include <asm/mman.h>
diff -Nru a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
--- a/arch/ia64/mm/hugetlbpage.c	Mon Apr 26 16:41:14 2004
+++ b/arch/ia64/mm/hugetlbpage.c	Mon Apr 26 16:41:14 2004
@@ -9,7 +9,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
diff -Nru a/arch/ppc64/mm/hugetlbpage.c b/arch/ppc64/mm/hugetlbpage.c
--- a/arch/ppc64/mm/hugetlbpage.c	Mon Apr 26 16:41:14 2004
+++ b/arch/ppc64/mm/hugetlbpage.c	Mon Apr 26 16:41:14 2004
@@ -14,7 +14,6 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/err.h>
 #include <linux/sysctl.h>
 #include <asm/mman.h>
diff -Nru a/arch/sparc64/mm/hugetlbpage.c b/arch/sparc64/mm/hugetlbpage.c
--- a/arch/sparc64/mm/hugetlbpage.c	Mon Apr 26 16:41:14 2004
+++ b/arch/sparc64/mm/hugetlbpage.c	Mon Apr 26 16:41:14 2004
@@ -5,7 +5,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
@@ -14,7 +13,6 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
-#include <linux/module.h>
 
 #include <asm/mman.h>
 #include <asm/pgalloc.h>


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
