Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758148AbWK0Mml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148AbWK0Mml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758151AbWK0Mmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:42:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:42464 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758150AbWK0Mmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:42:40 -0500
Subject: [PATCH 32/38] KVM: Move vmcs static variables to vmx.c
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:42:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127124238.C4DE625015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -138,18 +138,6 @@ unsigned long segment_base(u16 selector)
 }
 EXPORT_SYMBOL_GPL(segment_base);
 
-DEFINE_PER_CPU(struct vmcs *, vmxarea);
-EXPORT_SYMBOL_GPL(per_cpu__vmxarea); /* temporary hack */
-DEFINE_PER_CPU(struct vmcs *, current_vmcs);
-EXPORT_SYMBOL_GPL(per_cpu__current_vmcs); /* temporary hack */
-
-struct vmcs_descriptor {
-	int size;
-	int order;
-	u32 revision_id;
-} vmcs_descriptor;
-EXPORT_SYMBOL_GPL(vmcs_descriptor);
-
 int kvm_read_guest(struct kvm_vcpu *vcpu,
 			     gva_t addr,
 			     unsigned long size,
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -28,8 +28,8 @@
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
 
-DECLARE_PER_CPU(struct vmcs *, vmxarea);
-DECLARE_PER_CPU(struct vmcs *, current_vmcs);
+static DEFINE_PER_CPU(struct vmcs *, vmxarea);
+static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
 
 #ifdef __x86_64__
 #define HOST_IS_64 1
@@ -37,7 +37,7 @@ DECLARE_PER_CPU(struct vmcs *, current_v
 #define HOST_IS_64 0
 #endif
 
-extern struct vmcs_descriptor {
+static struct vmcs_descriptor {
 	int size;
 	int order;
 	u32 revision_id;
