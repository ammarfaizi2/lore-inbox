Return-Path: <linux-kernel-owner+w=401wt.eu-S965026AbXADQVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbXADQVL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbXADQVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:21:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:55840 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965026AbXADQVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:21:09 -0500
Subject: [PATCH 32/33] KVM: MMU: Destroy mmu while we still have a vcpu left
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:21:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104162107.BB6DC250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mmu_destroy flushes the guest tlb (indirectly), which needs a valid vcpu.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -271,8 +271,8 @@ static void kvm_free_physmem(struct kvm 
 
 static void kvm_free_vcpu(struct kvm_vcpu *vcpu)
 {
-	kvm_arch_ops->vcpu_free(vcpu);
 	kvm_mmu_destroy(vcpu);
+	kvm_arch_ops->vcpu_free(vcpu);
 }
 
 static void kvm_free_vcpus(struct kvm *kvm)
