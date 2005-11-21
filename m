Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbVKUQsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVKUQsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVKUQse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:48:34 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:6292 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751044AbVKUQse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:48:34 -0500
Date: Mon, 21 Nov 2005 11:48:32 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Workaround for gcc 2.96 (undefined references)
Message-ID: <Pine.LNX.4.44L0.0511211145330.4586-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:

As of 2.6.15-rc1-git4, gcc 2.96 complains about undefined references 
unless this patch (as607) is applied.  Apparently the old compiler isn't 
so good at avoiding linker references to unused code.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/mm/memory.c
===================================================================
--- usb-2.6.orig/mm/memory.c
+++ usb-2.6/mm/memory.c
@@ -2101,6 +2101,13 @@ int __pud_alloc(struct mm_struct *mm, pg
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
+#else
+
+/* Workaround for gcc 2.96 */
+int __pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
+{
+	return 0;
+}
 #endif /* __PAGETABLE_PUD_FOLDED */
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -2129,6 +2136,13 @@ int __pmd_alloc(struct mm_struct *mm, pu
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
+#else
+
+/* Workaround for gcc 2.96 */
+int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
+{
+	return 0;
+}
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 int make_pages_present(unsigned long addr, unsigned long end)

