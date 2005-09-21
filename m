Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVIURsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVIURsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVIURsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:48:55 -0400
Received: from [151.97.230.9] ([151.97.230.9]:10435 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751329AbVIURsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:48:53 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 08/10] uml: Fix GFP_ flags usage
Date: Wed, 21 Sep 2005 19:29:21 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921172920.10219.29856.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

GFP_ATOMIC | GFP_KERNEL is meaningless and won't work. Actually it never worked,
even in 2.4.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/process_kern.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
--- a/arch/um/kernel/process_kern.c
+++ b/arch/um/kernel/process_kern.c
@@ -82,7 +82,8 @@ unsigned long alloc_stack(int order, int
 	unsigned long page;
 	int flags = GFP_KERNEL;
 
-	if(atomic) flags |= GFP_ATOMIC;
+	if (atomic)
+		flags = GFP_ATOMIC;
 	page = __get_free_pages(flags, order);
 	if(page == 0)
 		return(0);

