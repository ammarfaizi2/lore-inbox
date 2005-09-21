Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVIURt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVIURt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVIURs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:48:58 -0400
Received: from [151.97.230.9] ([151.97.230.9]:11715 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751338AbVIURsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:48:53 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 03/10] uml: don't redundantly mark pte as newpage in pte_modify
Date: Wed, 21 Sep 2005 19:28:25 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921172824.10219.17857.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

pte_modify marks a page as needing flush, which is redundant because the
resulting PTE is still set with set_pte, which already handles that.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-um/pgtable.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/asm-um/pgtable.h b/include/asm-um/pgtable.h
--- a/include/asm-um/pgtable.h
+++ b/include/asm-um/pgtable.h
@@ -346,7 +346,6 @@ static inline void set_pte(pte_t *pteptr
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_set_val(pte, (pte_val(pte) & _PAGE_CHG_MASK), newprot);
-	if(pte_present(pte)) pte = pte_mknewpage(pte_mknewprot(pte));
 	return pte; 
 }
 

