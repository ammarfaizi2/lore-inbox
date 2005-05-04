Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVEDUgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVEDUgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVEDUeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:34:50 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:56707
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261570AbVEDU3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:29:05 -0400
To: linuxppc64-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Subject: [1/3] add early_pfn_to_nid for ppc64
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, apw@shadowen.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
Message-Id: <E1DTQUL-0002WE-D6@pinky.shadowen.org>
From: Andy Whitcroft <apw@shadowen.org>
Date: Wed, 04 May 2005 21:28:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an implementation of early_pfn_to_nid for PPC64.  This is
used by memory models to determine the node from which to take
allocations before the memory allocators are fully initialised.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Martin Bligh <mbligh@aracnet.com>
---
 arch/ppc64/Kconfig         |    4 ++++
 include/asm-ppc64/mmzone.h |    5 +++++
 2 files changed, 9 insertions(+)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/ppc64/Kconfig current/arch/ppc64/Kconfig
--- reference/arch/ppc64/Kconfig	2005-05-04 20:54:41.000000000 +0100
+++ current/arch/ppc64/Kconfig	2005-05-04 20:54:48.000000000 +0100
@@ -211,6 +211,10 @@ config ARCH_FLATMEM_ENABLE
 
 source "mm/Kconfig"
 
+config HAVE_ARCH_EARLY_PFN_TO_NID
+	bool
+	default y
+
 # Some NUMA nodes have memory ranges that span
 # other nodes.  Even though a pfn is valid and
 # between a node's start and end pfns, it may not
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/asm-ppc64/mmzone.h current/include/asm-ppc64/mmzone.h
--- reference/include/asm-ppc64/mmzone.h	2005-05-04 20:54:41.000000000 +0100
+++ current/include/asm-ppc64/mmzone.h	2005-05-04 20:54:48.000000000 +0100
@@ -90,4 +90,9 @@ static inline int pa_to_nid(unsigned lon
 #define discontigmem_pfn_valid(pfn)		((pfn) < num_physpages)
 
 #endif /* CONFIG_DISCONTIGMEM */
+
+#ifdef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
+#define early_pfn_to_nid(pfn)  pa_to_nid(((unsigned long)pfn) << PAGE_SHIFT)
+#endif
+
 #endif /* _ASM_MMZONE_H_ */
