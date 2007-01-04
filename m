Return-Path: <linux-kernel-owner+w=401wt.eu-S964981AbXADQIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbXADQIK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbXADQIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:08:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:47313 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964981AbXADQIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:08:09 -0500
Subject: [PATCH 19/33] KVM: MMU: Remove release_pt_page_64()
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:08:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104160807.24BC1250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unused.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -609,35 +609,6 @@ hpa_t gva_to_hpa(struct kvm_vcpu *vcpu, 
 	return gpa_to_hpa(vcpu, gpa);
 }
 
-
-static void release_pt_page_64(struct kvm_vcpu *vcpu, hpa_t page_hpa,
-			       int level)
-{
-	u64 *pos;
-	u64 *end;
-
-	ASSERT(vcpu);
-	ASSERT(VALID_PAGE(page_hpa));
-	ASSERT(level <= PT64_ROOT_LEVEL && level > 0);
-
-	for (pos = __va(page_hpa), end = pos + PT64_ENT_PER_PAGE;
-	     pos != end; pos++) {
-		u64 current_ent = *pos;
-
-		if (is_present_pte(current_ent)) {
-			if (level != 1)
-				release_pt_page_64(vcpu,
-						  current_ent &
-						  PT64_BASE_ADDR_MASK,
-						  level - 1);
-			else
-				rmap_remove(vcpu->kvm, pos);
-		}
-		*pos = 0;
-	}
-	kvm_mmu_free_page(vcpu, page_hpa);
-}
-
 static void nonpaging_new_cr3(struct kvm_vcpu *vcpu)
 {
 }
