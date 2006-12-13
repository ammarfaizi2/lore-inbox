Return-Path: <linux-kernel-owner+w=401wt.eu-S964961AbWLMNPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWLMNPQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWLMNOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:14:17 -0500
Received: from il.qumranet.com ([62.219.232.206]:47436 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964961AbWLMNOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:14:14 -0500
Subject: [PATCH 1/3] KVM: Disallow the kvm-amd module on intel hardware,
	and vice versa
From: Avi Kivity <avi@qumranet.com>
Date: Wed, 13 Dec 2006 12:43:47 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457FF542.6050602@qumranet.com>
In-Reply-To: <457FF542.6050602@qumranet.com>
Message-Id: <20061213124347.1AA2E250156@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They're not on speaking terms.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -377,6 +377,7 @@ static __init int svm_hardware_setup(voi
 	void *msrpm_va;
 	int r;
 
+	kvm_emulator_want_group7_invlpg();
 
 	iopm_pages = alloc_pages(GFP_KERNEL, IOPM_ALLOC_ORDER);
 
@@ -1628,9 +1629,7 @@ static struct kvm_arch_ops svm_arch_ops 
 
 static int __init svm_init(void)
 {
-	kvm_emulator_want_group7_invlpg();
-	kvm_init_arch(&svm_arch_ops, THIS_MODULE);
-	return 0;
+	return kvm_init_arch(&svm_arch_ops, THIS_MODULE);
 }
 
 static void __exit svm_exit(void)
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -2000,8 +2000,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 
 static int __init vmx_init(void)
 {
-	kvm_init_arch(&vmx_arch_ops, THIS_MODULE);
-	return 0;
+	return kvm_init_arch(&vmx_arch_ops, THIS_MODULE);
 }
 
 static void __exit vmx_exit(void)
