Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWKGQE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWKGQE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWKGQE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:04:59 -0500
Received: from il.qumranet.com ([62.219.232.206]:31145 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932645AbWKGQE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:04:58 -0500
Subject: [PATCH] KVM: Fix guest cr4 corruption
From: Avi Kivity <avi@qumranet.com>
Date: Tue, 07 Nov 2006 16:04:54 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20061107160454.34E7BA0001@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon entry to protected mode, we set cr4 to a value derived from cr0
accidentally.  Fix.

This could cause a guest to crash (though I never observed it).

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -697,7 +697,7 @@ static void enter_pmode(struct kvm_vcpu 
 	vmcs_writel(GUEST_RFLAGS, flags);
 
 	vmcs_writel(GUEST_CR4, (vmcs_readl(GUEST_CR4) & ~CR4_VME_MASK) |
-			(vmcs_readl(CR0_READ_SHADOW) & CR4_VME_MASK) );
+			(vmcs_readl(CR4_READ_SHADOW) & CR4_VME_MASK));
 
 	update_exception_bitmap(vcpu);
 
