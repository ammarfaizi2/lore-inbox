Return-Path: <linux-kernel-owner+w=401wt.eu-S933167AbWLaNUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933167AbWLaNUy (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 08:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933169AbWLaNUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 08:20:54 -0500
Received: from il.qumranet.com ([62.219.232.206]:41769 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933167AbWLaNUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 08:20:53 -0500
Subject: [PATCH 2/3] KVM: Use raw_smp_processor_id() instead of
	smp_processor_id() where applicable
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 31 Dec 2006 13:20:52 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
References: <4597B8AB.6040504@qumranet.com>
In-Reply-To: <4597B8AB.6040504@qumranet.com>
Message-Id: <20061231132052.122F92500F7@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -116,7 +116,7 @@ static void vmcs_clear(struct vmcs *vmcs
 static void __vcpu_clear(void *arg)
 {
 	struct kvm_vcpu *vcpu = arg;
-	int cpu = smp_processor_id();
+	int cpu = raw_smp_processor_id();
 
 	if (vcpu->cpu == cpu)
 		vmcs_clear(vcpu->vmcs);
@@ -541,7 +541,7 @@ static struct vmcs *alloc_vmcs_cpu(int c
 
 static struct vmcs *alloc_vmcs(void)
 {
-	return alloc_vmcs_cpu(smp_processor_id());
+	return alloc_vmcs_cpu(raw_smp_processor_id());
 }
 
 static void free_vmcs(struct vmcs *vmcs)
