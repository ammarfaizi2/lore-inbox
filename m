Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758141AbWK0Mpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758141AbWK0Mpl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758152AbWK0Mpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:45:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:45536 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758141AbWK0Mpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:45:40 -0500
Subject: [PATCH 35/38] KVM: Remove guest_cpl()
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:45:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127124538.E7F3525015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was used only in debugging.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -422,11 +422,6 @@ static inline int is_pse(struct kvm_vcpu
 	return vcpu->cr4 & CR4_PSE_MASK;
 }
 
-static inline unsigned guest_cpl(void)
-{
-	return vmcs_read16(GUEST_CS_SELECTOR) & SELECTOR_RPL_MASK;
-}
-
 static inline int is_paging(struct kvm_vcpu *vcpu)
 {
 	return vcpu->cr0 & CR0_PG_MASK;
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -1391,14 +1391,6 @@ static int handle_cr(struct kvm_vcpu *vc
 	int cr;
 	int reg;
 
-#ifdef KVM_DEBUG
-	if (guest_cpl() != 0) {
-		vcpu_printf(vcpu, "%s: not supervisor\n", __FUNCTION__);
-		inject_gp(vcpu);
-		return 1;
-	}
-#endif
-
 	exit_qualification = vmcs_read64(EXIT_QUALIFICATION);
 	cr = exit_qualification & 15;
 	reg = (exit_qualification >> 8) & 15;
