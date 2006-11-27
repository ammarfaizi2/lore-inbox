Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758139AbWK0Mhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758139AbWK0Mhk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758144AbWK0Mhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:37:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:43432 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758139AbWK0Mhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:37:39 -0500
Subject: [PATCH 27/38] KVM: Move the vmx segment field definitions to vmx.c
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:37:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127123738.7462325015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -65,31 +65,6 @@ static struct kvm_stats_debugfs_item {
 
 static struct dentry *debugfs_dir;
 
-#define VMX_SEGMENT_FIELD(seg)					\
-	[VCPU_SREG_##seg] {                                     \
-		GUEST_##seg##_SELECTOR,				\
-		GUEST_##seg##_BASE,			   	\
-		GUEST_##seg##_LIMIT,			   	\
-		GUEST_##seg##_AR_BYTES,			   	\
-	}
-
-struct kvm_vmx_segment_field {
-	unsigned selector;
-	unsigned base;
-	unsigned limit;
-	unsigned ar_bytes;
-} kvm_vmx_segment_fields[] = {
-	VMX_SEGMENT_FIELD(CS),
-	VMX_SEGMENT_FIELD(DS),
-	VMX_SEGMENT_FIELD(ES),
-	VMX_SEGMENT_FIELD(FS),
-	VMX_SEGMENT_FIELD(GS),
-	VMX_SEGMENT_FIELD(SS),
-	VMX_SEGMENT_FIELD(TR),
-	VMX_SEGMENT_FIELD(LDTR),
-};
-EXPORT_SYMBOL_GPL(kvm_vmx_segment_fields);
-
 #define MAX_IO_MSRS 256
 
 #define CR0_RESEVED_BITS 0xffffffff1ffaffc0ULL
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -42,12 +42,29 @@ extern struct vmcs_descriptor {
 	u32 revision_id;
 } vmcs_descriptor;
 
-extern struct kvm_vmx_segment_field {
+#define VMX_SEGMENT_FIELD(seg)					\
+	[VCPU_SREG_##seg] {                                     \
+		GUEST_##seg##_SELECTOR,				\
+		GUEST_##seg##_BASE,			   	\
+		GUEST_##seg##_LIMIT,			   	\
+		GUEST_##seg##_AR_BYTES,			   	\
+	}
+
+static struct kvm_vmx_segment_field {
 	unsigned selector;
 	unsigned base;
 	unsigned limit;
 	unsigned ar_bytes;
-} kvm_vmx_segment_fields[];
+} kvm_vmx_segment_fields[] = {
+	VMX_SEGMENT_FIELD(CS),
+	VMX_SEGMENT_FIELD(DS),
+	VMX_SEGMENT_FIELD(ES),
+	VMX_SEGMENT_FIELD(FS),
+	VMX_SEGMENT_FIELD(GS),
+	VMX_SEGMENT_FIELD(SS),
+	VMX_SEGMENT_FIELD(TR),
+	VMX_SEGMENT_FIELD(LDTR),
+};
 
 static const u32 vmx_msr_index[] = {
 #ifdef __x86_64__
