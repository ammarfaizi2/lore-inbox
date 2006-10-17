Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWJQSKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWJQSKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWJQSKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:10:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23012 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750714AbWJQSKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:10:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Yinghai Lu <yinghai.lu@amd.com>
Subject: [PATCH] x86_64: typo in __assign_irq_vector when update pos for vector and offset
References: <m13b9makht.fsf@ebiederm.dsl.xmission.com>
Date: Tue, 17 Oct 2006 12:08:14 -0600
In-Reply-To: <m13b9makht.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Tue, 17 Oct 2006 12:02:38 -0600")
Message-ID: <m1y7re95o1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yinghai Lu <yinghai.lu@amd.com>

typo with cpu instead of new_cpu

Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/io_apic.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 2207d4a..8a9a357 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
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
-- 
1.4.2.rc3.g7e18e-dirty

