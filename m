Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUGTLVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUGTLVX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 07:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUGTLVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 07:21:22 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:60059 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265792AbUGTLVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 07:21:19 -0400
MIME-Version: 1.0
Date: Tue, 20 Jul 2004 20:21:14 +0900
Subject: [PATCH] ia64 memory hotplug for hugetlbpages [3/4]
From: Nobuhiko Yoshida <n-yoshida@pst.fujitsu.com>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Message-ID: <JJ2004072020211410.33403984@pst.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Mailer: JsvMail 5.5 (Shuriken Pro3)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry. There is no [4/4] patch.
This is a last of patches.



diff -dupr linux-2.6.7/arch/ia64/mm/hugetlbpage.c linux-2.6.7-REMAP/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.7/arch/ia64/mm/hugetlbpage.c  2004-07-09 16:37:31.000000000 +0900
+++ linux-2.6.7-REMAP/arch/ia64/mm/hugetlbpage.c    2004-07-09 16:49:34.000000000 +0900
@@ -372,6 +372,15 @@ again:
            goto again;
        }
    }
+
+   if (page->mapping == NULL) {
+       BUG_ON(! PageAgain(page));
+       /* This page will go back to freelists[] */
+       put_page(page); /* XXX */
+       unlock_page(page);
+       goto again;
+   }
+
    if (pte_none(*pte)) {
        set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
        page_add_file_rmap(page);
