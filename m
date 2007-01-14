Return-Path: <linux-kernel-owner+w=401wt.eu-S1751019AbXANFgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXANFgg (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbXANFgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:36:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58916 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbXANFgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:36:35 -0500
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
In-Reply-To: Roland McGrath's message of  Saturday, 13 January 2007 21:31:39 -0800 <20070114053140.351701800E5@magilla.sf.frob.com>
Subject: [PATCH 7/11] x86_64 ia32 vDSO: define arch_vma_name
X-Shopping-List: (1) Imprudent auctions
   (2) Ponderous gravy
   (3) Slanderous emission compasses
   (4) Coniferous watchers
   (5) Fabulous snowbulb yies
Message-Id: <20070114053601.34F4B1800E5@magilla.sf.frob.com>
Date: Sat, 13 Jan 2007 21:36:01 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes x86_64 define arch_vma_name for CONFIG_IA32_EMULATION.
This makes the ia32 vDSO mapping appear in /proc/PID/maps with "[vdso]"
for ia32 processes, as it does on native i386.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/x86_64/ia32/syscall32.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/ia32/syscall32.c b/arch/x86_64/ia32/syscall32.c
index 3ac9355..59f1fa1 100644  
--- a/arch/x86_64/ia32/syscall32.c
+++ b/arch/x86_64/ia32/syscall32.c
@@ -82,6 +82,14 @@ int syscall32_setup_pages(struct linux_b
 	return 0;
 }
 
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	if (vma->vm_start == VSYSCALL32_BASE &&
+	    vma->vm_mm && vma->vm_mm->task_size == IA32_PAGE_OFFSET)
+		return "[vdso]";
+	return NULL;
+}
+
 static int __init init_syscall32(void)
 { 
 	syscall32_page = (void *)get_zeroed_page(GFP_KERNEL); 
