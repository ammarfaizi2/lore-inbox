Return-Path: <linux-kernel-owner+w=401wt.eu-S932963AbWL1KOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963AbWL1KOV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbWL1KOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:14:21 -0500
Received: from il.qumranet.com ([62.219.232.206]:54143 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932979AbWL1KOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:14:19 -0500
Subject: [PATCH 7/8] KVM: Rename some msrs
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 28 Dec 2006 10:14:17 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <45939755.7010603@qumranet.com>
In-Reply-To: <45939755.7010603@qumranet.com>
Message-Id: <20061228101417.960E22500F7@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nguyen Anh Quynh <aquynh@gmail.com>

No need to append _MSR to msr names, a prefix should suffice.

Signed-off-by: Nguyen Anh Quynh <aquynh@gmail.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -26,7 +26,6 @@
 
 #include "segment_descriptor.h"
 
-#define MSR_IA32_FEATURE_CONTROL 		0x03a
 
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
@@ -519,11 +518,11 @@ static __init void setup_vmcs_descriptor
 {
 	u32 vmx_msr_low, vmx_msr_high;
 
-	rdmsr(MSR_IA32_VMX_BASIC_MSR, vmx_msr_low, vmx_msr_high);
+	rdmsr(MSR_IA32_VMX_BASIC, vmx_msr_low, vmx_msr_high);
 	vmcs_descriptor.size = vmx_msr_high & 0x1fff;
 	vmcs_descriptor.order = get_order(vmcs_descriptor.size);
 	vmcs_descriptor.revision_id = vmx_msr_low;
-};
+}
 
 static struct vmcs *alloc_vmcs_cpu(int cpu)
 {
@@ -1039,12 +1038,12 @@ static int vmx_vcpu_setup(struct kvm_vcp
 	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
 
 	/* Control */
-	vmcs_write32_fixedbits(MSR_IA32_VMX_PINBASED_CTLS_MSR,
+	vmcs_write32_fixedbits(MSR_IA32_VMX_PINBASED_CTLS,
 			       PIN_BASED_VM_EXEC_CONTROL,
 			       PIN_BASED_EXT_INTR_MASK   /* 20.6.1 */
 			       | PIN_BASED_NMI_EXITING   /* 20.6.1 */
 			);
-	vmcs_write32_fixedbits(MSR_IA32_VMX_PROCBASED_CTLS_MSR,
+	vmcs_write32_fixedbits(MSR_IA32_VMX_PROCBASED_CTLS,
 			       CPU_BASED_VM_EXEC_CONTROL,
 			       CPU_BASED_HLT_EXITING         /* 20.6.2 */
 			       | CPU_BASED_CR8_LOAD_EXITING    /* 20.6.2 */
@@ -1127,7 +1126,7 @@ static int vmx_vcpu_setup(struct kvm_vcp
 		    virt_to_phys(vcpu->guest_msrs + NR_BAD_MSRS));
 	vmcs_writel(VM_EXIT_MSR_LOAD_ADDR,
 		    virt_to_phys(vcpu->host_msrs + NR_BAD_MSRS));
-	vmcs_write32_fixedbits(MSR_IA32_VMX_EXIT_CTLS_MSR, VM_EXIT_CONTROLS,
+	vmcs_write32_fixedbits(MSR_IA32_VMX_EXIT_CTLS, VM_EXIT_CONTROLS,
 		     	       (HOST_IS_64 << 9));  /* 22.2,1, 20.7.1 */
 	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, nr_good_msrs); /* 22.2.2 */
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, nr_good_msrs);  /* 22.2.2 */
@@ -1135,7 +1134,7 @@ static int vmx_vcpu_setup(struct kvm_vcp
 
 
 	/* 22.2.1, 20.8.1 */
-	vmcs_write32_fixedbits(MSR_IA32_VMX_ENTRY_CTLS_MSR,
+	vmcs_write32_fixedbits(MSR_IA32_VMX_ENTRY_CTLS,
                                VM_ENTRY_CONTROLS, 0);
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);  /* 22.2.1 */
 
Index: linux-2.6/drivers/kvm/vmx.h
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.h
+++ linux-2.6/drivers/kvm/vmx.h
@@ -286,11 +286,11 @@ enum vmcs_field {
 
 #define CR4_VMXE 0x2000
 
-#define MSR_IA32_VMX_BASIC_MSR   		0x480
+#define MSR_IA32_VMX_BASIC   		0x480
 #define MSR_IA32_FEATURE_CONTROL 		0x03a
-#define MSR_IA32_VMX_PINBASED_CTLS_MSR		0x481
-#define MSR_IA32_VMX_PROCBASED_CTLS_MSR		0x482
-#define MSR_IA32_VMX_EXIT_CTLS_MSR		0x483
-#define MSR_IA32_VMX_ENTRY_CTLS_MSR		0x484
+#define MSR_IA32_VMX_PINBASED_CTLS		0x481
+#define MSR_IA32_VMX_PROCBASED_CTLS		0x482
+#define MSR_IA32_VMX_EXIT_CTLS		0x483
+#define MSR_IA32_VMX_ENTRY_CTLS		0x484
 
 #endif
