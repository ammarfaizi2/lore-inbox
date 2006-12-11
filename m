Return-Path: <linux-kernel-owner+w=401wt.eu-S1762743AbWLKKRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762743AbWLKKRP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762747AbWLKKRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:17:15 -0500
Received: from il.qumranet.com ([62.219.232.206]:45725 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762743AbWLKKRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:17:15 -0500
Subject: [PATCH 3/5] KVM: Remove extranous put_cpu() from vcpu_put()
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 11 Dec 2006 10:17:13 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457D2F6B.8070809@qumranet.com>
In-Reply-To: <457D2F6B.8070809@qumranet.com>
Message-Id: <20061211101713.D20332500CF@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The arch splitting patchset left an extra put_cpu() in core code, where
it can cause trouble for CONFIG_PREEMPT kernels.

Reported by: Huihong Luo <huisinro@yahoo.com>

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -205,7 +205,6 @@ static struct kvm_vcpu *vcpu_load(struct
 static void vcpu_put(struct kvm_vcpu *vcpu)
 {
 	kvm_arch_ops->vcpu_put(vcpu);
-	put_cpu();
 	mutex_unlock(&vcpu->mutex);
 }
 
