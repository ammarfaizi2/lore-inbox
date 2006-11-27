Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758109AbWK0Mdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758109AbWK0Mdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758132AbWK0Mdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:33:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:30147 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758109AbWK0Mdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:33:39 -0500
Subject: [PATCH 23/38] KVM: Use the idt and gdt accessors in realmode emulation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:33:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127123338.4604E25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1225,14 +1225,16 @@ static u64 mk_cr_64(u64 curr_cr, u32 new
 
 void realmode_lgdt(struct kvm_vcpu *vcpu, u16 limit, unsigned long base)
 {
-	vmcs_writel(GUEST_GDTR_BASE, base);
-	vmcs_write32(GUEST_GDTR_LIMIT, limit);
+	struct descriptor_table dt = { limit, base };
+
+	kvm_arch_ops->set_gdt(vcpu, &dt);
 }
 
 void realmode_lidt(struct kvm_vcpu *vcpu, u16 limit, unsigned long base)
 {
-	vmcs_writel(GUEST_IDTR_BASE, base);
-	vmcs_write32(GUEST_IDTR_LIMIT, limit);
+	struct descriptor_table dt = { limit, base };
+
+	kvm_arch_ops->set_idt(vcpu, &dt);
 }
 
 void realmode_lmsw(struct kvm_vcpu *vcpu, unsigned long msw,
