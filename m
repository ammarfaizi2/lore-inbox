Return-Path: <linux-kernel-owner+w=401wt.eu-S932897AbWL1KLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897AbWL1KLT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbWL1KLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:11:19 -0500
Received: from il.qumranet.com ([62.219.232.206]:44575 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932897AbWL1KLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:11:18 -0500
Subject: [PATCH 4/8] KVM: Implement a few system configuration msrs
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 28 Dec 2006 10:11:17 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <45939755.7010603@qumranet.com>
In-Reply-To: <45939755.7010603@qumranet.com>
Message-Id: <20061228101117.65A392500F7@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resolves sourceforge bug 1622229 (guest crashes running benchmark software).

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -1068,6 +1068,9 @@ static int emulate_on_interception(struc
 static int svm_get_msr(struct kvm_vcpu *vcpu, unsigned ecx, u64 *data)
 {
 	switch (ecx) {
+	case 0xc0010010: /* SYSCFG */
+	case 0xc0010015: /* HWCR */
+	case MSR_IA32_PLATFORM_ID:
 	case MSR_IA32_P5_MC_ADDR:
 	case MSR_IA32_P5_MC_TYPE:
 	case MSR_IA32_MC0_CTL:
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -359,6 +359,9 @@ static int vmx_get_msr(struct kvm_vcpu *
 	case MSR_IA32_SYSENTER_ESP:
 		data = vmcs_read32(GUEST_SYSENTER_ESP);
 		break;
+	case 0xc0010010: /* SYSCFG */
+	case 0xc0010015: /* HWCR */
+	case MSR_IA32_PLATFORM_ID:
 	case MSR_IA32_P5_MC_ADDR:
 	case MSR_IA32_P5_MC_TYPE:
 	case MSR_IA32_MC0_CTL:
