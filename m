Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269384AbUJLASu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269384AbUJLASu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269382AbUJLARe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:17:34 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:10371
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269386AbUJLAQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:16:57 -0400
Subject: [patch 1/6] uml: fix wrong type for rb_entry call
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:16:24 +0200
Message-Id: <20041012001624.4DC928686@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the type-safe rb_entry (based on container_of, I sent it) I discovered
this type error, so I've fixed it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/physmem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/um/kernel/physmem.c~uml-fix-wrong-type arch/um/kernel/physmem.c
--- linux-2.6.9-current/arch/um/kernel/physmem.c~uml-fix-wrong-type	2004-10-12 01:05:58.196762360 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/physmem.c	2004-10-12 01:05:58.198762056 +0200
@@ -36,7 +36,7 @@ static struct rb_node **find_rb(void *vi
 	struct phys_desc *d;
 
 	while(*n != NULL){
-		d = rb_entry(n, struct phys_desc, rb);
+		d = rb_entry(*n, struct phys_desc, rb);
 		if(d->virt == virt)
 			return(n);
 
@@ -56,7 +56,7 @@ static struct phys_desc *find_phys_mappi
 	if(*n == NULL)
 		return(NULL);
 
-	return(rb_entry(n, struct phys_desc, rb));
+	return(rb_entry(*n, struct phys_desc, rb));
 }
 
 static void insert_phys_mapping(struct phys_desc *desc)
_
