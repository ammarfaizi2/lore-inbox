Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWDCQMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWDCQMA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWDCQMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:12:00 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:45539 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751762AbWDCQL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:11:59 -0400
Subject: [PATCH] fix MIPS PFN/page borkage
To: ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 03 Apr 2006 09:11:31 -0700
Message-Id: <20060403161131.0790DD9A@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The "unify PFN_* macros" patch screwed up and somehow modified
the MIPS code where it shouldn't have.  This backs those changes
back out.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 work-dave/arch/mips/mips-boards/generic/memory.c |    4 ++--
 work-dave/arch/mips/mips-boards/sim/sim_mem.c    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/mips/mips-boards/generic/memory.c~unify_PFN_macros arch/mips/mips-boards/generic/memory.c
--- work/arch/mips/mips-boards/generic/memory.c~unify_PFN_macros	2006-04-03 09:09:42.000000000 -0700
+++ work-dave/arch/mips/mips-boards/generic/memory.c	2006-04-03 09:09:42.000000000 -0700
@@ -106,10 +106,10 @@ struct prom_pmemblock * __init prom_getm
 
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
+++ work-dave/arch/mips/mips-boards/sim/sim_mem.c	2006-04-03 09:09:42.000000000 -0700
@@ -61,10 +61,10 @@ struct prom_pmemblock * __init prom_getm
 
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
