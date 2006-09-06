Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWIFN5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWIFN5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWIFN5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:57:35 -0400
Received: from [213.46.243.16] ([213.46.243.16]:11887 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751065AbWIFN5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:57:33 -0400
Message-Id: <20060906133953.588886000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:35 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Jeff Dike <jdike@addtoit.com>
Subject: [PATCH 05/21] uml: rename arch/um remove_mapping()
Content-Disposition: inline; filename=uml_remove_mapping.patch
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
