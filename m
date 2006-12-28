Return-Path: <linux-kernel-owner+w=401wt.eu-S932893AbWL1KIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932893AbWL1KIT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbWL1KIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:08:19 -0500
Received: from il.qumranet.com ([62.219.232.206]:39507 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932893AbWL1KIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:08:18 -0500
Subject: [PATCH 1/8] KVM: Use boot_cpu_data instead of current_cpu_data
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 28 Dec 2006 10:08:17 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <45939755.7010603@qumranet.com>
In-Reply-To: <45939755.7010603@qumranet.com>
Message-Id: <20061228100817.3B6042500F7@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

current_cpu_data invokes smp_processor_id(), which is inadvisable when
preemption is enabled.  Switch to boot_cpu_data instead.

Resolves sourceforge bug 1621401.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -246,7 +246,7 @@ static int has_svm(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 
-	if (current_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
 		printk(KERN_INFO "has_svm: not amd\n");
 		return 0;
 	}
