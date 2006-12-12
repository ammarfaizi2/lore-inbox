Return-Path: <linux-kernel-owner+w=401wt.eu-S1751259AbWLLN6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWLLN6j (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWLLN6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:58:39 -0500
Received: from il.qumranet.com ([62.219.232.206]:35419 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbWLLN6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:58:39 -0500
Subject: [PATCH 2/3] KVM: Don't touch the virtual apic vt registers on 32-bit
From: Avi Kivity <avi@qumranet.com>
Date: Tue, 12 Dec 2006 13:58:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457EB4ED.6020407@qumranet.com>
In-Reply-To: <457EB4ED.6020407@qumranet.com>
Message-Id: <20061212135837.8BB532500B4@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Riepe <michael@mr511.de>

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -1175,8 +1175,10 @@ static int vmx_vcpu_setup(struct kvm_vcp
                                VM_ENTRY_CONTROLS, 0);
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);  /* 22.2.1 */
 
+#ifdef CONFIG_X86_64
 	vmcs_writel(VIRTUAL_APIC_PAGE_ADDR, 0);
 	vmcs_writel(TPR_THRESHOLD, 0);
+#endif
 
 	vmcs_writel(CR0_GUEST_HOST_MASK, KVM_GUEST_CR0_MASK);
 	vmcs_writel(CR4_GUEST_HOST_MASK, KVM_GUEST_CR4_MASK);
