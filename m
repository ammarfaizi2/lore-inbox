Return-Path: <linux-kernel-owner+w=401wt.eu-S1751079AbXANFdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXANFdL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbXANFdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:33:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58389 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbXANFdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:33:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
In-Reply-To: Roland McGrath's message of  Saturday, 13 January 2007 21:31:39 -0800 <20070114053140.351701800E5@magilla.sf.frob.com>
Subject: [PATCH 2/11] Fix gate_vma.vm_flags
Message-Id: <20070114053306.059051800E5@magilla.sf.frob.com>
Date: Sat, 13 Jan 2007 21:33:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the initialization of gate_vma.vm_flags and
gate_vma.vm_page_prot to reflect reality.  This makes the "[vdso]" line in
/proc/PID/maps correctly show r-xp instead of ---p, when gate_vma is used
(CONFIG_COMPAT_VDSO on i386).

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 mm/memory.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index af227d2..5beb4b8 100644  
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2606,8 +2606,8 @@ static int __init gate_vma_init(void)
 	gate_vma.vm_mm = NULL;
 	gate_vma.vm_start = FIXADDR_USER_START;
 	gate_vma.vm_end = FIXADDR_USER_END;
-	gate_vma.vm_page_prot = PAGE_READONLY;
-	gate_vma.vm_flags = 0;
+	gate_vma.vm_flags = VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC;
+	gate_vma.vm_page_prot = __P101;
 	return 0;
 }
 __initcall(gate_vma_init);
