Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTEMMKu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 08:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTEMMKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 08:10:50 -0400
Received: from angband.namesys.com ([212.16.7.85]:10377 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263423AbTEMMKt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 08:10:49 -0400
Date: Tue, 13 May 2003 16:23:29 +0400
From: Oleg Drokin <green@namesys.com>
To: jdike@karaya.com, akpm@digeo.com, roland@redhat.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: build problems on architectures where FIXADDR_* stuff is not constant
Message-ID: <20030513122329.GA31609@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Since there are architectures where FIXADDR_* stuff is not constant (e.g. UML),
   I propose this patch that allows such architectures to build. (now compilation
   dies with complaints about using not constant value as struct initialiser).
   Here is my proposed patch, or may be there is a better way?

   This is against latest 2.5 bk tree.

Bye,
    Oleg

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1094  -> 1.1095 
#	         mm/memory.c	1.123   -> 1.124  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/13	green@angband.namesys.com	1.1095
# memory.c:
#   Well, not everyone have these FIXADDR_* as constants. UML have those as computed value.
#   So we need to assign those not in struct initializer.
# --------------------------------------------
#
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Tue May 13 16:18:28 2003
+++ b/mm/memory.c	Tue May 13 16:18:28 2003
@@ -696,15 +696,15 @@
 				   ones, we can make this be "&init_mm" or
 				   something.  */
 				.vm_mm = NULL,
-				.vm_start = FIXADDR_START,
-				.vm_end = FIXADDR_TOP,
-				.vm_page_prot = PAGE_READONLY,
 				.vm_flags = VM_READ | VM_EXEC,
 			};
 			unsigned long pg = start & PAGE_MASK;
 			pgd_t *pgd;
 			pmd_t *pmd;
 			pte_t *pte;
+			fixmap_vma.vm_start = FIXADDR_START;
+			fixmap_vma.vm_end = FIXADDR_TOP;
+			fixmap_vma.vm_page_prot = PAGE_READONLY;
 			pgd = pgd_offset_k(pg);
 			if (!pgd)
 				return i ? : -EFAULT;
