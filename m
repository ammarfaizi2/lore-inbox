Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUIEVTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUIEVTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 17:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUIEVTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 17:19:11 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:24734 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267232AbUIEVTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 17:19:08 -0400
Date: Sun, 5 Sep 2004 14:18:37 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tony Luck <tony.luck@intel.com>, ianw@gelato.unsw.edu.au,
       William Irwin <wli@holomorphy.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20040905211837.3068.64652.58313@sam.engr.sgi.com>
Subject: [PATCH] SN2 build fix CONFIG_VIRTUAL_MEM_MAP and CONFIG_DISCONTIGMEM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The change on 2004-09-03 by ianw@gelato.unsw.edu.au appears to have
a typo, which causes builds of configurations which define both
CONFIG_VIRTUAL_MEM_MAP and CONFIG_DISCONTIGMEM to emit some 890
warnings for redefines of each of pfn_valid, page_to_pfn,
pfn_to_page.  This shows up compiling sn2_defconfig, the SN2
config of arch ia64.  I believe that this is a simply typo,
an extra "#else" line.  Removing this exta line enables sn2_defconfig
to build as before.  Builds of other arch's untested.  No effort
made to boot this.

Signed-off-by: Paul Jackson <pj@sgi.com>

--- 2.6.9-rc1-pre/include/asm-ia64/page.h	2004-09-05 13:39:15.000000000 -0700
+++ 2.6.9-rc1-post/include/asm-ia64/page.h	2004-09-05 13:48:22.000000000 -0700
@@ -90,7 +90,6 @@ extern struct page *vmem_map;
 #  define page_to_pfn(page)    ((unsigned long) (page - vmem_map))
 #  define pfn_to_page(pfn)     (vmem_map + (pfn))
 # endif
-#else /* !CONFIG_VIRTUAL_MEM_MAP */
 #define pfn_valid(pfn)		(((pfn) < max_mapnr) && ia64_pfn_valid(pfn))
 #define page_to_pfn(page)	((unsigned long) (page - mem_map))
 #define pfn_to_page(pfn)	(mem_map + (pfn))

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
