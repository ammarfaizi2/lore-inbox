Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbVLOJ1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbVLOJ1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422642AbVLOJR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:17:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:11434 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422640AbVLOJRu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:17:50 -0500
To: torvalds@osdl.org
Subject: [PATCH] i386,amd64: ioremap.c __iomem annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpFG-0007ys-03@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:17:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 arch/i386/mm/ioremap.c   |    2 +-
 arch/x86_64/mm/ioremap.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

b1d0c1d84b2650707044dcc1136985f501f72c20
diff --git a/arch/i386/mm/ioremap.c b/arch/i386/mm/ioremap.c
index 8498b5a..247fde7 100644
--- a/arch/i386/mm/ioremap.c
+++ b/arch/i386/mm/ioremap.c
@@ -245,7 +245,7 @@ void iounmap(volatile void __iomem *addr
 			addr < phys_to_virt(ISA_END_ADDRESS))
 		return;
 
-	addr = (volatile void *)(PAGE_MASK & (unsigned long __force)addr);
+	addr = (volatile void __iomem *)(PAGE_MASK & (unsigned long __force)addr);
 
 	/* Use the vm area unlocked, assuming the caller
 	   ensures there isn't another iounmap for the same address
diff --git a/arch/x86_64/mm/ioremap.c b/arch/x86_64/mm/ioremap.c
index 0d260e4..ae20706 100644
--- a/arch/x86_64/mm/ioremap.c
+++ b/arch/x86_64/mm/ioremap.c
@@ -263,7 +263,7 @@ void iounmap(volatile void __iomem *addr
 		addr < phys_to_virt(ISA_END_ADDRESS))
 		return;
 
-	addr = (volatile void *)(PAGE_MASK & (unsigned long __force)addr);
+	addr = (volatile void __iomem *)(PAGE_MASK & (unsigned long __force)addr);
 	/* Use the vm area unlocked, assuming the caller
 	   ensures there isn't another iounmap for the same address
 	   in parallel. Reuse of the virtual address is prevented by
-- 
0.99.9.GIT

