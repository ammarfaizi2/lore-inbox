Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWILP7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWILP7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWILP6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:58:03 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:59855 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751421AbWILPuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:50:52 -0400
Message-Id: <20060912144903.526938000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Jeff Dike <jdike@addtoit.com>
Subject: [PATCH 05/20] uml: rename arch/um remove_mapping()
Content-Disposition: inline; filename=uml_remove_mapping.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 'include/linux/mm.h' includes 'include/linux/swap.h', the global
remove_mapping() definition clashes with the arch/um one.

Rename the arch/um one.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Jeff Dike <jdike@addtoit.com>
---
 arch/um/kernel/physmem.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/physmem.c
+++ linux-2.6/arch/um/kernel/physmem.c
@@ -160,7 +160,7 @@ int physmem_subst_mapping(void *virt, in
 
 static int physmem_fd = -1;
 
-static void remove_mapping(struct phys_desc *desc)
+static void um_remove_mapping(struct phys_desc *desc)
 {
 	void *virt = desc->virt;
 	int err;
@@ -184,7 +184,7 @@ int physmem_remove_mapping(void *virt)
 	if(desc == NULL)
 		return(0);
 
-	remove_mapping(desc);
+	um_remove_mapping(desc);
 	return(1);
 }
 
@@ -205,7 +205,7 @@ void physmem_forget_descriptor(int fd)
 		page = list_entry(ele, struct phys_desc, list);
 		offset = page->offset;
 		addr = page->virt;
-		remove_mapping(page);
+		um_remove_mapping(page);
 		err = os_seek_file(fd, offset);
 		if(err)
 			panic("physmem_forget_descriptor - failed to seek "

--

