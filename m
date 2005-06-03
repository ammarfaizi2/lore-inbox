Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVFCPAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVFCPAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 11:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFCPAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 11:00:40 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:52460
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261311AbVFCPAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 11:00:33 -0400
Date: Fri, 3 Jun 2005 16:00:26 +0100
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] i386 sparsemem: undefined early_pfn_to_nid when !NUMA
Message-ID: <20050603150026.GC19217@shadowen.org>
References: <20050527162822.EBE1D09F@kernel.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527162822.EBE1D09F@kernel.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seem benign for normal use and allows testing for hotplug.  Tested
on my test boxes.

Andrew please apply to -mm.

-apw

=== 8< ===
On i386, early_pfn_to_nid() is only defined when discontig.c
is compiled in.  The current dependency doesn't reflect this,
probably because the default i386 config doesn't allow for
SPARSEMEM without NUMA.

But, we'll need SPARSEMEM && !NUMA for memory hotplug, and I
do this for testing anyway.

Andy, please forward on if you concur.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat sparsemem-i386-undefined-early_pfn_to_nid-when-not-NUMA
---
 Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -upN reference/arch/i386/Kconfig current/arch/i386/Kconfig
--- reference/arch/i386/Kconfig
+++ current/arch/i386/Kconfig
@@ -803,6 +803,7 @@ source "mm/Kconfig"
 config HAVE_ARCH_EARLY_PFN_TO_NID
 	bool
 	default y
+	depends on NUMA
 
 config HIGHPTE
 	bool "Allocate 3rd-level pagetables from highmem"
