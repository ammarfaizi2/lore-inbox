Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUEQRzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUEQRzP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUEQRzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:55:15 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:22993 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261991AbUEQRzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:55:09 -0400
Date: Mon, 17 May 2004 10:54:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH][PPC32] Remove 'mem_pieces_append'
Message-ID: <20040517175448.GK6763@smtp.west.cox.net>
References: <20040516025514.3fe93f0c.akpm@osdl.org> <20040517174221.GJ6763@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517174221.GJ6763@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove mem_pieces_append, it is never used.

>From Fabian.Frederick <Fabian.Frederick&prov-liege.be>

 arch/ppc/mm/mem_pieces.c |   17 -----------------
 arch/ppc/mm/mem_pieces.h |    2 --
 2 files changed, 19 deletions(-)
--- 1.9/arch/ppc/mm/mem_pieces.c	Fri Sep 12 09:26:53 2003
+++ edited/arch/ppc/mm/mem_pieces.c	Fri May  7 15:58:55 2004
@@ -120,23 +120,6 @@
 	printk("\n");
 }
 
-#if defined(CONFIG_APUS) || defined(CONFIG_PPC_OF)
-/*
- * Add some memory to an array of pieces
- */
-void __init
-mem_pieces_append(struct mem_pieces *mp, unsigned int start, unsigned int size)
-{
-	struct reg_property *rp;
-
-	if (mp->n_regions >= MEM_PIECES_MAX)
-		return;
-	rp = &mp->regions[mp->n_regions++];
-	rp->address = start;
-	rp->size = size;
-}
-#endif /* CONFIG_APUS || CONFIG_PPC_OF */
-
 void __init
 mem_pieces_sort(struct mem_pieces *mp)
 {
--- 1.4/arch/ppc/mm/mem_pieces.h	Tue Feb 25 10:44:20 2003
+++ edited/arch/ppc/mm/mem_pieces.h	Fri May  7 15:58:58 2004
@@ -38,8 +38,6 @@
 extern void	*mem_pieces_find(unsigned int size, unsigned int align);
 extern void	 mem_pieces_remove(struct mem_pieces *mp, unsigned int start,
 				   unsigned int size, int must_exist);
-extern void	 mem_pieces_append(struct mem_pieces *mp, unsigned int start,
-				   unsigned int size);
 extern void	 mem_pieces_coalesce(struct mem_pieces *mp);
 extern void	 mem_pieces_sort(struct mem_pieces *mp);
 

-- 
Tom Rini
http://gate.crashing.org/~trini/
