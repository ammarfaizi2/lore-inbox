Return-Path: <linux-kernel-owner+w=401wt.eu-S1762726AbWLKKPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762726AbWLKKPQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762729AbWLKKPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:15:16 -0500
Received: from il.qumranet.com ([62.219.232.206]:45715 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762726AbWLKKPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:15:15 -0500
Subject: [PATCH 1/5] KVM: Make the GET_SREGS and SET_SREGS ioctls symmetric
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 11 Dec 2006 10:15:13 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457D2F6B.8070809@qumranet.com>
In-Reply-To: <457D2F6B.8070809@qumranet.com>
Message-Id: <20061211101513.C38EC2500CF@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the SET_SREGS ioctl behave symmetrically to the GET_SREGS
ioctl wrt the segment access rights flag.

From: Uri Lublin <uril@qumranet.com>

Signed-off-by: Uri Lublin <uril@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -884,6 +884,8 @@ static void vmx_set_segment(struct kvm_v
 		ar |= (var->db & 1) << 14;
 		ar |= (var->g & 1) << 15;
 	}
+	if (ar == 0) /* a 0 value means unusable */
+		ar = AR_UNUSABLE_MASK;
 	vmcs_write32(sf->ar_bytes, ar);
 }
 
