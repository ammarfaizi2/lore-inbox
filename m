Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268280AbUHYFqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268280AbUHYFqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 01:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268303AbUHYFqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 01:46:33 -0400
Received: from ozlabs.org ([203.10.76.45]:23218 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268280AbUHYFqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 01:46:31 -0400
Date: Wed, 25 Aug 2004 15:35:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: [PPC64] Clean up unused macro
Message-ID: <20040825053536.GB20279@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

After the recent SLB and STAB cleanups, the ppc64 KERNEL_CONTEXT()
macro is no longer used anywhere.  This patch removes it.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2004-08-23 17:40:55.311913488 +1000
+++ working-2.6/include/asm-ppc64/mmu.h	2004-08-23 17:41:59.696841960 +1000
@@ -27,16 +27,6 @@
 #endif
 } mm_context_t;
 
-#ifdef CONFIG_HUGETLB_PAGE
-#define KERNEL_LOW_HPAGES	.htlb_segs = 0,
-#else
-#define KERNEL_LOW_HPAGES
-#endif
-
-#define KERNEL_CONTEXT(ea) ({ \
-		mm_context_t ctx = { .id = REGION_ID(ea), KERNEL_LOW_HPAGES}; \
-		ctx; })
-
 #define STE_ESID_V	0x80
 #define STE_ESID_KS	0x20
 #define STE_ESID_KP	0x10

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
