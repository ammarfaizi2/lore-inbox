Return-Path: <linux-kernel-owner+w=401wt.eu-S932935AbWL1KNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935AbWL1KNT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbWL1KNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:13:19 -0500
Received: from il.qumranet.com ([62.219.232.206]:44585 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932935AbWL1KNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:13:18 -0500
Subject: [PATCH 6/8] KVM: More msr misery
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 28 Dec 2006 10:13:17 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <45939755.7010603@qumranet.com>
In-Reply-To: <45939755.7010603@qumranet.com>
Message-Id: <20061228101317.792FA2500F7@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These msrs are referenced by benchmarking software when pretending to be
an Intel cpu.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1122,11 +1122,15 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_IA32_MC0_MISC+12:
 	case MSR_IA32_MC0_MISC+16:
 	case MSR_IA32_UCODE_REV:
+	case MSR_IA32_PERF_STATUS:
 		/* MTRR registers */
 	case 0xfe:
 	case 0x200 ... 0x2ff:
 		data = 0;
 		break;
+	case 0xcd: /* fsb frequency */
+		data = 3;
+		break;
 	case MSR_IA32_APICBASE:
 		data = vcpu->apic_base;
 		break;
