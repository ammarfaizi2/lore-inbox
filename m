Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWHYPmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWHYPmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWHYPmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:42:40 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:38332 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422717AbWHYPmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:42:22 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Fri, 25 Aug 2006 17:37:40 +0200
Message-Id: <20060825153740.24254.20935.sendpatchset@twins>
In-Reply-To: <20060825153709.24254.28118.sendpatchset@twins>
References: <20060825153709.24254.28118.sendpatchset@twins>
Subject: [PATCH 3/6] uml: arch/um remove_mapping() clash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that 'include/linux/mm.h' includes 'include/linux/swap.h', the global
remove_mapping() definition clashes with the arch/um one.

Rename the arch/um one.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
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
