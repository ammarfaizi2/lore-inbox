Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161488AbWJUQwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161488AbWJUQwm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993133AbWJUQwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:52:01 -0400
Received: from ns1.suse.de ([195.135.220.2]:45724 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2993137AbWJUQvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:31 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: Yinghai Lu <yinghai.lu@amd.com>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [4/19] x86_64: typo in __assign_irq_vector when updating pos for vector and offset
Message-Id: <20061021165123.D84E313C4D@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:23 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yinghai Lu <yinghai.lu@amd.com>

typo with cpu instead of new_cpu

Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>
Signed-off-by: Andi Kleen <ak@suse.de>


---
 arch/x86_64/kernel/io_apic.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -651,12 +651,12 @@ next:
 		if (vector == IA32_SYSCALL_VECTOR)
 			goto next;
 		for_each_cpu_mask(new_cpu, domain)
-			if (per_cpu(vector_irq, cpu)[vector] != -1)
+			if (per_cpu(vector_irq, new_cpu)[vector] != -1)
 				goto next;
 		/* Found one! */
 		for_each_cpu_mask(new_cpu, domain) {
-			pos[cpu].vector = vector;
-			pos[cpu].offset = offset;
+			pos[new_cpu].vector = vector;
+			pos[new_cpu].offset = offset;
 		}
 		if (old_vector >= 0) {
 			int old_cpu;
