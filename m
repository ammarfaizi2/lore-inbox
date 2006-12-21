Return-Path: <linux-kernel-owner+w=401wt.eu-S1422886AbWLUJtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422886AbWLUJtJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422920AbWLUJtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:49:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:59787 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422886AbWLUJtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:49:08 -0500
Subject: [PATCH 4/5] KVM: Handle p5 mce msrs
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 21 Dec 2006 09:49:04 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <458A57A4.9000807@qumranet.com>
In-Reply-To: <458A57A4.9000807@qumranet.com>
Message-Id: <20061221094904.EDF91250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Riepe <michael@mr511.de>

This allows plan9 to get a little further booting.

Signed-off-by: Michael Riepe <michael@mr511.de>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -1073,6 +1073,8 @@ static int emulate_on_interception(struc
 static int svm_get_msr(struct kvm_vcpu *vcpu, unsigned ecx, u64 *data)
 {
 	switch (ecx) {
+	case MSR_IA32_P5_MC_ADDR:
+	case MSR_IA32_P5_MC_TYPE:
 	case MSR_IA32_MC0_CTL:
 	case MSR_IA32_MCG_STATUS:
 	case MSR_IA32_MCG_CAP:
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -359,6 +359,8 @@ static int vmx_get_msr(struct kvm_vcpu *
 	case MSR_IA32_SYSENTER_ESP:
 		data = vmcs_read32(GUEST_SYSENTER_ESP);
 		break;
+	case MSR_IA32_P5_MC_ADDR:
+	case MSR_IA32_P5_MC_TYPE:
 	case MSR_IA32_MC0_CTL:
 	case MSR_IA32_MCG_STATUS:
 	case MSR_IA32_MCG_CAP:
