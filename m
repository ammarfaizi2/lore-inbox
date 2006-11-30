Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759196AbWK3JJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759196AbWK3JJD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759195AbWK3JJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:09:01 -0500
Received: from il.qumranet.com ([62.219.232.206]:62918 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1759196AbWK3JJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:09:00 -0500
Subject: [PATCH] KVM: printk log levels
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 30 Nov 2006 09:08:59 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       rdreier@cisco.com
Message-Id: <20061130090859.1942725017B@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Drier <rdreier@cisco.com>

Here's a trivial patch that adds log levels to all printks.  This
avoids ugly things like

Message from syslogd@roland-xeon-2 at Wed Nov 29 14:01:01 2006 ...
roland-xeon-2 kernel: [81842.565619] msrs: 6

popping up in a console on my system when starting a guest.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -1153,7 +1153,7 @@ static int vmx_vcpu_setup(struct kvm_vcp
 		vcpu->guest_msrs[j] = vcpu->host_msrs[j];
 		++vcpu->nmsrs;
 	}
-	printk("msrs: %d\n", vcpu->nmsrs);
+	printk(KERN_DEBUG "kvm: msrs: %d\n", vcpu->nmsrs);
 
 	nr_good_msrs = vcpu->nmsrs - NR_BAD_MSRS;
 	vmcs_writel(VM_ENTRY_MSR_LOAD_ADDR,
Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -990,7 +990,7 @@ static int io_interception(struct kvm_vc
 
 		addr_mask = io_adress(vcpu, _in, &kvm_run->io.address);
 		if (!addr_mask) {
-			printk("%s: get io address failed\n", __FUNCTION__);
+			printk(KERN_DEBUG "%s: get io address failed\n", __FUNCTION__);
 			return 1;
 		}
 
@@ -1030,7 +1030,7 @@ static int invalid_op_interception(struc
 
 static int task_switch_interception(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
-	printk("%s: task swiche is unsupported\n", __FUNCTION__);
+	printk(KERN_DEBUG "%s: task swiche is unsupported\n", __FUNCTION__);
 	kvm_run->exit_reason = KVM_EXIT_UNKNOWN;
 	return 0;
 }
