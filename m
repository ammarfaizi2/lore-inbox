Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWHZRmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWHZRmg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWHZRmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:42:35 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:27259 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964949AbWHZRmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=VG0KXCm8F/04NbPTwpKy5pRkNkVP4mzQQplOOw716xmZqXOGJJ2nKRuxqw8ZOcblqP/FIM58NuuGgsm4BidhJvdoUsqr1H3qvx3qxjcYbSsS3zv1AbxYlNHsy7VeqO0PqZxJ6V4NbFVyOHvap4piXFnkaAhO725h+Gtyo1k5y8w=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 05/13] RFP prot support: disallow mprotect() on manyprots mappings
Date: Sat, 26 Aug 2006 19:42:24 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174224.14790.16609.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

For now we (I and Hugh) have found no agreement on which behavior to implement
here. So, at least as a stop-gap, return an error here.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 mm/mprotect.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 638edab..401ae11 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -240,6 +240,13 @@ sys_mprotect(unsigned long start, size_t
 	error = -ENOMEM;
 	if (!vma)
 		goto out;
+
+	/* If a need is felt, an appropriate behaviour may be implemented for
+	 * this case. We haven't agreed yet on which behavior is appropriate. */
+	error = -EACCES;
+	if (vma->vm_flags & VM_MANYPROTS)
+		goto out;
+
 	if (unlikely(grows & PROT_GROWSDOWN)) {
 		if (vma->vm_start >= end)
 			goto out;
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
