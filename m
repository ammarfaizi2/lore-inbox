Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263222AbVBDUEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbVBDUEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266694AbVBDUDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:03:41 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:25860 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S266074AbVBDUAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:00:46 -0500
Subject: [patch 7/8] uml: fix STATIC_LINK compilation [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 04 Feb 2005 19:35:55 +0100
Message-Id: <20050204183555.DC7E29BCB8@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Dike <jdike@addtoit.com>

This fixes a bug which assumes that __binary_start starts on a page
boundary, which isn't true when UML is configured to load into the normal
executable area.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/mem.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/mem.c~uml-fix-load-low arch/um/kernel/mem.c
--- linux-2.6.11/arch/um/kernel/mem.c~uml-fix-load-low	2005-02-04 06:45:31.750294120 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/mem.c	2005-02-04 06:45:31.753293664 +0100
@@ -79,7 +79,7 @@ void mem_init(void)
 	uml_reserved = brk_end;
 
 	/* Fill in any hole at the start of the binary */
-	start = (unsigned long) &__binary_start;
+	start = (unsigned long) &__binary_start & PAGE_MASK;
 	if(uml_physmem != start){
 		map_memory(uml_physmem, __pa(uml_physmem), start - uml_physmem,
 			   1, 1, 0);
_
