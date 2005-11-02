Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965318AbVKBWbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965318AbVKBWbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbVKBWbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:31:42 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:31396 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S965318AbVKBWbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:31:41 -0500
Date: Thu, 3 Nov 2005 00:31:40 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] sh: pte_mkhuge() compile fix for !CONFIG_HUGETLB_PAGE.
Message-ID: <20051102223140.GE27200@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Presently it is bogus to call pte_mkhuge() outside of the
CONFIG_HUGETLB_PAGE context, as the only processors that support
_PAGE_SZHUGE do so in the hugetlbpage context only (and this is the only
time that _PAGE_SZHUGE is even defined). SH-2 and SH-3 do not support
huge pages at all, and so it is not possible to enable this.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 include/asm-sh/pgtable.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

applies-to: 0aae3fb59b1e7a2877f297fbdc5acb7d281498ad
e1789731db5df57ba5a775be94f4d4e2a5a1c6de
diff --git a/include/asm-sh/pgtable.h b/include/asm-sh/pgtable.h
index aef8ae4..dee36bc 100644
--- a/include/asm-sh/pgtable.h
+++ b/include/asm-sh/pgtable.h
@@ -196,7 +196,9 @@ static inline pte_t pte_mkexec(pte_t pte
 static inline pte_t pte_mkdirty(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_DIRTY)); return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED)); return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_RW)); return pte; }
+#ifdef CONFIG_HUGETLB_PAGE
 static inline pte_t pte_mkhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_SZHUGE)); return pte; }
+#endif
 
 /*
  * Macro and implementation to make a page protection as uncachable.
---
0.99.8.GIT
