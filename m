Return-Path: <linux-kernel-owner+w=401wt.eu-S964983AbXADQKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbXADQKK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbXADQKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:10:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:47322 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964983AbXADQKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:10:08 -0500
Subject: [PATCH 21/33] KVM: MMU: <ove is_empty_shadow_page() above
	kvm_mmu_free_page()
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:10:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104161007.3CD71250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -303,16 +303,6 @@ static void rmap_write_protect(struct kv
 	}
 }
 
-static void kvm_mmu_free_page(struct kvm_vcpu *vcpu, hpa_t page_hpa)
-{
-	struct kvm_mmu_page *page_head = page_header(page_hpa);
-
-	list_del(&page_head->link);
-	page_head->page_hpa = page_hpa;
-	list_add(&page_head->link, &vcpu->free_pages);
-	++vcpu->kvm->n_free_mmu_pages;
-}
-
 static int is_empty_shadow_page(hpa_t page_hpa)
 {
 	u32 *pos;
@@ -324,6 +314,16 @@ static int is_empty_shadow_page(hpa_t pa
 	return 1;
 }
 
+static void kvm_mmu_free_page(struct kvm_vcpu *vcpu, hpa_t page_hpa)
+{
+	struct kvm_mmu_page *page_head = page_header(page_hpa);
+
+	list_del(&page_head->link);
+	page_head->page_hpa = page_hpa;
+	list_add(&page_head->link, &vcpu->free_pages);
+	++vcpu->kvm->n_free_mmu_pages;
+}
+
 static unsigned kvm_page_table_hashfn(gfn_t gfn)
 {
 	return gfn;
