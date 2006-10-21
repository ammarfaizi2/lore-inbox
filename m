Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993155AbWJUQwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993155AbWJUQwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993137AbWJUQwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:52:03 -0400
Received: from ns.suse.de ([195.135.220.2]:45212 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2993142AbWJUQvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:31 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: "bibo,mao" <bibo.mao@intel.com>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [10/19] x86_64: x86_64 add NX mask for PTE entry
Message-Id: <20061021165130.40E2213C4D@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:30 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "bibo,mao" <bibo.mao@intel.com>

    If function change_page_attr_addr calls revert_page to revert
to original pte value, mk_pte_phys does not mask NX bit. If NX bit
is set on no NX hardware supported x86_64 machine, there is will
be RSVD type page fault and system will crash. This patch adds NX
mask bit for PTE entry.

Signed-off-by: bibo,mao <bibo.mao@intel.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 include/asm-x86_64/pgtable.h |    1 +
 1 files changed, 1 insertion(+)

Index: linux/include/asm-x86_64/pgtable.h
===================================================================
--- linux.orig/include/asm-x86_64/pgtable.h
+++ linux/include/asm-x86_64/pgtable.h
@@ -366,6 +366,7 @@ static inline pte_t mk_pte_phys(unsigned
 { 
 	pte_t pte;
 	pte_val(pte) = physpage | pgprot_val(pgprot); 
+	pte_val(pte) &= __supported_pte_mask;
 	return pte; 
 }
  
