Return-Path: <linux-kernel-owner+w=401wt.eu-S964957AbWLMNOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWLMNOP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWLMNOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:14:15 -0500
Received: from il.qumranet.com ([62.219.232.206]:47434 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964957AbWLMNOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:14:14 -0500
X-Greylist: delayed 1889 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 08:14:13 EST
Subject: [PATCH 2/3] KVM: AMD SVM: handle MSR_STAR in 32-bit mode
From: Avi Kivity <avi@qumranet.com>
Date: Wed, 13 Dec 2006 12:44:56 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457FF542.6050602@qumranet.com>
In-Reply-To: <457FF542.6050602@qumranet.com>
Message-Id: <20061213124456.C85AA2502E1@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is necessary for linux guests.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -402,11 +402,11 @@ static __init int svm_hardware_setup(voi
 	set_msr_interception(msrpm_va, MSR_GS_BASE, 1, 1);
 	set_msr_interception(msrpm_va, MSR_FS_BASE, 1, 1);
 	set_msr_interception(msrpm_va, MSR_KERNEL_GS_BASE, 1, 1);
-	set_msr_interception(msrpm_va, MSR_STAR, 1, 1);
 	set_msr_interception(msrpm_va, MSR_LSTAR, 1, 1);
 	set_msr_interception(msrpm_va, MSR_CSTAR, 1, 1);
 	set_msr_interception(msrpm_va, MSR_SYSCALL_MASK, 1, 1);
 #endif
+	set_msr_interception(msrpm_va, MSR_K6_STAR, 1, 1);
 	set_msr_interception(msrpm_va, MSR_IA32_SYSENTER_CS, 1, 1);
 	set_msr_interception(msrpm_va, MSR_IA32_SYSENTER_ESP, 1, 1);
 	set_msr_interception(msrpm_va, MSR_IA32_SYSENTER_EIP, 1, 1);
@@ -1098,10 +1098,10 @@ static int svm_get_msr(struct kvm_vcpu *
 	case MSR_IA32_APICBASE:
 		*data = vcpu->apic_base;
 		break;
-#ifdef CONFIG_X86_64
-	case MSR_STAR:
+	case MSR_K6_STAR:
 		*data = vcpu->svm->vmcb->save.star;
 		break;
+#ifdef CONFIG_X86_64
 	case MSR_LSTAR:
 		*data = vcpu->svm->vmcb->save.lstar;
 		break;
@@ -1173,10 +1173,10 @@ static int svm_set_msr(struct kvm_vcpu *
 	case MSR_IA32_APICBASE:
 		vcpu->apic_base = data;
 		break;
-#ifdef CONFIG_X86_64_
-	case MSR_STAR:
+	case MSR_K6_STAR:
 		vcpu->svm->vmcb->save.star = data;
 		break;
+#ifdef CONFIG_X86_64_
 	case MSR_LSTAR:
 		vcpu->svm->vmcb->save.lstar = data;
 		break;
