Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWDCQVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWDCQVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWDCQVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:21:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:61094 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751768AbWDCQVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:21:50 -0400
Subject: [PATCH] fix MIPS PFN/page borkage (take 2)
To: ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 03 Apr 2006 09:21:17 -0700
Message-Id: <20060403162117.39F1BBF7@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The "unify PFN_* macros" patch screwed up and somehow modified
the MIPS code where it shouldn't have.  This backs those changes
back out.

Also remember to include the new header in the MIPS files.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 work-dave/arch/mips/mips-boards/generic/memory.c |    5 +++--
 work-dave/arch/mips/mips-boards/sim/sim_mem.c    |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff -puN arch/mips/mips-boards/generic/memory.c~unify_PFN_macros arch/mips/mips-boards/generic/memory.c
--- work/arch/mips/mips-boards/generic/memory.c~unify_PFN_macros	2006-04-03 09:09:42.000000000 -0700
+++ work-dave/arch/mips/mips-boards/generic/memory.c	2006-04-03 09:20:36.000000000 -0700
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
+#include <linux/pfn.h>
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
@@ -106,10 +107,10 @@ struct prom_pmemblock * __init prom_getm
 
 	mdesc[3].type = yamon_dontuse;
 	mdesc[3].base = 0x00100000;
-	mdesc[3].size = CPHYSADDR(PAGE_ALIGN(&_end)) - mdesc[3].base;
+	mdesc[3].size = CPHYSADDR(PFN_ALIGN(&_end)) - mdesc[3].base;
 
 	mdesc[4].type = yamon_free;
-	mdesc[4].base = CPHYSADDR(PAGE_ALIGN(&_end));
+	mdesc[4].base = CPHYSADDR(PFN_ALIGN(&_end));
 	mdesc[4].size = memsize - mdesc[4].base;
 
 	return &mdesc[0];
diff -puN arch/mips/mips-boards/sim/sim_mem.c~unify_PFN_macros arch/mips/mips-boards/sim/sim_mem.c
--- work/arch/mips/mips-boards/sim/sim_mem.c~unify_PFN_macros	2006-04-03 09:09:42.000000000 -0700
+++ work-dave/arch/mips/mips-boards/sim/sim_mem.c	2006-04-03 09:20:46.000000000 -0700
@@ -17,6 +17,7 @@
  */
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/pfn.h>
 #include <linux/bootmem.h>
 
 #include <asm/bootinfo.h>
@@ -61,10 +62,10 @@ struct prom_pmemblock * __init prom_getm
 
 	mdesc[2].type = simmem_reserved;
 	mdesc[2].base = 0x00100000;
-	mdesc[2].size = CPHYSADDR(PAGE_ALIGN(&_end)) - mdesc[2].base;
+	mdesc[2].size = CPHYSADDR(PFN_ALIGN(&_end)) - mdesc[2].base;
 
 	mdesc[3].type = simmem_free;
-	mdesc[3].base = CPHYSADDR(PAGE_ALIGN(&_end));
+	mdesc[3].base = CPHYSADDR(PFN_ALIGN(&_end));
 	mdesc[3].size = memsize - mdesc[3].base;
 
 	return &mdesc[0];
_
