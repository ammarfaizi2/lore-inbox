Return-Path: <linux-kernel-owner+w=401wt.eu-S1422926AbWLUJuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422926AbWLUJuJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422920AbWLUJuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:50:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:59792 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422926AbWLUJuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:50:06 -0500
Subject: [PATCH 5/5] KVM: API versioning
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 21 Dec 2006 09:50:05 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <458A57A4.9000807@qumranet.com>
In-Reply-To: <458A57A4.9000807@qumranet.com>
Message-Id: <20061221095005.097E0250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add compile-time and run-time API versioning.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1603,6 +1603,9 @@ static long kvm_dev_ioctl(struct file *f
 	int r = -EINVAL;
 
 	switch (ioctl) {
+	case KVM_GET_API_VERSION:
+		r = KVM_API_VERSION;
+		break;
 	case KVM_CREATE_VCPU: {
 		r = kvm_dev_ioctl_create_vcpu(kvm, arg);
 		if (r)
Index: linux-2.6/include/linux/kvm.h
===================================================================
--- linux-2.6.orig/include/linux/kvm.h
+++ linux-2.6/include/linux/kvm.h
@@ -11,6 +11,8 @@
 #include <asm/types.h>
 #include <linux/ioctl.h>
 
+#define KVM_API_VERSION 1
+
 /*
  * Architectural interrupt line count, and the size of the bitmap needed
  * to hold them.
@@ -209,6 +211,7 @@ struct kvm_dirty_log {
 
 #define KVMIO 0xAE
 
+#define KVM_GET_API_VERSION       _IO(KVMIO, 1)
 #define KVM_RUN                   _IOWR(KVMIO, 2, struct kvm_run)
 #define KVM_GET_REGS              _IOWR(KVMIO, 3, struct kvm_regs)
 #define KVM_SET_REGS              _IOW(KVMIO, 4, struct kvm_regs)
