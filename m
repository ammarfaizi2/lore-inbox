Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758606AbWK1Mov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758606AbWK1Mov (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758594AbWK1Mov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:44:51 -0500
Received: from il.qumranet.com ([62.219.232.206]:24006 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758606AbWK1Mou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:44:50 -0500
Subject: [PATCH 6/6] KVM: AMD SVM: Plumbing
From: Avi Kivity <avi@qumranet.com>
Date: Tue, 28 Nov 2006 12:44:49 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, yaniv.kamay@qumranet.com,
       mingo@elte.hu
References: <456C2D89.4050508@qumranet.com>
In-Reply-To: <456C2D89.4050508@qumranet.com>
Message-Id: <20061128124449.89C0A25017B@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wire it all up and we're ready to go.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/Kconfig
===================================================================
--- linux-2.6.orig/drivers/kvm/Kconfig
+++ linux-2.6/drivers/kvm/Kconfig
@@ -24,3 +24,10 @@ config KVM_INTEL
 	---help---
 	  Provides support for KVM on Intel processors equipped with the VT
 	  extensions.
+
+config KVM_AMD
+	tristate "KVM for AMD processors support"
+	depends on KVM && X86_64
+	---help---
+	  Provides support for KVM on AMD processors equipped with the AMD-V
+	  (SVM) extensions.
Index: linux-2.6/drivers/kvm/Makefile
===================================================================
--- linux-2.6.orig/drivers/kvm/Makefile
+++ linux-2.6/drivers/kvm/Makefile
@@ -6,3 +6,5 @@ kvm-objs := kvm_main.o mmu.o x86_emulate
 obj-$(CONFIG_KVM) += kvm.o
 kvm-intel-objs = vmx.o
 obj-$(CONFIG_KVM_INTEL) += kvm-intel.o
+kvm-amd-objs = svm.o
+obj-$(CONFIG_KVM_AMD) += kvm-amd.o
