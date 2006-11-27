Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758137AbWK0Mrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137AbWK0Mrl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758153AbWK0Mrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:47:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:33923 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758137AbWK0Mrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:47:40 -0500
Subject: [PATCH 37/38] KVM: Move vmx helper inlines to vmx.c
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:47:39 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127124739.0E9F525015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -400,19 +400,6 @@ static inline int is_paging(struct kvm_v
 	return vcpu->cr0 & CR0_PG_MASK;
 }
 
-static inline int is_page_fault(u32 intr_info)
-{
-	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
-			     INTR_INFO_VALID_MASK)) ==
-		(INTR_TYPE_EXCEPTION | PF_VECTOR | INTR_INFO_VALID_MASK);
-}
-
-static inline int is_external_interrupt(u32 intr_info)
-{
-	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VALID_MASK))
-		== (INTR_TYPE_EXT_INTR | INTR_INFO_VALID_MASK);
-}
-
 static inline int memslot_id(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
 	return slot - kvm->memslots;
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -77,6 +77,19 @@ static const u32 vmx_msr_index[] = {
 
 struct vmx_msr_entry *find_msr_entry(struct kvm_vcpu *vcpu, u32 msr);
 
+static inline int is_page_fault(u32 intr_info)
+{
+	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
+			     INTR_INFO_VALID_MASK)) ==
+		(INTR_TYPE_EXCEPTION | PF_VECTOR | INTR_INFO_VALID_MASK);
+}
+
+static inline int is_external_interrupt(u32 intr_info)
+{
+	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VALID_MASK))
+		== (INTR_TYPE_EXT_INTR | INTR_INFO_VALID_MASK);
+}
+
 static void vmcs_clear(struct vmcs *vmcs)
 {
 	u64 phys_addr = __pa(vmcs);
