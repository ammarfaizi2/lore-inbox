Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWACVYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWACVYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWACVYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:24:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38031 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932536AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 28/50] m68knommu: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Qt-SB@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68knommu/kernel/process.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

3effaa23eea55b0ba8c19896de3e37524146860a
diff --git a/arch/m68knommu/kernel/process.c b/arch/m68knommu/kernel/process.c
index 82e7ec8..9b0fd04 100644
--- a/arch/m68knommu/kernel/process.c
+++ b/arch/m68knommu/kernel/process.c
@@ -198,10 +198,9 @@ int copy_thread(int nr, unsigned long cl
 {
 	struct pt_regs * childregs;
 	struct switch_stack * childstack, *stack;
-	unsigned long stack_offset, *retp;
+	unsigned long *retp;
 
-	stack_offset = THREAD_SIZE - sizeof(struct pt_regs);
-	childregs = (struct pt_regs *) ((unsigned long) p->thread_info + stack_offset);
+	childregs = (struct pt_regs *) (task_stack_page(p) + THREAD_SIZE) - 1;
 
 	*childregs = *regs;
 	childregs->d0 = 0;
-- 
0.99.9.GIT

