Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVE0Q23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVE0Q23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVE0Q23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 12:28:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:44684 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262489AbVE0Q2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 12:28:25 -0400
Subject: [PATCH] i386 sparsemem: undefined early_pfn_to_nid when !NUMA
To: apw@shadowen.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 27 May 2005 09:28:22 -0700
Message-Id: <20050527162822.EBE1D09F@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On i386, early_pfn_to_nid() is only defined when discontig.c
is compiled in.  The current dependency doesn't reflect this,
probably because the default i386 config doesn't allow for
SPARSEMEM without NUMA.

But, we'll need SPARSEMEM && !NUMA for memory hotplug, and I
do this for testing anyway.

Andy, please forward on if you concur.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/i386/Kconfig~generify-early_pfn_to_nid-fix arch/i386/Kconfig
--- memhotplug/arch/i386/Kconfig~generify-early_pfn_to_nid-fix	2005-05-27 09:23:07.000000000 -0700
+++ memhotplug-dave/arch/i386/Kconfig	2005-05-27 09:23:07.000000000 -0700
@@ -837,6 +837,7 @@ source "mm/Kconfig"
 config HAVE_ARCH_EARLY_PFN_TO_NID
 	bool
 	default y
+	depends on NUMA
 
 config HIGHPTE
 	bool "Allocate 3rd-level pagetables from highmem"
_
