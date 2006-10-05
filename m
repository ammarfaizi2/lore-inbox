Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWJEVpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWJEVpL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWJEVl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:41:58 -0400
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:25782 "HELO
	smtp010.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932248AbWJEVln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:41:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=bVcD/kk7t3Z/hDowwCPLRt5LWPHrMyAxwrWFdTGDVUzZqHpkhRcIm5oZfWVrCT3wKWr0Urw8O6zMO/KB9qQretaUvsAXXUHp3knwtO09djW5G0amNNWVZxpYFqieLhIL8txpObVIhVq8whYLdAwGmmSe6M0a1LVfPUZ9mmpvf5k=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 03/14] uml: correct removal of pte_mkexec
Date: Thu, 05 Oct 2006 23:38:43 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213843.17268.83159.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Correct commit 5906e4171ad61ce68de95e51b773146707671f80 - this makes more sense:
we turn pte_mkexec + pte_wrprotect to pte_mkread. However, due to a bug in
pte_mkread, it does the exact same thing as pte_mkwrite, so this patch improves
the code but does not change anything in practice. The pte_mkread bug is fixed
separately, as it may have big impact.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/skas/mmu.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index c17eddc..2c6d090 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -60,10 +60,7 @@ #ifdef CONFIG_3_LEVEL_PGTABLES
 #endif
 
 	*pte = mk_pte(virt_to_page(kernel), __pgprot(_PAGE_PRESENT));
-	/* This is wrong for the code page, but it doesn't matter since the
-	 * stub is mapped by hand with the correct permissions.
-	 */
-	*pte = pte_mkwrite(*pte);
+	*pte = pte_mkread(*pte);
 	return(0);
 
  out_pmd:
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
